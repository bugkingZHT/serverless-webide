package com.free4inno.hufu.developertools.model;

import lombok.Data;

import java.util.HashMap;
import java.util.Map;

@Data
public class IndexHistogram {
    private String title;
    private String color;
    private Map<String, Double> content;
    public IndexHistogram(String title){
        this.title = title;
        this.color = "#5078f1";
        this.content = new HashMap<>();
    }
}
