<%--
  Created by IntelliJ IDEA.
  User: fuhua
  Date: 2018/7/3
  Time: 下午3:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="modal-body">
    <div id="historyLineChart" style="width: 600px;height: 500px">

    </div>
</div>
<div class="modal-footer">
    <a href="#" class="btn btn-default" data-dismiss="modal">关闭</a> <!-- 注意按钮换行会导致多余的外补(margin) -->
</div>
<script>
    console.log("${param.url}");
    $.post("${param.url}",{
        size:${param.size}
    },function (data) {
        var lineChart=echarts.init(document.getElementById('historyLineChart'));
        var rawHistoryData=data;
        var historyDate=[];
        var historyValue=[];
        console.log(rawHistoryData.length);
        for (var i=0;i<rawHistoryData.length;i++){
            var newDate = new Date();
            newDate.setTime(rawHistoryData[i].date);
            historyDate.push(newDate.toLocaleDateString());
            historyValue.push(rawHistoryData[i].result);
        }
        var historyOption = {
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'shadow',
                    label: {
                        show: true,
                        backgroundColor: '#333'
                    }
                }
            },
            xAxis: {
                data:historyDate
            },
            yAxis: {
                splitLine: {show: false}
            },
            series: {
                name: '${param.name}',
                type: 'line',
                smooth: true,
                showAllSymbol: true,
                symbol: 'emptyCircle',
                symbolSize: 15,
                data: historyValue
            }
        };
        lineChart.setOption(historyOption);
    });
</script>