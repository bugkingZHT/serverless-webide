
//YAML 详情显示
function show_hidden1(obj) {
    if (obj.id == 'div1' || obj.id == 'yamls') {
        if (obj.style.display == 'none') {
            obj.style.display = 'block';
        }
    } else {
        if (obj.style.display == 'block') {
            obj.style.display = 'none'
        }
    }
}

//Pod详情显示
function show_hidden2(obj) {
    if (obj.id == 'div2') {
        if (obj.style.display == 'none') {
            obj.style.display = 'block';
        }
    } else {
        if (obj.style.display == 'block') {
            obj.style.display = 'none'
        }
    }
}

function show_hidden3(obj) {
    if (obj.id == 'div3') {
        if (obj.style.display == 'none') {
            obj.style.display = 'block';
        }
    } else {
        if (obj.style.display == 'block') {
            obj.style.display = 'none'
        }
    }
}

function show_hidden4(obj) {
    if (obj.id == 'div4') {
        if (obj.style.display == 'none') {
            obj.style.display = 'block';
        }
    } else {
        if (obj.style.display == 'block') {
            obj.style.display = 'none'
        }
    }
}

function show_hidden5(obj) {
    if (obj.id == 'div5') {
        if (obj.style.display == 'none') {
            obj.style.display = 'block';
        }
    } else {
        if (obj.style.display == 'block') {
            obj.style.display = 'none'
        }
    }
}

function hide(obj) {
    obj.style.display = 'none';
}
var div1 = document.getElementById("div1");
var div2 = document.getElementById("div2");
var div3 = document.getElementById("div3");
var div4 = document.getElementById("div4");
var div5 = document.getElementById("div5");
//显示YAML详情
var sh1 = document.getElementById("showHidden1");
sh1.onclick = function () {
    show_hidden1(div1);
    hide(div2);
    hide(div3);
    hide(div4);
    hide(div5);
    return false;
}

//显示pod详情
var sh2 = document.getElementById("showHidden2");
sh2.onclick = function () {
    getPods(projectId);
    $("#podTable").show();

    show_hidden2(div2);
    hide(div1);
    hide(div3);
    hide(div4);
    hide(div5);
    return false;
};

//显示运行状态metrics
var sh3 = document.getElementById("showHidden3");
sh3.onclick = function () {

    show_hidden3(div3);
    hide(div1);
    hide(div2);
    hide(div4);
    hide(div5);
    getMemory(projectName);
    getCPU(projectName);
    getNetIO(projectName);
    getRestart(projectName);
    getPodStatus(projectName);
    return false;
};

//显示运行日志
var sh4 = document.getElementById("showHidden4");
sh4.onclick = function () {
    $(function() {
        var btimeDefault=new Date();
        var etimeDefault=new Date();

        $('#begin-date').datetimepicker({
            format: 'yyyy-mm-dd hh:ii:ss',
            autoclose:true
        });
        $('#end-date').datetimepicker({
            format: 'yyyy-mm-dd hh:ii:ss',
            autoclose: true
        });

        btimeDefault.setTime(btimeDefault.getTime()-(86400000));
        $("#begin-date").attr("placeholder",formatDateTime(btimeDefault));

        $("#end-date").attr("placeholder",formatDateTime(etimeDefault));
    });
    show_hidden4(div4);
    hide(div1);
    hide(div2);
    hide(div3);
    hide(div5);
    return false;
};

//显示文件详情
var sh5 = document.getElementById("showHidden5");
sh5.onclick = function () {
    getFileMessage(null);
    show_hidden5(div5);
    hide(div1);
    hide(div2);
    hide(div3);
    hide(div4);
    return false;
};



function startProject(id) {
    $.ajax({
        url: "/project/start",
        type: "get",
        datatype:"text",
        data: {id: id},
        success: function (data) {
            if(data== true){
                $.fillTipBox({type: 'success', icon: 'glyphicon-ok-sign', content: '项目开始启动'});
                // setInterval(function () {
                //     location.reload();
                // }, 1000);
            }
        },
        error:function (data) {
            $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '项目启动失败'});
        }
    });
}

function stopProject(id) {
    $.ajax({
        url: "/project/stop",
        type: "get",
        datatype:"text",
        data: {id: id},
        success: function (data) {
            if(data== true){
                $.fillTipBox({type: 'success', icon: 'glyphicon-ok-sign', content: '项目开始停止'});
                // setInterval(function () {
                //     location.reload();
                // }, 1000);
            }
        },
        error:function (data) {
            $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '项目停止失败'});
        }
    });
}

