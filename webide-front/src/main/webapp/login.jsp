<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <c:import url="/template/_header.jsp"/>
    <title>登录 - 轻量化容器管理平台</title>
</head>
<body class="front-body">

<nav class="navbar navbar-default navbar-fixed-top front-nav">
    <div class="container">
        <div class="nav-brand">
            <a href="/"><img src="/static/images/logo-ide.png" class="img-responsive"/></a>
        </div>
    </div>
</nav>

<div class="front-inner">
    <div class="container">
        <div class="row">
            <div class="col-md-9 col-sm-12 col-xs-12" style="padding-right: 5px">
                <div class="panel panel-default front-panel" style="padding-right: 0px;background: #e7e7e7; border: 0;">
                    <div class="panel-body" style="padding: 0px;">
                        <img src="static/images/banneride.png" class="change-img" style="height:300px;width: 100%;max-width: 100%; display: block;">
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-sm-12 col-xs-12" style="padding-right: 5px;">
                <div class="panel panel-default front-panel" style="border: 0px;">
                    <div class="panel-heading">
                        <img src="/static/images/landing.png">
                    </div>
                    <div class="panel-body" style="padding-bottom:20px">
                        <%--                            <div class="form-group" style="margin-left: 0px; color:#337ab7;" >--%>
                        <%--                                分布式系统管理--%>
                        <%--                            </div>--%>
                        <div class="form-group" id="username-div" style="margin-top:15px">
                            <input type="text" class="form-control login-input" id="username-input" name="username" placeholder="用户名" autofocus>
                        </div>
                        <div class="form-group" id="password-div">
                            <input type="password" class="form-control login-input" id="password-input" name="password" placeholder="密码">
                        </div>
                        <div class="form-group" style="height: 25px;margin-top:25px">
                            <div class="col-sm-offset-2 col-sm-10">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" id="username-remember"> 记住手机号码
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group" style="margin-bottom: 0px; margin-top:30px">
                            <button type="submit" class="btn btn-info btn-block btn-login" id="submit">登录</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
