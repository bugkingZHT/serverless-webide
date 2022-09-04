<%--
  Created by IntelliJ IDEA.
  User: 王云轩
  Date: 2020/10/8
  Time: 14:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <c:import url="/template/_header.jsp"/>
    <title>项目管理</title>
</head>
<body class="front-body">
<c:import url="/template/_navbar.jsp?menu=project"/>
<div class="front-inner" id = "main_container">
    <div class="container">


        <div class="container" id="loading-container" style="margin-top:5px;display: block">
            <div class="front-loading">
                <div class="front-loading-block"></div>
                <div class="front-loading-block"></div>
                <div class="front-loading-block"></div>
            </div>
            <div class="panel-body text-center">正在加载请稍候</div>
        </div>

        <div id="projectList"></div>

    </div>
    <c:import url="../template/_footer.jsp"/>
</div>
</body>

<script language="JavaScript">
    var searchValue = "";
    showProjects(1,'');


    document.addEventListener("keyup",function(e){
        if(e.keyCode == 13){
            search();
        }
    });

    function getAppPage(page){
        showProjects(page, searchValue);
    }

    function showDetail(id) {
        window.location.href="/project/getDetail?id="+id;
    }

    function showProjects(page, search) {
        $.ajax({
            url: "/project/getProjects",
            type: "get",
            data: {page:page, search:search},
            beforeSend:function(){
                $("#loading-container").css("display","block");
                $("#projectList").hide();
            },
            success: function (data) {
                $('#projectList').html(data);
                $("#loading-container").css("display","none");
                $("#projectList").show();
                loadNums();
            },
            error: function (data) {
                $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '查询项目失败！'});
            }
        });
    }

    function search(){
        var inputValue = $('#searchBox').val();
        searchValue = inputValue;
        showProjects(1,inputValue);
    }

    function getStatus1(id) {
        $.ajax({
            type: "get",
            url: "/project/getStatus1",
            data:{id:id},
            contentType: "application/json;charset=utf-8",
            success: function (data) {
                if (data.code === 200) {
                    var status = data.result;
                    load(id,status);
                } else
                    console.log("获取项目状态失败");
            }, error: function (err) {
                console.log("无法获取项目状态");
            }
        });
    }

    function load(id,status){
        var htmlStr = "";
        if(status =='UNKNOWN')
            htmlStr += "<div style=\"font-weight: bold\"><font color=\"#828282\">"+status+"</div>";
        else if (status == 'RUNNING' || status == 'STOP')
            htmlStr += "<div style=\"font-weight: bold\"><font color=\"#00b050\">"+status+"</font></div>";
        else
            htmlStr += "<div style=\"font-weight: bold\"><font color=\"#ee442e\">"+status+"</font></div>";
        $("#status"+id).html(htmlStr);
    }
</script>
</html>