function deleteProject(id) {
    $.ajax({
        url: "/project/delete",
        type: "get",
        datatype:"text",
        data: {id: id},
        success: function (data) {
            if(data== true){
                $.fillTipBox({type: 'success', icon: 'glyphicon-ok-sign', content: '项目已删除'});
                setInterval(function () {
                    window.location = "/project";
                }, 1000);
            }else{
                $.fillTipBox({type: 'error', icon: 'glyphicon-alert', content: '删除项目失败'});
            }
        },
        // error:function (data) {
        //     $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '项目删除失败'});
        //     setInterval(function () {
        //         window.location = "/project";
        //     }, 1000);
        // }
    });
}

// function loadLog(namespace, pod, container) {
//     var ws = new WebSocket("ws://" + window.location.host + "/logs/" + namespace + "/" + pod + "/" + container);
//     var logArea = document.getElementById('log-text');
//     ws.onopen = function () {
//         logArea.value = "";
//         ws.send("Hello websocket!");
//     };
//     ws.onmessage = function (ev) {
//         logArea.value = logArea.value + ev.data;
//     };
//     ws.onclose = function (ev) {
//         if (ev.code === 1000) { // normal closure
//             logArea.scrollTop = logArea.scrollHeight;
//         } else {
//             logArea.value = ev.reason;
//         }
//     };
// }
var pdTable = {};
function submit() {
    getPdTable();
    var details = JSON.stringify(pdTable);
    var description = document.getElementById("project-description").value;
    console.info(details);
    console.info(description);
    // if(name==""){
    //     $.fillTipBox({type: 'danger', icon: 'glyphicon-exclamation-sign', content: '项目名称不可为空'});
    //     return false;
    // }
    //alert("ajax");
    $.ajax({
        url:"/project/changeDetails",
        type:"post",
        async: false,
        dataType:"text",
        data:{id:id,
            details:details,
            projectDescription: description
        },
        success:function(data) {
            if(data=="ok") {
                $.fillTipBox({type: 'success', icon: 'glyphicon-ok-sign', content: '修改成功'});
                setInterval(function () {
                    window.location = "/project/getDetail?id="+id;
                }, 1000);
            }else if (data == "false") {
                $.fillTipBox({type: 'error', icon: 'glyphicon-alert', content: '新建项目失败'});
            } else {
                $.fillTipBox({type: 'error', icon: 'glyphicon-alert', content: data});
            }
        }
    });
}

function getMemory(projectName) {
    $.ajax({
        url:"/project/getmemory",
        type:"get",
        async: false,
        dataType:"text",
        data:{projectName: projectName
        },
        success:function(data) {
            console.info(JSON.stringify(data));
            var jsondata = JSON.parse(data);
            console.info(jsondata.metrics);
            showMemoryCharts(jsondata.metrics);
            // if(data=="ok") {
            //     $.fillTipBox({type: 'success', icon: 'glyphicon-ok-sign', content: '修改成功'});
            //     setInterval(function () {
            //         window.location = "/project/getDetail?id="+id;
            //     }, 1000);
            // }else{
            //     $.fillTipBox({type: 'error', icon: 'glyphicon-alert', content: '新建项目失败'});
            // }
        },
        error:function (data) {
            $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '内存曲线加载失败'});
        }
    });
}

function getCPU(projectName) {
    $.ajax({
        url:"/project/getcpu",
        type:"get",
        async: false,
        dataType:"text",
        data:{projectName: projectName
        },
        success:function(data) {
            showCPUCharts(JSON.parse(data).metrics);
        },
        error:function (data) {
            $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '内存曲线加载失败'});
        }
    });
}

function getRestart(projectName) {
    $.ajax({
        url:"/project/getrestart",
        type:"get",
        async: false,
        dataType:"text",
        data:{projectName: projectName
        },
        success:function(data) {
            showRestartCharts(JSON.parse(data).metrics);
        },
        error:function (data) {
            $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '内存曲线加载失败'});
        }
    });
}

function getNetIO(projectName) {
    $.ajax({
        url:"/project/getnetio",
        type:"get",
        async: false,
        dataType:"text",
        data:{projectName: projectName
        },
        success:function(data) {
            showNetIOCharts(JSON.parse(data));
        },
        error:function (data) {
            $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '内存曲线加载失败'});
        }
    });
}

function getPodStatus(projectName) {
    $.ajax({
        url:"/project/getpodstatus",
        type:"get",
        async: false,
        dataType:"text",
        data:{projectName: projectName
        },
        success:function(data) {
            showPodStatusCharts(JSON.parse(data).metrics);
        },
        error:function (data) {
            $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '内存曲线加载失败'});
        }
    });
}

