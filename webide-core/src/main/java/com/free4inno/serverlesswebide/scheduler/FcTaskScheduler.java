package com.free4inno.serverlesswebide.scheduler;

import com.free4inno.serverlesswebide.service.FuncService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

@Slf4j
@Component
public class FcTaskScheduler {

    @Resource
    private FuncService funcService;

    @Scheduled(cron = "0 */1 * * * ?")
    public void functionPoolScaleTask() {
        log.info("...function pool scale task");
        funcService.autoScaledAlgorithm();
    }

//    @Scheduled(cron = "*/15 * * * * ?")
//    public void functionPoolCheckAvailableTask() {
//        log.info("...function pool check available task");
//        funcService.checkAvailable();
//    }
}
