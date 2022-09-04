package com.free4inno.hufu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/chart")
public class HelmChartController {
    @GetMapping("")
    public String getInitChart() {

        return "kubernetes/templatePage";
    }
}
