<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <c:import url="/template/_header.jsp"/>
    <title>首页</title>
    <style>
        .card {
            height: 280px;
            background-color: white;
        }

        .new-row {
            margin-top: 10px;
            height: 310px;
        }

        .block {
            padding: 5px;
        }

        .full {
            height: 100%;
        }

        .mylabel {
            margin-top: 20px;
        }
    </style>
</head>
<body class="front-body">
<c:import url="/template/_navbar.jsp?menu=home"/>
<div class="front-inner">
    <div class="container">
        <div class="col-md-12">
            <h5 style="margin-top: 20px">平台整体</h5>
        </div>
        <div id="platformTotalInfo" class="row" style="height:310px">
            <div class="col-md-4 col-sm-12 col-xs-12" style="text-align: center;padding-left: 25px;">
                <div class="full" style="background-color:#3779f0;color:white;">
                    <p style="height: 14px"></p>
                    <p style="font-size: 15px">正在加载当前平台整体运行情况...</p>
                    <p id="scorenow" style="font-size: 65px"><B></B></p>
                    <br/>
                    <p id="whole"></p>
                    <p id="base"></p>
                    <p id="hadoop"></p>
                    <p id="stability"></p>
                </div>
            </div>
            <div class="col-md-8 col-sm-12 col-xs-12" style="text-align: center;padding-left: 0px;">
                <div class="full" style="height: 310px;" id="historySumScore"></div>
            </div>
        </div>

        <c:forEach items="${componentOrderList}" var="componentItem">
            <c:if test="${componentItem.type == 'separator'}">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <h5 style="margin-top: 20px">${separatorList.get(componentItem.index)}</h5>
                </div>
            </c:if>
            <c:if test="${componentItem.type == 'textBox'}">
                <c:import url="/metrics/indexcomponent/textBox.jsp">
                    <c:param name="url" value="${textBoxList.get(componentItem.index).url}"></c:param>
                    <c:param name="name" value="${textBoxList.get(componentItem.index).name}"></c:param>
                    <c:param name="value" value="${textBoxList.get(componentItem.index).value}"></c:param>
                </c:import>
            </c:if>
            <c:if test="${componentItem.type == 'doubleTextBox'}">
                <c:import url="/metrics/indexcomponent/doubleTextBox.jsp">
                    <c:param name="box1url" value="${doubleTextBoxList.get(componentItem.index).box1.url}"></c:param>
                    <c:param name="box1name" value="${doubleTextBoxList.get(componentItem.index).box1.name}"></c:param>
                    <c:param name="box1value" value="${doubleTextBoxList.get(componentItem.index).box1.value}"></c:param>
                    <c:param name="box2url" value="${doubleTextBoxList.get(componentItem.index).box2.url}"></c:param>
                    <c:param name="box2name" value="${doubleTextBoxList.get(componentItem.index).box2.name}"></c:param>
                    <c:param name="box2value" value="${doubleTextBoxList.get(componentItem.index).box2.value}"></c:param>
                </c:import>
            </c:if>
            <c:if test="${componentItem.type == 'textChart'}">
                <div class="col-md-4 col-sm-6 col-xs-8" >
                    <div id="${componentItem.divId}" style="height: 350px; background-color: white">
                        <p style="font-size: 15px; text-align: center; padding-top: 140px">正在加载图表...</p>
                    </div>
                </div>
            </c:if>
