<%--
  Created by IntelliJ IDEA.
  User: 王云轩
  Date: 2020/10/8
  Time: 14:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <c:import url="/template/_header.jsp"/>
    <title>项目详细配置</title>
    <style>
        .badge-grey {
            display: inline-block;
            min-width: 10px;
            padding: 3px 7px;
            font-size: 12px;
            font-weight: bold;
            line-height: 1;
            color: #fff;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            background-color: #777;
            border-radius: 10px;
        }
        .badge-green {
            display: inline-block;
            min-width: 10px;
            padding: 3px 7px;
            font-size: 12px;
            font-weight: bold;
            line-height: 1;
            color: #fff;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            background-color: #00b050;
            border-radius: 10px;
        }
        .badge-red {
            display: inline-block;
            min-width: 10px;
            padding: 3px 7px;
            font-size: 12px;
            font-weight: bold;
            line-height: 1;
            color: #fff;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            background-color: rgb(238, 68, 46);
            border-radius: 10px;
        }
    </style>
</head>
<body class="front-body">
<c:import url="/template/_navbar.jsp?menu=project"/>
<div class="front-inner" id = "main_container">
    <div class="container" >
        <div class="row front-canvas" id="front-canvas">
            <div>
                <ol class="breadcrumb">
                    <li><a href="/project">项目管理</a></li>
                    <li class="active">
                        项目详情[${project.name}]
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
                            <span id="myGroupName">${project.name}</span>&nbsp;&nbsp;
                            <span id="permission">${project.status}</span>
                            <script>
                                if ("${project.status}" == "RUNNING") {
                                    $('#permission').addClass('badge-green');
                                } else if ("${project.status}" == "ERROR") {
                                    $('#permission').addClass('badge-red');
                                } else {
                                    $('#permission').addClass('badge-grey');
                                }
                            </script>
<%--                            <span id="runningStatus">${project.runtimeStatus}</span>--%>
<%--                            <script>--%>
<%--                                if ("${project.runtimeStatus}" == "SUCCESS") {--%>
<%--                                    $('#runningStatus').addClass('badge-green');--%>
<%--                                } else if ("${project.runtimeStatus}" == "ERROR") {--%>
<%--                                    $('#runningStatus').addClass('badge-red');--%>
<%--                                } else {--%>
<%--                                    $('#runningStatus').addClass('badge-grey');--%>
<%--                                }--%>
<%--                            </script>--%>
                        </h4>
                        <h4 class="midia-heading" style="font-size: 15px">
                            <span id="describe">${project.description}</span>&nbsp;&nbsp;
                        </h4>
                        <h4 class="midia-heading" style="font-size: 15px">
                            <span id="runtimeStatus">探针服务：[${project.runtimeStatusCode}]${project.runtimeStatus}</span>&nbsp;&nbsp;
                        </h4>
                        <h4 class="midia-heading" style="font-size: 15px">
                            <div id="createTime"></div>&nbsp;&nbsp;
                        </h4>

                        <script>
                            var createTime = "${project.createTime}";
                            $('#createTime').html("创建时间："+createTime.substring(0,createTime.length-2))
                        </script>
                    </div>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="front-toolbar other col-lg-6" style="max-width: 70%;width:70%">
                    <div id="schema" class="front-btn-group collapse" data-toggle="buttons">
                        <a id="showHidden1" class="btn btn-default front-no-box-shadow active"
                           onclick="modifyGroup('${consumer.getName()}')">
                            <input type="radio" name="options" checked autocomplete="off" value="Topics">
                            项目配置
                            <span></span>
                        </a>
                        <a href="javascript:void(0)" id="showHidden5" class="btn btn-default front-no-box-shadow">
                            <input type="radio" name="options" autocomplete="off" value="Topics">
                            文件管理
                            <span></span>
                        </a>
                        <a href="javascript:void(0)" id="showHidden2" class="btn btn-default front-no-box-shadow">
                            <input type="radio" name="options" autocomplete="off" value="Topics">
                            Pod详情
                            <span></span>
                        </a>
                        <a id="showHidden3" class="btn btn-default front-no-box-shadow">
                            <input type="radio" name="options" autocomplete="off" value="Connectors">
                            运行状态
                            <span></span>
                        </a>
                        <a id="showHidden4" class="btn btn-default front-no-box-shadow">
                            <input type="radio" name="options" autocomplete="off" value="Connectors">
                            运行日志
                            <span></span>
                        </a>
                    </div>
                </div>
                <div class="front-toolbar other pull-right" style="max-width: 30%;width:30%">
                    <div class="front-btn-group collapse pull-right" data-toggle="buttons">
                        <a  id="startButton" class="btn btn-default front-no-box-shadow" onclick="startProject('${project.id}')">
                            启动
                        </a>
                        <a  id="pauseButton" class="btn btn-default front-no-box-shadow" onclick="stopProject('${project.id}')">
                            停止
                        </a>
                        <a  id="deleteButton" class="btn btn-danger front-no-box-shadow" data-toggle="modal" data-target="#myModal">
                            删除
                        </a>
                    </div>

                    <script>
                        var status = "${project.status}";
                        if (status == "STOP") {
                            $('#pauseButton').addClass('disabled');
                        } else if (status == "PROCESSING") {
                            $('#pauseButton').addClass('disabled');
                            $('#startButton').addClass('disabled');
                            $('#deleteButton').addClass('disabled');
                        } else if (status == "ERROR") {
                            $('#startButton').addClass('disabled');
                        } else if (status == "RUNNING") {
                            $('#startButton').addClass('disabled');
                        }
                    </script>
                </div>


                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                                <h4 class="modal-title" id="exampleModalLabel">确认删除</h4>
                            </div>
                            <div class="modal-body">
                                <form>
                                    <div class="form-group">
                                        <label form="message-text" class="control-label">确定要删除此项目？</label>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
                                <button type="button" class="btn btn-primary"  onclick="deleteProject(${project.id})">确认</button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
            <div id = "div1"  class="panel panel-default front-panel clear form-horizontal">
