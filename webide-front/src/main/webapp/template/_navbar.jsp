<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <c:import url="/template/_header.jsp"/>
</head>
<body>
<nav class="navbar navbar-default navbar-fixed-top front-nav">
    <div class="container">
        <div>
            <div class="nav-brand" style="padding-right: 0px">
                <a href="/"><img src="/static/images/logo-ide-small.png" class="img-responsive"/></a>
            </div>
        </div>
        <div class="nav-collapse collapse" id="nav-collapse-demo">
            <ul class="nav navbar-nav">
<%--                <li class="${param.menu=='home'?'front-active':''}">--%>
<%--                    <a href="/">首页</a>--%>
<%--                </li> <!-- 激活菜单 -->--%>
<%--&lt;%&ndash;                <li class="${param.menu=='project'?'front-active':''}">&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <a href="/project">项目管理</a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                </li> <!-- 激活菜单 -->&ndash;%&gt;--%>
<%--                <c:if test="${not empty sessionScope.systemMana}">--%>
<%--                    <li class = "dropdown">--%>
<%--                        <a href="#" class="${param.menu=='management'?'front-active dropdown-toggle':'dropdown-toggle'}"--%>
<%--                           data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">系统管理<span--%>
<%--                                class="caret"></span></a>--%>
<%--                        <ul class="dropdown-menu nav-dropdown front-min-width">--%>
<%--                            <li><a href="/basicfacility"><span class="glyphicon glyphicon-hdd"></span>&nbsp;&nbsp;基础设施</a></li>--%>
<%--                            <li><a href="http://grafana.docker.free4inno.com/d/H9CbW6FGk/1-ji-qun-gai-lan?orgId=1&refresh=10s"--%>
<%--                                   target="_blank"><span class="glyphicon glyphicon-hdd"></span>&nbsp;&nbsp;k8s仪表盘</a></li>--%>
<%--                        </ul>--%>
<%--                    </li>--%>
<%--                </c:if>--%>
                <li class="${param.menu=='project'?'front-active':''}">
                    <a href="/project" >WorkSpace</a>
                </li>
<%--                <li class="dropdown">--%>
<%--                    <a href="#" class="${param.menu=='service'?'front-active dropdown-toggle':'dropdown-toggle'}"--%>
<%--                       data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">服务管理<span--%>
<%--                            class="caret"></span></a>--%>
<%--                    <ul class="dropdown-menu nav-dropdown front-min-width">--%>
<%--                        <li>--%>
<%--                            <a href="/kubernetes/templatePage.jsp"><span class="glyphicon glyphicon-cog"></span>&nbsp;&nbsp;模板</a>--%>
<%--                        </li>--%>
<%--&lt;%&ndash;                            <c:if test="${not empty sessionScope.runlog}">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <li><a href="/log"><span class="glyphicon glyphicon-random"></span>&nbsp;&nbsp;域名</a></li>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </c:if>&ndash;%&gt;--%>
<%--                        <li><a href="/kubernetes/domainPage.jsp"><span class="glyphicon glyphicon-random"></span>&nbsp;&nbsp;域名</a></li>--%>
<%--                        <li class="${param.menu=='pv'?'front-active dropdown-toggle':''}"><a href="/service/pvManagement.jsp"><span class="glyphicon glyphicon-bell"></span>&nbsp;&nbsp;持久化卷</a></li>--%>
<%--                    </ul>--%>
<%--                </li>--%>
<%--                <li class="dropdown">--%>
<%--                    <a href="#" class="${param.menu=='log'?'front-active dropdown-toggle':'dropdown-toggle'}"--%>
<%--                       data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">日志管理<span--%>
<%--                            class="caret"></span></a>--%>
<%--                    <ul class="dropdown-menu nav-dropdown front-min-width">--%>
<%--&lt;%&ndash;                            <c:if test="${not empty sessionScope.runlog}">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <li><a href="/log"><span class="glyphicon glyphicon-random"></span>&nbsp;&nbsp;运行日志</a></li>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </c:if>&ndash;%&gt;--%>
<%--                        <li><a href="/runninglog"><span class="glyphicon glyphicon-cog"></span>&nbsp;&nbsp;运行日志</a></li>--%>
<%--                        <li><a href="/adminlog"><span class="glyphicon glyphicon-cog"></span>&nbsp;&nbsp;操作日志</a></li>--%>
<%--                        <li><a href="/adminlog"><span class="glyphicon glyphicon-cog"></span>&nbsp;&nbsp;告警日志</a></li>--%>
<%--&lt;%&ndash;                            <c:if test="${not empty sessionScope.alarmlog}">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <li><a href="/alarm"><span class="glyphicon glyphicon-bell"></span>&nbsp;&nbsp;告警日志</a></li>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </c:if>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <c:if test="${not empty sessionScope.alarmSet}">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <li><a href="/alarmsetup?page=1"><span class="glyphicon glyphicon-wrench"></span>&nbsp;&nbsp;告警设置</a> </li>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </c:if>&ndash;%&gt;--%>
<%--                    </ul>--%>
<%--                </li>--%>


                <%--------------------------------在这里加入用户管理部分的界面--%>
                <%--                <c:if test="${not empty sessionScope.usersMana}">--%>
                <%--                    <li class="${param.menu=='user'?'front-active':''}">--%>
                <%--                        <a href="http://www.free4inno.com/" target="_blank">用户管理</a>--%>
                <%--                    </li>--%>
                <%--                </c:if>--%>
                <%--                -----------------------------------------------------------------------------%>

