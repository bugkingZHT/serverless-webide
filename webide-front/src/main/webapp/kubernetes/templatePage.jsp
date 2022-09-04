<%--
  Created by IntelliJ IDEA.
  User: 高齐鸿
  Date: 2020/11/18
  Time: 14:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <c:import url="/template/_header.jsp"/>
    <title>模板管理</title>
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
                         模板管理
                     </li>
                 </ol>
            </div>
            <div class="col-md-12 col-sm-12 col-xs-12 col-lg-12 form-group" style="margin-bottom: 5px">
                <div id= "searchedText" class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="bottom: -10px; left: -10px"></div>
                <div id="appManage" class="col-lg-3 col-md-3 col-sm-3 col-xs-3
                        col-lg-offset-4 col-md-offset-4 col-xs-offset-4 col-sm-offset-4" style="position: relative;left: 35px;">
                    <input type="text" class="form-control"  id="searchBox" placeholder="搜索模板" autofocus="autofocus">
                </div>
                <div class="col-lg-1 col-md-1 col-sm-1 col-xs-1" style="padding-right:0px">
                    <a class="btn btn-primary pull-right" type="button" href="/kubernetes/newTemplate.jsp" style="text-align:center;left: 0px"><span class="glyphicon glyphicon-plus-sign"></span>&nbsp;新建</a>
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

        <div id="templateList"></div>


    </div>
    <c:import url="/template/_footer.jsp"/>
</div>

</body>

<script language="JavaScript">
    var searchValue = "";
    showTemplates(1,'');

    document.addEventListener("keyup",function(e){
        if(e.keyCode == 13){
            search();
        }
    });

    function getAppPage(page){
        showTemplates(page, searchValue);
    }

    function showDetail(id) {
        window.location.href="/template/getDetail?id="+id;
    }

    function showTemplates(page, search) {
        $.ajax({
            url: "/template/getTemplates",
            type: "get",
            data: {page:page, search:search},
            beforeSend:function(){
                $("#loading-container").css("display","block");
                $("#templateList").hide();
            },
            success: function (data) {
                $('#templateList').html(data);
                //获取查到的模板数量
                var parser = new DOMParser();
                var htmlDoc = parser.parseFromString("" + data, "text/html");
                $("#loading-container").css("display","none");
                $("#templateList").show();
            },
            error: function (data) {
                $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '查询模板失败！'});
            }
        });
    }

    function search(){
        var inputValue = $('#searchBox').val();
        searchValue = inputValue;
        showTemplates(1,inputValue);
    }
</script>
</html>

