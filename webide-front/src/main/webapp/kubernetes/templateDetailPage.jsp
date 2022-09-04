<%--
  Created by IntelliJ IDEA.
  User: 吴宇轩
  Date: 2020/11/25
  Time: 13:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <c:import url="/template/_header.jsp"/>
    <title>模板详情页</title>
</head>
<body class="front-body">
<c:import url="/template/_navbar.jsp?menu=service"/>
<div class="front-inner" id = "main_container">
    <div class="container" >
        <div class="row front-canvas" id="front-canvas">
            <div>
                <ol class="breadcrumb">
                    <li>服务管理</li>
                    <li><a href="/kubernetes/templatePage.jsp">模板管理</a></li>
                    <li class="active">
                        模板详情[${template.name}]
                    </li>
                </ol>
            </div>
            <div class="panel-body">
                <div>
                    <div class="nav-brand">
                        <img id="avator" alt="icon" class="img-responsive" src="/static/images/service_logo.png">
                    </div>
                </div>
                <div>
                    <div class="nav-brand">
                        <h4 class="midia-heading" style="font-size: 20px">
                            <span id="myGroupName">${template.name}</span>&nbsp;&nbsp;
<%--                            <span id="permission" class="badge">${template.status}</span>--%>
                        </h4>
                        <h4 class="midia-heading" style="font-size: 15px">
                            <span id="describe">描述：${template.description}</span>&nbsp;&nbsp;
                        </h4>
                        <h4 class="midia-heading" style="font-size: 15px">
                            <span id="projectNum">项目数：${projectNum}</span>
                        </h4>
                        <h4 class="midia-heading" style="font-size: 15px">
                            <span id="time">创建时间/更新时间：${template.createTime}/${template.updateTime}</span>
                        </h4>
<%--                        <div class="front-toolbar other">--%>
<%--                            <div class="front-btn-group collapse" data-toggle="buttons">--%>
<%--                                <a  id="startButton" class="btn btn-default front-no-box-shadow" onclick="startProject('${project.id}')">--%>
<%--                                    启动--%>
<%--                                </a>--%>
<%--                                <a  id="pauseButton" class="btn btn-default front-no-box-shadow" onclick="stopProject('${project.id}')">--%>
<%--                                    停止--%>
<%--                                </a>--%>
<%--                                <a  id="deleteButton" class="btn btn-danger front-no-box-shadow">--%>
<%--                                    删除--%>
<%--                                </a>--%>
<%--                            </div>--%>
<%--                            <script>--%>
<%--                                var status = "${project.status}";--%>
<%--                                if (status == "STOP") {--%>
<%--                                    $('#pauseButton').addClass('disabled');--%>
<%--                                } else if (status == "PROCESSING") {--%>
<%--                                    $('#pauseButton').addClass('disabled');--%>
<%--                                    $('#startButton').addClass('disabled');--%>
<%--                                    $('#deleteButton').addClass('disabled');--%>
<%--                                } else if (status == "ERROR") {--%>
<%--                                    $('#startButton').addClass('disabled');--%>
<%--                                } else if (status == "RUNNING") {--%>
<%--                                    $('#startButton').addClass('disabled');--%>
<%--                                }--%>
<%--                            </script>--%>
<%--                        </div>--%>
                    </div>
                </div>
            </div>
            <div id="config-div" class="panel panel-default front-panel clear form-horizontal">
                <div class="panel-heading"> <strong>模板详细配置</strong>
                    <a id="help" style="margin-left: 10px;cursor:pointer">帮助</a>
                </div>
                <div class="panel-body" style=" padding-bottom:0px">
                    <div style="margin-left: 90px">
<%--                        <div class='form-group'>--%>
<%--                            <label class="col-md-2 control-label front-label">项目名</label>--%>
<%--                            <div class="col-md-7">--%>
<%--                                <input type="text" class="form-control front-no-box-shadow" id="project-name" disabled value="${project.name}">--%>
<%--                            </div>--%>
<%--                        </div>--%>
                        <div class='form-group'>
                            <label class="col-md-2 control-label front-label">模板名</label>
                            <div class="col-md-7">
                                <input type="text" class="form-control front-no-box-shadow" id="project-template" value="${template.name}">
                            </div>
                        </div>
