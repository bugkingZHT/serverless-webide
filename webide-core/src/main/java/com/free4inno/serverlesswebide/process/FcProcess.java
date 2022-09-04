package com.free4inno.serverlesswebide.process;

import com.alibaba.fastjson.JSON;
import com.aliyun.fc_open20210406.Client;
import com.aliyun.fc_open20210406.models.*;
import com.aliyun.teaopenapi.models.Config;
import com.aliyun.teautil.models.RuntimeOptions;
import com.free4inno.serverlesswebide.constants.Constants;
import com.free4inno.serverlesswebide.constants.NginxConstants;
import com.free4inno.serverlesswebide.dao.feign.NginxController;
import com.free4inno.serverlesswebide.entity.Func;
import com.free4inno.serverlesswebide.exception.FcException;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class FcProcess {

    @Resource
    private NginxController nginxController;

    private static final String layerARN = "${layerARN}";
    private final Config config;

    public FcProcess() {
        config = new com.aliyun.teaopenapi.models.Config();
        config.setAccessKeyId("${AccessKeyId}");
        config.setAccessKeySecret("${AccessKeySecret}");
        config.setRegionId("${RegionId}");
        config.setEndpoint("${Endpoint}");
        config.setConnectTimeout(120 * 1000);
        config.setReadTimeout(300 * 1000);
    }

    /*
    public String createService(String serviceName) {
        try {
            log.info(config.getAccessKeyId());

            Client client = new Client(config);
            RuntimeOptions runtimeOptions = new RuntimeOptions();
            CreateServiceHeaders createServiceHeaders = new CreateServiceHeaders();
            CreateServiceRequest createServiceRequest = new CreateServiceRequest();

            createServiceRequest.setServiceName(serviceName);
            createServiceRequest.setRole("acs:ram::1874296593577700:role/aliyunfcdefaultrole");

            CreateServiceResponse resp = client.createServiceWithOptions(createServiceRequest, createServiceHeaders, runtimeOptions);
            // response 包含服务端响应的 body 和 headers
            log.info(new Gson().toJson(resp.body));
            log.info(new Gson().toJson(resp.headers));

            return new Gson().toJson(resp.body);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }
     */

    // 利用 sdk 创建一个 function 作为 server，并返回 url
    public void createFunction(String serviceName, String functionName) throws FcException {
        try {
            log.info(config.getAccessKeyId());

            Client client = new Client(config);
            RuntimeOptions runtimeOptions = new RuntimeOptions();
            CreateFunctionHeaders createFunctionHeaders = new CreateFunctionHeaders();
            CreateFunctionRequest createFunctionRequest = new CreateFunctionRequest();

            // set code
            Code code = new Code();
            code
                    .setOssBucketName("${ossBucketName}")
                    .setOssObjectName("code-package/code.zip");
            createFunctionRequest.setCode(code);

            // set custom runtime config
            CustomRuntimeConfig customRuntimeConfig = new CustomRuntimeConfig();
            List<String> command = new ArrayList<>();
            command.add("./main");
            List<String> args = new ArrayList<>();
            args.add("-alsologtostderr");
            customRuntimeConfig
                    .setCommand(command)
                    .setArgs(args);
            createFunctionRequest.setCustomRuntimeConfig(customRuntimeConfig);

            // set instance life cycle
            InstanceLifecycleConfig instanceLifecycleConfig = new InstanceLifecycleConfig();
            LifecycleHook lifecycleHook = new LifecycleHook();
            lifecycleHook
                    .setHandler("/pre-stop")
                    .setTimeout(90);
            instanceLifecycleConfig.setPreStop(lifecycleHook);
            createFunctionRequest.setInstanceLifecycleConfig(instanceLifecycleConfig);

            // set layer
            List<String> layers = new ArrayList<>();
            layers.add(layerARN);
            createFunctionRequest.setLayers(layers);

            // set others
            createFunctionRequest
                    .setFunctionName(functionName)
                    .setDescription("use sdk create function.")
                    .setHandler("main")
                    .setInitializationTimeout(120)
                    .setInitializer("/initialize")
                    .setMemorySize(3072)
                    .setRuntime("custom")
                    .setTimeout(900)
                    .setCaPort(9000)
                    .setEnvironmentVariables(new HashMap<>())
                    .setInstanceConcurrency(100)
                    .setInstanceType("e1");


            CreateFunctionResponse resp = client.createFunctionWithOptions(serviceName, createFunctionRequest, createFunctionHeaders, runtimeOptions);
            // response 包含服务端响应的 body 和 headers
            log.info(new Gson().toJson(resp.body));
            //log.info(new Gson().toJson(resp.headers));
            //return new Gson().toJson(resp.body);

        } catch (Exception e) {
            e.printStackTrace();
            throw new FcException("create function failed");
        }
    }

    // 利用 sdk 创建 http trigger
    public String createTrigger(String serviceName, String functionName, String triggerName) throws FcException {
        try {
            log.info(config.getAccessKeyId());

            Client client = new Client(config);
            RuntimeOptions runtimeOptions = new RuntimeOptions();
            CreateTriggerHeaders createTriggerHeaders = new CreateTriggerHeaders();
            CreateTriggerRequest createTriggerRequest = new CreateTriggerRequest();

            createTriggerRequest.setTriggerName("http_t");
            createTriggerRequest.setTriggerType("http");

            Map<String, Object> triggerConfigMap = new HashMap<>();

            List<String> methods = new ArrayList<>();
            methods.add("GET");
            methods.add("POST");
            methods.add("PUT");
            methods.add("DELETE");

            triggerConfigMap.put("authType", "anonymous");
            triggerConfigMap.put("methods", methods);

            String triggerConfigString = JSON.toJSONString(triggerConfigMap);
            log.info(triggerConfigString);
            createTriggerRequest.setTriggerConfig(triggerConfigString);

            CreateTriggerResponse resp = client.createTriggerWithOptions(serviceName, functionName, createTriggerRequest, createTriggerHeaders, runtimeOptions);
            // response 包含服务端响应的 body 和 headers
            log.info(new Gson().toJson(resp.body));
            // log.info(new Gson().toJson(resp.headers));
            return new Gson().toJson(resp.body);

        } catch (Exception e) {
            e.printStackTrace();
            throw new FcException("create trigger failed");
        }
    }

    public void deleteFunction(String serviceName, String functionName) throws FcException {
        try {
            log.info(config.getAccessKeyId());

            Client client = new Client(config);
            RuntimeOptions runtimeOptions = new RuntimeOptions();
            DeleteFunctionHeaders deleteFunctionHeaders = new DeleteFunctionHeaders();

            DeleteFunctionResponse resp = client.deleteFunctionWithOptions(serviceName, functionName, deleteFunctionHeaders, runtimeOptions);

            //log.info(new Gson().toJson(resp.headers));
        } catch (Exception e) {
            e.printStackTrace();
            throw new FcException("delete function failed");
        }
    }

    public void deleteTrigger(String serviceName, String functionName, String triggerName) throws FcException {
        try {
            log.info(config.getAccessKeyId());

            Client client = new Client(config);
            RuntimeOptions runtimeOptions = new RuntimeOptions();
            DeleteTriggerHeaders deleteTriggerHeaders = new DeleteTriggerHeaders();

            DeleteTriggerResponse resp = client.deleteTriggerWithOptions(serviceName, functionName, triggerName, deleteTriggerHeaders, runtimeOptions);

            //log.info(new Gson().toJson(resp.headers));
        } catch (Exception e) {
            e.printStackTrace();
            throw new FcException("delete trigger failed");
        }
    }

    // update domain-function route table
    /*
    public void updateRoute(String domainName, String serviceName, List<Func> funcList) throws FcException {
        try {
            Client client = new Client(config);
            RuntimeOptions runtimeOptions = new RuntimeOptions();
            UpdateCustomDomainHeaders updateCustomDomainHeaders = new UpdateCustomDomainHeaders();
            UpdateCustomDomainRequest updateCustomDomainRequest = new UpdateCustomDomainRequest();

            updateCustomDomainRequest.setProtocol("HTTP");

            RouteConfig routeConfig = new RouteConfig();

            List<String> methods = new ArrayList<>();
            methods.add("GET");
            methods.add("POST");
            methods.add("PUT");
            methods.add("DELETE");

            List<PathConfig> pathConfigList = new ArrayList<>();
            for (Func func : funcList) {
                PathConfig pathConfig = new PathConfig();
                pathConfig.setServiceName(serviceName);
                pathConfig.setFunctionName(func.getName());
                pathConfig.setPath(String.format(Constants.FUNCTION_ROUTE_URL, func.getPath()));
                pathConfig.setQualifier("LATEST");
                pathConfig.setMethods(methods);

                pathConfigList.add(pathConfig);
            }
            routeConfig.setRoutes(pathConfigList);

            updateCustomDomainRequest.setRouteConfig(routeConfig);

            UpdateCustomDomainResponse resp = client.updateCustomDomainWithOptions(domainName, updateCustomDomainRequest, updateCustomDomainHeaders, runtimeOptions);

            log.info(new Gson().toJson(resp.body));

        } catch (Exception e) {
            e.printStackTrace();
            throw new FcException("update route table failed");
        }
    }
     */

    // set function's environment variable
    public void updateFunctionEnv(String serviceName, String functionName, Map<String, String> envVariables) throws FcException {
        try {
            Client client = new Client(config);
            RuntimeOptions runtimeOptions = new RuntimeOptions();
            UpdateFunctionHeaders updateFunctionHeaders = new UpdateFunctionHeaders();
            UpdateFunctionRequest updateFunctionRequest = new UpdateFunctionRequest();

            updateFunctionRequest.setEnvironmentVariables(envVariables);

            UpdateFunctionResponse resp = client.updateFunctionWithOptions(serviceName, functionName, updateFunctionRequest, updateFunctionHeaders, runtimeOptions);

            log.info(new Gson().toJson(resp.body));

        } catch (Exception e) {
            e.printStackTrace();
            throw new FcException("update function env failed");
        }
    }

    // get function's instance list
    public List<ListInstancesResponseBody.ListInstancesResponseBodyInstances> getFunctionInstance(String serviceName, String functionName) throws FcException {
        try {
            Client client = new Client(config);
            RuntimeOptions runtimeOptions = new RuntimeOptions();
            ListInstancesHeaders listInstancesHeaders = new ListInstancesHeaders();
            ListInstancesRequest listInstancesRequest = new ListInstancesRequest();

            listInstancesRequest.setQualifier("LATEST");

            ListInstancesResponse resp = client.listInstancesWithOptions(serviceName, functionName, listInstancesRequest, listInstancesHeaders, runtimeOptions);

            return resp.body.getInstances();

        } catch (Exception e) {
            e.printStackTrace();
            throw new FcException("get function instances failed");
        }
    }

    // put function instance max limit
    public void setMaxInstance(String serviceName, String functionName, long maxLimit) throws FcException {
        try {
            Client client = new Client(config);
            RuntimeOptions runtimeOptions = new RuntimeOptions();
            PutFunctionOnDemandConfigHeaders putFunctionOnDemandConfigHeaders = new PutFunctionOnDemandConfigHeaders();
            PutFunctionOnDemandConfigRequest putFunctionOnDemandConfigRequest = new PutFunctionOnDemandConfigRequest();

            putFunctionOnDemandConfigRequest.setQualifier("LATEST");
            putFunctionOnDemandConfigRequest.setMaximumInstanceCount(maxLimit);

            PutFunctionOnDemandConfigResponse resp =
                    client.putFunctionOnDemandConfigWithOptions(serviceName, functionName, putFunctionOnDemandConfigRequest, putFunctionOnDemandConfigHeaders, runtimeOptions);

            log.info(new Gson().toJson(resp.body));

        } catch (Exception e) {
            e.printStackTrace();
            throw new FcException("set Max Instance failed");
        }
    }

    // delete function instance max limit
    public void delMaxInstance(String serviceName, String functionName) throws FcException {
        try {
            Client client = new Client(config);
            RuntimeOptions runtimeOptions = new RuntimeOptions();
            DeleteFunctionOnDemandConfigHeaders deleteFunctionOnDemandConfigHeaders = new DeleteFunctionOnDemandConfigHeaders();
            DeleteFunctionOnDemandConfigRequest deleteFunctionOnDemandConfigRequest = new DeleteFunctionOnDemandConfigRequest();

            deleteFunctionOnDemandConfigRequest.setQualifier("LATEST");

            DeleteFunctionOnDemandConfigResponse resp =
                    client.deleteFunctionOnDemandConfigWithOptions(serviceName, functionName, deleteFunctionOnDemandConfigRequest, deleteFunctionOnDemandConfigHeaders, runtimeOptions);

//            log.info(new Gson().toJson(resp.body));

        } catch (Exception e) {
            e.printStackTrace();
            throw new FcException("delete Max Instance failed");
        }
    }

    // set domain to nginx
    public void bindNginxDomain(String domainName, String passAddress) throws FcException {
        try {
            // only support http now
            if (passAddress.contains("https")) {
                log.info("bindDomain -- replace https");
                passAddress = passAddress.replace("https", "http");
            }
            String res = nginxController.bindDomain(domainName, passAddress);
            if (!res.equals(NginxConstants.SUCCESS)) {
                throw new FcException("bind domain failed! (Caused by Nginx Controller)");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new FcException("bind domain failed!");
        }
    }

    public void bindFcDomain(String serviceName, String functionName, String domainName) throws FcException {
        try {
            Client client = new Client(config);
            RuntimeOptions runtimeOptions = new RuntimeOptions();
            CreateCustomDomainHeaders createCustomDomainHeaders = new CreateCustomDomainHeaders();
            CreateCustomDomainRequest createCustomDomainRequest = new CreateCustomDomainRequest();

            createCustomDomainRequest.setDomainName(domainName);
            createCustomDomainRequest.setProtocol("HTTP");

            RouteConfig routeConfig = new RouteConfig();

            List<String> methods = new ArrayList<>();
            methods.add("GET");
            methods.add("POST");
            methods.add("PUT");
            methods.add("DELETE");

            List<PathConfig> pathConfigList = new ArrayList<>();
            // --
            PathConfig pathConfig = new PathConfig();
            pathConfig.setServiceName(serviceName);
            pathConfig.setFunctionName(functionName);
            pathConfig.setPath(String.format(Constants.FUNCTION_HANDLER_URL) + "*");
            pathConfig.setQualifier("LATEST");
            pathConfig.setMethods(methods);
            // --
            pathConfigList.add(pathConfig);

            routeConfig.setRoutes(pathConfigList);

            createCustomDomainRequest.setRouteConfig(routeConfig);

            CreateCustomDomainResponse resp = client.createCustomDomainWithOptions(createCustomDomainRequest, createCustomDomainHeaders, runtimeOptions);

            log.info(new Gson().toJson(resp.body));

        } catch (Exception e) {
            e.printStackTrace();
            throw new FcException("bind domain failed");
        }
    }

    public void unbindFcDomain(String domainName) throws FcException {
        try {
            Client client = new Client(config);
            RuntimeOptions runtimeOptions = new RuntimeOptions();
            DeleteCustomDomainHeaders deleteCustomDomainHeaders = new DeleteCustomDomainHeaders();

            DeleteCustomDomainResponse resp = client.deleteCustomDomainWithOptions(domainName, deleteCustomDomainHeaders, runtimeOptions);

//            log.info(new Gson().toJson(resp.body));

        } catch (Exception e) {
            e.printStackTrace();
            throw new FcException("unbind domain failed");
        }
    }

}
