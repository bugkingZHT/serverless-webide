package com.free4inno.hufu.developertools;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.DecimalFormat;
import java.util.*;
import java.util.concurrent.TimeUnit;

@Service
public class IndexService {
//    @Autowired
//    ProjectDao projectDao;
//
//    @Autowired
//    TemplateDao templateDao;
//
//    @Autowired
//    GenericMetricsService genericMetricsService;
//
//    public int getProjectNum(){
//        return (int)projectDao.count();
//    }
//
//    public int getActiveProjectNum(){
//        return (int)projectDao.countProjectByStatus(Project.StatusEnum.RUNNING);
//    }
//
//    public int getTemplateNum(){
//        return (int)templateDao.count();
//    }
//
//    public int getActiveTemplateNum(){
//        List<Project> projectList = projectDao.findAll();
//        Set<Integer> templateSet = new HashSet<>();
//        for(Project project : projectList){
//            templateSet.add(project.getTemplateId());
//        }
//        return templateSet.size();
//    }
//
//    public List<Map<String, Object>> getHeatRanking(int maxsize){
//        List<Template> templateList = templateDao.findAll();
//        List<Project> projectList = projectDao.findAll();
//        Map<String, String> templateId2Name = new HashMap<>();
//        Map<String, Integer> templateMap = new HashMap<>();
//        for(Template template : templateList){
//            templateId2Name.put(String.valueOf(template.getId()), template.getName());
//            templateMap.put(String.valueOf(template.getId()), 0);
//        }
//        for(Project project: projectList){
//            int cnt = templateMap.getOrDefault(String.valueOf(project.getTemplateId()), 0);
//            templateMap.put(String.valueOf(project.getTemplateId()), cnt + 1);
//        }
//        List<Map<String, Object>> rankingList = new ArrayList<>();
//        for(Map.Entry entry : templateMap.entrySet()){
//            rankingList.add(new HashMap<String, Object>(){
//                {
//                    put("id", entry.getKey());
//                    put("cnt", entry.getValue());
//                    put("name", templateId2Name.getOrDefault(entry.getKey(), ""));
//                }
//            });
//        }
//        rankingList.sort((o1, o2) -> (int)o2.getOrDefault("cnt", 0) - (int)o1.getOrDefault("cnt", 0));
//        if(rankingList.size() <= maxsize) return rankingList;
//        return rankingList.subList(0, maxsize);
//    }
//
//    public Map<String, Double> getHeatRankingForShow(int maxsize){
//        List<Map<String, Object>> rankingList = getHeatRanking(maxsize);
//        Map<String, Double> retMap = new HashMap<>();
//        for(Map<String, Object> item : rankingList){
//            retMap.put(String.valueOf(item.get("name")), Double.valueOf(String.valueOf(item.get("cnt"))));
//        }
//        return retMap;
//    }
//
//    public Map<String, String> getMetricsMap(ProjectMetricEnum enu){
//        List<Project> projectList = projectDao.findAll();
//        List<Project> projectRunningList = new ArrayList<>();
//        for(Project proj : projectList){
//            if(proj.getStatus() == Project.StatusEnum.RUNNING){
//                projectRunningList.add(proj);
//            }
//        }
//        Map<String, String> retMap = new HashMap<>();
//        for(Project proj : projectRunningList){
//            String value = "";
//            try{
//                value = genericMetricsService.searchProjectMetrics(
//                        proj.getName(),
//                        enu,
//                        System.currentTimeMillis() - TimeUnit.HOURS.toMillis(12),
//                        System.currentTimeMillis()
//                ).get(0).getValue();
//            }catch (Exception ignored){
////                ignored.printStackTrace();
//            }
//            retMap.put(proj.getName(), value.equals("") ? "0" : value);
//        }
//        if(retMap.isEmpty()){
//            retMap.put("无正在运行的项目", "0");
//        }
//        return retMap;
//    }
//
//    public Map<String, Double> getMetricsRanking(int maxsize, ProjectMetricEnum enu){
//        Map<String, String> MetricsMap = getMetricsMap(enu);
//        List<Map<String, Object>> rankingList = new ArrayList<>();
//        for(Map.Entry entry : MetricsMap.entrySet()){
//            try {
//                Double value = Double.valueOf(String.valueOf(entry.getValue()));
//                rankingList.add(new HashMap<String, Object>() {
//                    {
//                        put("key", entry.getKey());
//                        put("value", value);
//                    }
//                });
//            }catch (Exception ignored){}
//        }
//        rankingList.sort(new Comparator<Map<String, Object>>() {
//            @Override
//            public int compare(Map<String, Object> o1, Map<String, Object> o2) {
//                return (double)o2.getOrDefault("value", 0) - (double)o1.getOrDefault("value", 0) > 0 ? 1: -1;
//            }
//        });
//        if(rankingList.size() > maxsize){
//            rankingList = rankingList.subList(0, maxsize);
//        }
//        Map<String, Double> retMap = new HashMap<>();
//        for(Map<String, Object> map : rankingList){
//            retMap.put(String.valueOf(map.get("key")), (double)map.get("value"));
//        }
//        return retMap;
//    }
//
//    public Map<String, Double> getMemoryRankingMB(int maxsize){
//        Map<String, Double> metricsRanking = getMetricsRanking(maxsize, ProjectMetricEnum.MEMORY);
//        Map<String, Double> retMap = new HashMap<>();
//        for(Map.Entry entry: metricsRanking.entrySet()){
//            Double v = Double.valueOf(new DecimalFormat("0.00").format((double)entry.getValue() / (1024*1024)));
//            retMap.put(String.valueOf(entry.getKey()), v);
//        }
//        return retMap;
//    }
//
//    public Map<String, Double> getCPURanking(int maxsize){
//        Map<String, Double> metricsRanking = getMetricsRanking(maxsize, ProjectMetricEnum.CPU);
//        Map<String, Double> retMap = new HashMap<>();
//        for(Map.Entry entry: metricsRanking.entrySet()){
//            Double v = Double.valueOf(new DecimalFormat("0.000").format((double)entry.getValue()));
//            retMap.put(String.valueOf(entry.getKey()), v);
//        }
//        return retMap;
//    }
//
//    public Map<String, Double> getNetworkInRankingKB(int maxsize){
//        Map<String, Double> metricsRanking = getMetricsRanking(maxsize, ProjectMetricEnum.NETWORK_INPUT);
//        Map<String, Double> retMap = new HashMap<>();
//        for(Map.Entry entry: metricsRanking.entrySet()){
//            Double v = Double.valueOf(new DecimalFormat("0.00").format((double)entry.getValue() / 1024));
//            retMap.put(String.valueOf(entry.getKey()), v);
//        }
//        return retMap;
//    }
//
//    public Map<String, Double> getNetworkOutRankingKB(int maxsize){
//        Map<String, Double> metricsRanking = getMetricsRanking(maxsize, ProjectMetricEnum.NETWORK_OUTPUT);
//        Map<String, Double> retMap = new HashMap<>();
//        for(Map.Entry entry: metricsRanking.entrySet()){
//            Double v = Double.valueOf(new DecimalFormat("0.00").format((double)entry.getValue() / 1024));
//            retMap.put(String.valueOf(entry.getKey()), v);
//        }
//        return retMap;
//    }
//
//
//    public HistoryLine getProjectHistoryLine(String label, PlatformMetricEnum enu, int pointNum, int day){
//        HistoryLine historyLine = new HistoryLine(label);
//        List<Metric> value = genericMetricsService.searchPlatformMetrics(
//                enu,
//                System.currentTimeMillis() - TimeUnit.DAYS.toMillis(day),
//                System.currentTimeMillis()
//        );
//        value.sort(new Comparator<Metric>() {
//            @Override
//            public int compare(Metric o1, Metric o2) {
//                return (int)(o1.getTime() - o2.getTime());
//            }
//        });
//        if(value.size() >= pointNum) {
//            value = value.subList(value.size() - pointNum, value.size());
//        }
//        for (int i = 0; i < pointNum; i++) {
//            if(i <= pointNum - value.size()){
//                historyLine.getScoreList().add(0.0);
//            }else{
//                try {
//                    historyLine.getScoreList().add(Double.valueOf(value.get(i - pointNum + value.size()).getValue()));
//                }catch (NumberFormatException e){
//                    historyLine.getScoreList().add(0.0);
//                }
//            }
//        }
//        return historyLine;
//    }
}