<%--            <c:if test="${componentItem.type == 'indexHeatInfo'}">--%>
<%--                <div  class="card col-md-12 col-sm-12 col-xs-12" style="width:98%; margin-left: 10px;margin-top: 10px">--%>
<%--                    <div id="${componentItem.divId}" class="card col-md-12 col-sm-12 col-xs-12">--%>
<%--                        <p style="font-size: 15px; text-align: center; padding-top: 130px">正在加载热力图...</p>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </c:if>--%>
            <c:if test="${componentItem.type == 'indexLineDiagram'}">
                <div  class="card col-md-6 col-sm-12 col-xs-12" style="margin-top: 10px;margin-left:-5px;margin-right:0px; background-color: rgb(231,231,231)">
                    <div id="${componentItem.divId}" class="card col-md-12 col-sm-12 col-xs-12">
                        <p style="font-size: 15px; text-align: center; padding-top: 130px">正在加载折线图...</p>
                    </div>
                </div>
            </c:if>
            <c:if test="${componentItem.type == 'indexHistogram'}">
                <div  class="card col-md-6 col-sm-12 col-xs-12" style="margin-top: 10px;margin-left:-5px;margin-right:0px; background-color: rgb(231,231,231)">
                    <div id="${componentItem.divId}" class="card col-md-12 col-sm-12 col-xs-12">
                        <p style="font-size: 15px; text-align: center; padding-top: 130px">正在加载柱状图...</p>
                    </div>
                </div>
            </c:if>
            <c:if test="${componentItem.type == 'serviceLabel'}">
                <div class="col-md-2 col-sm-3 col-xs-4" style="padding-left: 10px; padding-bottom: 10px;margin-right: -4px;margin-left: 3px">
                    <div style="background-color: white;height: 170px">
                        <a href="${serviceLabelList.get(componentItem.index).link}" target="_blank">
                            <img src="${serviceLabelList.get(componentItem.index).photoPath}" class="img-responsive"/></a>
                    </div>
                </div>
            </c:if>
        </c:forEach>
        <div class="col-md-12 col-sm-12 col-xs-12">
            <h5 style="margin-top: 20px">基础设施</h5>
        </div>
        <div class="card col-md-12 col-sm-12 col-xs-12" style="margin-left: -5px;margin-right: -30px; margin-top: 10px; height: 350px;background-color: rgb(231,231,231)">
            <div id="platformChart1" class="card col-md-12 col-sm-12 col-xs-12" style="height: 350px;margin-right: -20px;" >
                <p style="font-size: 15px; text-align: center; padding-top: 130px">正在加载折线图...</p>
            </div>
        </div>
        <div class="card col-md-12 col-sm-12 col-xs-12" style="margin-left: -5px;margin-right: -30px; margin-top: 10px; height: 350px;margin-bottom:30px;background-color: rgb(231,231,231)">
            <div id="platformChart2" class="card col-md-12 col-sm-12 col-xs-12" style="height: 350px;">
                <p style="font-size: 15px; text-align: center; padding-top: 130px">正在加载折线图...</p>
            </div>
        </div>
<%--        <div class="col-md-2 col-sm-3 col-xs-4" style="padding-left: 30px; padding-bottom: 10px; padding-top: 10px">--%>
<%--            <div style="background-color: white;height: 170px; width: 160px">--%>
<%--                <a href="/workcomponent">--%>
<%--                    <img src="/static/images/grafana.png" class="img-responsive"></a>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-md-2 col-sm-3 col-xs-4" style="margin-left:-10px; padding-left: 30px; padding-bottom: 10px; padding-top: 10px;">--%>
<%--            <div style="background-color: white;height: 170px; width: 160px;">--%>
<%--                <a href="/workcomponent">--%>
<%--                    <img src="/static/images/harbor.png" class="img-responsive"></a>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-md-2 col-sm-3 col-xs-4" style="padding-left: 30px; padding-bottom: 10px; ">--%>
<%--            <div style="background-color: white;height: 170px; width: 160px">--%>
<%--                <a href="/workcomponent">--%>
<%--                    <img src="/static/images/dashboard.png" class="img-responsive"></a>--%>
<%--            </div>--%>
<%--        </div>--%>
    </div>
    <c:import url="/template/_footer.jsp"/>
</div>
<c:import url="/template/_tailer.jsp"/>
<script src="/static/js/echarts.common.min.js"></script>
<script src="/static/js/echarts-liquidfill.js"></script>
<script src="/metrics/indexcomponent/setScoreInfo.js"></script>
<%--<script src="/metrics/indexcomponent/setHeatMap.js"></script>--%>
<script src="/metrics/indexcomponent/setTextChart.js"></script>
<script src="/metrics/indexcomponent/setLineDiagram.js"></script>
<script src="/metrics/indexcomponent/setHistogram.js"></script>
<script src="/metrics/platformMetrics.js"></script>
<%--基础设施热力图--%>
<%--<script type="text/javascript">--%>
<%--    function getIndexHeatMap(index) {--%>
<%--        var url = "/indexHeatMap?index=" + index;--%>
<%--        var divId = 'indexHeatInfo' + index;--%>
<%--        $.ajax({--%>
<%--            url: url,--%>
<%--            type: "get",--%>
<%--            data: {},--%>
<%--            success: function (data) {--%>
<%--                var option = setHeatMap(data);--%>
<%--                var heatMap = echarts.init(document.getElementById(divId));--%>
<%--                heatMap.setOption(option);--%>
<%--                heatMap.on('click', function (e) {--%>
<%--                    window.location.href = "/basicfacility";--%>
<%--                });--%>
<%--                heatMapList.push(heatMap);--%>
<%--            },--%>
<%--            error: function (data) {--%>
<%--                $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '热图信息获取失败！'});--%>
<%--            }--%>
<%--        });--%>
<%--    }--%>
<%--</script>--%>

<%--折线图--%>
<script type="text/javascript">
    function getIndexLineDiagram(index) {
        var url = "/indexLineDiagram?index=" + index;
        var divId = 'indexLineDiagram' + index;
        $.ajax({
            url: url,
            type: "get",
            data: {},
            success: function (data) {
                var option = setIndexLineDiagram(data);
                var lineDiagram = echarts.init(document.getElementById(divId));
                lineDiagram.setOption(option);
                // heatMap.on('click', function (e) {
                //     window.location.href = "/basicfacility";
                // });
                heatMapList.push(lineDiagram);
            },
            error: function (data) {
                $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '折线图信息获取失败！'});
            }
        });
    }
