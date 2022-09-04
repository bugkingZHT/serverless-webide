package com.free4inno.serverlesswebide.controller;

import com.alibaba.fastjson.JSON;
import com.free4inno.serverlesswebide.entity.Func;
import com.free4inno.serverlesswebide.service.FuncService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Slf4j
@Controller
@RequestMapping("/func")
public class FuncController {

    @Resource
    private FuncService funcService;

    @GetMapping(value = "/list_all")
    @ResponseBody
    public String listAll() {
        List<Func> funcList = funcService.getAllFuncs();
        return JSON.toJSONString(funcList);
    }

    @GetMapping(value = "/create")
    @ResponseBody
    public String create() {
        Func func = funcService.createFunc();
        if (func != null) {
            return JSON.toJSONString(func);
        } else {
            return "create func failed!";
        }
    }

    @GetMapping(value = "/delete")
    @ResponseBody
    public void delete(
            @RequestParam(value = "id") int id) {
        funcService.deleteFunc(id);
    }

}
