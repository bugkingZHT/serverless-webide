package com.free4inno.hufu.developertools.model;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class IndexHeatInfo {
    private List<TextMachine> textOriginalList;
    private List<TextMachine> textMachineList;
    private List<TextMetrics> textMetricsList;
    private String name;
    public IndexHeatInfo( String name) {
        textMachineList = new ArrayList<>();
        textOriginalList = new ArrayList<>();
        textMetricsList = new ArrayList<>();
        this.name = name;
    }
}
