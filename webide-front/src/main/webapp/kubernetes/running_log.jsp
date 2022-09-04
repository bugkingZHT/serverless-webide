<%--
  Created by IntelliJ IDEA.
  User: 吴宇轩
  Date: 2021-01-07
  Time: 17:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <c:import url="/template/_header.jsp" />
    <link rel="stylesheet" href="/static/css/bootstrap-datetimepicker.min.css"/>
    <title>运行日志查询</title>
</head>
<body class = "front-body">
<c:import url="/template/_navbar.jsp?menu=log" />
<div class="front-inner">
    <div class="container">
        <div class="row front-canvas" id="front-canvas">
            <div class="col-md-12">
                <ol class="breadcrumb">
                    <li>日志管理</li>
                    <li class="active">运行日志</li>
                </ol>
            </div>
        </div>
        <div id="custom-query-div" class="panel  panel-default front-panel clear form-horizontal">
            <div class="panel-heading">查询条件</div>
            <div class="panel-body" style="margin-bottom: 0px;padding-bottom: 0px;">
                <div class="form-group">
                    <label class="col-md-1 control-label">时间范围</label>
                    <div class="col-md-5">
                        <input type="text" class="form-control" id="begin-date" placeholder="起始时间">
                    </div>
                    <div class="col-md-1"></div>
                    <div class="col-md-5">
                        <input type="text" class="form-control" id="end-date" placeholder="终止时间">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-1 control-label">日志类型</label>
                    <label class="radio-inline">&nbsp;&nbsp;&nbsp;
                        <input type="radio" name="type" value="project" onclick="logType(0)"/>项目
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="type" value="platform" onclick="logType(1)"/>平台
                    </label>
                </div>
                <script>
                    function logType(num) {
                        if (num == 1)  $('#projectNameGroup').hide();
                        else $('#projectNameGroup').show();
                    }
                </script>
                <div class="form-group" id="projectNameGroup">
                    <label class="col-md-1 control-label">项目名称</label>
                    <div class="col-md-11">
                        <select id="projectName" name="projectName" type="text" class="form-control front-no-radius front-no-box-shadow">
                                <option selected value="">请选择一个项目</option>
                            <c:forEach var="p" items="${projectNameList}">
                                <option value="${p.projectName}">${p.projectName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-1 control-label">级别</label>
                    <label class="radio-inline">&nbsp;&nbsp;&nbsp;
                        <input type="radio" name="level" value="NORMAL"/>NORMAL
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="level" value="WARN">WARN
                    </label>
                </div>
                <div class="form-group">
                    <label class="col-md-1 control-label" for="content">日志内容</label>
                    <div class="col-md-11">
                        <input class="form-control" type="text" id="content">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-12">
                        <button type="submit" id="search-log" class="btn btn-primary pull-right">
                            搜索
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div id="hide" class="hide">
            <div class="front-loading">
                <div class="front-loading-block"></div>
                <div class="front-loading-block"></div>
                <div class="front-loading-block"></div>
            </div>
            <div class="panel-body text-center">搜索中，请稍后</div>
        </div>

        <div id="log-list-table"></div>

    </div>
    <c:import url="/template/_footer.jsp" />
</div>

<c:import url="/template/_tailer.jsp"/>
<script src="/static/js/bootstrap-datetimepicker.min.js"></script>

<script>
    $('#projectNameGroup').hide();
    function formatDateTime(inputTime) {
        var date = new Date(inputTime);
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        m = m < 10 ? ('0' + m) : m;
        var d = date.getDate();
        d = d < 10 ? ('0' + d) : d;
        var h = date.getHours();
        h = h < 10 ? ('0' + h) : h;
        var minute = date.getMinutes();
        var second = date.getSeconds();
        minute = minute < 10 ? ('0' + minute) : minute;
        second = second < 10 ? ('0' + second) : second;
        return y + '-' + m + '-' + d+' '+h+':'+minute+':'+second;
    };

    $(function() {
        var btimeDefault=new Date();
        var etimeDefault=new Date();

        $('#begin-date').datetimepicker({
            format: 'yyyy-mm-dd hh:ii:ss',
            autoclose:true
        });
        $('#end-date').datetimepicker({
            format: 'yyyy-mm-dd hh:ii:ss',
            autoclose: true
        });

        btimeDefault.setTime(btimeDefault.getTime()-(86400000));
        $("#begin-date").attr("placeholder",formatDateTime(btimeDefault));

        $("#end-date").attr("placeholder",formatDateTime(etimeDefault));
    });

    $("#search-log").click(function() {
        $("#hide").removeClass('hide');
        var btime = $("#begin-date").val();
        var etime = $("#end-date").val();
        var start = new Date();
        var end=new Date();
        if (btime != "") {
            btime = new Date($("#begin-date").val().substring(0, 19).replace(/-/g, '/')).getTime();
        } else {
            start.setTime(start.getTime()-(86400000));
            btime = start.getTime();
            $("#begin-date").attr("placeholder",formatDateTime(start));
        }
        if (etime != "") {
            etime = new Date($("#end-date").val().substring(0, 19).replace(/-/g, '/')).getTime();
        } else{
            etime=end.getTime();
            $("#end-date").attr("placeholder",formatDateTime(end));
        }

        var type = $("input[name='type']:checked").val();
        if (typeof(type) =="undefined"){
            type = "";
        }
        var level = $("input[name='level']:checked").val();
        if (typeof(level) =="undefined"){
            level = "";
        }
        console.info(level);
        var content = $("#content").val();
        var projectName = $("#projectName").val();
        $.post('runninglogsearch', {
            btime: btime,
            etime: etime,
            level: level,
            type: type,
            projectName: projectName,
            content: content,
            currentpage:0,
        }, function(data) {
            $("#hide").addClass("hide");
            $('#log-list-table').html(data);
            // alert(data);
        });
    });
</script>
</body>
</html>

