<%--
  Created by IntelliJ IDEA.
  User: Creed
  Date: 2021/1/16
  Time: 16:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <c:import url="/template/_header.jsp"/>
    <title>域名管理</title>
</head>
<body class="front-body">
<c:import url="/template/_navbar.jsp?menu=service"/>
<div class="front-inner" id = "main_container">
    <div class="container" >
        <div class="row">
            <div class="col-md-12">
                <ol class="breadcrumb">
                    <li>服务管理</li>
                    <li class="active">
                        域名管理
                    </li>
                </ol>
            </div>
            <div class="col-md-12 col-sm-12 col-xs-12 col-lg-12 form-group" style="margin-bottom: 5px">
                <div id= "searchedText" class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="bottom: -10px; left: -10px"></div>
                <div id="appManage" style="float: right" align="right">
                    <input type="text" class="form-control"  id="searchBox" placeholder="搜索域名" autofocus="autofocus" style="float: right" align="right">
                </div>
            </div>
        </div>

        <div class="container" id="loading-container" style="margin-top:5px;display: block">
            <div class="front-loading">
                <div class="front-loading-block"></div>
                <div class="front-loading-block"></div>
                <div class="front-loading-block"></div>
            </div>
            <div class="panel-body text-center">正在加载请稍候</div>
        </div>

        <div id="domainList"></div>

    </div>
</div>
<c:import url="/template/_footer.jsp"/>
</body>

<script language="JavaScript">
    var searchValue = "";
    showDomains(1,'');

    document.addEventListener("keyup",function(e){
        if(e.keyCode == 13){
            search();
        }
    });

    function getAppPage(page){
        showDomains(page, searchValue);
    }

    function showDomains(page, search) {
        console.log(search);
        console.log("search");
        $.ajax({
            url: "/domain/getDomains",
            type: "get",
            data: {page:page, search:search},
            beforeSend:function(){
                $("#loading-container").css("display","block");
                $("#domainList").hide();
            },
            success: function (data) {
                $('#domainList').html(data);
                $("#loading-container").css("display","none");
                $("#domainList").show();
            },
            error: function (data) {
                $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '查询项目失败！'});
            }
        });
    }

    function search(){
        var inputValue = $('#searchBox').val();
        searchValue = inputValue;
        showDomains(1,inputValue);
    }


</script>
</html>