<%--                <c:choose>--%>
<%--                    <c:when test="${not empty sessionScope.adminsMana}">--%>
<%--                        <li class="dropdown">--%>
<%--                            <a href="#" class="${param.menu=='admin'?'front-active dropdown-toggle':'dropdown-toggle'}"--%>
<%--                               data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">管理员管理<span--%>
<%--                                    class="caret"></span></a>--%>
<%--                            <ul class="dropdown-menu nav-dropdown front-min-width">--%>
<%--                                <c:if test="${not empty sessionScope.admins}">--%>
<%--                                    <li><a href="/user"><span class="glyphicon glyphicon-pawn"></span>&nbsp;&nbsp;管理员</a></li>--%>
<%--                                </c:if>--%>
<%--                                <c:if test="${not empty sessionScope.adminGroup}">--%>
<%--                                    <li><a href="/admingroup"><span class="glyphicon glyphicon-list"></span>&nbsp;&nbsp;管理组</a></li>--%>
<%--                                </c:if>--%>

<%--                            </ul>--%>
<%--                        </li>--%>
<%--                    </c:when>--%>
<%--                </c:choose>--%>
            </ul>
        </div>
        <div class="nav-right">
            <div class="area visible-xs visible-sm nav-toggle-down" data-toggle="collapse" data-target="#nav-collapse-demo">
                <span class="glyphicon glyphicon-menu-hamburger" id="front-nav-toggle-down-demo"></span>
            </div>
        </div>
        <div class="nav-right">
            <div class="area area-media" style="margin-top: 13px">
                    <span id="warning" class="label" href="/alarm" title="您有告警信息未处理"
                          style="display: none;font-size:15px;text-align: center;background-color:#EE442E;padding-left: 10px;padding-right: 5px;">
                        <span class="glyphicon glyphicon-info-sign" style="color: white"></span>
                    <a href="/alarm" id="warn" style="text-decoration: none; color: white">!!</a>
                </span>&nbsp;
            </div>
            <div class="area area-media" style="margin-left: 10px">
                <div class="dropdown" style="font-size: 15px;">
                    <a href="#" data-toggle="dropdown" class="dropdown-toggle" role="button" aria-haspopup="true" aria-expanded="false">${sessionScope.username}
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu nav-dropdown front-min-width" style="min-width:115px">
<%--                        <li>--%>
<%--                            <a data-toggle="front-modal" data-title="编辑个人信息"--%>
<%--                               data-href="/user/_updateUser.jsp?username=${sessionScope.username}"--%>
<%--                            >编辑个人信息</a>--%>
<%--                        </li>--%>
<%--                        <li><a data-toggle="front-modal" data-title="修改密码" data-href="/user/_update.jsp">修改密码</a></li>--%>
<%--                        <li>--%>
<%--                            <a href="/config/lzconfig.jsp">--%>
<%--                                编辑系统配置</a>--%>
<%--                        </li>--%>
                        <li>
                            <a href="javascript:void(0)" id="logoutid" onclick="
                            $.tipModal('confirm', 'danger','确定要退出吗？',function(result){
                                if(result){
                                    window.location.href = '/logout';
                                }
                            })
                            ">退出
                            </a>
                        </li>

                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>
<%--<script src="/static/js/jquery.min.js"></script>--%>
<%--这是新增的Autocomplete插件 注意！--%>
<script src="/static/js/jquery-1.12.4.min.js"></script>
<script src="/static/js/jquery-ui.min.js"></script>
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<script src="/static/js/front.js"></script>
<%--<script src="../static/bootstrap/js/bootstrap-table.js"/>--%>
<%--<script src="../static/bootstrap/js/bootstrap-table-zh-CN.js"/>--%>
<script>
    // var oTimer = null;
    // jQuery(document).ready(function () {
    //     // oTimer = setInterval("queryHandle()", 1000);
    //     oTimer = setInterval("queryHandle()", 1000);
    // });
    //
    // function queryHandle() {
    //     // alert("queryHandle");
    //     $.get("/getStatus", {},
    //         function (data) {
    //         // alert("data="+data);
    //             // if (data["num"] != 0) {
    //             if (data != 0) {
    //                 // alert("num="+data["num"]);
    //                 $("#warning").show();
    //                 $("#warn").text(data);
    //                 $("#warn").title = "您有告警信息未处理";
    //             } else
    //                 $("#warning").hide();
    //         });
    // }
    //
    // $(function () {
    //     $("#warning").click(function () {
    //         window.location.href = "/alarm"
    //     });
    // });

</script>


</body>
</html>