</script>

<%--柱状图--%>
<script type="text/javascript">
    function getIndexHistogram(index) {
        var url = "/indexHistogram?index=" + index;
        var divId = 'indexHistogram' + index;
        $.ajax({
            url: url,
            type: "get",
            data: {},
            success: function (data) {
                var option = setHistogram(data);
                var histogram = echarts.init(document.getElementById(divId));
                histogram.setOption(option);
                // document.getElementById(divId).style.backgroundColor = "white";
                // heatMap.on('click', function (e) {
                //     window.location.href = "/basicfacility";
                // });
                heatMapList.push(histogram);
            },
            error: function (data) {
                $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '柱状图信息获取失败！'});
            }
        });
    }
</script>

<%--历史曲线--%>
<script type="text/javascript">
    function scoreLineInit() {
        var historySumScoreInit = echarts.init(document.getElementById('historySumScore'));
        var historySumScoreOptionInit = {
            title: {
                left: 'center',
                top: "20px",
                text: '正在加载近n天平台整体运行情况...',
                textStyle: {
                    fontStyle: "normal",
                    fontWeight: 'normal',
                    fontFamily: "sans-serif",
                    fontSize: 15
                }
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'line'
                }
            },
            grid: {
                left: '80px',
                right: '110px',
                bottom: '15%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    axisTick: {
                        alignWithLabel: true
                    }
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            dataZoom: [
                {
                    type: 'inside',
                    start: 50,
                    end: 100
                },
                {
                    show: true,
                    type: 'slider',
                    y: '90%',
                    start: 50,
                    end: 100
                }
            ],
            legend: {
                x: 'right',
                y: '20px',
            },
            color: ['#5078f1', '#fe9702', '#dc3b1a']
        };
        historySumScoreInit.setOption(historySumScoreOptionInit);
    }

    function showPlatformInfo() {
        $.ajax({
            url: "/getHistoryScore",
            type: "get",
            data: {},
            success: function (data) {
                var res = getPlatformTotalInfo(data);
                var historySumScore = echarts.init(document.getElementById('historySumScore'));
                historySumScore.setOption(res.option);
                heatMapList.push(historySumScore);
                $("#whole").html(res.whole);
                $("#scorenow").html(res.scorenow);
                $("#hadoop").html(res.hadoop);
                $("#base").html(res.base);
                $("#stability").html(res.stability);
            },
            error: function (data) {
                $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '历史曲线信息获取失败！'});
            }
        });
    }

    function getPlatformMetrics() {
        $.ajax({
            url: "/getplatformmetrics",
            type: "get",
            async: false,
            dataType: "text",
            success: function (data) {
                showPlatformMetrics(JSON.parse(data));
            },
            error: function (data) {
                $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '内存曲线加载失败'});
            }
        });
    }

    function getPlatformNetIO() {
        $.ajax({
            url: "/getplatformnetio",
            type: "get",
            async: false,
            dataType: "text",
            success: function (data) {
                showNetIOCharts(JSON.parse(data));
            },
            error: function (data) {
                $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '内存曲线加载失败'});
            }
        });
    }
</script>

<%--饼图--%>
<script type="text/javascript">
    function getTextChart(index) {
        var url = "/indexTextChart?index=" + index;
        var divId = 'textChart' + index;
        $.ajax({
            url: url,
            type: "get",
            data: {},
            success: function (data) {
                setTextChart(data, divId);
            },
            error: function (data) {
                $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '饼图信息获取失败！'});
            }
        });
    }
</script>


<%--初始化--%>
<script type="text/javascript">
    var heatMapList = [];
    scoreLineInit();
    var heatMapNum = parseInt("${componentNum.heatMapNum}");
    var textChartNum = parseInt("${componentNum.textChartNum}");
    var lineDiagramNum = parseInt("${componentNum.lineDiagramNum}");
    var histogramNum = parseInt("${componentNum.histogramNum}");
    getPlatformMetrics();
    getPlatformNetIO();
</script>


<%--后端数据读取--%>
<script type="text/javascript">
    // for(i = 0; i < heatMapNum; i++){
    //     getIndexHeatMap(i);
    // }
    showPlatformInfo();
    for (i = 0; i < textChartNum; i++) {
        getTextChart(i);
    }
    for (i = 0; i < lineDiagramNum; i++) {
        getIndexLineDiagram(i);
    }
    for (i = 0; i < histogramNum; i++) {
        getIndexHistogram(i);
    }

    window.addEventListener("resize", function () {
        for (i = 0; i < heatMapList.length; i++) {
            heatMapList[i].resize();
        }
    });
</script>

</body>
</html>