<%--                        <div class='form-group'>--%>
<%--                            <label class="col-md-2 control-label front-label">所有者</label>--%>
<%--                            <div class="col-md-7">--%>
<%--                                <input type="text" class="form-control front-no-box-shadow" id="project-owner" disabled value="${template.ownerName}">--%>
<%--                            </div>--%>
<%--                        </div>--%>
                        <div class='form-group'>
                            <label class="col-md-2 control-label front-label">详细信息</label>
                            <div class="col-md-7">
                                <%--                                <textarea type="text" class="form-control front-no-box-shadow" id="project-details" style="height: 400px;">${project.details}</textarea>--%>
                                <table class="table front-table" style="text-align: center; border:1px solid #ddd;" id = "detailTab">
                                    <thead style="border-color:inherit;">
                                    <tr style="border-color:inherit;">
                                        <td style="border:1px solid #ddd;border-radius:1px" class="col-md-4 col-lg-4">参数名</td>
                                        <td style="border:1px solid #ddd;border-radius:1px" class="col-md-8 col-lg-8">参数值</td>
<%--                                        <td style="border:1px solid #ddd;border-radius:1px">--%>
<%--                                            <a class="btn" onclick="addRow('detailTab',2);"><strong><span class="glyphicon glyphicon-plus"></span> </strong></a>--%>
<%--                                        </td>--%>
                                    </tr>
                                    </thead>
                                    <%--没有默认值，且首次填写，则给一行填写框--%>
                                    <c:choose>
                                        <c:when test="${template.details == null}">
                                            <tr>
                                                    <%--                                        <td style="display:none ">--%>
                                                    <%--                                            <input class="form-control" type="hidden" value="1"  style="border-radius:10px;">--%>
                                                    <%--                                        </td>--%>
                                                <td style="border:1px solid #ddd;border-radius:1px" >
                                                    <input class="form-control" type="text" style="border-radius:4px;">
                                                </td>
                                                <td style="border:1px solid #ddd;border-radius:1px" >
                                                    <input class="form-control" type="text" style="border-radius:4px;">
                                                </td>
<%--                                                <td style="border:1px solid #ddd;border-radius:1px">--%>
<%--                                                     <a class="btn" onclick="deleteRow(this)" style="padding-top:10px"><strong><span class="glyphicon glyphicon-minus"></span> </strong></a>--%>
<%--                                                 </td>--%>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="e" items="${tdList}" varStatus="status">
                                                <c:choose>
                                                    <c:when test="${status.index < defaultSymAndAcroTabCount}"></c:when>
                                                </c:choose>
                                                <tr  class="disabled">
                                                        <%--                                            <td>--%>
                                                        <%--                                                <input class="form-control" type="number" value="${e.no}" style="border-radius:10px;">--%>
                                                        <%--                                            </td>--%>
                                                    <td style="border:1px solid #ddd;border-radius:1px; vertical-align: middle" >
                                                        <input class="form-control" type="text" value = "${e.key}" style="border-radius:10px;" disabled="disabled">
                                                    </td>
                                                    <td  style="border:1px solid #ddd;border-radius:1px" >
                                                        <input class="form-control" type="text" value = "${e.value}" style="border-radius:10px;" disabled="disabled">
                                                    </td>
<%--                                                    <td style="border:1px solid #ddd;border-radius:1px">--%>
<%--                                                         <a class="btn" onclick="deleteRow(this)" style="padding-top:10px"><strong><span class="glyphicon glyphicon-minus"></span> </strong></a>--%>
<%--                                                    </td>--%>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>

                                    </c:choose>
                                </table>
                            </div>
                        </div>
                    </div>
<%--                    <div>--%>
<%--                        <div class="front-toolbar other" style="max-width: 100%;width:100%;padding-left:2px;">--%>
<%--                            <div id="schema" class="front-btn-group collapse" data-toggle="buttons">--%>
<%--                                <a id="showHidden1" class="btn btn-default front-no-box-shadow active"--%>
<%--                                   onclick="modifyGroup('${consumer.getName()}')">--%>
<%--                                    <input type="radio" name="options" checked autocomplete="off" value="Topics">--%>
<%--                                    YAML详情--%>
<%--                                    <span></span>--%>
<%--                                </a>--%>

