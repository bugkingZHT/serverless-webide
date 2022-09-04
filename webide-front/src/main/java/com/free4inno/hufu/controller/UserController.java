package com.free4inno.hufu.controller;

import com.alibaba.fastjson.JSONObject;
import com.free4inno.hufu.service.ClientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

@Controller
public class UserController {
    @Autowired
    private ClientService clientService;

    @GetMapping("/login")
    public String login(HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "login";
        } else {
            return "redirect:/";
        }
    }

    @ResponseBody
    @PostMapping("/login")
    public boolean login(HttpSession session,
                         @RequestParam("username") String username,
                         @RequestParam("password") String password) throws IOException {
        Map<String, String> paraMap = new HashMap<>();
        paraMap.put("username", username);
        paraMap.put("password", password);
        String resStr = clientService.requestAny(paraMap, "/user/login", "GET");
        System.out.println(resStr);
        try {
            JSONObject resObject = JSONObject.parseObject(resStr);
            String userId = String.valueOf(resObject.get("id"));
            String userName = (String) resObject.get("username");
            session.setAttribute("username", userName);
            session.setAttribute("user_id", userId);

        } catch (Exception e) {
            return false;
        }
        return true;

    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        String username = (String)session.getAttribute("username");

        Enumeration em = session.getAttributeNames();
        while(em.hasMoreElements()){
            session.removeAttribute(em.nextElement().toString());
        }
        return "redirect:/login";
    }
}
