<%--
  Created by IntelliJ IDEA.
  User: Creed
  Date: 2020/11/3
  Time: 15:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <c:import url="/template/_header.jsp"/>
    <title>新建项目</title>
</head>
<body class="front-body">
<c:import url="/template/_navbar.jsp?menu=project"/>
<div class="front-inner" id = "main_container">
    <div class="container" >

            <ol class="breadcrumb">
                <li><a href="/kubernetes/projectPage.jsp">Workspace</a> </li>
                <li>新建Workspace</li>
            </ol>

            <div id="config-div" class="panel panel-default front-panel clear form-horizontal">
                <div class="panel-body" style=" padding-bottom:0px">
                    <div style="margin-left: 90px">
                        <div class='form-group'>
                            <label class="col-md-2 control-label front-label">名称</label>
                            <div class="col-md-7">
                                <input style="width:calc(100% - 25px);resize:none; height: 34px; float: left" type="text" class="form-control front-no-box-shadow" id="newName">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label front-label"></label>
                            <div class="col-md-7">
<%--                                <span class="pull-left" style="margin-top: 10px; float: left; text-align: left">--%>
<%--                                    <a href="javascript:void(0)" class="btn btn-primary pull-right" id="saveButton" style="width: 70px; horiz-align: left; float: left; margin-right: 10px; background-color: white; border-color: #828282"  onclick="clearInput();">--%>
<%--                                        <font color="black">重置</font>--%>
<%--                                    </a>--%>
<%--                                </span>--%>
                                <span class="pull-left" style="margin-top: 10px; float: left; text-align: left">
    <%--                                <a href="javascript:void(0)" class="btn btn-primary pull-right" style="width: 124px" onclick="loadLog('default','warpackage','warget')">加载日志</a>--%>
                                    <a href="javascript:void(0)" class="btn btn-primary pull-right" id="saveButton" style="width: 70px; horiz-align: left; float: left" onclick="confirmNewProject();">保存</a>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </div>
    <c:import url="/template/_footer.jsp"/>
</div>
</body>
<script>
    // $('#newName').keyup(function(){
    //     var val = $(this).val() == "-" ? "" : $(this).val();
    //     $('#newName').val(val.replace(/[^a-z0-9 -]/g,''));
    // });

    function clearInput(){
        $("#newName").val('');
        $("#newDescription").val('');
    }

    function confirmNewProject(){
        $.tipModal('confirm', 'warning', '由于WorkSpace名称无法修改，请确认WorkSpace设置是否正确！', function(result) {
            if(result===true){
                submit();
            }
        })
    }

    function submit() {
        var name = $("#newName").val().trim();
        if(name === ""){
            $.fillTipBox({type: 'danger', icon: 'glyphicon-exclamation-sign', content: '项目名称不可为空'});
            return false;
        }
        //alert("ajax");
        $.ajax({
            url:"/project/createWorkSpace",
            type:"post",
            async: false,
            dataType:"text",
            data:{name:name,
            },
            success:function(data) {
                if(data=="ok") {
                    $.fillTipBox({type: 'success', icon: 'glyphicon-ok-sign', content: '新建项目成功'});
                    setInterval(function () {
                        window.location = "/project";
                    }, 1000);
                } else{
                    $.fillTipBox({type: 'error', icon: 'glyphicon-alert', content: data});
                }
            }
        });
    }


    function startProject(id) {
        $.ajax({
            url: "/project/start",
            type: "get",
            datatype:"text",
            data: {id: id},
            success: function (data) {
                if(data== true){
                    $.fillTipBox({type: 'success', icon: 'glyphicon-ok-sign', content: '项目开始启动'});
                    // setInterval(function () {
                    //     location.reload();
                    // }, 1000);
                }
            },
            error:function (data) {
                $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '项目启动失败'});
            }
        });
    }

    function stopProject(id) {
        $.ajax({
            url: "/project/stop",
            type: "get",
            datatype:"text",
            data: {id: id},
            success: function (data) {
                if(data== true){
                    $.fillTipBox({type: 'success', icon: 'glyphicon-ok-sign', content: '项目开始停止'});
                    // setInterval(function () {
                    //     location.reload();
                    // }, 1000);
                }
            },
            error:function (data) {
                $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '项目停止失败'});
            }
        });
    }

    function loadLog(namespace, pod, container) {
        var ws = new WebSocket("ws://" + window.location.host + "/logs/" + namespace + "/" + pod + "/" + container);
        var logArea = document.getElementById('log-text');
        ws.onopen = function () {
            logArea.value = "";
            ws.send("Hello websocket!");
        };
        ws.onmessage = function (ev) {
            logArea.value = logArea.value + ev.data;
        };
        ws.onclose = function (ev) {
            if (ev.code === 1000) { // normal closure
                logArea.scrollTop = logArea.scrollHeight;
            } else {
                logArea.value = ev.reason;
            }
        };
    }
</script>
</html>
