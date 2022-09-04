package com.free4inno.serverlesswebide.dao.feign;

import com.free4inno.serverlesswebide.constants.NginxConstants;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@FeignClient(name = NginxConstants.NGINX_CONTROLLER, url = NginxConstants.NGINX_CONTROLLER_ADDRESS)
public interface NginxController {

    @RequestMapping(method = RequestMethod.GET, value = NginxConstants.BIND_DOMAIN)
    @ResponseBody
    String bindDomain(
            @RequestParam(value = NginxConstants.DOMAIN) String domain,
            @RequestParam(value = NginxConstants.PROXY_PASS) String pass);
}
