<%--
  Created by IntelliJ IDEA.
  User: Creed
  Date: 2021/1/10
  Time: 11:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>projectList</title>
</head>
<body>
<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12 col-lg-12 form-group" style="margin-bottom: 5px">
        <div id= "searchedText" class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="bottom: -10px; left: -10px">共有${searchedProjectNum}个WorkSpace</div>
        <div id="appManage" class="col-lg-3 col-md-3 col-sm-3 col-xs-3
                    col-lg-offset-4 col-md-offset-4 col-xs-offset-4 col-sm-offset-4" style="position: relative;left: 35px;">
<%--        <input type="text" class="form-control"  id="searchBox" placeholder="搜索项目" autofocus="autofocus">--%>
    </div>
        <div class="col-lg-1 col-md-1 col-sm-1 col-xs-1" style="padding-right:0px">
            <a class="btn btn-primary pull-right" type="button" href="/project/newWorkSpace" style="text-align:center;left: 0px"><span class="glyphicon glyphicon-plus-sign"></span>&nbsp;新建</a>
        </div>
    </div>
</div>

<div class="panel panel-default front-panel" style="margin-top:10px">
    <table id="infoTable" class="table table-striped front-table table-bordered" style="margin-bottom: 0px">
        <thead>
            <tr>
                <th style="text-align: center">名称</th>
                <%--                        <th style="text-align: center">描述</th>--%>
                <th class="col-md-2" style="text-align: center">Code</th>
                <%--                        <th class="col-md-1" style="text-align: center">所有者</th>--%>
                <th class="col-md-1" style="text-align: center">状态</th>
                <th class="col-md-2" style="text-align: center">OSS地址</th>
                <%--<th class="col-md-1">位置</th>--%>
                <%--                        <th class="col-md-2" style="text-align: center">状态更新时间</th>--%>
                <th class="col-md-1" style="text-align: center">操作</th>
            </tr>
        </thead>
        <c:forEach var="ws" items="${workSpaceList}">
            <tr id="${ws.id}">
                <td style="vertical-align: middle;overflow: auto;text-align: center">
                    <div align="left"><b>${ws.name}</b></div>
                </td>
                <td style="vertical-align: middle;overflow: auto;text-align: center">${ws.code}</td>
                    <%--                            <td style="vertical-align: middle;overflow: auto;text-align: center">${proj.owner}</td>--%>
                    <%--                            <td style="vertical-align: middle;overflow: auto;text-align: center">${proj.status}</td>--%>
                <td style="vertical-align: middle;overflow: auto;text-align: center">
                    <c:choose>
                        <c:when test="${ws.isActive == '1'}">
                            <a style="vertical-align: middle;overflow: auto;text-align: center; font-weight: bold; color: #3779F0">已激活</a>
                        </c:when>
                        <c:when test="${ws.isActive == '0'}">
                           <a style="vertical-align: middle;overflow: auto;text-align: center; font-weight: bold; color: #828282">未激活</a>
                        </c:when>
                    </c:choose>
                </td>
                <td style="vertical-align: middle;overflow: auto;text-align: center">${ws.workspaceOssPath}</td>
                <td style="vertical-align: middle;padding: 3px;;text-align: center">
                    <c:choose>
                    <c:when test="${ws.isActive == '1'}">
                        <a href="javascript:void(0)"   onclick="gotoIDE('${ws.id}')">打开IDE</a>
                        <br>
                        <a href="javascript:void(0)"   onclick="releaseWs('${ws.id}')">释放资源</a>
                    </c:when>
                    <c:when test="${ws.isActive == '0'}">
                        <a href="javascript:void(0)"   onclick="activateWs('${ws.id}')">激活</a>
                    </c:when>
                    </c:choose>

                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>

<script>

    function activateWs(id) {
        $.ajax({
            url: "/project/activate",
            type: "get",
            datatype: "text",
            data: {id: id},
            success: function (data) {
                if (data == true) {
                    $.fillTipBox({type: 'success', icon: 'glyphicon-ok-sign', content: '正在激活WorkSpace'});
                    setInterval(function () {
                        location.reload();
                    }, 5000);

                }
            },
            error: function (data) {
                $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: 'WorkSpace激活失败'});
            }
        });
    }

    function gotoIDE(id) {
        $.ajax({
            url: "/project/gotoide",
            type: "get",
            datatype: "text",
            data: {id: id},
            success: function (data) {
                window.open('http://' + data, 'self');
            },
            error: function (data) {
                $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: 'WorkSpace激活失败'});
            }
        });
    }

    function releaseWs(id) {
        $.ajax({
            url: "/project/release",
            type: "get",
            datatype: "text",
            data: {id: id},
            success: function (data) {
                if (data == true) {
                    $.fillTipBox({type: 'success', icon: 'glyphicon-ok-sign', content: '正在释放函数'});
                    setInterval(function () {
                        location.reload();
                    }, 5000);

                }
            },
            error: function (data) {
                $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '函数释放失败'});
            }
        });
    }
</script>

</html>
