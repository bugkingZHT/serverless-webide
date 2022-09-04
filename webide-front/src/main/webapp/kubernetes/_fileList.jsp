<%--
  Created by IntelliJ IDEA.
  User: WangYunxuan
  Date: 2021/4/1
  Time: 15:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>List</title>
</head>
<body>
<div class="panel-body panel-default col-md-12" style="margin-top: 0px">
    <table id="fileTable" class="table table-striped front-table table-bordered" >
        <thead>
        <tr>
            <th class="col-md-3" style="text-align: center">文件名称</th>
            <th class="col-md-2" style="text-align: center">创建时间</th>
            <th class="col-md-1" style="text-align: center">操作</th>
        </tr>
        </thead>
        <div>
            <c:forEach var="file" items ="${fileList}" varStatus="index">
                <td style="vertical-align: middle;overflow: auto;text-align: left">
                        ${file.fileName}
                    <c:if test="${index.count == 1}">
                        <span class="label label-success">latest</span>
                    </c:if>
                </td>
                <td style="vertical-align: middle;overflow: auto;text-align: left">
                        ${file.createTimeFormat}
                </td>
                <td style="vertical-align: middle;overflow: auto;text-align: left">
                    <a href="/project/download?fileId=${file.fileId}">下载</a>
                    <a href="javascript:void(0)" style="color: red" onclick="deletefile('${file.fileId}')">删除</a>
                </td>

                </tr>
            </c:forEach>
        </div>
    </table>
</div>
</body>
<script>

</script>
</html>

