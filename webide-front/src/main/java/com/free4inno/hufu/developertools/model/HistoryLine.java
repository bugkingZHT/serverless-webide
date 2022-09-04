package com.free4inno.hufu.developertools.model;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class HistoryLine {
    private String name;
    private List<Double> scoreList;

    public HistoryLine(String name){
        this.name = name;
        this.scoreList = new ArrayList<>();
    }
}
