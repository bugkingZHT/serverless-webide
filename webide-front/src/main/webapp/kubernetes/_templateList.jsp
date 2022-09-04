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
    <title>templateList</title>
</head>
<body>
<div id="templateList" class="panel panel-default front-panel" style="margin-top:10px">
    <table id="infoTable" class="table table-striped front-table table-bordered" style="margin-bottom: 0px">
        <thead>
            <tr>
                <th style="text-align: center">名称/描述</th>
                <th class="col-md-1" style="text-align: center">项目数</th>
                <th class="col-md-2" style="text-align: center">创建时间</th>
                <th class="col-md-2" style="text-align: center">更新时间</th>
                <th class="col-md-1" style="text-align: center">操作</th>
            </tr>
        </thead>
        <c:forEach var="temp" items="${templateList}">
            <tr id="${temp.id}">
                <td style="vertical-align: middle;overflow: auto;text-align: center"><div align="left"><b>${temp.name}</b></div>
                    <div align="left"><font color="#828282" size="3">${temp.describe}</font></div></td>
                <td style="vertical-align: middle;overflow: auto;text-align: center">${temp.projectNum}</td>
                <td style="vertical-align: middle;overflow: auto;text-align: center">${temp.createTime}
                <td style="vertical-align: middle;overflow: auto;text-align: center">${temp.updateTime}
                <td style="vertical-align: middle;padding: 3px;;text-align: center">
                    <a href="javascript:void(0)"   onclick="showDetail('${temp.id}')">详情</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>


<script>
    var searchValue = "";
    showPageNumbers();
    loadNums();

    function showPageNumbers(){
        var htmlstr = "";
        var page = parseInt("${currentPage}");
        var maxPage = parseInt("${maxPages}");
        var maxShowPage = 10;
        if(maxShowPage > maxPage) maxShowPage = maxPage;
        if(maxPage <= 1){
            return;
        }
        htmlstr += "<div class=\"text-center\">" +
            "<ul class=\"pagination\">";
        if(page <= 1){
            htmlstr += "<li class=\"disabled\"><a aria-label=\"Previous\">«</a></li>";
        }
        else{
            htmlstr += "<li><a href=\"javascript:getAppPage("+ (page-1).toString() + ");\" aria-label=\"Previous\">«</a></li>";
        }

        if(maxPage <= maxShowPage){
            for(i = 1; i <= maxShowPage; i++){
                if(i === page){
                    htmlstr += "<li class=\"active\"><a>"+ i.toString() +"</a></li>";
                }
                else{
                    htmlstr += "<li><a href=\"javascript:getAppPage("+ i.toString() +");\">"+ i.toString() +"</a></li>";
                }
            }
        }
        else{
            if(page < maxShowPage - 2){
                for(i = 1; i <= maxShowPage - 2; i++){
                    if(i === page){
                        htmlstr += "<li class=\"active\"><a>"+ i.toString() +"</a></li>";
                    }
                    else{
                        htmlstr += "<li><a href=\"javascript:getAppPage("+ i.toString() +");\">"+ i.toString() +"</a></li>";
                    }
                }
                htmlstr += "<li><a aria-label=\"AfterMore\">...</a></li>";
                htmlstr += "<li><a href=\"javascript:getAppPage("+maxPage.toString()+");\" aria-label=\"Last\">"+maxPage.toString()+"</a></li>";
            }
            else if(page >= maxShowPage - 2 && page <= maxPage - maxShowPage + 3){
                htmlstr += "<li><a href=\"javascript:getAppPage(1);\">1</a></li>";
                htmlstr += "<li><a aria-label=\"AfterMore\">...</a></li>";
                htmlstr += "<li><a href=\"javascript:getAppPage("+ (page-2).toString() +");\">"+ (page-2).toString() +"</a></li>";
                htmlstr += "<li><a href=\"javascript:getAppPage("+ (page-1).toString() +");\">"+ (page-1).toString() +"</a></li>";
                htmlstr += "<li class=\"active\"><a>"+ page.toString() +"</a></li>";
                for(i = page + 1; i <= maxShowPage - 7 + page; i++){
                    htmlstr += "<li><a href=\"javascript:getAppPage("+ i.toString() +");\">"+ i.toString() +"</a></li>";
                }
                htmlstr += "<li><a aria-label=\"AfterMore\">...</a></li>";
                htmlstr += "<li><a href=\"javascript:getAppPage("+maxPage.toString()+");\" aria-label=\"Last\">"+maxPage.toString()+"</a></li>";
            }
            else{
                htmlstr += "<li><a href=\"javascript:getAppPage(1);\">1</a></li>";
                htmlstr += "<li><a aria-label=\"AfterMore\">...</a></li>";
                for(i = maxPage - maxShowPage + 3; i <= maxPage; i++){
                    if(i === page){
                        htmlstr += "<li class=\"active\"><a>"+ i.toString() +"</a></li>";
                    }
                    else{
                        htmlstr += "<li><a href=\"javascript:getAppPage("+ i.toString() +");\">"+ i.toString() +"</a></li>";
                    }
                }
            }
        }
        if(parseInt(page) >= maxPage){
            htmlstr += "<li class=\"disabled\"><a aria-label=\"Next\">»</a></li>";
        }
        else{
            htmlstr += "<li><a href=\"javascript:getAppPage("+ (parseInt(page)+1).toString() + ");\" aria-label=\"Next\">»</a></li>";
        }
        htmlstr += "</ul>" +
            "</div>"
        $("#pageNumbers").html(htmlstr);
    }

    function loadNums() {
        if($('#searchBox').val().trim() === "")
            $("#searchedText").text("当前共有${searchedTemplateNum}个模板");
        else
            $("#searchedText").text("当前共有${searchedTemplateNum}个模板含\""+$('#searchBox').val()+"\"关键字");
    }
</script>
</body>
</html>
