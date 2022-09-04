package com.free4inno.serverlesswebide.service;

import com.free4inno.serverlesswebide.constants.Constants;
import com.free4inno.serverlesswebide.dao.FuncDao;
import com.free4inno.serverlesswebide.dao.UserDao;
import com.free4inno.serverlesswebide.dao.WorkspaceDao;
import com.free4inno.serverlesswebide.entity.Func;
import com.free4inno.serverlesswebide.entity.User;
import com.free4inno.serverlesswebide.entity.Workspace;
import com.free4inno.serverlesswebide.process.FcProcess;
import com.free4inno.serverlesswebide.utils.CodeUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class WorkspaceService {

    @Value("${oss.workspace.path}")
    private String ossWorkspacePathTemplate;

    @Resource
    private WorkspaceDao workspaceDao;

    @Resource
    private FuncDao funcDao;

    @Resource
    private UserDao userDao;

    @Resource
    private FuncService funcService;

    public List<Workspace> getAllByUserId(int userId) {
        return workspaceDao.findAllByUserId(userId);
    }

    public Workspace addWorkspace(int userId, String name) {
        Workspace workspace = new Workspace();
        // set basic
        workspace.setName(name);
        workspace.setUserId(userId);
        // generate code and path
        String uniCode = CodeUtils.getRandomLowString(8);
        workspace.setCode(uniCode);
        workspace.setWorkspaceOssPath(String.format(ossWorkspacePathTemplate, uniCode));
        workspace.setIsActive(Constants.NOT_ACTIVE);
        // save
        workspaceDao.saveAndFlush(workspace);
        log.info("created new workspace");
        return workspace;
    }

    public Func activate(int workspaceId) {
        // get workspace
        Workspace workspace = workspaceDao.findById(workspaceId);
        if (workspace == null) {
            log.error("workspace is not exist");
            return null;
        }
        if (workspace.getIsActive() == Constants.ACTIVE) {
            log.error("workspace already active!");
            return null;
        }

        // get user
        User user = userDao.findById(workspace.getUserId());
        int activeNum = workspaceDao.findAllByUserIdAndIsActive(user.getId(), Constants.ACTIVE).size();
        if (activeNum >= Constants.MAX_ACTIVE_WORKSPACE) {
            log.error("user's active workspace up to limit!");
            return null;
        }

        // find a function to bind with workspace
        List<Func> funcList = funcDao.findByIsAvailable(Constants.AVAILABLE);
        Func selectedFunc;
        if (funcList == null || funcList.isEmpty()) {
            // no available function: create a function
            selectedFunc = funcService.createFunc();
        } else {
            // has available function: get the first in list
            selectedFunc = funcList.get(0);
        }

        // selectedFunc may be null !!!
        if (selectedFunc == null) {
            log.error("get available function failed!");
            return null;
        }

        // do activate
        try {
            // 1. set selected function's env
            Map<String, String> envVariables = new HashMap<>();
            envVariables.put(Constants.DATA_OSS_PATH_KEY, user.getDataOssPath());
            envVariables.put(Constants.DATA_WORKSPACE_PATH_KEY, workspace.getWorkspaceOssPath());
            envVariables.put(Constants.PROXY_HANDLER_KEY, Constants.FUNCTION_HANDLER_URL);
            funcService.updateFunctionEnv(selectedFunc.getName(), envVariables);

            // 2. use workspace code bind domain
            String domainName = String.format(Constants.FUNCTION_DOMAIN_URL, workspace.getCode(), Constants.DOMAIN_NAME);
            selectedFunc.setDomain(domainName);
            funcService.bindDomain(selectedFunc);

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        // save
        workspace.setIsActive(Constants.ACTIVE);
        workspaceDao.saveAndFlush(workspace);

        selectedFunc.setIsAvailable(Constants.NOT_AVAILABLE);
        selectedFunc.setWorkspaceId(workspaceId);
        funcDao.saveAndFlush(selectedFunc);

        return selectedFunc;
    }

    public Workspace release(int workspaceId) {
        // get workspace
        Workspace workspace = workspaceDao.findById(workspaceId);
        if (workspace == null) {
            log.error("workspace is not exist");
            return null;
        }

        // check active
        if (workspace.getIsActive() == Constants.NOT_ACTIVE) {
            log.error("workspace already not active!");
            return null;
        }

        // find the function to unbind
        Func func = funcDao.findByWorkspaceId(workspaceId);
        try {
            // 1. unbind domain
            funcService.unbindDomain(func);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        // save
        workspace.setIsActive(Constants.NOT_ACTIVE);
        workspaceDao.saveAndFlush(workspace);

        func.setIsAvailable(Constants.AVAILABLE);
        func.setWorkspaceId(Constants.EMPTY);
        funcDao.saveAndFlush(func);

        return workspace;
    }

    public String getWorkspaceUrl(int id) {
        Func func = funcDao.findByWorkspaceId(id);
        if (func != null && func.getIsAvailable() == Constants.NOT_AVAILABLE) {
            return String.format(Constants.FUNCTION_FULL_URL, func.getDomain());
        } else {
            return "function bind error!";
        }
    }

    public Workspace getWorkspaceById(int id) {
        return workspaceDao.findById(id);
    }

}
