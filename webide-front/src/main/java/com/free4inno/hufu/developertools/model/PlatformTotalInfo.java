package com.free4inno.hufu.developertools.model;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class PlatformTotalInfo {
    private long beginTime;
    private int interval;
    private int num;
    private List<HistoryLine> historyLineList;
    public PlatformTotalInfo(long beginTime, int interval, int num){
        this.beginTime = beginTime;
        this.interval = interval;
        this.num = num;
        this.historyLineList = new ArrayList<>();
    }
}
