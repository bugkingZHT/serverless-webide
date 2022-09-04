<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<input class="hidden" id ="btime" value="${btime}">
<input class="hidden" id ="etime" value="${etime}">
<input class="hidden" id ="content" value="${content}">
<c:choose>
    <c:when test='${empty logList}'>
        <div class="panel panel-default front-panel">
            <div class="panel-body front-last-no-margin">
                没有搜索结果
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div style="background-color: white;">
            <table class="table table-striped" style="margin-bottom: 0">
                <thead>
                <tr>
                    <th class="col-md-3" style="text-align: center">时间/来源</th>
                    <th class="col-md-1" style="text-align: center">日志级别</th>
                    <th class="col-md-8" style="text-align: center">日志内容</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="log" items="${logList}">
                    <tr>
                        <td>
<%--                            <jsp:useBean id="timestamp" class="java.util.Date"/>--%>
<%--                            <jsp:setProperty name="timestamp" property="time" value="${log.metadata.creationTimestamp}"/>--%>
<%--                            <fmt:formatDate value="${log.metadata.creationTimestamp}" pattern="yyyy/MM/dd HH:mm:ss"/>--%>
                            <c:set var="str1" value="${fn:replace(log.metadata.creationTimestamp, 'T', ' ')}" />
                            ${fn:replace(str1, "Z", " ")}
<%--        ${log.metadata.creationTimestamp}--%>
                            <br>
                            ${log.involvedObject.labels.get("app")}
                        </td>
                        <td style="text-align: center">${log.type}</td>
                        <td style="word-break:break-all"><div style="height:100px;overflow:auto">${log.message}</div></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
<%--            <p>总页码${logList.totalPage}当前页码${logList.currentPage}</p>--%>
            <div style="background-color: #e7e7e7;text-align: center;margin-bottom: 20px;padding-top: 20px">
<%--                显示--%>
                <c:if test="${totalPage == 1}">
                    当前第  ${currentPage }  页 / 共   ${totalPage}  页
                </c:if>
                <c:if test="${totalPage >=2 && currentPage!=1 && currentPage!=totalPage}">
                    <a href="javascript:void(0)" onclick="goPage(1)">首页</a>
                    &nbsp;
                    <a href="javascript:void(0)" onclick="goPage((${currentPage-1}))">上一页</a>
                    &nbsp;
                    当前第  ${currentPage }  页 / 共   ${totalPage}  页
                    &nbsp;
                    <a href="javascript:void(0)" onclick="goPage(${currentPage+1})">下一页</a>
                    &nbsp;
                    <a href="javascript:void(0)" onclick="goPage(${totalPage})">末页</a>
                </c:if>
                <c:if test="${totalPage >=2 && currentPage==1}">
<%--                    当前第1页--%>
                    当前第  ${currentPage }  页 / 共   ${totalPage}  页
                    &nbsp;
                    <a href="javascript:void(0)" onclick="goPage(${currentPage+1})">下一页</a>
                    &nbsp;
                    <a href="javascript:void(0)" onclick="goPage(${totalPage})">末页</a>
                </c:if>
                <c:if test="${totalPage >=2 && currentPage==totalPage}">
                    <a href="javascript:void(0)" onclick="goPage(1)">首页</a>
                    &nbsp;
                    <a href="javascript:void(0)" onclick="goPage((${currentPage-1}))">上一页</a>
                    &nbsp;
                    当前第  ${currentPage}  页 / 共   ${totalPage}  页
                </c:if>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<script>


</script>
