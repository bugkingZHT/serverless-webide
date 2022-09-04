package com.free4inno.hufu.service;

import okhttp3.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Map;
import java.util.Objects;

@Service
public class ClientService {
    private OkHttpClient client;
    @Value("${hufu-server-url}")
    private String address;
    private RequestBody body;

    ClientService() {
        client = new OkHttpClient().newBuilder()
                .build();
    }

    public String intercept(String origin) {
        int idx1, idx2;
        idx1 = origin.indexOf("//", 0);
        idx2 = origin.indexOf("/", idx1+2);
        return origin.substring(idx2);
    }

    public String requestAny(Map<String,String> m, String requestUrl, String method) throws IOException {
        if (method.equals("GET"))
            return requestGet(m, requestUrl);
        else if (method.equals("POST"))
            return requestPost(m, requestUrl);
        else
            return requestDel(m, requestUrl);
    }

    public String requestGet(Map<String,String> m, String requestUrl) throws IOException {

        String params = "";
        String url = address.concat(requestUrl);

        url = getParams(m, params, url);

        Request request = new Request.Builder()
                .url(url)
                .method("GET", null)
                .build();

        return Objects.requireNonNull(client.newCall(request).execute().body()).string();
    }

    public String requestPost(Map<String,String> m, String requestUrl) throws IOException {
        String url = address.concat(requestUrl);

        FormBody.Builder builder = new FormBody.Builder();
        for (Map.Entry<String, String> entry : m.entrySet()) {
            builder.add(entry.getKey(), entry.getValue());
        }
        RequestBody body = builder.build();

        Request request = new Request.Builder()
                .url(url)
                .method("POST", body)
                .addHeader("Content-Type", "application/json")
                .build();
        return Objects.requireNonNull(client.newCall(request).execute().body()).string();
    }

    public String requestDel(Map<String,String> m, String requestUrl) throws IOException {
        String params = "";
        String url = address.concat(requestUrl);
        MediaType mediaType = MediaType.parse("text/plain");
        RequestBody body = RequestBody.create(mediaType, "");


        url = getParams(m, params, url);

        Request request = new Request.Builder()
                .url(url)
                .method("DELETE", body)
                .build();

        return Objects.requireNonNull(client.newCall(request).execute().body()).string();
    }

    private String getParams(Map<String, String> m, String params, String url) {
        for (Map.Entry<String, String> entry : m.entrySet()) {
            params = params.concat(String.format("%s=%s&", entry.getKey(), entry.getValue()));
        }

        if (!params.equals("")) {
            url = url.concat('?' + params.substring(0, params.length() - 1));
        }
        return url;
    }
}
