package com.free4inno.hufu.developertools.model;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class IndexFormInfo {
    private List<TextBox> textBoxList;
    private List<DoubleTextBox> doubleTextBoxList;
    private List<TextChart> textChartList;
    private List<IndexHeatInfo> indexHeatInfoList;
    private List<ServiceLabel> serviceLabelList;
    private List<IndexLineDiagram> indexLineDiagramList;
    private List<IndexHistogram> indexHistogramList;
    private List<ComponentOrderItem> componentOrderList;
    private List<String> separatorList;
    private ComponentNum componentNum;

    public IndexFormInfo(){
        textBoxList = new ArrayList<>();
        doubleTextBoxList = new ArrayList<>();
        textChartList = new ArrayList<>();
        indexHeatInfoList = new ArrayList<>();
        indexLineDiagramList = new ArrayList<>();
        indexHistogramList = new ArrayList<>();
        serviceLabelList = new ArrayList<>();
        componentOrderList = new ArrayList<>();
        componentNum = new ComponentNum();
        separatorList = new ArrayList<>();
    }

    public void clear(){
        textChartList.clear();
        textBoxList.clear();
        doubleTextBoxList.clear();
        indexHeatInfoList.clear();
        indexLineDiagramList.clear();
        indexHistogramList.clear();
        serviceLabelList.clear();
        componentOrderList.clear();
        separatorList.clear();
        componentNum.setHeatMapNum(0);
        componentNum.setTextChartNum(0);
        componentNum.setHistogramNum(0);
        componentNum.setLineDiagramNum(0);
    }

    public void addTextBox(TextBox textBox){
        textBoxList.add(textBox);
        componentOrderList.add(new ComponentOrderItem("textBox",String.valueOf(textBoxList.size()-1),textBoxList.size()-1));
    }

    public void addDoubleTextBox(DoubleTextBox doubleTextBox){
        doubleTextBoxList.add(doubleTextBox);
        componentOrderList.add(new ComponentOrderItem("doubleTextBox",String.valueOf(doubleTextBoxList.size()-1),doubleTextBoxList.size()-1));
    }

    public void addTextChart(TextChart textChart){
        textChartList.add(textChart);
        componentOrderList.add(new ComponentOrderItem("textChart","textChart" + String.valueOf(textChartList.size()-1),textChartList.size()-1));
        componentNum.setTextChartNum(componentNum.getTextChartNum() + 1);
    }

    public void addHeatMap(IndexHeatInfo indexHeatInfo){
        indexHeatInfoList.add(indexHeatInfo);
        componentOrderList.add(new ComponentOrderItem("indexHeatInfo","indexHeatInfo" + String.valueOf(indexHeatInfoList.size()-1),indexHeatInfoList.size()-1));
        componentNum.setHeatMapNum(componentNum.getHeatMapNum() + 1);
    }

    public void addIndexLabel(ServiceLabel serviceLabel){
        serviceLabelList.add(serviceLabel);
        componentOrderList.add(new ComponentOrderItem("serviceLabel",String.valueOf(serviceLabelList.size()-1),serviceLabelList.size()-1));
    }

    public void addSeparator(String separatorValue){
        separatorList.add(separatorValue);
        componentOrderList.add(new ComponentOrderItem("separator",String.valueOf(separatorList.size()-1),separatorList.size()-1));
    }

    public void addIndexLineDiagram(IndexLineDiagram indexLineDiagram){
        indexLineDiagramList.add(indexLineDiagram);
        componentOrderList.add(new ComponentOrderItem("indexLineDiagram","indexLineDiagram" + String.valueOf(indexLineDiagramList.size()-1),indexLineDiagramList.size()-1));
        componentNum.setLineDiagramNum(componentNum.getLineDiagramNum() + 1);
    }

    public void addIndexHistogram(IndexHistogram indexHistogram){
        indexHistogramList.add(indexHistogram);
        componentOrderList.add(new ComponentOrderItem("indexHistogram","indexHistogram" + String.valueOf(indexHistogramList.size()-1),indexHistogramList.size()-1));
        componentNum.setHistogramNum(componentNum.getHistogramNum() + 1);
    }
}