<%--                <div class="panel-heading"> <strong>项目详细配置</strong>--%>
<%--                    <a id="help" style="margin-left: 10px;cursor:pointer">帮助</a>--%>
<%--                </div>--%>
                <div class="panel-body" style=" padding-bottom:0px">
                    <div style="margin-left: 90px">
                        <div class='form-group'>
                            <label class="col-md-2 control-label front-label">名称</label>
                            <div class="col-md-7">
                                <input type="text" class="form-control front-no-box-shadow" id="project-name" disabled value="${project.name}">
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class="col-md-2 control-label front-label">描述</label>
                            <div class="col-md-7">
                                <textarea type="text" class="form-control front-no-box-shadow" id="project-description">${project.description}</textarea>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class="col-md-2 control-label front-label">模板</label>
                            <div class="col-md-7">
                                <input type="text" class="form-control front-no-box-shadow" id="project-template" disabled value="${templateName}">
                            </div>
                        </div>
<%--                        <div class='form-group'>--%>
<%--                            <label class="col-md-2 control-label front-label">所有者</label>--%>
<%--                            <div class="col-md-7">--%>
<%--                                <input type="text" class="form-control front-no-box-shadow" id="project-owner" disabled value="${project.ownerName}">--%>
<%--                            </div>--%>
<%--                        </div>--%>
                        <div class='form-group'>
                            <label class="col-md-2 control-label front-label">详细信息</label>
                            <div class="col-md-7">
<%--                                <textarea type="text" class="form-control front-no-box-shadow" id="project-details" style="height: 400px;">${project.details}</textarea>--%>
                                <table class="table front-table" style="text-align: center; border:1px solid #ddd;" id = "detailTab">
                                    <thead style="border-color:inherit;">
                                    <tr style="border-color:inherit;">
                                        <td style="border:1px solid #ddd;border-radius:1px;font-size:10pt" class="col-md-4 col-lg-4"><b>参数名</b></td>
                                        <td style="border:1px solid #ddd;border-radius:1px;font-size:10pt" class="col-md-8 col-lg-8"><b>参数值</b></td>
<%--                                        <td style="border:1px solid #ddd;border-radius:1px">--%>
<%--                                            <a class="btn" onclick="addRow('envTab',2)"><strong><span class="glyphicon glyphicon-plus"></span> </strong></a>--%>
<%--                                        </td>--%>
                                    </tr>
                                    </thead>
                                    <%--没有默认值，且首次填写，则给一行填写框--%>
                                    <c:choose>
                                        <c:when test="${project.details == null}">
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
<%--                                                    <a class="btn" onclick="deleteRow(this)" style="padding-top:10px"><strong><span class="glyphicon glyphicon-minus"></span> </strong></a>--%>
<%--                                                </td>--%>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="e" items="${pdList}" varStatus="status">
                                                <c:choose>
                                                    <c:when test="${status.index < defaultSymAndAcroTabCount}"></c:when>
                                                </c:choose>
                                                <tr>
                                                        <%--                                            <td>--%>
                                                        <%--                                                <input class="form-control" type="number" value="${e.no}" style="border-radius:10px;">--%>
                                                        <%--                                            </td>--%>
                                                    <td style="border:1px solid #ddd;border-radius:1px; vertical-align: middle" >
                                                            ${e.key}