<%--                                &lt;%&ndash;                                <a href="javascript:void(0)" id="showHidden2" class="btn btn-default front-no-box-shadow">&ndash;%&gt;--%>
<%--                                &lt;%&ndash;                                    <input type="radio" name="options" autocomplete="off" value="Topics">&ndash;%&gt;--%>
<%--                                &lt;%&ndash;                                    运行信息&ndash;%&gt;--%>
<%--                                &lt;%&ndash;                                    <span></span>&ndash;%&gt;--%>
<%--                                &lt;%&ndash;                                </a>&ndash;%&gt;--%>
<%--                                <a id="showHidden2" class="btn btn-default front-no-box-shadow">--%>
<%--                                    <input type="radio" name="options" autocomplete="off" value="Connectors">--%>
<%--                                    Pod详情--%>
<%--                                    <span></span>--%>
<%--                                </a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
                    <div id = "div1" style="margin-left: 90px">
                        <div class='form-group'>
                            <label class="col-md-2 control-label front-label">YAML</label>
                            <div class="col-md-7">
                                <textarea type="text" class="form-control front-no-box-shadow" id="project-yaml" style="height: 400px;">${template.yamls}</textarea>
                            </div>
                        </div>
                        <%--                        <div class='form-group'>--%>
                        <%--                            <label class="col-md-2 control-label front-label">LOG</label>--%>
                        <%--                            <div class="col-md-7">--%>
                        <%--                                <textarea type="text" class="form-control front-no-box-shadow" id="log-text" style="height: 400px;" readonly></textarea>--%>
                        <%--                            </div>--%>
                        <%--                        </div>--%>
                    </div>
<%--                    &lt;%&ndash;pod详情表格&ndash;%&gt;--%>
<%--                    <div id = "div2" style="margin-left: 0px">--%>
<%--                        <div class="panel panel-default front-panel" style="margin-bottom: 0px;" id="podTable">--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <script>$("#podTable").css("display","none");</script>--%>
<%--                    <div id = "div3" style="margin-left: 90px">--%>
<%--                    </div>--%>
<%--                    <div id = "div4" style="margin-left: 90px">--%>
<%--                    </div>--%>
                    <div id = "saveInfo" style="margin-left: 0px">
                        <div class="form-group"style="margin-right: -15px">
                            <span class="pull-right col-md-5" style="margin-top: 10px">
