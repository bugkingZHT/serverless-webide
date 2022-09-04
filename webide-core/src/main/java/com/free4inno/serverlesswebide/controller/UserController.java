package com.free4inno.serverlesswebide.controller;

import javax.annotation.Resource;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import com.alibaba.fastjson.JSON;
import com.free4inno.serverlesswebide.entity.User;
import com.free4inno.serverlesswebide.service.FuncService;
import com.free4inno.serverlesswebide.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Slf4j
@Controller
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserService userService;

    @GetMapping(value = "/login")
    @ResponseBody
    public String login(
            @RequestParam(value = "username") @NotNull @NotEmpty String username,
            @RequestParam(value = "password") @NotNull @NotEmpty String password) {
        User user = userService.login(username, password);
        if (user != null) {
            return JSON.toJSONString(user);
        } else {
            return "login failed. ERR: wrong username or password!";
        }
    }

    @GetMapping(value = "/register")
    @ResponseBody
    public String register(
            @RequestParam(value = "username") @NotNull @NotEmpty String username,
            @RequestParam(value = "password") @NotNull @NotEmpty String password) {
        User user = userService.addUser(username, password);
        if (user != null) {
            return JSON.toJSONString(user);
        } else {
            return "register failed. ERR: duplicate username!";
        }
    }
}
