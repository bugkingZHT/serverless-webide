package com.free4inno.hufu.developertools.model;

import lombok.Data;

@Data
public class TextBox {
    private String name;
    private String value;
    private String url;
    public TextBox(String name, String value, String url){
        this.name = name;
        this.value = value;
        this.url = url;
    }
}
