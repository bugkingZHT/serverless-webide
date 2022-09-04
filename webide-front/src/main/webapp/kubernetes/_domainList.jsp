<%--
  Created by IntelliJ IDEA.
  User: Creed
  Date: 2021/1/16
  Time: 16:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>domainList</title>
</head>
<body>
<div id="domainList" class="panel panel-default front-panel" style="margin-top:10px">
    <table id="infoTable" class="table table-striped front-table table-bordered" style="margin-bottom: 0px">
        <thead>
        <tr>
            <th class="col-md-2" style="text-align: center">名称</th>
            <th class="col-md-2" style="text-align: center">名称空间</th>
            <th style="text-align: center">域名</th>
            <th class="col-md-2" style="text-align: center">创建时间</th>
            <th class="col-md-2" style="text-align: center">所属项目</th>
        </tr>
        </thead>
        <c:forEach var="temp" items="${domainList}">
            <tr id="${temp.id}">
                <td style="vertical-align: middle;overflow: auto;text-align: center">${temp.name}</td>
                <td style="vertical-align: middle;overflow: auto;text-align: center">${temp.nameSpace}</td>
                <td style="vertical-align: middle;overflow: auto;text-align: center"><a href=http://${temp.domain}>${temp.domain}</a></td>
                <td style="vertical-align: middle;overflow: auto;text-align: center">${temp.createTime}</td>
                <c:if test="${temp.projectId == -1}">
                    <td style="vertical-align: middle;overflow: auto;text-align: center">${temp.project}</td>
                </c:if>
                <c:if test="${temp.projectId != -1}">
                    <td style="vertical-align: middle;overflow: auto;text-align: center"><a href="/project/getDetail?id=${temp.projectId}">${temp.project}</a></td>
                </c:if>
            </tr>
        </c:forEach>
    </table>
</div>
</body>

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
            $("#searchedText").text("当前共有${searchedDomainNum}个域名");
        else
            $("#searchedText").text("当前共有${searchedDomainNum}个域名含\""+$('#searchBox').val()+"\"关键字");
    }
</script>

</html>
