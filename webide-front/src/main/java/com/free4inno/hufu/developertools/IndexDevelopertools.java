package com.free4inno.hufu.developertools;

import com.free4inno.hufu.developertools.model.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * IndexDevelopertools.
 */

@Service
public class IndexDevelopertools {
//    @Autowired
//    private VmSummaryDao vmSummaryDao;
//
//    @Resource
//    private GenericMetricsService metricService;

    private static final Long METRICS_QUERY_PERIOD = TimeUnit.DAYS.toMillis(7); //定义7天的查询窗口
    private static final Long METRICS_QUERY_GRANULARITY = TimeUnit.HOURS.toMillis(1); //定义1小时的查询粒度

//    @Autowired
//    private ScoreService scoreService;

    @Autowired
    private IndexService indexService;

    private IndexFormInfo indexFormInfo = new IndexFormInfo();

    public PlatformTotalInfo setPlatformTotalInfo() {

        /* Config begin time and time interval and points' number of platform curve here. */

        long beginTime = System.currentTimeMillis() - 1000L * 3600L * 24L * 30L;
        int num = 720;
        PlatformTotalInfo platformTotalInfo = new PlatformTotalInfo(beginTime, 1000 * 3600, num);

        /* Add your curve to platformTotalInfo. */

//        HistoryLine historyLine = new HistoryLine("基础设施");
//        List<Metric> metricScoreList = scoreService.getAllMetrics(PlatformMetricEnum.METRIC_SCORE);
//        List<Metric> appScoreList = scoreService.getAllMetrics(PlatformMetricEnum.PROJECT_SCORE);
//        for (int i = 0; i < 720; i++) {
//            historyLine.getScoreList().add(Double.parseDouble(metricScoreList.get(i).getValue()));
//        }
//        platformTotalInfo.getHistoryLineList().add(historyLine);

        /* Add your curve to platformTotalInfo. */

//        HistoryLine historyLine2 = new HistoryLine("应用");
//        for (int i = 0; i < 720; i++) {
//            historyLine2.getScoreList().add(Double.parseDouble(appScoreList.get(i).getValue()));
//        }
//        platformTotalInfo.getHistoryLineList().add(historyLine2);


        /* User coding area end. */
        return platformTotalInfo;
    }

    public void setIndexFormInfo() {
        indexFormInfo.clear();
        /* User coding area begin. Add your own information here. */

        indexFormInfo.addSeparator("应用");
        indexFormInfo.addTextBox(new TextBox("项目", "loading", "/workcomponent"));
        indexFormInfo.addTextBox(new TextBox("模板", "loading", "/workcomponent"));
        indexFormInfo.addIndexLabel(new ServiceLabel("/static/images/prometheus.png", "http://prometheus.docker.free4inno.com/graph"));
        indexFormInfo.addIndexLabel(new ServiceLabel("/static/images/harbor.png", "http://newharbor.free4inno.com/"));
        indexFormInfo.addIndexLabel(new ServiceLabel("/static/images/grafana.png", "http://grafana.docker.free4inno.com"));
        indexFormInfo.addIndexLabel(new ServiceLabel("/static/images/dashboard.png", "http://www.free4inno.com"));
        indexFormInfo.addSeparator("");

        IndexHistogram indexHistogram2 = new IndexHistogram("模板热度");
        indexHistogram2.setColor("#fe9702");
        indexFormInfo.addIndexHistogram(indexHistogram2);

        IndexLineDiagram indexLineDiagram = new IndexLineDiagram(
                "项目数（30天）",
                System.currentTimeMillis() - 1000L * 3600L * 24L * 30L,
                1000 * 3600,
                720);
        indexFormInfo.addIndexLineDiagram(indexLineDiagram);

        IndexHistogram indexHistogram3 = new IndexHistogram("CPU负载（core）");
        indexHistogram3.setColor("#fe9702");
        indexFormInfo.addIndexHistogram(indexHistogram3);

        IndexHistogram indexHistogram4 = new IndexHistogram("内存负载（MB）");
        indexHistogram4.setColor("#fe9702");
        indexFormInfo.addIndexHistogram(indexHistogram4);

        IndexHistogram indexHistogram5 = new IndexHistogram("网络INPUT（kbps）");
        indexHistogram5.setColor("#fe9702");
        indexFormInfo.addIndexHistogram(indexHistogram5);

        IndexHistogram indexHistogram6 = new IndexHistogram("网络OUTPUT（kbps）");
        indexHistogram6.setColor("#fe9702");
        indexFormInfo.addIndexHistogram(indexHistogram6);

        /* User coding area end. */
    }

//    public List<TextBox> getTextBoxList() {
//        this.indexFormInfo.getTextBoxList().get(0).setValue(indexService.getActiveProjectNum() + "/" + indexService.getProjectNum());
//        this.indexFormInfo.getTextBoxList().get(1).setValue(indexService.getActiveTemplateNum() + "/" + indexService.getTemplateNum());
//        return this.indexFormInfo.getTextBoxList();
//    }

