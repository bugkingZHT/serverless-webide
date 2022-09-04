package com.free4inno.serverlesswebide.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.aliyun.fc_open20210406.models.ListInstancesResponseBody;
import com.free4inno.serverlesswebide.constants.Constants;
import com.free4inno.serverlesswebide.dao.FuncDao;
import com.free4inno.serverlesswebide.dao.WorkspaceDao;
import com.free4inno.serverlesswebide.entity.Func;
import com.free4inno.serverlesswebide.entity.Workspace;
import com.free4inno.serverlesswebide.exception.FcException;
import com.free4inno.serverlesswebide.process.FcProcess;
import com.free4inno.serverlesswebide.utils.CodeUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class FuncService {

    // use to limit max
    private int totalFunc = 0;

    @Autowired
    private FuncDao funcDao;

    @Autowired
    private WorkspaceDao workspaceDao;

    @Resource
    private FcProcess fcProcess;

    public Func findSingleAvailableFunc() {
        List<Func> funcList = funcDao.findByIsAvailable(1);
        if(funcList.size() == 0) {
            log.warn("there is no free func left");
            // invoke to create more func
            return null;
        } else {
            return funcList.get(0);
        }
    }

//    public String assignFuncForUser(int userId) {
//        User user = userDao.findById(userId);
//        Func availableFunc = findSingleAvailableFunc();
//        if (availableFunc != null) {
//            availableFunc.setUserId(user.getId());
//            // set another parameters
//            funcDao.save(availableFunc);
//            // other operations of assigning am func to a user
//            // which is contains but not limited to the domains management
//            return "success";
//        } else {
//            return "failed";
//        }
//
//    }

    //create a empty func without assigning a certain user
    public Func createFunc() {
        // check total function max limit
        if (getAllFuncNum() >= Constants.MAX_TOTAL_FUNC) {
            log.error("createFunc -- total function is up to limit!");
            return null;
        }

        // generate function info
        String uniCode = CodeUtils.getRandomLowString(8);
        Func func = new Func();
        func.setWorkspaceId(Constants.EMPTY);
        func.setIsAvailable(Constants.AVAILABLE);
        func.setCode(uniCode);
        func.setName(String.format(Constants.FUNCTION_NAME, uniCode));
        func.setDomain("");

        // call sdk to create function in aliyun
        try {
            // 1. create function
            log.info("create function -- start");
            fcProcess.createFunction(Constants.SERVICE_NAME, func.getName());
            log.info("create function -- end");

            // 2. bind trigger
            log.info("create trigger -- start");
            String triggerRes = fcProcess.createTrigger(Constants.SERVICE_NAME, func.getName(), Constants.TRIGGER_NAME);
            log.info("create trigger -- end");

            // 3. bind route (abandon)
//            log.info("update route -- start");
//            List<Func> funcList = funcDao.findAll();
//            funcList.add(func);
//            fcProcess.updateRoute(Constants.DOMAIN_NAME, Constants.SERVICE_NAME, funcList);
//            log.info("update route -- end");

            // 3. bind domain (abandon)
//            log.info("bind domain -- start");
            // -- 3.1. bind by nginx
//            JSONObject jsonObject = JSON.parseObject(triggerRes);
//            String urlIntranet = String.valueOf(jsonObject.get("urlIntranet"));
//            fcProcess.bindNginxDomain(func.getDomain(), urlIntranet);
            // -- 3.2. bind by ali fc
//            log.info("bind domain -- end");

            // 4. set max instance
            log.info("set max instance -- start");
            fcProcess.setMaxInstance(Constants.SERVICE_NAME, func.getName(), Constants.MAX_INSTANCE);
            log.info("set max instance -- end");

            // save in DB
            funcDao.saveAndFlush(func);

        } catch (FcException e) {
             log.error(e.getMessage());
             return null;
        }
        return func;
    }

    // When calling, make sure it is 'AVAILABLE'
    public void deleteFunc(int id) {
        Func func = funcDao.findById(id);

        if (func.getIsAvailable() == Constants.NOT_AVAILABLE) {
            log.error("function is in use!");
            return;
        }

        try {
            // 1. delete trigger
            log.info("delete trigger -- start");
            fcProcess.deleteTrigger(Constants.SERVICE_NAME, func.getName(), Constants.TRIGGER_NAME);
            log.info("delete trigger -- end");

            // 2. delete max instance
            log.info("del max instance -- start");
            fcProcess.delMaxInstance(Constants.SERVICE_NAME, func.getName());
            log.info("del max instance -- end");

            // 3. delete function
            log.info("delete function -- start");
            fcProcess.deleteFunction(Constants.SERVICE_NAME, func.getName());
            log.info("delete function -- end");

            // 4. delete route (abandon)
//            log.info("update route -- start");
//            List<Func> funcList = funcDao.findAll();
//            funcList.remove(func);
//            fcProcess.updateRoute(Constants.DOMAIN_NAME, Constants.SERVICE_NAME, funcList);
//            log.info("update route -- end");

            // delete operations of faas
            funcDao.delete(func);

        } catch (FcException e) {
            log.error(e.getMessage());
        }
    }

    public boolean bindDomain(Func func) {
        // 1. bind by nginx (abandon)
        // 2. bind by ali fc
        try {
            fcProcess.bindFcDomain(Constants.SERVICE_NAME, func.getName(), func.getDomain());
        } catch (FcException e) {
            log.error(e.getMessage());
            return false;
        }
        return true;
    }

    public boolean unbindDomain(Func func) {
        // 1. bind by nginx (abandon)
        // 2. bind by ali fc
        try {
            fcProcess.unbindFcDomain(func.getDomain());
        } catch (FcException e) {
            log.error(e.getMessage());
            return false;
        }
        return true;
    }

    public void updateFunctionEnv(String funcName, Map<String, String> envVariables) {
        try {
            fcProcess.updateFunctionEnv(Constants.SERVICE_NAME, funcName, envVariables);
        } catch (FcException e) {
            log.error(e.getMessage());
        }
    }

    // ======================== basic ========================

    public List<Func> getAllFuncs() {
        return funcDao.findAll();
    }

    public int getAvailableFuncNum() {
        List<Func> funcList = funcDao.findByIsAvailable(Constants.AVAILABLE);
        return funcList.size();
    }

    public int getAllFuncNum() {
        List<Func> funcList = funcDao.findAll();
        return funcList.size();
    }

    // ================== schedule algorithm ==================

    // a algorithm for maintaining a sufficient function pool for users to apply
    // if there are less than 3 free funcs, new func should be created
    // if there are more than 5 free funcs, the rest funcs should be killed
    // this method should be invoked by another thread
    public void autoScaledAlgorithm() {
        // too low
        if (getAvailableFuncNum() < Constants.MIN_LEFT_FUNC) {
            for (int i = 0; i < Constants.MIN_LEFT_FUNC - getAvailableFuncNum(); i++) {
                createFunc();
            }
        }
        // too high
        if (getAvailableFuncNum() > Constants.MAX_REST_FUNC) {
            List<Func> funcList = funcDao.findByIsAvailable(1);
            for (int i = 0; i < getAvailableFuncNum() - Constants.MAX_REST_FUNC; i++) {
                deleteFunc(funcList.get(i).getId());
            }
        }
    }

    // find if the function has an instance (ABANDON)
    // if there is no instance: the function is unbound with workspace, available now
    // if there is instance: the function is bound with workspace, not available now
    /*
    public void checkAvailable() {
        List<Func> funcList = funcDao.findAll();
        for (Func func : funcList) {
            // 'not available' is set by activate workspace
            // 'available' is set by this function
            // this function is only used for 'unbind'
            if (func.getIsAvailable() == Constants.NOT_AVAILABLE) {
                List<ListInstancesResponseBody.ListInstancesResponseBodyInstances> res;
                try {
                    res = fcProcess.getFunctionInstance(Constants.SERVICE_NAME, func.getName());
                    if (res == null || res.isEmpty()) {
                        // available func
                        func.setIsAvailable(Constants.AVAILABLE);
                        // unbind workspace
                        Workspace ws = workspaceDao.findById(func.getWorkspaceId());
                        ws.setIsActive(Constants.NOT_ACTIVE);
                        func.setWorkspaceId(Constants.EMPTY);
                        // save
                        funcDao.saveAndFlush(func);
                        workspaceDao.saveAndFlush(ws);
                    }
                } catch (FcException e) {
                    log.error(e.getMessage());
                }
            }
        }
    }
     */

}
