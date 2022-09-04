package com.free4inno.serverlesswebide.controller;

import com.alibaba.fastjson.JSON;
import com.free4inno.serverlesswebide.constants.Constants;
import com.free4inno.serverlesswebide.entity.Func;
import com.free4inno.serverlesswebide.entity.Workspace;
import com.free4inno.serverlesswebide.service.FuncService;
import com.free4inno.serverlesswebide.service.WorkspaceService;
import com.free4inno.serverlesswebide.utils.CodeUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

@Slf4j
@Controller
@RequestMapping("/workspace")
public class WorkspaceController {

    @Resource
    private WorkspaceService workspaceService;

    @GetMapping(value = "/list")
    @ResponseBody
    public String list(
            @RequestParam(value = "user_id") int userId) {
        List<Workspace> res = workspaceService.getAllByUserId(userId);
        return JSON.toJSONString(res);
    }

    @GetMapping(value = "/new")
    @ResponseBody
    public String newWorkspace(
            @RequestParam(value = "user_id") int userId,
            @RequestParam(value = "name") @NotNull @NotEmpty String name) {
        Workspace workspace = workspaceService.addWorkspace(userId, name);
        if (workspace != null) {
            return JSON.toJSONString(workspace);
        } else {
            return "Create workspace failed!";
        }
    }

    @GetMapping(value = "/activate")
    @ResponseBody
    public String activate(
            @RequestParam(value = "id") int workspaceId) {
        Func func = workspaceService.activate(workspaceId);
        if (func != null) {
            return JSON.toJSONString(func);
        } else {
            return "Activate workspace failed!";
        }
    }

    @GetMapping(value = "/release")
    @ResponseBody
    public String release(
            @RequestParam(value = "id") int workspaceId) {
        Workspace workspace = workspaceService.release(workspaceId);
        if (workspace != null) {
            return JSON.toJSONString(workspace);
        } else {
            return "Release workspace failed!";
        }
    }

    @GetMapping(value = "/workspace")
    @ResponseBody
    public String workspace(
            @RequestParam(value = "id") int workspaceId) {
        Workspace workspace = workspaceService.getWorkspaceById(workspaceId);
        return JSON.toJSONString(workspace);
    }

    @GetMapping(value = "/url")
    @ResponseBody
    public String getUrl(
            @RequestParam(value = "id") int workspaceId) {
        return workspaceService.getWorkspaceUrl(workspaceId);
    }

}