    public List<DoubleTextBox> getDoublueTextBoxList() {
        return this.indexFormInfo.getDoubleTextBoxList();
    }

    public TextChart getTextChartByIndex(int index) {
        return this.indexFormInfo.getTextChartList().get(index);
    }

    public IndexHeatInfo getIndexHeatInfoByIndex(int index) {
        return this.indexFormInfo.getIndexHeatInfoList().get(index);
    }

//    public IndexLineDiagram getIndexLineDiagram(int index) {
//        if(index == 0) {
//            this.indexFormInfo.getIndexLineDiagramList().get(0).getHistoryLineList().add(
//                    indexService.getProjectHistoryLine("总数",
//                    PlatformMetricEnum.TOTAL_PROJECT_NUM, 720, 30)
//            );
//            this.indexFormInfo.getIndexLineDiagramList().get(0).getHistoryLineList().add(
//                    indexService.getProjectHistoryLine("运行中",
//                    PlatformMetricEnum.RUNNING_PROJECT_NUM, 720, 30)
//            );
//        }
//        return this.indexFormInfo.getIndexLineDiagramList().get(index);
//    }

//    public IndexHistogram getIndexHistogram(int index) {
//        switch (index){
//            case 0:
//                this.indexFormInfo.getIndexHistogramList().get(index).setContent(
//                        indexService.getHeatRankingForShow(5)
//                );
//                break;
//            case 1:
//                this.indexFormInfo.getIndexHistogramList().get(index).setContent(
//                        indexService.getCPURanking(4)
//                );
//                break;
//            case 2:
//                this.indexFormInfo.getIndexHistogramList().get(index).setContent(
//                        indexService.getMemoryRankingMB(5)
//                );
//                break;
//            case 3:
//                this.indexFormInfo.getIndexHistogramList().get(index).setContent(
//                        indexService.getNetworkInRankingKB(6)
//                );
//                break;
//            case 4:
//                this.indexFormInfo.getIndexHistogramList().get(index).setContent(
//                        indexService.getNetworkOutRankingKB(3)
//                );
//                break;
//        }
//        return this.indexFormInfo.getIndexHistogramList().get(index);
//    }

    public List<ServiceLabel> getServiceLabelList() {
        return this.indexFormInfo.getServiceLabelList();
    }

    public List<ComponentOrderItem> getComponentOrderList() {
        return this.indexFormInfo.getComponentOrderList();
    }

    public ComponentNum getComponentNum() {
        return this.indexFormInfo.getComponentNum();
    }

    public List<String> getSeparatorList() {
        return this.indexFormInfo.getSeparatorList();
    }

//    /**
//     * Generate the platform metrics of ALL time for the echarts
//     * if it doesn't have a point in a certain time, the value is 0
//     * @param metricEnum
//     * @return
//     */
//    public List<Metric> getAllMetrics(PlatformMetricEnum metricEnum) {
//        List<Metric> allMetrics;
//        allMetrics = metricService.searchPlatformMetrics(metricEnum, System.currentTimeMillis() - METRICS_QUERY_PERIOD, System.currentTimeMillis());
//        //log.info(allMetrics.toString());
//        Collections.sort(allMetrics);
//        Long initialTime = System.currentTimeMillis() / METRICS_QUERY_GRANULARITY * METRICS_QUERY_GRANULARITY - METRICS_QUERY_PERIOD + TimeUnit.HOURS.toMillis(1);
//        //log.info(initialTime.toString());
//        int j = 0;
//        List<Metric> sendMetrics = new ArrayList<>();
//        for (int i = 0; i < METRICS_QUERY_PERIOD/METRICS_QUERY_GRANULARITY; i++) {
//            Long time = initialTime + i * METRICS_QUERY_GRANULARITY;
//            if (allMetrics.isEmpty()) {
//                sendMetrics.add(new Metric(time, "0"));
//            } else {
//                if (time == allMetrics.get(j).getTime()) {
//                    sendMetrics.add(new Metric(time, allMetrics.get(j).getValue()));
//                    if (j < allMetrics.size() - 1) {
//                        j++;
//                    }
//                } else {
//                    sendMetrics.add(new Metric(time, "0"));
//                }
//            }
//
//        }
//        //log.info(sendMetrics.toString());
//        return sendMetrics;
//    }
}