<%--                                                        <input class="form-control" type="text" disabled value = "${e.key}" style="border-radius:10px;">--%>
                                                    </td>
                                                    <td style="border:1px solid #ddd;border-radius:1px" >
                                                        <input class="form-control" id = "evalue${e.key}" type="text" value = "${e.value}" style="border-radius:10px;" >
                                                    </td>
                                                            <script>
                                                                var status = "${project.status}";
                                                                if (status == "RUNNING") {
                                                                    $('#evalue${e.key}').attr("disabled", "true");
                                                                }
                                                            </script>
<%--                                                    <td style="border:1px solid #ddd;border-radius:1px">--%>
<%--                                                        <a class="btn" onclick="deleteRow(this)" style="padding-top:10px"><strong><span class="glyphicon glyphicon-minus"></span> </strong></a>--%>
<%--                                                    </td>--%>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>

                                    </c:choose>
                                </table>
                            </div>
                            <div class="col-md-5" style="margin-top: 10px; margin-left: 175px;">
                                <a href="javascript:void(0)" class="btn btn-primary pull-left" id="saveButton" style="width: 124px" onclick="submit()">保存</a>
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

<%--&lt;%&ndash;                                <a href="javascript:void(0)" id="showHidden2" class="btn btn-default front-no-box-shadow">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    <input type="radio" name="options" autocomplete="off" value="Topics">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    运行信息&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    <span></span>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                </a>&ndash;%&gt;--%>
<%--                                <a id="showHidden2" class="btn btn-default front-no-box-shadow">--%>
<%--                                    <input type="radio" name="options" autocomplete="off" value="Connectors">--%>
<%--                                    Pod详情--%>
<%--                                    <span></span>--%>
<%--                                </a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
                    <div id = "yamls" style="margin-left: 90px">
                        <div class='form-group'>
                            <label class="col-md-2 control-label front-label">YAML详情</label>
                            <div class="col-md-7">
                                <textarea type="text" class="form-control front-no-box-shadow" id="project-yaml" style="height: 400px;" disabled>${project.yamls}</textarea>
                            </div>
                        </div>
<%--                        <div class='form-group'>--%>
<%--                            <label class="col-md-2 control-label front-label">LOG</label>--%>
<%--                            <div class="col-md-7">--%>
<%--                                <textarea type="text" class="form-control front-no-box-shadow" id="log-text" style="height: 400px;" readonly></textarea>--%>
<%--                            </div>--%>
<%--                        </div>--%>
                    </div>
                </div>
            </div>
            <div id = "div2" style="margin-left: 0px">
                <h5 style="margin-top: 10px; margin-left: 5px" id = "podTableNum"></h5>
                <div class="panel panel-default front-panel" style="margin-bottom: 10px;" id="podTable">
                </div>
            </div>
            <script>$("#podTable").css("display","none");</script>
            <div id = "div3" style="margin-left: 0px">
                <div class="panel panel-default front-panel" style="height: 250px;margin-top: 10px">
                    <div class="panel-body">
                        <div id="podstatus" style="height:220px">
                            <p style="font-size: 15px; text-align: center; padding-top: 110px">加载中...</p>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default front-panel" style="height: 250px;">
                    <div class="panel-body">
                        <div id="memory" style="height:220px">
                            <p style="font-size: 15px; text-align: center; padding-top: 110px">加载中...</p>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default front-panel" style="height: 250px;margin-top: 10px">
                    <div class="panel-body">
                        <div id="cpu" style="height:220px">
                            <p style="font-size: 15px; text-align: center; padding-top: 110px">加载中...</p>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default front-panel" style="height: 250px;margin-top: 10px">
                    <div class="panel-body">
                        <div id="netio" style="height:220px">
                            <p style="font-size: 15px; text-align: center; padding-top: 110px">加载中...</p>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default front-panel" style="height: 250px;margin-top: 10px">
                    <div class="panel-body">
                        <div id="restart" style="height:220px">
                            <p style="font-size: 15px; text-align: center; padding-top: 110px">加载中...</p>
                        </div>
                    </div>
                </div>
            </div>
            <script>$("#div3").css("display","none");</script>
            <div id = "div4" style="margin-left: 0px">
                <div id="custom-query-div" class="panel  panel-default front-panel clear form-horizontal">
                    <div class="panel-heading">日志查询</div>
                    <div class="panel-body" style="margin-bottom: 0px;padding-bottom: 0px;">
                        <div class="form-group">
                            <label class="col-md-1 control-label">时间</label>
                            <div class="col-md-5">
                                <input type="text" class="form-control" id="begin-date" placeholder="起始时间">
                            </div>
                            <div class="col-md-1"></div>
                            <div class="col-md-5">
                                <input type="text" class="form-control" id="end-date" placeholder="终止时间">
                            </div>
                        </div>
