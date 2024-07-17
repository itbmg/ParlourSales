<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="livegraphchart.aspx.cs" Inherits="livegraphchart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        #chartdiv
        {
            width: 100%;
            height: 500px;
        }
    </style>
    <!-- Resources -->
    <script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
    <script src="https://www.amcharts.com/lib/3/serial.js"></script>
    <script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
    <link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css"
        type="text/css" media="all" />
    <!-- Chart code -->
    <style>
        #chartdiv
        {
            width: 100%;
            height: 500px;
            font-size: 11px;
        }
    </style>
    <!-- Resources -->
    <script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
    <script src="https://www.amcharts.com/lib/3/serial.js"></script>
    <script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
    <link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css"
        type="text/css" media="all" />
    <!-- Chart code -->
    <script>
        var chart = AmCharts.makeChart("chartdiv", {
            "type": "serial",
            "theme": "none",
            "categoryField": "year",
            "rotate": false,
            "startDuration": 1,
            "categoryAxis": {
                "gridPosition": "start",
                "position": "left"
            },
            "trendLines": [],
            "graphs": [
    {
        "balloonText": "Income:[[value]]",
        "fillAlphas": 0.8,
        "id": "AmGraph-1",
        "lineAlpha": 0.2,
        "title": "Income",
        "type": "column",
        "valueField": "income"
    },
    {
        "balloonText": "Expenses:[[value]]",
        "fillAlphas": 0.8,
        "id": "AmGraph-2",
        "lineAlpha": 0.2,
        "title": "Expenses",
        "type": "column",
        "valueField": "expenses"
    },
    {
        "balloonText": "Expenses2:[[value]]",
        "fillAlphas": 0.8,
        "id": "AmGraph-3",
        "lineAlpha": 0.2,
        "title": "Expenses2",
        "type": "column",
        "valueField": "expenses2"
    },
    {
        "balloonText": "Expenses3:[[value]]",
        "fillAlphas": 0.8,
        "id": "AmGraph-4",
        "lineAlpha": 0.2,
        "title": "Expenses3",
        "type": "column",
        "valueField": "Expenses3"
    },
    {
        "balloonText": "Expenses4:[[value]]",
        "fillAlphas": 0.8,
        "id": "AmGraph-5",
        "lineAlpha": 0.2,
        "title": "Expenses4",
        "type": "column",
        "valueField": "expenses4"
    },
    {
        "balloonText": "Expenses5:[[value]]",
        "fillAlphas": 0.8,
        "id": "AmGraph-6",
        "lineAlpha": 0.2,
        "title": "Expenses5",
        "type": "column",
        "valueField": "expenses5"
    },
    {
        "balloonText": "Expenses6:[[value]]",
        "fillAlphas": 0.8,
        "id": "AmGraph-7",
        "lineAlpha": 0.2,
        "title": "Expenses6",
        "type": "column",
        "valueField": "expenses6"
    }
  ],
            "guides": [],
            "valueAxes": [{
                "id": "ValueAxis-1",
                "position": "top",
                "axisAlpha": 0
            }],
            "allLabels": [],
            "balloon": {},
            "titles": [],
            "dataProvider": [
    {
        "year": 2005,
        "income": 23.5,
        "expenses": 18.1,
        "expenses2": 1,
        "expenses3": 1,
        "expenses4": 1,
        "expenses5": 1,
        "expenses6": 1
    },
    {
        "year": 2006,
        "income": 26.2,
        "expenses": 22.8,
        "expenses2": 1,
        "expenses3": 1,
        "expenses4": 1,
        "expenses5": 1,
        "expenses6": 1
    },
    {
        "year": 2007,
        "income": 30.1,
        "expenses": 23.9,
        "expenses2": 1,
        "expenses3": 1,
        "expenses4": 1,
        "expenses5": 1,
        "expenses6": 1
    },
    {
        "year": 2008,
        "income": 29.5,
        "expenses": 25.1,
        "expenses2": 1,
        "expenses3": 1,
        "expenses4": 1,
        "expenses5": 1,
        "expenses6": 1
    },
    {
        "year": 2009,
        "income": 24.6,
        "expenses": 25,
        "expenses2": 1,
        "expenses3": 1,
        "expenses4": 1,
        "expenses5": 1,
        "expenses6": 1
    }
  ],
            "export": {
                "enabled": true
            }

        });
    </script>
    <script type="text/javascript">
        $(function () {
            get_currentweekpossalevalue_details();
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
                Error: e
            });
        }
        var chartdataarray = [];
        function get_currentweekpossalevalue_details() {
            var data = { 'op': 'get_currentweekpossalevalue_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        currentBindsalvalueGrid(msg);
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
        var outward = [];
        var currentweekTotalDate = []; var currentweekattendancearry = []; var currentweektotattendance = []; var currentweekemptytable4 = [];
        function currentBindsalvalueGrid(msg) {
            currentweekTotalDate = msg[0].Allbiomertcdates;
            currentweektotattendance = msg[0].salevalue;
            for (var i = 0; i < currentweekTotalDate.length; i++) {
                var dta = currentweekTotalDate[i].Betweendates;
                var mysplit = dta.split("(");
                var dm = mysplit[0];
                var day = mysplit[1]
            }
            var totalpossalevalue = 0;
            for (var i = 0; i < currentweektotattendance.length; i++) {
                var parlorname = currentweektotattendance[i].parlorname
                if (currentweekemptytable4.indexOf(parlorname) == -1) {
                    currentweekemptytable4.push(parlorname);
                    var totalbranchvalue = 0;
                    for (var j = 0; j < currentweekTotalDate.length; j++) {
                        var d = 1;
                        var prevparlorname = "";
                        for (var k = 0; k < currentweektotattendance.length; k++) {
                            if (currentweekTotalDate[j].Betweendates == currentweektotattendance[k].LogDate && parlorname == currentweektotattendance[k].parlorname) {
                                if (currentweektotattendance[k].salevalue == "") {
                                    currentweektotattendance[k].salevalue = "0";
                                }
                                if (currentweektotattendance[k].salevalue != "") {
                                    var st = currentweektotattendance[k].parlorid + '-' + currentweektotattendance[k].LogDate;
                                    //20/Jan(Sunday)
                                    var logdt = currentweektotattendance[k].LogDate;
                                    var cmpid = currentweektotattendance[k].cmpid;
                                    var value = parseFloat(currentweektotattendance[k].salevalue);
                                    var date = currentweektotattendance[k].LogDate;
                                    d = 0;
                                    chartdataarray.push({ 'parlorname': parlorname, 'value': value, 'date': date });
                                }
                                else {

                                }
                            }
                            else {

                            }
                        }
                    }
                }
            }

            if (chartdataarray.length > 0) {
                var year = "";
                var tot = 0;
                var value1 = 0;
                var value2 = 0;
                var value3 = 0;
                var value4 = 0;
                var value5 = 0;
                var value6 = 0;
                var value7 = 0;
                var d1 = "";
                var d2 = "";
                var d3 = "";
                var d4 = "";
                var d5 = "";
                var d6 = "";
                var d7 = "";
                var newparray = [];
                var prevparlor = "";
                var k = 0;
                for (var i = 0; i < chartdataarray.length; i++) {
                    var j = i + 1;
                    k = k + 1;
                    var parlorname = chartdataarray[i].parlorname;
                    if (prevparlor == parlorname) {
                        if (k == "2") {
                            if (value2 == "0") {
                                value2 = chartdataarray[i].value;
                                d2 = chartdataarray[i].date;
                            }
                        }
                        if (k == "3") {
                            if (value3 == "0") {
                                value3 = chartdataarray[i].value;
                                d3 = chartdataarray[i].date;
                            }
                        }
                        if (k == "4") {
                            if (value4 == "0") {
                                value4 = chartdataarray[i].value;
                                d4 = chartdataarray[i].date;
                            }
                        }
                        if (k == "5") {
                            if (value5 == "0") {
                                value5 = chartdataarray[i].value;
                                d5 = chartdataarray[i].date;
                            }
                        }
                        if (k == "6") {
                            if (value6 == "0") {
                                value6 = chartdataarray[i].value;
                                d6 = chartdataarray[i].date;
                            }
                        }
                        if (k == "7") {
                            if (value7 == "0") {
                                value7 = chartdataarray[i].value;
                                d7 = chartdataarray[i].date;
                            }
                        }
                        tot += parseFloat(chartdataarray[i].value);
                    }
                    else {
                        if (tot != "0") {
                            newparray.push({ 'year': prevparlor, 'income': value1, 'expenses': value2, 'expenses2': value3, 'expenses3': value4, 'expenses4': value5, 'expenses5': value6, 'expenses6': value7, 'd1': d1, 'd2': d2, 'd3': d3, 'd4': d4, 'd5': d5, 'd6': d6, 'd7': d7 });
                            value1 = 0;
                            value2 = 0;
                            value3 = 0;
                            value4 = 0;
                            value5 = 0;
                            value6 = 0;
                            value7 = 0;
                            d1 = "";
                            d2 = "";
                            d3 = "";
                            d4 = "";
                            d5 = "";
                            d6 = "";
                            d7 = "";
                            k = 0;
                            tot = 0;
                        }
                        prevparlor = parlorname;
                        value1 = chartdataarray[i].value;
                        tot += parseFloat(chartdataarray[i].value);
                        d1 = chartdataarray[i].date;
                    }
                }
            }
            newparray.push({ 'year': prevparlor, 'income': value1, 'expenses': value2, 'expenses2': value3, 'expenses3': value4, 'expenses4': value5, 'expenses5': value6, 'expenses6': value7, 'd1': d1, 'd2': d2, 'd3': d3, 'd4': d4, 'd5': d5, 'd6': d6, 'd7': d7 });
            if (newparray.length > 0) {
                var chart = AmCharts.makeChart("chartdiv", {
                    "type": "serial",
                    "theme": "none",
                    "categoryField": "year",
                    "rotate": false,
                    "startDuration": 1,
                    "categoryAxis": {
                        "gridPosition": "start",
                        "position": "left"
                    },
                    "trendLines": [],
                    "graphs": [
    {
        "balloonText": "[[d1]]:[[value]]",
        "fillAlphas": 0.8,
        "id": "AmGraph-1",
        "lineAlpha": 0.2,
        "title": "Income",
        "type": "column",
        "valueField": "income"
    },
    {
        "balloonText": "[[d2]]:[[value]]",
        "fillAlphas": 0.8,
        "id": "AmGraph-2",
        "lineAlpha": 0.2,
        "title": "Expenses",
        "type": "column",
        "valueField": "expenses"
    },
    {
        "balloonText": "[[d3]]:[[value]]",
        "fillAlphas": 0.8,
        "id": "AmGraph-3",
        "lineAlpha": 0.2,
        "title": "Expenses2",
        "type": "column",
        "valueField": "expenses2"
    },
    {
        "balloonText": "[[d4]]:[[value]]",
        "fillAlphas": 0.8,
        "id": "AmGraph-4",
        "lineAlpha": 0.2,
        "title": "Expenses3",
        "type": "column",
        "valueField": "Expenses3"
    },
    {
        "balloonText": "[[d5]]:[[value]]",
        "fillAlphas": 0.8,
        "id": "AmGraph-5",
        "lineAlpha": 0.2,
        "title": "Expenses4",
        "type": "column",
        "valueField": "expenses4"
    },
    {
        "balloonText": "[[d6]]:[[value]]",
        "fillAlphas": 0.8,
        "id": "AmGraph-6",
        "lineAlpha": 0.2,
        "title": "Expenses5",
        "type": "column",
        "valueField": "expenses5"
    },
    {
        "balloonText": "[[d7]]:[[value]]",
        "fillAlphas": 0.8,
        "id": "AmGraph-7",
        "lineAlpha": 0.2,
        "title": "Expenses6",
        "type": "column",
        "valueField": "expenses6"
    }
  ],
                    "guides": [],
                    "valueAxes": [{
                        "id": "ValueAxis-1",
                        "position": "top",
                        "axisAlpha": 0
                    }],
                    "allLabels": [],
                    "balloon": {},
                    "titles": [],
                    "dataProvider": newparray,
                    "export": {
                        "enabled": true
                    }
                });
            }
            // chart code 
        }




    </script>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <div id="chartdiv">
    </div>
</asp:content>
