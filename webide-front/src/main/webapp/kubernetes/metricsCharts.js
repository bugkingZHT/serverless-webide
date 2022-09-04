function getTimeSeries(data) {
    var i = 0;
    timeLine = [];
    for (i = 0; i < data.length; i++) {
        //console.info(formatDateTime(data[i].time));
        timeLine.push(formatDateTime(data[i].time));
    }
    return timeLine;
}
function getMetricValues(data) {
    var i = 0;
    metricsLine = [];
    for (i = 0; i < data.length; i++) {
        metricsLine.push(parseFloat(data[i].value));
    }
    return metricsLine;
}
function showMemoryCharts(data) {
    var memory = document.getElementById("memory");
    var memoryChart = echarts.init(memory);
    var timeline = getTimeSeries(data);
    var metricsLine = getMetricValues(data);
    memoryOptions = {
        color: ['#1b9b0c'],
        title: {
            // left:'10%',
            text: '内存使用率'
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                type: 'line'        // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        grid: {
            left: '80px',
            right: '110px',
            bottom: '15%',
            containLabel: true
        },
        // legend: {
        //     data: ['内存使用率'],
        //     x: 'right',
        //     top: '15'
        // },
        xAxis: [
            {
                type: 'category',
                data: timeline,
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
        series: [
            {
                name: '内存使用率',
                type: 'line',
                data: metricsLine
            }
        ]
    };
    memoryChart.setOption(memoryOptions);
}
function showCPUCharts(data) {
    var cpu = document.getElementById("cpu");
    var cpuChart = echarts.init(cpu);
    var timeline = getTimeSeries(data);
    var metricsLine = getMetricValues(data);
    cpuOptions = {
        color: ['#1b9b0c'],
        title: {
            // left:'10%',
            text: 'CPU使用率'
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                type: 'line'        // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        grid: {
            left: '80px',
            right: '110px',
            bottom: '15%',
            containLabel: true
        },
        legend: {
            data: ['CPU 使用率'],
            x: 'right',
            top: '15'
        },
        xAxis: [
            {
                type: 'category',
                data: timeline,
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
        series: [
            {
                name: 'CPU使用率',
                type: 'line',
                data: metricsLine
            }
        ]
    };
    cpuChart.setOption(cpuOptions);
}
function showNetIOCharts(data) {
    var net = document.getElementById("netio");
    var netChart = echarts.init(net);
    var timeline = getTimeSeries(data.input);
    var inputLine = getMetricValues(data.input);
    var outputLine = getMetricValues(data.output);
    netOptions = {
        color: ['#1b9b0c', '#0000AA'],
        title: {
            // left:'10%',
            text: '网络流量IO'
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                type: 'line'        // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        grid: {
            left: '80px',
            right: '110px',
            bottom: '15%',
            containLabel: true
        },
        legend: {
            data: ['输入流量', '输出流量'],
            x: 'right',
            top: '15'
        },
        xAxis: [
            {
                type: 'category',
                data: timeline,
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
        series: [
            {
                name: '输入流量',
                type: 'line',
                data: inputLine
            },
            {
                name: '输出流量',
                type: 'line',
                data: outputLine
            }
        ]
    };
    netChart.setOption(netOptions);
}
function showRestartCharts(data) {
    var restart = document.getElementById("restart");
    var restartChart = echarts.init(restart);
    var timeline = getTimeSeries(data);
    var metricsLine = getMetricValues(data);
    restartOptions = {
        color: ['#1b9b0c'],
        title: {
            // left:'10%',
            text: '重启次数'
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                type: 'line'        // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        grid: {
            left: '80px',
            right: '110px',
            bottom: '15%',
            containLabel: true
        },
        legend: {//
            data: ['Memory Used'],
            x: 'right',
            top: '15'
        },
        xAxis: [
            {
                type: 'category',
                data: timeline,
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
        series: [
            {
                name: '重启次数',
                type: 'line',
                data: metricsLine
            }
        ]
    };
    restartChart.setOption(restartOptions);
}
function showPodStatusCharts(data) {
    var podStatus = document.getElementById("podstatus");
    var podStatusChart = echarts.init(podStatus);
    var timeline = getTimeSeries(data);
    var metricsLine = getMetricValues(data);
    podStatusOptions = {
        color: ['#1b9b0c'],
        title: {
            // left:'10%',
            text: '探针运行详情'
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                type: 'line'        // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        label: {
          formatter: function (params) {
                   if (params.seriesData[0].data == 1) {
                      return "SUCCESS";
                   } else if (params.seriesData[0].data == 0) {
                       return  "ERROR"
                   } else if (params.seriesData[0].data == -1) {
                       return "UNKNOWN";
                   }
              }
          },
        grid: {
            left: '80px',
            right: '110px',
            bottom: '15%',
            containLabel: true
        },
        // legend: {
        //     data: ['内存使用率'],
        //     x: 'right',
        //     top: '15'
        // },
        xAxis: [
            {
                type: 'category',
                data: timeline,
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
        series: [
            {
                name: '探针运行详情',
                type: 'line',
                data: metricsLine
            }
        ]
    };
    podStatusChart.setOption(podStatusOptions);
}

function showDiskCharts(data) {
    var disk = document.getElementById("diskUsed");
    var diskChart = echarts.init(disk);
    var timeline = getTimeSeries(data);
    var metricsLine = getMetricValues(data);
    diskUsedOptions = {
        color: ['#1b9b0c'],
        title: {
            // left:'10%',
            text: '硬盘占用率'
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                type: 'line'        // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        grid: {
            left: '80px',
            right: '110px',
            bottom: '15%',
            containLabel: true
        },
        // legend: {
        //     data: ['内存使用率'],
        //     x: 'right',
        //     top: '15'
        // },
        xAxis: [
            {
                type: 'category',
                data: timeline,
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
        series: [
            {
                name: '硬盘占用率',
                type: 'line',
                data: metricsLine
            }
        ]
    };
    diskChart.setOption(diskUsedOptions);
}