function getPods(id) {
    $.ajax({
        url: "/project/getPods",
        type: "get",
        data: {id: id},
        success: function (data) {
            console.info(data);

            // var podCount = "<h5 style=\"margin-top: 15px; margin-left: 10px\"><p>本项目共有" + data.podList.length +"个pod</p></h5>";
            if (data.podList.length != 0) {
                $('#podTableNum').html("本项目共有" + data.podList.length +"个Pod");
                var tableHeading = "<div><table id=\"podInfoTable\" class=\"table table-striped front-table table-bordered\">\n" +
                    "<thead>\n" +
                    "<tr>\n" +
                    "<th width=\"21%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">名称</th>\n" +
                    "<th width=\"4%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">当前状态</th>\n" +
                    "<th width=\"5%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">重启</th>\n" +
                    "<th width=\"14%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">运行时间</th>\n" +
                    "<th width=\"9%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">IP</th>\n" +
                    "<th width=\"9%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">节点</th>\n" +
                    "<th width=\"10%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">初始化</br>容器</th>\n" +
                    "<th width=\"11%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">容器</th>\n" +
                    "<th width=\"8%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">监控</th>\n" +
                    "</tr>\n" +
                    "</thead>\n";
                var tableStr = "";
                for (var i = 0; i < data.podList.length; i++) {
                    var containerStr = "";
                    for(var j = 0; j < data.podList[i].container.length; j++) {
                        containerStr += "<a herf=\"javascript:void(0)\" onclick='window.open(\""+data.podList[i].container[j].url+"\")' style=\"cursor:pointer\">" + data.podList[i].container[j].containerName + "</a><br>"
                    }
                    var initContainerStr = "";
                    for(var j = 0; j < data.podList[i].initContainer.length; j++) {
                        initContainerStr += "<a herf=\"javascript:void(0)\" onclick='window.open(\""+data.podList[i].initContainer[j].url+"\")' style=\"cursor:pointer\">" + data.podList[i].initContainer[j].containerName + "</a><br>"
                    }
                    var monitorUrl = data.addr + "d/DkUPfrpGk/06-podxiang-qing?orgId=1&var-datasource=prometheus&var-cluster=&var-namespace=default&var-pod=" + data.podList[i].name + "&var-container=All";
                    var monitorLink = "<a herf=\"javascript:void(0)\" onclick='window.open(\""+monitorUrl+"\")' style=\"cursor:pointer\">" + "查看" + "</a><br>"
                    tableStr += "<tr>\n" +
                        "<td width=\"21%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed; border: 1px solid #ddd\">\n" + data.podList[i].name +
                        "</td>\n" +
                        "<td width=\"9%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">\n" + data.podList[i].status +
                        "</td>\n" +
                        "<td width=\"5%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">\n" + data.podList[i].restarts +
                        "</td>\n" +
                        "<td width=\"14%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">\n" + data.podList[i].age +
                        "</td>\n" +
                        "<td width=\"9%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">\n" + data.podList[i].ip +
                        "</td>\n" +
                        "<td width=\"9%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">\n" + data.podList[i].node +
                        "</td>\n" +
                        "<td width=\"10%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">\n" + initContainerStr
                        +
                        "</td>\n" +
                        "<td width=\"11%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">\n" + containerStr
                        +
                        "</td>\n" +
                        "<td width=\"8%\" style=\"text-align: center; vertical-align:middle; table-layout: fixed\">\n" + monitorLink
                        +
                        "</td>\n" +
                        "</tr>";
                }
                var tableHtml = tableHeading + tableStr + "</table></div>";
                $('#podTable').html(tableHtml);
            } else {
                $('#podTable').html("<div style=\"padding-left: 15px;font-size: large;padding-top: 15px;padding-bottom: 15px;font-size:15px\">\n" +
                    "                    未查询到Pod详情\n" +
                    "                </div>");
            }
        },
        error:function (data) {
            $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '查询Pods详情失败'});
        }
    });

}

// var table = document.getElementById("envTab");
// table.rows[1].cells[0].getElementsByTagName("input")[0].value = 222;
function getPdTable() {
    pdTable = {};
    var table = document.getElementById("detailTab");
    for(var j = 1; j<table.rows.length; j++){
        var key = table.rows[j].cells[0].textContent.trim();
        var parameter = table.rows[j].cells[1].getElementsByTagName("input")[0].value;
        if(key !== ""){
            pdTable[key] = parameter;
        }
    }
}