<%--        <div class="row">--%>
<%--            <div class="col-md-3 col-sm-6 col-xs-6" style="padding-right: 5px;">--%>
<%--                <div class="panel panel-default front-panel" style=" height: auto;">--%>
<%--                    <div class="panel-body" style="padding-top: 30px;">--%>
<%--                        <img src="static/images/0001.png" style="width: 66%;max-width: 100%; display: block; margin: 3px auto;">--%>
<%--                    </div>--%>
<%--                    &lt;%&ndash;                        <div class="panel-body">&ndash;%&gt;--%>
<%--                    &lt;%&ndash;                            <p class="text-center">&ndash;%&gt;--%>
<%--                    &lt;%&ndash;                                <strong>统一数据描述<br/>适配异构数据格式</strong>&ndash;%&gt;--%>
<%--                    &lt;%&ndash;                            </p>&ndash;%&gt;--%>
<%--                    &lt;%&ndash;                        </div>&ndash;%&gt;--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="col-md-3 col-sm-6 col-xs-6" style="padding-right: 5px;">--%>
<%--                <div class="panel panel-default front-panel" style=" height: auto;">--%>
<%--                    <div class="panel-body" style="padding-top: 30px;">--%>
<%--                        <img src="static/images/0002.png" style="width: 66%;max-width: 100%; display: block; margin: 3px auto;">--%>
<%--                    </div>--%>
<%--                    &lt;%&ndash;                        <div class="panel-body">&ndash;%&gt;--%>
<%--                    &lt;%&ndash;                            <p class="text-center">&ndash;%&gt;--%>
<%--                    &lt;%&ndash;                                <strong>汇聚流式数据<br/>保障数据处理时效</strong>&ndash;%&gt;--%>
<%--                    &lt;%&ndash;                            </p>&ndash;%&gt;--%>
<%--                    &lt;%&ndash;                        </div>&ndash;%&gt;--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="col-md-3 col-sm-6 col-xs-6" style="padding-right: 5px;">--%>
<%--                <div class="panel panel-default front-panel" style=" height: auto;">--%>
<%--                    <div class="panel-body" style="padding-top: 30px;">--%>
<%--                        <img src="static/images/0003.png" style="width: 66%;max-width: 100%; display: block; margin: 3px auto;">--%>
<%--                    </div>--%>
<%--                    &lt;%&ndash;                        <div class="panel-body">&ndash;%&gt;--%>
<%--                    &lt;%&ndash;                            <p class="text-center">&ndash;%&gt;--%>
<%--                    &lt;%&ndash;                                <strong>实时学习数据<br/>训练数据处理规则</strong>&ndash;%&gt;--%>
<%--                    &lt;%&ndash;                            </p>&ndash;%&gt;--%>
<%--                    &lt;%&ndash;                        </div>&ndash;%&gt;--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="col-md-3 col-sm-6 col-xs-6" style="padding-right: 5px;">--%>
<%--                <div class="panel panel-default front-panel" style=" height: auto;">--%>
<%--                    <div class="panel-body" style="padding-top: 30px;">--%>
<%--                        <img src="static/images/0004.png" style="width: 66%;max-width: 100%; display: block; margin: 3px auto;">--%>
<%--                    </div>--%>
<%--                    &lt;%&ndash;                        <div class="panel-body">&ndash;%&gt;--%>
<%--                    &lt;%&ndash;                            <p class="text-center">&ndash;%&gt;--%>
<%--                    &lt;%&ndash;                                <strong>配置数据流向<br/>多样数据存储组件</strong>&ndash;%&gt;--%>
<%--                    &lt;%&ndash;                            </p>&ndash;%&gt;--%>
<%--                    &lt;%&ndash;                        </div>&ndash;%&gt;--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
    </div>
    <c:import url="/template/_footer.jsp"/>
</div>

<script src="/static/js/jquery.min.js"></script>
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<script src="/static/js/front.js"></script>
<script src="/static/js/jquery.cookie.js"></script>
<script src="/static/js/jquery.md5.js"></script>
<script>
    document.addEventListener("keyup",function(e){
        if(e.keyCode == 13){
            $(submit).click();
        }
    })
    ;(function () {
        if($.cookie('username') != undefined) {
            $('#username-input').val($.cookie('username'));
            $('#username-remember').attr('checked', 'true');
        }
        $('#username-input').blur(usernameInputBlur);
        $('#password-input').blur(passwordInputBlur);
        $('#submit').click(submit);
    })();

    function usernameInputBlur() {
        if($('#username-div').hasClass("has-error")) {
            $('#username-div').removeClass("has-error");
        }
        // if($('#username-input').val().length != 11) {
        //     $('#username-div').addClass("has-error");
        // }
    }

    function passwordInputBlur() {
        if($('#password-div').hasClass("has-error")) {
            $('#password-div').removeClass("has-error");
        }
        if($('#password-input').val() == "") {
            $('#password-div').addClass("has-error");
        }
    }

    function submit() {
        $('#username-input').blur();
        $('#password-input').blur();
        if($('#username-remember').is(':checked')) {
            $.cookie('username', $('#username-input').val());
        } else {
            $.removeCookie('username');
        }
        if(0){//$('#username-div').hasClass("has-error") || $('#password-div').hasClass("has-error")) {
            return;
        } else {
            $.post('/login', {
                username: $('#username-input').val(),
                password: $('#password-input').val(),
            }, function(boolean) {
                if (boolean == true) {
                    window.location.href = "/project";
                } else {
                    $.fillTipBox({type:'danger', icon:'glyphicon-alert', content:'手机或密码错误！'});
                    $('#username-div').addClass("has-error");
                    $('#password-div').addClass("has-error");
                    $('#password-input').val("");
                }
            });
        }
    }
</script>

</body>
</html>
