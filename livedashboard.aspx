<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="livedashboard.aspx.cs" Inherits="livedashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="Kendo/jquery.min.js" type="text/javascript"></script>
    <script src="Kendo/kendo.all.min.js" type="text/javascript"></script>
    <link href="Kendo/kendo.common.min.css" rel="stylesheet" type="text/css" />
    <link href="Kendo/kendo.default.min.css" rel="stylesheet" type="text/css" />
    <script src="Charts/jquery.blockUI.js" type="text/javascript"></script>
    <script src="Charts/amcharts.js" type="text/javascript"></script>
    <script src="Charts/serial.js" type="text/javascript"></script>
    <link href="Charts/style.css" rel="stylesheet" type="text/css" />
    <script src="Charts/light.js" type="text/javascript"></script>
    <style type="text/css">
        #chartdiv1
        {
            width: 1000px;
            height: 500px;
            font-size: 11px;
            position: absolute;
        }
        #mychart
        {
            width: 1000px;
            height: 500px;
            font-size: 11px;
            position: absolute;
        }
        #chartdiv3
        {
            width: 10px;
            height: 50px;
        }
        #chartdiv4
        {
            width: 10px;
            height: 50px;
        }
        #chartdiv5
        {
            width: 10px;
            height: 50px;
        }
        label
        {
            font-size: 35px !important;
            font-weight: 600 !important;
            text-transform: capitalize !important;
            color: white !important;
            line-height: 1.8 !important;
        }
        
        /*change the label effects on quantity */
    </style>
    <script type="text/javascript">
        $(function () {

        });
        function callHandler(d, s, e) {
            $.ajax({
                url: 'FleetManagementHandler.axd',
                data: d,
                type: 'GET',
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                async: true,
                cache: true,
                success: s,
                error: e
            });
        }
        function CallHandlerUsingJson(d, s, e) {
            d = JSON.stringify(d);
            d = d.replace(/&/g, '\uFF06');
            d = d.replace(/#/g, '\uFF03');
            d = d.replace(/\+/g, '\uFF0B');
            d = d.replace(/\=/g, '\uFF1D');
            $.ajax({
                type: "GET",
                url: "FleetManagementHandler.axd?json=",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: d,
                async: true,
                cache: true,
                success: s,
                error: e
            });
        }
        function get_vendorlinechart_details() {
            var date = document.getElementById("txt_cowbuffdate").value;
            var data = { 'op': 'get_vendorlinechart_details', 'date': date };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        createlineChart(msg);
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            }; $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        var datainXSeries = 0;
        var datainYSeries = 0;
        var newXarray = [];
        var newYarray = [];
        function createlineChart(databind) {
            var newYarray = [];
            var newXarray = [];
            if (databind.length > 0) {
                for (var k = 0; k < databind.length; k++) {
                    var BranchName = [];
                    var vendorname = databind[k].vendorname;
                    var quantity = databind[k].quantity;
                    var Status = databind[k].status;
                    newXarray = vendorname.split(',');
                    for (var i = 0; i < quantity.length; i++) {
                        newYarray.push({ 'data': quantity[i].split(','), 'name': Status[i] });
                    }
                }
            }
            var textname = "Inter Branches Milk Transaction Details";
            $("#interactive").kendoChart({
                title: {
                    text: textname,
                    color: "#006600",
                    font: "bold italic 18px Arial,Helvetica,sans-serif"
                },
                legend: {
                    position: "bottom"
                },
                chartArea: {
                    background: ""
                },
                seriesDefaults: {
                    type: "line",
                    style: "smooth"
                },
                series: newYarray,
                valueAxis: {
                    labels: {
                        format: "{0}"
                    },
                    line: {
                        visible: false
                    },
                    axisCrossingValue: -10
                },
                categoryAxis: {
                    categories: newXarray,
                    //                        categories: [2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011],
                    majorGridLines: {
                        visible: false
                    },
                    labels: {
                        rotation: 65
                    }
                },
                tooltip: {
                    visible: true,
                    format: "{0}%",
                    template: "#= series.name #: #= value #"
                }
            });
        }
        function get_cowdetailschart() {
            var cowbuffdate = document.getElementById("txt_cowbuffdate").value;
            var data = { 'op': 'get_cowdetailschart', 'cowbuffdate': cowbuffdate };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        cowdetail(msg);
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            }; $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        var Qtykg = [];
        function cowdetail(msg) {
            var Qtykg = msg[0].qtykg;
            var Qtyltr = msg[0].qtyltr;
            var snf = msg[0].snf;
            var fat = msg[0].fat;
            var kgfat = msg[0].kgfat;
            var kgsnf = msg[0].kgsnf;

            document.getElementById('lblcowqtykgs').innerHTML = Qtykg;
            document.getElementById('lblcowqtyltrs').innerHTML = Qtyltr;
            document.getElementById('lblcowAvgfat').innerHTML = fat;
            document.getElementById('lblcowAvgsnf').innerHTML = snf;
            document.getElementById('lblcowkgfat').innerHTML = kgfat;
            document.getElementById('lblcowkgsnf').innerHTML = kgsnf;
        }
        function get_buffalodetailschart() {
            var cowbuffdate = document.getElementById("txt_cowbuffdate").value;
            var data = { 'op': 'get_buffalodetailschart', 'cowbuffdate': cowbuffdate };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        buffalodetail(msg);
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            }; $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        var Qtyltr = [];
        function buffalodetail(msg) {
            var Qtykg = msg[0].qtykg;
            var Qtyltr = msg[0].qtyltr;
            var snf = msg[0].snf;
            var fat = msg[0].fat;
            var kgfat = msg[0].kgfat;
            var kgsnf = msg[0].kgsnf;

            document.getElementById('lblbuffkgs').innerHTML = Qtykg;
            document.getElementById('lblbuffltrs').innerHTML = Qtyltr;
            document.getElementById('lblbuffavgfat').innerHTML = fat;
            document.getElementById('lblbuffavgsnf').innerHTML = snf;
            document.getElementById('lblbuffkgfat').innerHTML = kgfat;
            document.getElementById('lblbuffkgsnf').innerHTML = kgsnf;
        }

        function generate_filimchart() {
            var date = document.getElementById("txt_cowbuffdate").value;
            var data = { 'op': 'filimchartdetails', 'date': date };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        createChart(msg);
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            }; $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        var newXarray = [];
        var wastagearray = [];
        function createChart(databind) {
            $("#divfilim").empty();
            newXarray = [];
            var wastage = databind[0].wastage;
            if (wastage == undefined) {

            }
            else {
                for (var i = 0; i < wastage.length; i++) {
                    document.getElementById('lblwastagefilim').innerHTML = wastage[0];
                    document.getElementById('lblcuttingfilim').innerHTML = wastage[1];
                    document.getElementById('lbloverallwastage').innerHTML = wastage[2];
                }
            }
            var Amount = databind[0].Amount;
            var RouteName = databind[0].RouteName;
            if (RouteName != undefined) {
                for (var i = 0; i < RouteName.length; i++) {
                    newXarray.push({ "category": RouteName[i], "value": parseFloat(Amount[i]) });
                }
            }
            $("#divfilim").kendoChart({
                title: {
                    position: "bottom",
                    text: "",
                    color: "#006600",
                    font: "bold italic 18px Arial,Helvetica,sans-serif"
                },
                legend: {
                    visible: false
                },
                chartArea: {
                    background: ""
                },
                seriesDefaults: {
                    labels: {
                        visible: true,
                        background: "transparent",
                        template: "#= category #: #= value#"
                    }
                },
                dataSource: {
                    data: newXarray
                },
                series: [{
                    type: "pie",
                    field: "value",
                    categoryField: "category"
                }],
                seriesColors: ["#3275a8", "#FF7F50", "#A52A2A", "#c71585", "#00FF00"],
                tooltip: {
                    visible: true,
                    format: "{0}"
                }
            });
        }
        function generate_vendorwisecowmilk() {
            var branchtype = "Inter Branch";
            var milktype = "Cow";
            var status = "Daily";
            var date = document.getElementById("txt_cowbuffdate").value;
            var data = { 'op': 'piechartvalues', 'milktype': milktype, 'status': status, 'branchtype': branchtype, 'date': date };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        createvendorwisecowmilkChart(msg);
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            }; $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        var newXarray = [];
        function createvendorwisecowmilkChart(databind) {
            $("#divdailycowmilk").empty();
            newXarray = [];
            var Amount = databind[0].Amount;
            var RouteName = databind[0].RouteName;
            if (RouteName.length > 0) {
                for (var i = 0; i < RouteName.length; i++) {
                    newXarray.push({ "category": RouteName[i], "value": parseFloat(Amount[i]) });
                }
            }
            $("#divdailycowmilk").kendoChart({
                title: {
                    position: "bottom",
                    text: "Inter Branches Daily Milk Summary",
                    color: "#006600",
                    font: "bold italic 18px Arial,Helvetica,sans-serif"
                },
                legend: {
                    visible: false
                },
                chartArea: {
                    background: ""
                },
                seriesDefaults: {
                    labels: {
                        visible: true,
                        background: "transparent",
                        template: "#= category #: #= value#"
                    }
                },
                dataSource: {
                    data: newXarray
                },
                series: [{
                    type: "pie",
                    field: "value",
                    categoryField: "category"
                }],
                seriesColors: ["#3275a8", "#267ed4", "#068c35", "#808080", "#FFA500", "#A52A2A", "#FF7F50", "#00FF00", "#808000", "#0041C2", "#800517", "#1C1715", "#F1E4C9", "#D82AF1", "#17B2B7"],
                tooltip: {
                    visible: true,
                    format: "{0}"
                }
            });
        }
        function generate_vendorwisebuffalomilk() {
            var branchtype = "Inter Branch";
            var milktype = "Buffalo";
            var status = "Daily";
            var date = document.getElementById("txt_cowbuffdate").value;
            var data = { 'op': 'piechartvalues', 'milktype': milktype, 'status': status, 'branchtype': branchtype, 'date': date };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        createvendorwisebuffalomilkChart(msg);
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            }; $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        var newXarray = [];
        function createvendorwisebuffalomilkChart(databind) {
            $("#divdailybuffalomilkChart").empty();
            newXarray = [];
            var Amount = databind[0].Amount;
            var RouteName = databind[0].RouteName;
            for (var i = 0; i < RouteName.length; i++) {
                newXarray.push({ "category": RouteName[i], "value": parseFloat(Amount[i]) });
            }
            $("#divdailybuffalomilkChart").kendoChart({
                title: {
                    position: "bottom",
                    text: "Inter Branches Daily Milk Summary",
                    color: "#006600",
                    font: "bold italic 18px Arial,Helvetica,sans-serif"
                },
                legend: {
                    visible: false
                },
                chartArea: {
                    background: ""
                },
                seriesDefaults: {
                    labels: {
                        visible: true,
                        background: "transparent",
                        template: "#= category #: #= value#"
                    }
                },
                dataSource: {
                    data: newXarray
                },
                series: [{
                    type: "pie",
                    field: "value",
                    categoryField: "category"
                }],
                seriesColors: ["#3275a8", "#267ed4", "#068c35", "#808080", "#FFA500", "#A52A2A", "#FF7F50", "#00FF00", "#808000", "#0041C2", "#800517", "#1C1715", "#F1E4C9", "#D82AF1", "#17B2B7"],
                tooltip: {
                    visible: true,
                    format: "{0}"
                }
            });
        }
        function generate_returnmilkbarchart() {
            var date = document.getElementById("txt_cowbuffdate").value;
            var data = { 'op': 'generate_returnmilkbarchart', 'date': date };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        createbarChart(msg);
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            }; $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        var newXarray = [];
        function createbarChart(databind) {
            $("#divbarchart").empty();
            newXarray = [];
            var quantity = databind[0].quantity;
            var milktype = databind[0].milktype;
            for (var i = 0; i < milktype.length; i++) {
                newXarray.push({ "category": milktype[i], "value": parseFloat(quantity[i]) });
            }
            $("#divbarchart").kendoChart({
                title: {
                    position: "bottom",
                    text: "Return Milk Details",
                    color: "#006600",
                    font: "bold italic 18px Arial,Helvetica,sans-serif"
                },
                legend: {
                    visible: false
                },
                chartArea: {
                    background: ""
                },
                seriesDefaults: {
                    labels: {
                        visible: true,
                        background: "transparent",
                        template: "#= value #"
                    }
                },
                dataSource: {
                    data: newXarray
                },
                series: [{
                    type: "column",
                    field: "value"
                }],
                categoryAxis: {
                    field: "category"
                },
                tooltip: {
                    visible: true,
                    format: "{0}"
                }
            });
        }
        function get_cow_vendor_details_chart() {
            var date = document.getElementById("txt_cowbuffdate").value;
            var data = { 'op': 'get_cow_vendor_details_chart', 'date': date };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        $('#divMainAddNewRowCow').css('display', 'none');
                        fillcowvendordetails(msg);
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            }; $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function fillcowvendordetails(msg) {
            $('#divMainAddNewRowCow').css('display', 'block');
            var results = '<div  style="overflow:auto;"><table style="background-color: antiquewhite;" class="table table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="example2_info">';
            results += '<thead><tr style="background-color: #abbed2;"><th scope="col">SNO</th><th scope="col">Vendor Name</th><th scope="col">Qty(Kgs)</th><th scope="col">Qty(Ltrs)</th><th scope="col">FAT</th><th scope="col">SNF</th><th scope="col">KGFAT</th><th scope="col">KGSNF</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                results += '<tr><td scope="row" class="1" style="text-align:center;">' + (i + 1) + '</td>';
                results += '<td scope="row" class="2" style="text-align:center;">' + msg[i].vendorname + '</td>';
                results += '<td data-title="Capacity" class="totqtykgsclss">' + msg[i].qtykg + '</td>';
                results += '<td data-title="Capacity" class="totlqtyltrsclss">' + msg[i].qtyltr + '</td>';
                results += '<td data-title="Capacity" class="5">' + msg[i].fat + '</td>';
                results += '<td data-title="Capacity" class="6">' + msg[i].snf + '</td>';
                results += '<td data-title="Capacity" class="7">' + msg[i].kgfat + '</td>';
                results += '<td class="8">' + msg[i].kgsnf + '</td></tr>';
            }
            results += '<tr><th scope="row" class="1" style="text-align:center;"></th>';
            results += '<td data-title="brandstatus" class="badge bg-yellow">Total</td>';
            results += '<td data-title="brandstatus" class="3"><span id="totalkgsclss" class="badge bg-yellow"></span></td>';
            results += '<td data-title="brandstatus" class="4"><span id="totalltrsclss" class="badge bg-yellow"></span></td>';
            results += '<td data-title="brandstatus" class="5"></td>';
            results += '<td data-title="brandstatus" class="6"></td>';
            results += '<td data-title="brandstatus" class="7"></td>';
            results += '<td data-title="brandstatus" class="8"></td></tr>';
            results += '</table></div>';
            $("#div_cowvendordetails").html(results);
            GetkgstotalclsCalcow();
            GetltrstotalclsCalcow();
        }
        function GetkgstotalclsCalcow() {
            var totamount = 0;
            $('.totqtykgsclss').each(function (i, obj) {
                var qtyclass = $(this).text();
                if (qtyclass == "" || qtyclass == "0") {
                }
                else {
                    totamount += parseFloat(qtyclass);
                }
            });
            document.getElementById('totalkgsclss').innerHTML = parseFloat(totamount).toFixed(2);
        }
        function GetltrstotalclsCalcow() {
            var totamount = 0;
            $('.totlqtyltrsclss').each(function (i, obj) {
                var qtyclass = $(this).text();
                if (qtyclass == "" || qtyclass == "0") {
                }
                else {
                    totamount += parseFloat(qtyclass);
                }
            });
            document.getElementById('totalltrsclss').innerHTML = parseFloat(totamount).toFixed(2);
        }
        function CloseClick_cowvendor_det_close() {
            $('#divMainAddNewRowCow').css('display', 'none');
        }
        function get_buffalo_vendor_details_chart() {
            var date = document.getElementById("txt_cowbuffdate").value;
            var data = { 'op': 'get_buffalo_vendor_details_chart', 'date': date };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        $("#divMainAddNewRowBuffalo").css('diaplay', 'none');
                        fillbuffalovendordetails(msg);
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            }; $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function fillbuffalovendordetails(msg) {
            $('#divMainAddNewRowBuffalo').css('display', 'block');
            var results = '<div  style="overflow:auto;"><table style="background-color: antiquewhite;" class="table table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="example2_info">';
            results += '<thead><tr style="background-color: #abbed2;"><th scope="col">SNO</th><th scope="col">Vendor Name</th><th scope="col">Qty(Kgs)</th><th scope="col">Qty(Ltrs)</th><th scope="col">FAT</th><th scope="col">SNF</th><th scope="col">KGFAT</th><th scope="col">KGSNF</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                results += '<tr><td scope="row" class="1" style="text-align:center;">' + (i + 1) + '</td>';
                results += '<td scope="row" class="2" style="text-align:center;">' + msg[i].vendorname + '</td>';
                results += '<td data-title="Capacity" class="totqtykgscls">' + msg[i].qtykg + '</td>';
                results += '<td data-title="Capacity" class="totlqtyltrscls">' + msg[i].qtyltr + '</td>';
                results += '<td data-title="Capacity" class="5">' + msg[i].fat + '</td>';
                results += '<td data-title="Capacity" class="6">' + msg[i].snf + '</td>';
                results += '<td data-title="Capacity" class="7">' + msg[i].kgfat + '</td>';
                results += '<td class="8">' + msg[i].kgsnf + '</td></tr>';
            }
            results += '<tr><th scope="row" class="1" style="text-align:center;"></th>';
            results += '<td data-title="brandstatus" class="badge bg-yellow">Total</td>';
            results += '<td data-title="brandstatus" class="3"><span id="totalkgscls" class="badge bg-yellow"></span></td>';
            results += '<td data-title="brandstatus" class="4"><span id="totalltrscls" class="badge bg-yellow"></span></td>';
            results += '<td data-title="brandstatus" class="5"></td>';
            results += '<td data-title="brandstatus" class="6"></td>';
            results += '<td data-title="brandstatus" class="7"></td>';
            results += '<td data-title="brandstatus" class="8"></td></tr>';
            results += '</table></div>';
            $("#div_buffalovendordetails").html(results);
            GetkgstotalclsCalbuff();
            GetltrstotalclsCalbuff();
        }
        function CloseClick_buffalovendor_det_close() {
            $('#divMainAddNewRowBuffalo').css('display', 'none');
        }
        function GetkgstotalclsCalbuff() {
            var totamount = 0;
            $('.totqtykgscls').each(function (i, obj) {
                var qtyclass = $(this).text();
                if (qtyclass == "" || qtyclass == "0") {
                }
                else {
                    totamount += parseFloat(qtyclass);
                }
            });
            document.getElementById('totalkgscls').innerHTML = parseFloat(totamount).toFixed(2);
        }
        function GetltrstotalclsCalbuff() {
            var totamount = 0;
            $('.totlqtyltrscls').each(function (i, obj) {
                var qtyclass = $(this).text();
                if (qtyclass == "" || qtyclass == "0") {
                }
                else {
                    totamount += parseFloat(qtyclass);
                }
            });
            document.getElementById('totalltrscls').innerHTML = parseFloat(totamount).toFixed(2);
        }

        // Silo Dash Board

        function Siloquantity_details() {
            var data = { 'op': 'Siloquantity_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        filldetails(msg);
                    }
                    else {
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            }; $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function filldetails(msg) {
            var newYarray = [];
            for (var i = 0; i < msg.length; i++) {
                var newdiv = document.createElement('div');
                var divid = "chartdiv" + (i + 1);
                newdiv.id = divid;
                newdiv.style.width = "1800px";
                newdiv.style.height = "500px";
                newdiv.style.marginLeft = "-300px";
                // newdiv.style.marginright = "100px";
                newdiv.style.position = "absolute";

                var category = msg[i].SiloName;
                var value1 = msg[i].Quantity;
                var value2 = msg[i].Capacity;
                var value3 = msg[i].DeportmentName;
                newYarray.push({ 'category': category, 'value2': value2, 'value1': value1, 'value3': value3 });
                var chart1 = AmCharts.makeChart(newdiv, {
                    "theme": "light",
                    "type": "serial",
                    "depth3D": 100,
                    "angle": 30,
                    "autoMargins": false,
                    "marginBottom": 100,
                    "marginLeft": 350,
                    "marginRight": 300,
                    "dataProvider": newYarray,
                    "valueAxes": [{
                        "stackType": "100%",
                        "gridAlpha": 0
                    }],
                    "graphs": [{
                        "type": "column",
                        "topRadius": 1,
                        "columnWidth": 1,
                        "showOnAxis": true,
                        "lineThickness": 2,
                        "lineAlpha": 0.5,
                        "lineColor": "#FFFFFF",
                        "fillColors": "#8d003b",
                        "fillAlphas": 0.8,
                        "valueField": "value1"
                    }, {
                        "type": "column",
                        "topRadius": 1,
                        "columnWidth": 1,
                        "showOnAxis": true,
                        "lineThickness": 2,
                        "lineAlpha": 0.5,
                        "lineColor": "#cdcdcd",
                        "fillColors": "#cdcdcd",
                        "fillAlphas": 0.5,
                        "valueField": "value2"
                    }],

                    "categoryField": "category",
                    "categoryAxis": {
                        "axisAlpha": 0,
                        "labelOffset": 40,
                        "gridAlpha": 0
                    },
                    "export": {
                        "enabled": true
                    }
                });
            }
            $('#mychart').append(newdiv);
        }

    </script>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        $('body').addClass('hold-transition sidebar-mini skin-green-light sidebar-collapse');
    </script>
    <section class="content">
    <div>
        <div class="row">
            <div class="col-xs-12">
                <!-- interactive chart -->
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <i class="fa fa-bar-chart-o"></i>
                        <h3 class="box-title">
                            Sale Details</h3>
                         <input id="txt_cowbuffdate" class="form-control"  type="date" name="vendorcode" onblur="get_cowdetailschart();get_buffalodetailschart();get_vendorlinechart_details();generate_vendorwisecowmilk();generate_vendorwisebuffalomilk();generate_returnmilkbarchart();generate_filimchart();"/> 
                    </div>
                    
                    
                    <!-- /.box-body-->
                </div>
                <!-- /.box -->
            </div>
        </div>
        
        <div class="row">
            <div class="col-xs-12">
                <!-- interactive chart -->
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <i class="fa fa-bar-chart-o"></i>
                        <h3 class="box-title">
                            Inter Branches Milk Details</h3>
                        <div class="box-tools pull-right">
                            <div class="box-tools pull-right">
                                <button class="btn btn-box-tool" data-widget="collapse">
                                    <i class="fa fa-minus"></i>
                                </button>
                                <button class="btn btn-box-tool" data-widget="remove">
                                    <i class="fa fa-times"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="box-body">
                        <div id="interactive" style="height: 300px; position: relative;" data-role="chart" class="k-chart"><!--?xml version='1.0' ?--><svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="1248px" height="300px" style="position: relative; display: block;"><defs><clipPath id="k5904aaaa"><path id="k2c825555" d="M0 0 1248 0 1248 300 0 300 z" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path></clipPath></defs><path d="M5 46 1243 46 1243 261 5 261 z" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><path d="M0 0 1248 0 1248 300 0 300 z" stroke="" stroke-width="0" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><path id="k9fb00001" data-model-id="k9fd80001" d="M5 46 1243 46 1243 261 5 261 z" stroke="" stroke-linecap="square" stroke-linejoin="round" fill-opacity="0" stroke-opacity="1" fill="#fff"></path><text x="456" y="31" fill-opacity="1" style="font: bold italic 18px Arial,Helvetica,sans-serif" fill="#006600">Inter Branches Milk Transaction Details</text><path data-model-id="k9fd80001" d="M54.5 163.5 1243.5 163.5" stroke="#dfdfdf" stroke-width="1" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><path data-model-id="k9fd80001" d="M54.5 136.5 1243.5 136.5" stroke="#dfdfdf" stroke-width="1" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><path data-model-id="k9fd80001" d="M54.5 108.5 1243.5 108.5" stroke="#dfdfdf" stroke-width="1" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><path data-model-id="k9fd80001" d="M54.5 81.5 1243.5 81.5" stroke="#dfdfdf" stroke-width="1" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><path data-model-id="k9fd80001" d="M54.5 53.5 1243.5 53.5" stroke="#dfdfdf" stroke-width="1" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><path d="M54.5 191.5 1243.5 191.5" stroke="#8e8e8e" stroke-width="1" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><path d="M54.5 191.5 54.5 195.5" stroke="#8e8e8e" stroke-width="1" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><path d="M162.5 191.5 162.5 195.5" stroke="#8e8e8e" stroke-width="1" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><path d="M270.5 191.5 270.5 195.5" stroke="#8e8e8e" stroke-width="1" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><path d="M378.5 191.5 378.5 195.5" stroke="#8e8e8e" stroke-width="1" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><path d="M486.5 191.5 486.5 195.5" stroke="#8e8e8e" stroke-width="1" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><path d="M594.5 191.5 594.5 195.5" stroke="#8e8e8e" stroke-width="1" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><path d="M703.5 191.5 703.5 195.5" stroke="#8e8e8e" stroke-width="1" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><path d="M811.5 191.5 811.5 195.5" stroke="#8e8e8e" stroke-width="1" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><path d="M919.5 191.5 919.5 195.5" stroke="#8e8e8e" stroke-width="1" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><path d="M1027.5 191.5 1027.5 195.5" stroke="#8e8e8e" stroke-width="1" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><path d="M1135.5 191.5 1135.5 195.5" stroke="#8e8e8e" stroke-width="1" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><path d="M1243.5 191.5 1243.5 195.5" stroke="#8e8e8e" stroke-width="1" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><g clip-path="url(#k5904aaaa)"><path id="keaaaaaea" data-model-id="k75555575" d="M108.045 162.269 216.136 119.226 324.227 123.434 432.318 141.141 540.409 80.874 648.5 139.695 756.591 181.643 864.682 185.582 972.773 172.383 1080.864 166.326 1188.955 167.77" stroke="#ff6800" stroke-width="4" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><circle id="kfafffffe" data-model-id="k7d7fffff" cx="108.045" cy="162.269" r="4" stroke="#ff6800" stroke-width="2" fill-opacity="1" stroke-opacity="1" fill="#fff"></circle><circle id="keebffffe" data-model-id="k775fffff" cx="216.136" cy="119.226" r="4" stroke="#ff6800" stroke-width="2" fill-opacity="1" stroke-opacity="1" fill="#fff"></circle><circle id="kebaffffe" data-model-id="k75d7ffff" cx="324.227" cy="123.434" r="4" stroke="#ff6800" stroke-width="2" fill-opacity="1" stroke-opacity="1" fill="#fff"></circle><circle id="keaebfffe" data-model-id="k7575ffff" cx="432.318" cy="141.141" r="4" stroke="#ff6800" stroke-width="2" fill-opacity="1" stroke-opacity="1" fill="#fff"></circle><circle id="keabafffe" data-model-id="k755d7fff" cx="540.409" cy="80.874" r="4" stroke="#ff6800" stroke-width="2" fill-opacity="1" stroke-opacity="1" fill="#fff"></circle><circle id="keaaebffe" data-model-id="k75575fff" cx="648.5" cy="139.695" r="4" stroke="#ff6800" stroke-width="2" fill-opacity="1" stroke-opacity="1" fill="#fff"></circle><circle id="keaabaffe" data-model-id="k7555d7ff" cx="756.591" cy="181.643" r="4" stroke="#ff6800" stroke-width="2" fill-opacity="1" stroke-opacity="1" fill="#fff"></circle><circle id="keaaaebfe" data-model-id="k755575ff" cx="864.682" cy="185.582" r="4" stroke="#ff6800" stroke-width="2" fill-opacity="1" stroke-opacity="1" fill="#fff"></circle><circle id="keaaabafe" data-model-id="k75555d7f" cx="972.773" cy="172.383" r="4" stroke="#ff6800" stroke-width="2" fill-opacity="1" stroke-opacity="1" fill="#fff"></circle><circle id="keaaaaebe" data-model-id="k7555575f" cx="1080.864" cy="166.326" r="4" stroke="#ff6800" stroke-width="2" fill-opacity="1" stroke-opacity="1" fill="#fff"></circle><circle id="keaaaabae" data-model-id="k755555d7" cx="1188.955" cy="167.77" r="4" stroke="#ff6800" stroke-width="2" fill-opacity="1" stroke-opacity="1" fill="#fff"></circle></g><g><path d="M589 266 656 266 656 290 589 290 z" stroke="" stroke-width="0" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="none"></path><text x="608" y="282" fill-opacity="1" style="font: 12px Arial,Helvetica,sans-serif" fill="#232323">Qty Kgs</text><path d="M594 274.5 601 274.5 601 281.5 594 281.5 z" stroke="#ff6800" stroke-linecap="square" stroke-linejoin="round" fill-opacity="1" stroke-opacity="1" fill="#ff6800"></path></g><text id="k9fec0001" data-model-id="k9ff60001" x="94" y="211" fill-opacity="1" transform="translate(-4.337,12.725) rotate(65,112.383,206.799)" style="font: 12px Arial,Helvetica,sans-serif" fill="#232323">ARANI</text><text id="k9ffb0001" data-model-id="k9ffd8001" x="197" y="211" fill-opacity="1" transform="translate(-10.977,23.147) rotate(65,227.114,206.799)" style="font: 12px Arial,Helvetica,sans-serif" fill="#232323">CSPURAM</text><text id="k9ffec001" data-model-id="k9fff6001" x="309" y="211" fill-opacity="1" transform="translate(-5.78,14.99) rotate(65,330.008,206.799)" style="font: 12px Arial,Helvetica,sans-serif" fill="#232323">GPADU</text><text id="k9fffb001" data-model-id="k9fffd801" x="415" y="211" fill-opacity="1" transform="translate(-8.379,19.069) rotate(65,440.698,206.799)" style="font: 12px Arial,Helvetica,sans-serif" fill="#232323">KALIGIRI</text><text id="k9fffec01" data-model-id="k9ffff601" x="526" y="211" fill-opacity="1" transform="translate(-5.203,14.084) rotate(65,545.613,206.799)" style="font: 12px Arial,Helvetica,sans-serif" fill="#232323">KAVALI</text><text id="k9ffffb01" data-model-id="k9ffffd81" x="631" y="211" fill-opacity="1" transform="translate(-9.245,20.428) rotate(65,657.745,206.799)" style="font: 12px Arial,Helvetica,sans-serif" fill="#232323">KONDEPI</text><text id="k9ffffec1" data-model-id="k9fffff61" x="740" y="211" fill-opacity="1" transform="translate(-8.091,18.616) rotate(65,764.681,206.799)" style="font: 12px Arial,Helvetica,sans-serif" fill="#232323">KUPPAM</text><text id="k9fffffb1" data-model-id="k9fffffd9" x="848" y="211" fill-opacity="1" transform="translate(-8.09,18.616) rotate(65,872.772,206.799)" style="font: 12px Arial,Helvetica,sans-serif" fill="#232323">KVPTNM</text><text id="k9fffffed" data-model-id="k9ffffff7" x="954" y="211" fill-opacity="1" transform="translate(-11.265,23.6) rotate(65,984.038,206.799)" style="font: 12px Arial,Helvetica,sans-serif" fill="#232323">RCPURAM</text><text id="k9ffffffa" data-model-id="k4ffffffd" x="1064" y="211" fill-opacity="1" transform="translate(-8.379,19.069) rotate(65,1089.243,206.799)" style="font: 12px Arial,Helvetica,sans-serif" fill="#232323">TGONDA</text><text id="kf7ffffff" data-model-id="kabfffffe" x="1177" y="211" fill-opacity="1" transform="translate(-1.161,7.74) rotate(65,1190.116,206.799)" style="font: 12px Arial,Helvetica,sans-serif" fill="#232323">WAL</text><text id="keaaaaabb" data-model-id="ka555555c" x="38" y="195" fill-opacity="1" style="font: 12px Arial,Helvetica,sans-serif" fill="#232323">0</text><text id="k52aaaaae" data-model-id="k29555557" x="12" y="167" fill-opacity="1" style="font: 12px Arial,Helvetica,sans-serif" fill="#232323">50000</text><text id="kc4aaaaaa" data-model-id="k62555555" x="5" y="140" fill-opacity="1" style="font: 12px Arial,Helvetica,sans-serif" fill="#232323">100000</text><text id="ke12aaaab" data-model-id="ka0955554" x="5" y="112" fill-opacity="1" style="font: 12px Arial,Helvetica,sans-serif" fill="#232323">150000</text><text id="k504aaaaa" data-model-id="k28255555" x="5" y="85" fill-opacity="1" style="font: 12px Arial,Helvetica,sans-serif" fill="#232323">200000</text><text id="kc412aaab" data-model-id="kb2095554" x="5" y="57" fill-opacity="1" style="font: 12px Arial,Helvetica,sans-serif" fill="#232323">250000</text></svg><div class="k-tooltip" style="position: absolute; font: 12px Arial, Helvetica, sans-serif; border: 3px solid rgb(255, 104, 0); opacity: 0.8; top: 128px; left: 119px; background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); display: none;">Qty Kgs: 51760</div></div>
                    </div>
                    <!-- /.box-body-->
                </div>
                <!-- /.box -->
            </div>
        </div>

         <!-- Silo Dash Board -->
         <div class="row">
            <div class="col-md-6" style="width: 100%;">
                <!-- AREA CHART -->
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">
                            <i class="fa fa-cog fa-spin fa-1x fa-fw"></i>Silo Wise Milk Details</h3>
                        <div class="box-tools pull-right">
                            <button class="btn btn-box-tool" data-widget="collapse">
                                <i class="fa fa-minus"></i>
                            </button>
                        </div>
                    </div>
                    <div style="width: 100%; position: relative;">
                        <div id="mychart">
                        </div>
                    </div>
                </div>
            </div>
        </div>
         <!--- Silo Dash Board End  --->

        <div class="row" style="margin-top: 550px;">
            <div class="col-md-6">
                <div class="box box-danger">
                    <div class="box-header with-border">
                        <h3 class="box-title">
                            Film Details</h3>
                        <div class="box-tools pull-right">
                            <button class="btn btn-box-tool" data-widget="collapse">
                                <i class="fa fa-minus"></i>
                            </button>
                            <button class="btn btn-box-tool" data-widget="remove">
                                <i class="fa fa-times"></i>
                            </button>
                        </div>
                    </div>
                    <div class="box-body">
                        <div class="chart">
                            <div id="divfilim">
                            </div>
                            Total Wastage Film(%) :
                            <label id="lblwastagefilim" style="font-size: 15px !important;color: black !important;">
                            </label>
                            <br />
                            Total Cutting Film(%) :
                            <label id="lblcuttingfilim" style="font-size: 15px !important;color: black !important;">
                            </label>
                            <br />
                            Over All Film Watsge(%) :
                            <label id="lbloverallwastage" style="font-size: 15px !important;color: black !important;">
                            </label>
                        </div>
                    </div>
                    <!-- /.box-body -->
                </div>
            </div>
            <div class="col-md-6">
                <div class="box box-success">
                    <div class="box-header with-border">
                        <h3 class="box-title">
                            Return Milk Details</h3>
                        <div class="box-tools pull-right">
                            <button class="btn btn-box-tool" data-widget="collapse">
                                <i class="fa fa-minus"></i>
                            </button>
                            <button class="btn btn-box-tool" data-widget="remove">
                                <i class="fa fa-times"></i>
                            </button>
                        </div>
                    </div>
                    <div class="box-body">
                        <div class="chart">
                            <div id="divbarchart">
                            </div>
                        </div>
                    </div>
                    <!-- /.box-body -->
                </div>
            </div>
        </div>
       </div>
    </section>
</asp:content>