<%--                                <a href="javascript:void(0)" class="btn btn-primary pull-right" style="width: 124px" onclick="loadLog('default','warpackage','warget')">加载日志</a>--%>
                                <a href="javascript:void(0)" class="btn btn-primary pull-right" id="saveButton" style="width: 124px" onclick="submit()">保存</a>
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
    var projectNum = ${projectNum};
    if (projectNum != 0) {
        $(":input").attr("disabled", "true");
    }

    var tempId = ${template.id};
    // //YAML 详情显示
    // function show_hidden1(obj) {
    //     if (obj.id == 'div1') {
    //         if (obj.style.display == 'none') {
    //             obj.style.display = 'block';
    //         }
    //     } else {
    //         if (obj.style.display == 'block') {
    //             obj.style.display = 'none'
    //         }
    //     }
    // }
    //
    // //Pod详情显示
    // function show_hidden2(obj) {
    //     if (obj.id == 'div2') {
    //         if (obj.style.display == 'none') {
    //             obj.style.display = 'block';
    //         }
    //     } else {
    //         if (obj.style.display == 'block') {
    //             obj.style.display = 'none'
    //         }
    //     }
    // }
    //
    // // function show_hidden3(obj) {
    // //     if (obj.id == 'div3') {
    // //         if (obj.style.display == 'none') {
    // //             obj.style.display = 'block';
    // //         }
    // //     } else {
    // //         if (obj.style.display == 'block') {
    // //             obj.style.display = 'none'
    // //         }
    // //     }
    // // }
    //
    // function hide(obj) {
    //     obj.style.display = 'none';
    // }
    //
    // //显示YAML详情
    // var sh1 = document.getElementById("showHidden1");
    // sh1.onclick = function () {
    //     var div1 = document.getElementById("div1");
    //     var div2 = document.getElementById("div2");
    //     var div3 = document.getElementById("div3");
    //     var div4 = document.getElementById("div4");
    //     show_hidden1(div1);
    //     hide(div2);
    //     hide(div3);
    //     return false;
    // }
    //
    // //显示pod详情
    // var sh2 = document.getElementById("showHidden2");
    // sh2.onclick = function () {
    //     getPods(projectId);
    //     $("#podTable").show();
    //
    //     var div1 = document.getElementById("div1");
    //     var div2 = document.getElementById("div2");
    //     var div3 = document.getElementById("div3");
    //     var div4 = document.getElementById("div4");
    //     show_hidden2(div2);
    //     hide(div1);
    //     hide(div3);
    //     hide(div4);
    //     return false;
    // };

    // //显示pod详情
    // var sh3 = document.getElementById("showHidden3");
    // sh3.onclick = function () {
    //     getPods(projectId);
    //     var div1 = document.getElementById("div1");
    //     var div2 = document.getElementById("div2");
    //     var div3 = document.getElementById("div3");
    //     var div4 = document.getElementById("div4");
    //     show_hidden3(div3);
    //     hide(div1);
    //     hide(div2);
    //     hide(div4);
    //     return false;
    // };



    // function startProject(id) {
    //     $.ajax({
    //         url: "/project/start",
    //         type: "get",
    //         datatype:"text",
    //         data: {id: id},
    //         success: function (data) {
    //             if(data== true){
    //                 $.fillTipBox({type: 'success', icon: 'glyphicon-ok-sign', content: '项目开始启动'});
    //                 // setInterval(function () {
    //                 //     location.reload();
    //                 // }, 1000);
    //             }
    //         },
    //         error:function (data) {
    //             $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '项目启动失败'});
    //         }
    //     });
    // }
    //
    // function stopProject(id) {
    //     $.ajax({
    //         url: "/project/stop",
    //         type: "get",
    //         datatype:"text",
    //         data: {id: id},
    //         success: function (data) {
    //             if(data== true){
    //                 $.fillTipBox({type: 'success', icon: 'glyphicon-ok-sign', content: '项目开始停止'});
    //                 // setInterval(function () {
    //                 //     location.reload();
    //                 // }, 1000);
    //             }
    //         },
    //         error:function (data) {
    //             $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '项目停止失败'});
    //         }
    //     });
    // }

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
    var pdTable = {};
    function submit() {
        getPdTable();
        var details = JSON.stringify(pdTable);
        var yamls = document.getElementById("project-yaml").value;
        // console.info(details);
        // console.info(yamls);
        var id = ${template.id};
        // if(name==""){
        //     $.fillTipBox({type: 'danger', icon: 'glyphicon-exclamation-sign', content: '项目名称不可为空'});
        //     return false;
        // }
        //alert("ajax");
        $.ajax({
            url:"/template/changeDetails",
            type:"post",
            async: false,
            dataType:"text",
            data:{id:id,
                details:details,
                yamls: yamls
            },
            success:function(data) {
                if (data == "ok") {
                    $.fillTipBox({type: 'success', icon: 'glyphicon-ok-sign', content: '修改成功'});
                    setInterval(function () {
                        window.location = "/template/getDetail?id=" + id;
                    }, 1000);
                } else if (data == "false") {
                    $.fillTipBox({type: 'error', icon: 'glyphicon-alert', content: '修改失败'});
                } else {
                    $.fillTipBox({type: 'error', icon: 'glyphicon-alert', content: data});
                }
            },
        });
    }

    // function getPods(id) {
    //     $.ajax({
    //         url: "/project/getPods",
    //         type: "get",
    //         data: {id: id},
    //         success: function (data) {
    //             if (data.podList.length != 0) {
    //                 var tableHeading = "<table id=\"podInfoTable\" class=\"table table-striped front-table table-bordered\">\n" +
    //                     "<thead>\n" +
    //                     "<tr>\n" +
    //                     "<th width=\"22%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">Pod名称</th>\n" +
    //                     "<th width=\"5%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">状态</th>\n" +
    //                     "<th width=\"5%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">重启数量</th>\n" +
    //                     "<th width=\"15%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">运行时间</th>\n" +
    //                     "<th width=\"10%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">IP</th>\n" +
    //                     "<th width=\"10%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">节点</th>\n" +
    //                     "<th width=\"12%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">初始化容器</th>\n" +
    //                     "<th width=\"12%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">容器</th>\n" +
    //                     "</tr>\n" +
    //                     "</thead>\n";
    //                 var tableStr = "";
    //                 for (var i = 0; i < data.podList.length; i++) {
    //                     var containerStr = "";
    //                     for(var j = 0; j < data.podList[i].container.length; j++) {
    //                         containerStr += "<a herf=\"javascript:void(0)\" onclick='window.open(\""+data.podList[i].container[j].url+"\")' style=\"cursor:pointer\">" + data.podList[i].container[j].containerName + "</a><br>"
    //                     }
    //                     var initContainerStr = "";
    //                     for(var j = 0; j < data.podList[i].initContainer.length; j++) {
    //                         initContainerStr += "<a herf=\"javascript:void(0)\" onclick='window.open(\""+data.podList[i].initContainer[j].url+"\")' style=\"cursor:pointer\">" + data.podList[i].initContainer[j].containerName + "</a><br>"
    //                     }
    //                     tableStr += "<tr>\n" +
    //                         "<td width=\"22%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed; border: 1px solid #ddd\">\n" + data.podList[i].name +
    //                         "</td>\n" +
    //                         "<td width=\"10%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">\n" + data.podList[i].status +
    //                         "</td>\n" +
    //                         "<td width=\"5%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">\n" + data.podList[i].restarts +
    //                         "</td>\n" +
    //                         "<td width=\"15%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">\n" + data.podList[i].age +
    //                         "</td>\n" +
    //                         "<td width=\"10%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">\n" + data.podList[i].ip +
    //                         "</td>\n" +
    //                         "<td width=\"10%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">\n" + data.podList[i].node +
    //                         "</td>\n" +
    //                         "<td width=\"12%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">\n" + initContainerStr
    //                         +
    //                         "</td>\n" +
    //                         "<td width=\"12%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">\n" + containerStr
    //                         +
    //                         "</td>\n" +
    //                         "</tr>";
    //                 }
    //                 var tableHtml = tableHeading + tableStr + "</table>";
    //                 $('#podTable').html(tableHtml);
    //             } else {
    //                 $('#podTable').html("<div style=\"padding-left: 15px;font-size: large;padding-top: 15px;padding-bottom: 15px;font-size:15px\">\n" +
    //                     "                    未查询到Pod详情\n" +
    //                     "                </div>");
    //             }
    //         },
    //         error:function (data) {
    //             $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '查询Pods详情失败'});
    //         }
    //     });
    //
    // }

    // var table = document.getElementById("envTab");
    // table.rows[1].cells[0].getElementsByTagName("input")[0].value = 222;
    function getPdTable() {
        pdTable = {};
        var table = document.getElementById("detailTab");
        for(var j = 1; j<table.rows.length; j++){
            var key = table.rows[j].cells[0].getElementsByTagName("input")[0].value;
            var parameter = table.rows[j].cells[1].getElementsByTagName("input")[0].value;
            if(key !== ""){
                pdTable[key] = parameter;
            }
        }
    }

    // function deleteRow(item){
    //     $.tipModal('confirm', 'warning', '确认删除该行吗？', function(result) {
    //         if(result==true){
    //             $(item).parent().parent().remove();
    //         }
    //     })
    // }

    // function addRow(tabId,num) {
    //     var newTr;   //新增加的行
    //     newTr = document.getElementById(tabId).insertRow();
    //     newTr.setAttribute("class","editList");
    //     for(i=0;i<num;i++){
    //         var newTd=newTr.insertCell();
    //         newTd.setAttribute("style","border:1px solid #ddd;border-radius:1px");
    //         newTd.innerHTML = "<input  class=\"form-control\" type=\"text\" style=\"border-radius:10px;\">";
    //     }
    //     var newTd=newTr.insertCell();
    //     newTd.setAttribute("style","border:1px solid #ddd;border-radius:1px");
    //     newTd.innerHTML="<a class=\"btn\" onclick=\"deleteRow(this)\" style=\"padding-top:10px\"><strong><span class=\"glyphicon glyphicon-minus\"></span> </strong></a>";
    //     return false;
    // }
</script>
</html>