<%--                        <div class="form-group" id="projectNameGroup">--%>
<%--                            <label class="col-md-1 control-label">项目名称</label>--%>
<%--                            <div class="col-md-11">--%>
<%--                                <input type="text" class="form-control front-no-box-shadow" id="projectName" disabled value="${project.name}">--%>
<%--                            </div>--%>
<%--                        </div>--%>
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
                            <label class="col-md-1 control-label" for="content">内容</label>
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
            <script>$("#div4").css("display","none");</script>
            <div id="div5" style="margin-left: 0px">
                <div class="panel panel-default front-panel" style="margin-bottom: 10px;">
                    <div class="panel-heading" >文件信息</div>
                    <div class="panel-body" style="margin-bottom: 0px;padding-bottom: 0px;">
                        <div class="row">
<%--                                <div id="appManage" class="col-lg-4 col-md-4 col-sm-4 col-xs-4"  style="position: relative;left: 0px;">--%>
<%--                                    <input type="text" class="form-control"  id="searchBox" placeholder="搜索文件" autofocus="autofocus">--%>
<%--                                </div>--%>
<%--                                <div id= "searchedText" class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="bottom: 0px; left: 0px"></div>--%>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <%-- <a class="btn btn-primary pull-right" type="button" href="/upload" style="text-align:center;left: 0px">上传</a>--%>
<%--                                        method="post" action="/upload"  type="submit" --%>
                                        <form id="fileform" method="post" action="/project/upload?projectId=${project.id}" enctype="multipart/form-data">

                                            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3 ">
                                            </div>
                                            <div class="col-lg-7 col-md-7 col-sm-7 col-xs-7" style="height: 32px; background: #fff; border: 1px solid #ddd;margin-left: 0px; margin-right: 0px">
                                                <span id="filetext"  style="position: absolute; text-align:center; line-height: 32px;"> 点击此处或拖拽文件到此处选择文件</span>
                                                <input id="input-ke-2" name="file" type="file" style="opacity: 0; cursor: pointer;  height: 32px;">
                                            </div>
                                            <div class="col-lg-1 col-md-1 col-sm-1 col-xs-1">
                                                <input class="btn btn-primary " type="submit" value="上传文件" id="basic-addon2">
                                            </div>
<%--                                                <div class="col-lg-8 col-md-8 col-sm-8 col-xs-8" style="height: 32px; background: #fff; border: 1px solid #ddd;margin-left: 0px;margin-right: 100px">--%>
<%--                                                    <span id="filetext"  style="position: absolute; left: 40%; line-height: 32px;"> 点击此处或拖拽文件到此处</span>--%>
<%--                                                    <input id="input-ke-2" name="file" type="file" style="opacity: 0 ;cursor: pointer;width: 100%; height: 100%;">--%>
<%--                                                </div>--%>


                                        </form>
<%--                                        <form id="uploadForm" enctype="multipart/form-data">--%>
<%--                                        <table>--%>
<%--                                            <tr>--%>
<%--                                                <td><input id="cert" class="form-control" type="file" name="file"></td>--%>
<%--                                                <td> <input type="button" class="btn btn-primary pull-right" value="上传" onclick="Fileupload()"/></td>--%>
<%--&lt;%&ndash;                                                <input width="10px" id="fileUpload" class="btn btn-primary pull-right"  value="上传">&ndash;%&gt;--%>
<%--                                            </tr>--%>
<%--                                        </table>--%>
<%--                                    </form>--%>
                                </div>

<%--                            </div>--%>
                        </div>

                        <div class="container" id="loading-container" style="margin-top:5px;display: block">
                            <div class="front-loading">
                                <div class="front-loading-block"></div>
                                <div class="front-loading-block"></div>
                                <div class="front-loading-block"></div>
                            </div>
                            <div class="panel-body text-center">正在加载请稍候</div>
                        </div>
                        <div id="fileList" class="panel panel-default front-panel" style="margin-top:10px">
                                <table class="table table-striped front-table table-bordered" style="margin-bottom: 0px">
                                    <thead>
                                    <tr>
                                        <th class="col-md-1" style="text-align: center">#</th>
                                        <th style="text-align: center">文件名称</th>
                                        <th class="col-md-3" style="text-align: center">创建时间</th>
                                        <th class="col-md-2" style="text-align: center">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody id="resultTable" style="text-align: center">

                                    </tbody>
                                </table>
                        </div>
                    </div>
                </div>
            </div>
            <script>$("#div5").css("display","none");</script>
        </div>
    <c:import url="/template/_footer.jsp"/>
