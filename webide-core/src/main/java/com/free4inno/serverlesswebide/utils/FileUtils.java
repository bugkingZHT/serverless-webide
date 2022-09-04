package com.free4inno.serverlesswebide.utils;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;


public class FileUtils {
    public static String readAll(String filePath) {
        String content = "";
        StringBuilder builder = new StringBuilder();
        try {
            File file = new File(filePath);
            InputStreamReader streamReader = new InputStreamReader(new FileInputStream(file), StandardCharsets.UTF_8);
            BufferedReader bufferedReader = new BufferedReader(streamReader);
            while ((content = bufferedReader.readLine()) != null) {
                builder.append(content);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return builder.toString();
    }
}