function formatDateTime(inputTime) {
    var date = new Date(inputTime);
    var y = date.getFullYear();
    var m = date.getMonth() + 1;
    m = m < 10 ? ('0' + m) : m;
    var d = date.getDate();
    d = d < 10 ? ('0' + d) : d;
    var h = date.getHours();
    h = h < 10 ? ('0' + h) : h;
    var minute = date.getMinutes();
    var second = date.getSeconds();
    minute = minute < 10 ? ('0' + minute) : minute;
    second = second < 10 ? ('0' + second) : second;
    return y + '-' + m + '-' + d+' '+h+':'+minute+':'+second;
};

function search(){
    var inputValue = $('#searchBox').val();
    searchValue = inputValue;
    getFileMessage(inputValue);
}

function getFileMessage(search){
    $.ajax({
        url: "/project/getFileMessage",
        type: "get",
        data: {search:search},
        beforeSend:function(){
            $("#loading-container").css("display","block");
            $("#fileList").hide();
        },
        success: function (data) {
            $("#loading-container").css("display","none");
            $("#fileList").show();
            //方法中传入的参数data为后台获取的数据
            $("#resultTable").empty();
            for(var i = 0; i < data.fileMessageList.length; i++)
            {
                var tr;
                tr='<td>'+data.fileMessageList[i].file_id+'</td>'+'<td>'+data.fileMessageList[i].file_name+'</td>'+'<td>'+data.fileMessageList[i].file_createTime+'</td>'+'<td><a href="javascript:void(0);" onclick="deltefile(this)">'+"删除" +'</a></td>'
                $("#resultTable").append('<tr>'+tr+'</tr>')
            }
        },
        error: function (data) {
            $.fillTipBox({type: 'warning', icon: 'glyphicon-exclamation-sign', content: '查询文件信息失败！'});
        }
    });
}
//
// function Fileupload(){
//     var type = "file";          //后台接收时需要的参数名称，自定义即可
//     var id = "cert";            //即input的id，用来寻找值
//     var formData = new FormData();
//     formData.append(type, $("#"+id)[0].files[0]);    //生成一对表单属性
//     $.ajax({
//         type: "POST",           //因为是传输文件，所以必须是post
//         url: '/upload',         //对应的后台处理类的地址
//         data: formData,
//         processData: false,
//         contentType: false,
//         success: function (data) {
//             alert(data);
//         }
//     });
// }

window.deltefile=function (a){
    var tr = a.parentNode.parentNode;
    var fileid = tr.cells[0].innerHTML;
    $.tipModal('confirm', 'danger', '您确定要删除这个文件？', function (result) {
        if (result) {
            $.showLoading('show');
            $.post("/project/deleteFileMessage", {
                file_id: fileid,
            }, function () {
                $.showLoading('reset');
                getFileMessage(null);
            })
        }
    });
}


$("#search-log").click(function() {
    $("#hide").removeClass('hide');
    var btime = $("#begin-date").val();
    var etime = $("#end-date").val();
    var start = new Date();
    var end=new Date();
    if (btime != "") {
        btime = new Date($("#begin-date").val().substring(0, 19).replace(/-/g, '/')).getTime();
    } else {
        start.setTime(start.getTime()-(86400000));
        btime = start.getTime();
        $("#begin-date").attr("placeholder",formatDateTime(start));
    }
    if (etime != "") {
        etime = new Date($("#end-date").val().substring(0, 19).replace(/-/g, '/')).getTime();
    } else{
        etime=end.getTime();
        $("#end-date").attr("placeholder",formatDateTime(end));
    }

    var type = $("input[name='type']:checked").val();
    if (typeof(type) =="undefined"){
        type = "";
    }
    var level = $("input[name='level']:checked").val();
    if (typeof(level) =="undefined"){
        level = "";
    }
    console.info(level);
    var content = $("#content").val();
    $.post('runninglogsearch', {
        btime: btime,
        etime: etime,
        level: level,
        projectName: projectName,
        content: content,
        currentpage:0,
    }, function(data) {
        $("#hide").addClass("hide");
        $('#log-list-table').html(data);
        // alert(data);
    });
});

function goPage(page){
    var btime = $("#btime").val();
    var etime = $("#etime").val();
    var level = $("input[name='level']:checked").val();
    if (typeof(level) =="undefined"){
        level = "";
    }
    var content = $("#content").val();
    $.post('runninglogsearch', {
        btime: btime,
        etime: etime,
        level: level,
        projectName: projectName,
        content: content,
        currentpage:page,
    }, function(data) {
        $('#log-list-table').html(data);
    });
}