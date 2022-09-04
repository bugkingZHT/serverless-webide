package com.free4inno.hufu.developertools.model;

import lombok.Data;

import java.util.List;

@Data
public class TextMachine {
    private String uuid;
    private List<String> valueList;
    public TextMachine(String uuid,List<String> valueList){
        this.uuid = uuid;
        this.valueList = valueList;
    }
}
