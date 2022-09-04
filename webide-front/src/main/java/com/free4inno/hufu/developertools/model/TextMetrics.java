package com.free4inno.hufu.developertools.model;

import lombok.Data;

@Data
public class TextMetrics {
    private String name;
    public TextMetrics(String name){
        this.name = name;
    }
}
