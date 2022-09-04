<%--
  Created by IntelliJ IDEA.
  User: Creed
  Date: 2020/11/3
  Time: 15:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <c:import url="/template/_header.jsp"/>
    <title>新建模板</title>
</head>
<body class="front-body">
<c:import url="/template/_navbar.jsp?menu=project"/>
<div class="front-inner" id = "main_container">
    <div class="container" >
        <div class="row front-canvas" id="front-canvas">
            <div id="config-div" class="panel panel-default front-panel clear form-horizontal">
                <div class="panel-heading"><strong>新建模板配置</strong>
                </div>
                <div class="panel-body" style=" padding-bottom:0px">
                    <div style="margin-left: 90px">
                        <div class='form-group'>
                            <label class="col-md-2 control-label front-label">模板名</label>
                            <div class="col-md-7">
                                <input style="resize:none; height: 34px; float: left" type="text" class="form-control front-no-box-shadow" id="name">
                            </div>
                        </div>
<%--                        <div class='form-group'>--%>
<%--                            <label class="col-md-2 control-label front-label">模板名</label>--%>
<%--                            <div class="col-md-7">--%>
<%--                                <select class="form-control front-no-radius front-no-box-shadow" id="newTemplate" name="groupId" >--%>
<%--                                    <c:forEach var="temp" items="${templateList}">--%>
<%--                                        <option value="${temp.id}">${temp.name}</option>--%>
<%--                                    </c:forEach>--%>
<%--                                </select>--%>
<%--                            </div>--%>
<%--                        </div>--%>
                        <div class='form-group'>
                            <label class="col-md-2 control-label front-label">模板描述</label>
                            <div class="col-md-7">
                                <textarea type="text" class="form-control front-no-box-shadow" id="description" style="height: 100px;"></textarea>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class="col-md-2 control-label front-label">详细信息</label>
                            <div class="col-md-7">
                                <%--                                <textarea type="text" class="form-control front-no-box-shadow" id="project-details" style="height: 400px;">${project.details}</textarea>--%>
                                <table class="table front-table" style="text-align: center; border:1px solid #ddd;" id = "detailTab">
                                    <thead style="border-color:inherit;">
                                    <tr style="border-color:inherit;">
                                        <td style="border:1px solid #ddd;border-radius:1px" class="col-md-4 col-lg-4">参数名</td>
                                        <td style="border:1px solid #ddd;border-radius:1px" class="col-md-8 col-lg-8">参数值</td>
                                        <td style="border:1px solid #ddd;border-radius:1px">
                                            <a class="btn" onclick="addARow('detailTab',2)"><strong><span class="glyphicon glyphicon-plus"></span> </strong></a>
                                        </td>
                                    </tr>
                                    </thead>
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
                                        <td style="border:1px solid #ddd;border-radius:1px">
                                            <a class="btn" onclick="deleteRow(this)" style="padding-top:10px"><strong><span class="glyphicon glyphicon-minus"></span> </strong></a>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div id = "div1" >
                            <div class='form-group'>
                                <label class="col-md-2 control-label front-label">YAML</label>
                                <div class="col-md-7">
                                    <textarea type="text" class="form-control front-no-box-shadow" id="yaml" style="height: 400px;"></textarea>
                                </div>
                            </div>
                        </div>


                        <div class="form-group"style="margin-right: 15px">
                            <span class="pull-right col-md-5" style="margin-top: 10px">
<%--                                <a href="javascript:void(0)" class="btn btn-primary pull-right" style="width: 124px" onclick="loadLog('default','warpackage','warget')">加载日志</a>--%>
                                <a href="javascript:void(0)" class="btn btn-primary pull-right" id="saveButton" style="width: 124px" onclick="submit();">保存</a>
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
    // var detailTable = {};
    function submit() {
        // getDetailTable();
        // var details = JSON.stringify(detailTable);
        var name = $("#name").val().trim();
        var description = $("#description").val().trim();
        var yaml = $("#yaml").val().trim();
        if(name==""){
            $.fillTipBox({type: 'danger', icon: 'glyphicon-exclamation-sign', content: '模板名称不可为空'});
            return false;
        }
        $.ajax({
            url:"/template/createNewTemplate",
            type:"post",
            async: false,
            dataType:"text",
            data:{name:name,
                description:description,
                yaml:yaml
            },
            success:function(data) {
                if(data=="ok") {
                    $.fillTipBox({type: 'success', icon: 'glyphicon-ok-sign', content: '新建模板成功'});
                    setInterval(function () {
                        window.location = "/kubernetes/templatePage.jsp";
                    }, 1000);
                }
                else if(data=="false"){
                    $.fillTipBox({type: 'danger', icon: 'glyphicon-alert', content: '新建项目失败'});
                }else{
                    $.fillTipBox({type: 'error', icon: 'glyphicon-alert', content: data});
                }
            }
        });
    }

    function addARow(tabId,num) {
        console.log(tabId);
        var newTr;   //新增加的行
        newTr = document.getElementById(tabId).insertRow();
        newTr.setAttribute("class","editList");
        for(i=0;i<num;i++){
            var newTd=newTr.insertCell();
            newTd.setAttribute("style","border:1px solid #ddd;border-radius:1px");
            newTd.innerHTML = "<input  class=\"form-control\" type=\"text\" style=\"border-radius:1px;\">";
        }
        var newTd=newTr.insertCell();
        newTd.setAttribute("style","border:1px solid #ddd;border-radius:1px");
        newTd.innerHTML="<a class=\"btn\" onclick=\"deleteRow(this)\" style=\"padding-top:10px\"><strong><span class=\"glyphicon glyphicon-minus\"></span> </strong></a>";
        return false;
    }

    function deleteRow(item){
        $.tipModal('confirm', 'warning', '确认删除该行吗？', function(result) {
            if(result==true){
                $(item).parent().parent().remove();
            }
        })
    }

    function getDetailTable() {
        detailTable = {};
        var table = document.getElementById("detailTab");
        for(var j = 1; j<table.rows.length; j++){
            var key = table.rows[j].cells[0].getElementsByTagName("input")[0].value;
            var parameter = table.rows[j].cells[1].getElementsByTagName("input")[0].value;
            if(key !== ""){
                detailTable[key] = parameter;
            }
        }
    }
</script>
</html>
