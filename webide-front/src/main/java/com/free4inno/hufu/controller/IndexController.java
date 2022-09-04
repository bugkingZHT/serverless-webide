package com.free4inno.hufu.controller;

import com.free4inno.hufu.developertools.IndexDevelopertools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class IndexController {
    @Autowired
    private IndexDevelopertools indexDevelopertools;

    @GetMapping("/")
    public String index(Map<String, Object> map){

//        System.out.println("/index/");
//        List<Config> ConfigList = configDao.findByApplication("Main");
//        Config tempConfig = ConfigList.get(0);
//        System.out.println(tempConfig);
//        System.out.println(tempConfig.getLzurl() + "\t" + tempConfig.getAppKey());
//        if ((tempConfig.getLzurl().length() == 0) || (tempConfig.getAppKey().length() == 0) ||(tempConfig.getAppName().length() == 0) || (tempConfig.getSecretKey().length() == 0))
//        {
////            return "metrics/index";
//            System.out.println("configerror");
//            return "error/ConfigError";
//        }



//        metricsService.indexRequests.mark();
//        List<Status> statusList = new ArrayList<>();
//        System.out.println(metrics.getMeters());
//        long etime = new Date().getTime();
//        long btime = new Date().getTime()-1000*60*60*24L;
//        String top = "";
//        String diskinfo = "";
//        String network = "";
//        String disk_error = "";
//        String reg = "";
//        Pattern pattern;
//        Matcher matcher;
//        String cpu1 = "";
//        String mem1 = "10";
//        String swap1 = "10";
//        String disk1 = "10";
//        String networkRecv1 = "10";
//        String networkSend1 = "10";
//        String host = "";
//        String level = "test";
//        String info = "";
//        JSONObject jsonObject = new JSONObject();
//        JSONObject infoObject = new JSONObject();
//        List<VmSummary> vmSummaryList = vmSummaryDao.findByType("SERVICE");
//        JSONArray jsonArray1 = lolService.getInfo(btime+"",etime+"", "192.168.35.91", "", level, "");
//        System.out.println("json:"+jsonArray1);
////        for(int i=0;i<jsonArray1.size();i++){
////            jsonObject = jsonArray1.getJSONObject(i);
////            info = jsonObject.getString("content");
////            infoObject = JSONObject.fromObject(info);
////            top = infoObject.getString("top");
////            System.out.println("top: "+top);
////        }
//        jsonObject = jsonArray1.getJSONObject(0);
//        info = jsonObject.getString("content");
//        infoObject = JSONObject.fromObject(info);
//        top = infoObject.getString("top");
////        System.out.println("top:"+top);
//        diskinfo = infoObject.getString("diskinfo");
////        System.out.println("diskinfo:"+diskinfo);
//        network = infoObject.getString("network");
//        System.out.println("network:"+network);
//        disk_error = infoObject.getString("disk_error");
//        //top
//        reg = "Cpu\\(s\\):\\s+(\\d+\\.\\d)us,.*\\s+Mem:\\s+(\\d*)k\\s+total,.+\\s+(\\d+)k\\s+free,.+\\s+Swap:\\s+(\\d*)k\\s+total,.+\\s+(\\d+)k\\s+free,";
//        pattern = Pattern.compile(reg);
//        matcher = pattern.matcher(top);
//        if(matcher.find()){
//            cpu1 = Float.parseFloat(matcher.group(1))/10+"";
//            mem1 = ((Double.parseDouble(matcher.group(2))-Double .parseDouble(matcher.group(3)))/Double.parseDouble(matcher.group(2)))*10+"";
//            swap1 = ((Double.parseDouble(matcher.group(4))-Double .parseDouble(matcher.group(5)))/Double.parseDouble(matcher.group(4)))*10+"";
//        }
//        else{
//            System.out.println("没找着top1");
//        }
//        System.out.println("cpu1:"+cpu1+"\nmem1:"+mem1+"\nswap1:"+swap1);
//        //disk
//        reg = "root\\s+.+\\s+.+\\s+.+\\s+(\\d+)\\s+/\\s+";
//        pattern = Pattern.compile(reg);
//        matcher = pattern.matcher(diskinfo);
//        if(matcher.find()){
////                    System.out.println(matcher.group());
//            disk1 = Double.parseDouble(matcher.group(1))/10+"";
//            System.out.println("disk1: "+disk1);
//        }
//        else{
//            System.out.println("没找着diskinfo");
//        }
//
//        //disk_error
////        reg = "time:\n.+\n.\\d+";
//        reg = "\n\\d+\n";
//        int broken = 0;
//        pattern = Pattern.compile(reg);
//        matcher = pattern.matcher(disk_error);
//        while(matcher.find()){
//            broken++;
//            System.out.println(matcher.group());
//        }
//
//        //network
//        reg = "send\\s+\\d+\\s+\\d+\\s+(\\d+)(\\D)\\s+(\\d+)(\\D)";
//        pattern = Pattern.compile(reg);
//        matcher = pattern.matcher(network);
//        if(matcher.find()){
////                    System.out.println(matcher.group());
//            networkRecv1 = matcher.group(1);
//            String networkRecva = matcher.group(2);
//            networkSend1 = matcher.group(3);
//            String networkSenda = matcher.group(4);
//            if(networkRecva.equals("B"))
//                networkRecv1 = Double.parseDouble(networkRecv1)/10000000+"";
//            else if(networkRecva.equals("k"))
//                networkRecv1 = Double.parseDouble(networkRecv1)/10000+"";
//            else if(networkRecva.equals("m"))
//                networkRecv1 = Double.parseDouble(networkRecv1)/10+"";
//
//            if(networkSenda.equals("B"))
//                networkSend1 = Double.parseDouble(networkSend1)/10000000+"";
//            else if(networkSenda.equals("k"))
//                networkSend1 = Double.parseDouble(networkSend1)/10000+"";
//            else if(networkSenda.equals("m"))
//                networkSend1 = Double.parseDouble(networkSend1)/10+"";
//            System.out.println("net: "+networkSend1);
//        }
//        else {
//            System.out.println("没找着network");
//        }
//        JSONObject jsonObject0 = new JSONObject();
//        jsonObject0.put("cpu", cpu1);
//        jsonObject0.put("mem", mem1);
//        jsonObject0.put("swap", swap1);
//        jsonObject0.put("disk", disk1);
//        jsonObject0.put("disk_error", broken);
//        jsonObject0.put("networkSend", networkSend1);
//        jsonObject0.put("networkRecv", networkRecv1);
//        Config infrastructureConfig=configDao.findByApplication("Infrastructure").get(0);
//
//        List<Status> statusList = new ArrayList<>();
//        List<VmSummary> vmSummaryList = vmSummaryDao.findByType("SERVICE");
//        List<String> vmMacList = new ArrayList<>();
//        for(VmSummary vmSummary:vmSummaryList){
//            vmMacList.add(vmSummary.getUuid());
//        }
//        HashSet<String> hs = new HashSet<String>(vmMacList);
//        vmMacList.clear();
//        vmMacList.addAll(hs);
//        for(String mac:vmMacList){
//            boolean resetFlag=false;
//            JSONArray logArray=new JSONArray();
//            if ((infrastructureConfig.getLzurl().length() > 0) && (infrastructureConfig.getAppKey().length() > 0) && (infrastructureConfig.getAppName().length() > 0) && (infrastructureConfig.getSecretKey().length() > 0))
//            {
//                try{
//                    String appkey = infrastructureConfig.getAppKey();
//                    String secretkey = infrastructureConfig.getSecretKey();
//                    String appname = infrastructureConfig.getAppName();
//                    String url = infrastructureConfig.getLzurl();
//                    Long eTime = System.currentTimeMillis();
//                    String endTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(eTime));
//                    Long bTime = (System.currentTimeMillis()-600000000);//600000 :10min
//                    String beginTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(bTime));
//
//                    JSONObject queryMap = new JSONObject();
//                    queryMap.put("beginTime",beginTime);
//                    queryMap.put("endTime",endTime);
//                    queryMap.put("ipaddress",mac);
//                    queryMap.put("page",1);
//                    queryMap.put("index",1);
//                    String query = queryMap.toJSONString();
//                    String serviceData = lolutil.operateLog(appkey,secretkey,appname,
//                            query,url,"GET");
//
//                    JSONObject serviceDataJsonObject = JSON.parseObject(serviceData);
//
//                    //Error的处理
////                    if(serviceDataJsonObject.get("data").toString().equals("ERROR")){
////                        resetFlag=false;
////                    }
//
//                    JSONObject serviceDataJson=JSON.parseObject(serviceDataJsonObject.get("data").toString());
//
//                    if(Integer.parseInt(serviceDataJson.get("size").toString())>0){
//                        logArray = JSON.parseArray(serviceDataJson.get("item").toString());
//                        resetFlag=true;
//                    }
//                }catch (Exception e){
//                    resetFlag=false;
//                }
//            }
//
////            Status status = statusDao.findFirstByStatusAddressOrderByStatusTimeDesc(mac);
//            Status status=new Status();
//            if(resetFlag){
//                JSONObject job = logArray.getJSONObject(0);
//                status.setStatusId(Integer.parseInt(job.get("id").toString()));
//                status.setStatusTime(new Timestamp(Long.parseLong(job.get("createdTime").toString())));
//                status.setStatusAddress(mac);
//                status.setStatusContent(job.get("content").toString());
//            }else{
//                status.setStatusId(0);
//                status.setStatusTime(new Timestamp(System.currentTimeMillis()));
//                status.setStatusAddress(mac);
//                status.setStatusContent("{\"cpu\":100.0,\"mem\":100.0,\"swap\":100.0,\"disk\":100.0,\"disk_error\":100.0,\"networkSend\":50000000000,\"networkRecv\":50000000000}");
//            }
////                status.setStatusContent("{\"cpu\":0.0,\"mem\":0.0,\"swap\":0.0,\"disk\":0.0,\"disk_error\":0,\"networkSend\":0.0,\"networkRecv\":0.0}");
//            statusList.add(status);
//        }
//        System.out.println("statusList: "+statusList);
        //indexDevelopertools.setIndexFormInfo(statusList);
//        map.put("textBoxList",indexDevelopertools.getTextBoxList());
        map.put("doubleTextBoxList",indexDevelopertools.getDoublueTextBoxList());
        map.put("serviceLabelList",indexDevelopertools.getServiceLabelList());
        map.put("componentOrderList",indexDevelopertools.getComponentOrderList());
        map.put("componentNum",indexDevelopertools.getComponentNum());
        map.put("separatorList",indexDevelopertools.getSeparatorList());
        return "kubernetes/index";
    }
}
