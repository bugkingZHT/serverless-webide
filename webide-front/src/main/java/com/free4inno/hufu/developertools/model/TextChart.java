package com.free4inno.hufu.developertools.model;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class TextChart {
    private String name;
    private List<TextBox> chartInfo;

    public TextChart(String name){
        chartInfo = new ArrayList<>();
        this.name = name;
    }
}
