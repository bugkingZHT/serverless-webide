package com.free4inno.hufu.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.free4inno.hufu.service.ClientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/project")
public class ProjectController {
    public final static String ACTIVE = "1";
    public final static String DEACTIVE = "0";
    @Autowired
    private ClientService clientService;

    @Autowired
    private HttpServletRequest request;

    @GetMapping("")
    public String getInitProject() {

        return "kubernetes/projectPage";
    }

    @GetMapping("/getProjects")
    public String getProjects(HttpSession session, Map<String, Object> map, @RequestParam("page") Integer currentPage, @RequestParam("search") String searchKey) throws IOException {
        //后端获取列表数据
        String user_id = (String)session.getAttribute("user_id");
        Map<String, String> paraMap = new HashMap<>();
        paraMap.put("user_id", user_id);
        String resStr = clientService.requestAny(paraMap, "/workspace/list", "GET");
        JSONArray workSpaceArray = JSONArray.parseArray(resStr);

        map.put("workSpaceList", workSpaceArray);
        map.put("searchedProjectNum", workSpaceArray.size());

        return "kubernetes/_projectList";
    }

    @GetMapping("/activate")
    @ResponseBody
    public boolean start(@RequestParam("id") Integer wsId) throws IOException {
        Map<String, String> paraMap = new HashMap<>();
        paraMap.put("id", String.valueOf(wsId));
        String resStr = clientService.requestAny(paraMap, "/workspace/activate", "GET");
        JSONObject resObject = JSONObject.parseObject(resStr);
        if ((int) resObject.get("isAvailable") == 0) {
            return true;
        } else return false;
    }

    @GetMapping("/gotoide")
    @ResponseBody
    public String gotoIde(@RequestParam("id") Integer wsId) throws IOException {
        Map<String, String> paraMap = new HashMap<>();
        paraMap.put("id", String.valueOf(wsId));
        String resStr = clientService.requestAny(paraMap, "/workspace/url", "GET");
        return resStr;
    }

    @GetMapping("/newWorkSpace")
    public String newWorkSpace() throws IOException {

        return "kubernetes/newProject";
    }

    @ResponseBody
    @PostMapping("/createWorkSpace")
    public String createNewProject(HttpSession session, @RequestParam("name") String name) throws IOException {
        Map<String, String> paraMap = new HashMap<>();
        paraMap.put("name", name);
        String user_id = (String)session.getAttribute("user_id");
        paraMap.put("user_id", user_id);
        System.out.println(name);
        String resStr = clientService.requestAny(paraMap, "/workspace/new", "GET");
        return "ok";
    }

    @GetMapping("/release")
    @ResponseBody
    public boolean release(@RequestParam("id") Integer wsId) throws IOException {
        Map<String, String> paraMap = new HashMap<>();
        paraMap.put("id", String.valueOf(wsId));
        String resStr = clientService.requestAny(paraMap, "/workspace/release", "GET");
        try {
            JSONObject resObject = JSONObject.parseObject(resStr);
            return true;
        } catch (Exception e) {
            return false;

        }
    }
}