</div>
<div id="progressModal" class="modal fade" tabindex="-1" role="dialog" data-backdrop="static"
     data-keyboard="false">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">文件上传中</h4>
            </div>
            <div class="modal-body">
                <div id="progress" class="progress">
                    <div id="progress_rate" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"
                         class="progress-bar progress-bar-success progress-bar-striped active"
                         role="progressbar" style="width: 50%">
                        <span id="percent">50%</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    var projectId = ${project.id};
    var projectName = '${project.name}';
    var id = ${project.id};
    var projectDescription = $('#project-description').val();
</script>
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap-datetimepicker.min.js"></script>
<script src="/static/js/echarts.common.min.js"></script>
<script src="/static/js/echarts-liquidfill.js"></script>
<script src="/kubernetes/metricsCharts.js"></script>

<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<script src="/static/js/front.js"></script>
<script src="/static/js/jquery.cookie.js"></script>
<script src="/static/js/jquery.md5.js"></script>
<script src="/static/bootstrap/js/bootstrap-table.js"></script>
<script src="/static/bootstrap/js/bootstrap-table-zh-CN.js"></script>
<script src="/static/js/jquery.form.js"></script>
<script>
    <%--var projectId = ${project.id};--%>
    <%--var projectName = '${project.name}';--%>
    <%--var id = ${project.id};--%>
    <%--var projectDescription = $('#project-description').val();--%>

    $("#input-ke-2").change(function(){
        var path = $("#input-ke-2").val().split('\\');
        $("#filetext").html(path[path.length-1]);
    });

    $(function () {
        $("#fileform").ajaxForm(function (data) {
            $("#progressModal").modal("hide");
            if(data === "success"){
                showList();
                console.log("上传成功");
                $.fillTipBox({type:'success', icon:'glyphicon-ok-sign', content:'上传成功'});
                $("#input-ke-2").val("");
                $("#filetext").html("点击此处或拖拽文件到此处");
            }else if(data === "repeat"){
                $.fillTipBox({type:'warning', icon:'glyphicon-exclamation-sign', content:'文件名称重复'});
            }else{
                $.fillTipBox({type:'warning', icon:'glyphicon-exclamation-sign', content:'上传失败'});
            }
        });
    });
    showList();
    function showList() {
        $.ajax({
            url: "/project/getfiles",
            type: "get",
            data: {projectId: ${project.id}},
            success: function (data) {
                $('#fileList').html(data);
            },
            error: function (data) {
                $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '文件信息获取失败！'});
            }
        });
    }

    function deletefile(fileId) {
        $.ajax({
            url: "/project/deletefile?fileId=" + fileId,
            type: "post",
            data: {},
            success: function (data) {
                if(data === "删除成功"){
                    showList();
                    $.fillTipBox({type:'success', icon:'glyphicon-ok-sign', content:'删除成功'});
                }else if(data === "文件不存在"){
                    $.fillTipBox({type:'warning', icon:'glyphicon-exclamation-sign', content:'文件不存在'});
                }else{
                    $.fillTipBox({type:'warning', icon:'glyphicon-exclamation-sign', content:'删除失败'});
                }
            },
            error: function (data) {
                $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '删除失败！'});
            }
        });
    }

    var process;// 定时对象

    $(function() {

        <%--var time = "${time}";--%>
        <%--if (time != null && time != "") {--%>
        <%--    $("#msg").css("display", "block");--%>
        <%--}--%>

        $("#basic-addon2").bind("click", function(){

            process = setInterval("getProcess()", 100);// 每0.1s读取一次进度
            $("#progressModal").modal("show");// 打开模态框

        });

    });

    // 读取文件上传进度并通过进度条展示
    function getProcess() {

        $.ajax({
            type: "get",
            url: "/project/upload/progress",
            success: function(data) {
                var rate = data * 100;
                rate = rate.toFixed(2);
                $("#progress_rate").css("width", rate + "%");
                $("#percent").text(rate + "%");
                if (rate >= 100) {
                    clearInterval(process);
                    $("#percent").text("文件上传成功！");
                }
            }
        });

    }
</script>
<script src="/kubernetes/projectDetails.js"></script>
</html>
