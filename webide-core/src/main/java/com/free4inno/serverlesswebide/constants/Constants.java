package com.free4inno.serverlesswebide.constants;

public class Constants {

    public static final String SERVICE_NAME = "webide-server";

    public static final String FUNCTION_NAME = "webide-fc-%s";
//    public static final String FUNCTION_URL = "%s/";
//    public static final String FUNCTION_ROUTE_URL = "/%s*";
    public static final String FUNCTION_HANDLER_URL = "/";
    public static final String FUNCTION_DOMAIN_URL = "%s.%s";
    public static final String FUNCTION_FULL_URL = "%s/?folder=/workspace";

    public static final String DOMAIN_NAME = "${domain}";

    public static final String TRIGGER_NAME = "http_t";

    // env variables
    public static final String DATA_OSS_PATH_KEY = "DATA_OSS_PATH";
    public static final String DATA_WORKSPACE_PATH_KEY = "WORKSPACE_OSS_PATH";
    public static final String PROXY_HANDLER_KEY = "PROXY_HANDLER";

    // function pool scale
    public static final int MAX_TOTAL_FUNC = 20;
    public static final int MIN_LEFT_FUNC = 3;
    public static final int MAX_REST_FUNC = 5;

    // function
    public static final int AVAILABLE = 1;
    public static final int EMPTY = -1;
    public static final int NOT_AVAILABLE = 0;
    public static final long MAX_INSTANCE = 1;

    // workspace
    public static final int MAX_ACTIVE_WORKSPACE = 3;
    public static final int ACTIVE = 1;
    public static final int NOT_ACTIVE = 0;
}
