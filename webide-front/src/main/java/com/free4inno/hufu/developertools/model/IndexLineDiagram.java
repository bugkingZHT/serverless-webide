package com.free4inno.hufu.developertools.model;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class IndexLineDiagram {
    private String name;
    private long beginTime;
    private int interval;
    private int num;
    private List<HistoryLine> historyLineList;
    public IndexLineDiagram(String name, long beginTime, int interval, int num){
        this.name = name;
        this.beginTime = beginTime;
        this.interval = interval;
        this.num = num;
        this.historyLineList = new ArrayList<>();
    }
}
