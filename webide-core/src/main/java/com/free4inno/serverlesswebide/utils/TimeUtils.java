package com.free4inno.serverlesswebide.utils;

import java.util.concurrent.TimeUnit;

public class TimeUtils {

    /**
     * sleep by seconds
     * @param timeout
     */
    public static void sleepBySeconds(long timeout) {
        try {
            TimeUnit.SECONDS.sleep(timeout);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
