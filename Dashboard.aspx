<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
    <script src="https://www.amcharts.com/lib/3/serial.js"></script>
    <script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
    <link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css"
        type="text/css" media="all" />
    <script src="https://www.amcharts.com/lib/3/themes/light.js"></script>
    <script src="https://www.amcharts.com/lib/3/pie.js"></script>
    <!-- Chart code -->
    <!-- Chart code -->
    <script>
       
    </script>
    <script type="text/javascript">
        $(function () {
            subcategorywise_hoursalevalue();
            get_saledetails();
            salesanalysis();
            expences();
            purchases();
            subcategorywisesalevalue();
            barchart();
            
        });
        function salesanalysis() {
            var chart = AmCharts.makeChart("chartdiv", {
                "type": "serial",
                "theme": "light",
                "legend": {
                    "equalWidths": false,
                    "useGraphSettings": true,
                    "valueAlign": "left",
                    "valueWidth": 120
                },
                "dataProvider": [{
                    "date": "2012-11-01",
                    "distance": 227,
                    "townName": "New York",
                    "townName2": "New York",
                    "townSize": 25,
                    "latitude": 40.71,
                    "duration": 408
                }, {
                    "date": "2012-11-02",
                    "distance": 371,
                    "townName": "Washington",
                    "townSize": 14,
                    "latitude": 38.89,
                    "duration": 482
                }, {
                    "date": "2012-11-03",
                    "distance": 433,
                    "townName": "Wilmington",
                    "townSize": 6,
                    "latitude": 34.22,
                    "duration": 562
                }, {
                    "date": "2012-11-04",
                    "distance": 345,
                    "townName": "Jacksonville",
                    "townSize": 7,
                    "latitude": 30.35,
                    "duration": 379
                }, {
                    "date": "2012-11-05",
                    "distance": 480,
                    "townName": "Miami",
                    "townName2": "Miami",
                    "townSize": 10,
                    "latitude": 25.83,
                    "duration": 501
                }, {
                    "date": "2012-11-06",
                    "distance": 386,
                    "townName": "Tallahassee",
                    "townSize": 7,
                    "latitude": 30.46,
                    "duration": 443
                }, {
                    "date": "2012-11-07",
                    "distance": 348,
                    "townName": "New Orleans",
                    "townSize": 10,
                    "latitude": 29.94,
                    "duration": 405
                }, {
                    "date": "2012-11-08",
                    "distance": 238,
                    "townName": "Houston",
                    "townName2": "Houston",
                    "townSize": 16,
                    "latitude": 29.76,
                    "duration": 309
                }, {
                    "date": "2012-11-09",
                    "distance": 218,
                    "townName": "Dalas",
                    "townSize": 17,
                    "latitude": 32.8,
                    "duration": 287
                }, {
                    "date": "2012-11-10",
                    "distance": 349,
                    "townName": "Oklahoma City",
                    "townSize": 11,
                    "latitude": 35.49,
                    "duration": 485
                }, {
                    "date": "2012-11-11",
                    "distance": 603,
                    "townName": "Kansas City",
                    "townSize": 10,
                    "latitude": 39.1,
                    "duration": 890
                }, {
                    "date": "2012-11-12",
                    "distance": 534,
                    "townName": "Denver",
                    "townName2": "Denver",
                    "townSize": 18,
                    "latitude": 39.74,
                    "duration": 810
                }, {
                    "date": "2012-11-13",
                    "townName": "Salt Lake City",
                    "townSize": 12,
                    "distance": 425,
                    "duration": 670,
                    "latitude": 40.75,
                    "dashLength": 8,
                    "alpha": 0.4
                }, {
                    "date": "2012-11-14",
                    "latitude": 36.1,
                    "duration": 470,
                    "townName": "Las Vegas",
                    "townName2": "Las Vegas"
                }, {
                    "date": "2012-11-15"
                }, {
                    "date": "2012-11-16"
                }, {
                    "date": "2012-11-17"
                }, {
                    "date": "2012-11-18"
                }, {
                    "date": "2012-11-19"
                }],
                "valueAxes": [{
                    "id": "distanceAxis",
                    "axisAlpha": 0,
                    "gridAlpha": 0,
                    "position": "left",
                    "title": "distance"
                }, {
                    "id": "latitudeAxis",
                    "axisAlpha": 0,
                    "gridAlpha": 0,
                    "labelsEnabled": false,
                    "position": "right"
                }, {
                    "id": "durationAxis",
                    "duration": "mm",
                    "durationUnits": {
                        "hh": "h ",
                        "mm": "min"
                    },
                    "axisAlpha": 0,
                    "gridAlpha": 0,
                    "inside": true,
                    "position": "right",
                    "title": "duration"
                }],
                "graphs": [{
                    "alphaField": "alpha",
                    "balloonText": "[[value]] miles",
                    "dashLengthField": "dashLength",
                    "fillAlphas": 0.7,
                    "legendPeriodValueText": "total: [[value.sum]] mi",
                    "legendValueText": "[[value]] mi",
                    "title": "distance",
                    "type": "column",
                    "valueField": "distance",
                    "valueAxis": "distanceAxis"
                }, {
                    "balloonText": "latitude:[[value]]",
                    "bullet": "round",
                    "bulletBorderAlpha": 1,
                    "useLineColorForBulletBorder": true,
                    "bulletColor": "#FFFFFF",
                    "bulletSizeField": "townSize",
                    "dashLengthField": "dashLength",

                    "labelPosition": "right",

                    "legendValueText": "[[value]]/[[description]]",
                    "title": "latitude/city",
                    "fillAlphas": 0,
                    "valueField": "latitude",
                    "valueAxis": "latitudeAxis"
                }, {
                    "bullet": "square",
                    "bulletBorderAlpha": 1,
                    "bulletBorderThickness": 1,
                    "dashLengthField": "dashLength",
                    "legendValueText": "[[value]]",
                    "title": "duration",
                    "fillAlphas": 0,
                    "valueField": "duration",
                    "valueAxis": "durationAxis"
                }],
                "chartCursor": {
                    "categoryBalloonDateFormat": "DD",
                    "cursorAlpha": 0.1,
                    "cursorColor": "#000000",
                    "fullWidth": true,
                    "valueBalloonsEnabled": false,
                    "zoomable": false
                },
                "dataDateFormat": "YYYY-MM-DD",
                "categoryField": "date",
                "categoryAxis": {
                    "dateFormats": [{
                        "period": "DD",
                        "format": "DD"
                    }, {
                        "period": "WW",
                        "format": "MMM DD"
                    }, {
                        "period": "MM",
                        "format": "MMM"
                    }, {
                        "period": "YYYY",
                        "format": "YYYY"
                    }],
                    "parseDates": true,
                    "autoGridCount": false,
                    "axisColor": "#555555",
                    "gridAlpha": 0.1,
                    "gridColor": "#FFFFFF",
                    "gridCount": 50
                },
                "export": {
                    "enabled": true
                }
            });
        }


        function purchases() {
            var sno = "0";
            var data = { 'op': 'get_dailyinward_details', 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillpurchases(msg);
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

        function fillpurchases(msg) {
            var newparray = [];
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                var subcategoryname = msg[i].subcategoryname;
                var totvalue = msg[i].TotalCost;
                newparray.push({ 'category': subcategoryname, 'totvalue': totvalue});
            }
            var chart = AmCharts.makeChart("divdailypurchase", {
                "type": "pie",
                "theme": "light",
                "dataProvider": newparray,
                "valueField": "totvalue",
                "titleField": "category",
                "balloon": {
                    "fixedPosition": true
                },
                "export": {
                    "enabled": true
                }
            });
        }
        function expences() {
            var chart = AmCharts.makeChart("divexpences", {
                "type": "pie",
                "theme": "light",
                "dataProvider": [{
                    "country": "Lithuania",
                    "litres": 501.9
                }, {
                    "country": "Czech Republic",
                    "litres": 301.9
                }, {
                    "country": "Ireland",
                    "litres": 201.1
                }, {
                    "country": "Germany",
                    "litres": 165.8
                }, {
                    "country": "Australia",
                    "litres": 139.9
                }, {
                    "country": "Austria",
                    "litres": 128.3
                }, {
                    "country": "UK",
                    "litres": 99
                }, {
                    "country": "Belgium",
                    "litres": 60
                }, {
                    "country": "The Netherlands",
                    "litres": 50
                }],
                "valueField": "litres",
                "titleField": "country",
                "balloon": {
                    "fixedPosition": true
                },
                "export": {
                    "enabled": true
                }
            });
        }
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
        function CallHandlerUsingJson(d, s, e) {
            d = JSON.stringify(d);
            d = encodeURIComponent(d);
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
        function get_saledetails() {
            var data = { 'op': 'get_saledetails' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        for (var i = 0; i < msg.length; i++) {
                            document.getElementById('spnsalevalue').innerHTML = msg[i].salevalue;
                            document.getElementById('spnsalevalueprg').innerHTML = msg[i].salevalue;
                            document.getElementById('spnpurchase').innerHTML = msg[i].purchasevalue;
                            document.getElementById('spnpurchaseprg').innerHTML = msg[i].purchasevalue;
                            document.getElementById('spnexpences').innerHTML = msg[i].expencesvalue;
                            document.getElementById('spnexpencesprg').innerHTML = msg[i].expencesvalue;
                            document.getElementById('spnprofitorloss').innerHTML = msg[i].profit;

                            document.getElementById('spnprofitprogress').innerHTML = msg[i].salevalue + '-' + msg[i].purchasevalue + '-' + msg[i].expencesvalue;
                        }
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
        function subcategorywisesalevalue() {
            var sno = "0";
            var data = { 'op': 'get_subcategorywisesalevalue_details', 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        barchart(msg);
                        fillsubcategorywisesale(msg);
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

        function fillsubcategorywisesale(msg) {
            var newYarray = [];
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                var subcategoryname = msg[i].subcategoryname;
                var totvalue = msg[i].totvalue;
                var avgsale = msg[i].Avgsale;
                newYarray.push({ 'category': subcategoryname, 'totvalue': totvalue, 'avgsale': avgsale });
            }

            var chart1 = AmCharts.makeChart("divmarketing", {
                "type": "serial",
                "theme": "light",
                "dataDateFormat": "YYYY-MM-DD",
                "precision": 2,
                "valueAxes": [{
                    "id": "v1",
                    "title": "Sale Value",
                    "position": "left",
                    "autoGridCount": false,
                    "labelFunction": function (value) {
                        return "" + Math.round(value) + "";
                    }
                }, {
                    "id": "v2",
                    "title": "Avg Sale Value",
                    "gridAlpha": 0,
                    "position": "right",
                    "autoGridCount": false
                }],
                "graphs": [{
                    "id": "g4",
                    "valueAxis": "v1",
                    "lineColor": "#62cf73",
                    "fillColors": "#62cf73",
                    "fillAlphas": 1,
                    "type": "column",
                    "title": "Total Value",
                    "valueField": "totvalue",
                    "clustered": false,
                    "columnWidth": 0.3,
                    "legendValueText": "[[value]]",
                    "balloonText": "[[title]]<br/><b style='font-size: 130%'>[[value]]</b>"
                }, {
                    "id": "g1",
                    "valueAxis": "v2",
                    "bullet": "round",
                    "bulletBorderAlpha": 1,
                    "bulletColor": "#FFFFFF",
                    "bulletSize": 5,
                    "hideBulletsCount": 50,
                    "lineThickness": 2,
                    "lineColor": "#20acd4",
                    "type": "smoothedLine",
                    "title": "Avg Salevalue",
                    "useLineColorForBulletBorder": true,
                    "valueField": "avgsale",
                    "balloonText": "[[title]]<br/><b style='font-size: 130%'>[[value]]</b>"
                }],
                "chartScrollbar": {
                    "graph": "g1",
                    "oppositeAxis": false,
                    "offset": 30,
                    "scrollbarHeight": 50,
                    "backgroundAlpha": 0,
                    "selectedBackgroundAlpha": 0.1,
                    "selectedBackgroundColor": "#888888",
                    "graphFillAlpha": 0,
                    "graphLineAlpha": 0.5,
                    "selectedGraphFillAlpha": 0,
                    "selectedGraphLineAlpha": 1,
                    "autoGridCount": true,
                    "color": "#AAAAAA"
                },
                "chartCursor": {
                    "pan": true,
                    "valueLineEnabled": true,
                    "valueLineBalloonEnabled": true,
                    "cursorAlpha": 0,
                    "valueLineAlpha": 0.2
                },
                "categoryField": "category",
                "categoryAxis": {

                    "dashLength": 1,
                    "minorGridEnabled": true
                },
                "legend": {
                    "useGraphSettings": true,
                    "position": "top"
                },
                "balloon": {
                    "borderThickness": 1,
                    "shadowAlpha": 0
                },
                "export": {
                    enabled: true
                },
                dataProvider: newYarray
            });
        }
        function barchart(msg) {
            var newYarray = [];
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                var subcategoryname = msg[i].subcategoryname;
                var totvalue = msg[i].totvalue;
                newYarray.push({ 'category': subcategoryname, 'value': totvalue });
            }

            var chart = AmCharts.makeChart("divhrsale", {
                "type": "serial",
                "theme": "light",
                "dataDateFormat": "YYYY-MM-DD",
                "graphs": [{
                    "id": "g1",
                    "bullet": "round",
                    "bulletBorderAlpha": 1,
                    "bulletColor": "#FFFFFF",
                    "bulletSize": 5,
                    "hideBulletsCount": 50,
                    "lineThickness": 2,
                    "title": "red line",
                    "useLineColorForBulletBorder": true,
                    "valueField": "value"
                }],
                "chartScrollbar": {
                    "graph": "g1",
                    "oppositeAxis": false,
                    "offset": 30,
                    "scrollbarHeight": 80,
                    "backgroundAlpha": 0,
                    "selectedBackgroundAlpha": 0.1,
                    "selectedBackgroundColor": "#888888",
                    "graphFillAlpha": 0,
                    "graphLineAlpha": 0.5,
                    "selectedGraphFillAlpha": 0,
                    "selectedGraphLineAlpha": 1,
                    "autoGridCount": true,
                    "color": "#AAAAAA"
                },
                "chartCursor": {
                    "cursorAlpha": 1,
                    "cursorColor": "#258cbb"
                },
                "categoryField": "category",
                "categoryAxis": {
                    "gridPosition": "start",
                    "dashLength": 1,
                    "minorGridEnabled": true
                },
                "zoomOutOnDataUpdate": false,
                dataProvider: newYarray
            });
        }
        function setSize(size) {
            document.getElementById("chartdiv1").style.width = size;
        }


        function enterAnnotations() {
            chart.export.capture({
                action: "draw"
            }, function () {
                var drawingMenu = chart.export.config.menu[0].menu[2].menu;
                chart.export.createMenu(drawingMenu);
            })
        }

        function setAnnotations() {

            chart.export.setAnnotations({
                data: [{
                    top: 200,
                    left: 200,
                    text: "Manual inserted annotation",
                    type: "text"
                }]
            });
        }
        function subcategorywise_hoursalevalue() {
            var sno = "0";
            var data = { 'op': 'subcategorywise_hoursalevalue', 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillsubcatsale(msg);
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

        function fillsubcatsale(msg) {
            var newxYarray = [];
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                var Hour = msg[i].Hour;
                var subcat1 = msg[i].subcat1;
                var subcat2 = msg[i].subcat2;
                var subcat3 = msg[i].subcat3;
                var subcat4 = msg[i].subcat4;
                var subcat5 = msg[i].subcat5;
                var subcat6 = msg[i].subcat6;
                var subcat7 = msg[i].subcat7;
                var subcat8 = msg[i].subcat8;
                var subcat9 = msg[i].subcat9;
                var subcat10 = msg[i].subcat10;
                var subcat11 = msg[i].subcat11;
                var subcat12 = msg[i].subcat12;
                var subcat13 = msg[i].subcat13;
                var subcat14 = msg[i].subcat14;
                var subcat15 = msg[i].subcat15;
                var subcat16 = msg[i].subcat16;
                var subcat17 = msg[i].subcat17;


                var value1 = msg[i].value1;
                var value2 = msg[i].value2;
                var value3 = msg[i].value3;
                var value4 = msg[i].value4;
                var value5 = msg[i].value5;
                var value6 = msg[i].value6;
                var value7 = msg[i].value7;
                var value8 = msg[i].value8;
                var value9 = msg[i].value9;
                var value10 = msg[i].value10;
                var value11 = msg[i].value11;
                var value12 = msg[i].value12;
                var value13 = msg[i].value13;
                var value14 = msg[i].value14;
                var value15 = msg[i].value15;
                var value16 = msg[i].value16;
                var value17 = msg[i].value17;

                var totvalue = msg[i].totvalue;
                newxYarray.push({ 'Hour': Hour, 'subcat1': subcat1, 'subcat2': subcat2, 'subcat3': subcat3, 'subcat4': subcat4, 'subcat5': subcat5, 'subcat6': subcat6, 'subcat7': subcat7, 'subcat8': subcat8, 'subcat9': subcat9, 'subcat10': subcat10, 'subcat11': subcat11, 'subcat12': subcat12, 'subcat13': subcat13, 'subcat14': subcat14, 'subcat15': subcat15, 'subcat16': subcat16, 'subcat17': subcat17,
                    'value1': value1, 'value2': value2, 'value3': value3, 'value4': value4, 'value5': value5, 'value6': value6, 'value7': value7, 'value8': value8, 'value9': value9, 'value10': value10, 'value11': value11, 'value12': value12, 'value13': value13, 'value14': value14, 'value15': value15, 'value16': value16, 'value17': value17
                });
            }
            var chart = AmCharts.makeChart("div1", {
                "type": "serial",
                "theme": "none",
                "legend": {
                    "autoMargins": false,
                    "borderAlpha": 0.2,
                    "equalWidths": false,
                    "horizontalGap": 10,
                    "markerSize": 10,
                    "useGraphSettings": true,
                    "valueAlign": "left",
                    "valueWidth": 0
                },
                "dataProvider": newxYarray,
                "valueAxes": [{
                    "stackType": "100%",
                    "axisAlpha": 0,
                    "gridAlpha": 0,
                    "labelsEnabled": false,
                    "position": "left"
                }],
                "graphs": [{
                    "balloonText": "[[subcat1]]<br><span style='font-size:14px;'><b>[[value1]]</span>",
                    "fillAlphas": 0.8,
                    "labelText": "[[value1]]",
                    "lineAlpha": 0.3,
                    "title": [[subcat1]],
                    "type": "column",
                    "valueField": "value1"
                }, {
                    "balloonText": "<b>[[subcat2]]</b><br><span style='font-size:14px;'><b>[[value2]]</span>",
                    "fillAlphas": 0.8,
                    "labelText": "[[value2]]",
                    "lineAlpha": 0.3,
                    "title": [[subcat2]],
                    "type": "column",
                    "valueField": "value2"
                }, {
                    "balloonText": "<b>[[subcat3]]</b><br><span style='font-size:14px'>[[value3]]</b></span>",
                    "fillAlphas": 0.8,
                    "labelText": "[[value3]]",
                    "lineAlpha": 0.3,
                    "title": [[subcat3]],
                    "type": "column",
                    "valueField": "value3"
                }, {
                    "balloonText": "<b>[[subcat4]]</b><br><span style='font-size:14px'>[[value4]]</b></span>",
                    "fillAlphas": 0.8,
                    "labelText": "[[value4]]",
                    "lineAlpha": 0.3,
                    "title": [[subcat4]],
                    "type": "column",
                    "valueField": "value4"
                }, {
                    "balloonText": "<b>[[subcat5]]</b><br><span style='font-size:14px'>[[value5]]</b></span>",
                    "fillAlphas": 0.8,
                    "labelText": "[[value5]]",
                    "lineAlpha": 0.3,
                    "title": [[subcat5]],
                    "type": "column",
                    
                    "valueField": "value5"
                }, {
                    "balloonText": "<b>[[subcat6]]</b><br><span style='font-size:14px'>[[value6]]</b></span>",
                    "fillAlphas": 0.8,
                    "labelText": "[[value6]]",
                    "lineAlpha": 0.3,
                    "title": [[subcat6]],
                    "type": "column",
                    
                    "valueField": "value6"
                }, {
                    "balloonText": "<b>[[subcat7]]</b><br><span style='font-size:14px'>[[value7]]</b></span>",
                    "fillAlphas": 0.8,
                    "labelText": "[[value7]]",
                    "lineAlpha": 0.3,
                    "title": [[subcat7]],
                    "type": "column",
                    
                    "valueField": "value7"
                }, {
                    "balloonText": "<b>[[subcat8]]</b><br><span style='font-size:14px'>[[value8]]</b></span>",
                    "fillAlphas": 0.8,
                    "labelText": "[[value8]]",
                    "lineAlpha": 0.3,
                    "title": [[subcat8]],
                    "type": "column",
                    
                    "valueField": "value8"
                }, {
                    "balloonText": "<b>[[subcat9]]</b><br><span style='font-size:14px'>[[value9]]</b></span>",
                    "fillAlphas": 0.8,
                    "labelText": "[[value9]]",
                    "lineAlpha": 0.3,
                    "title": [[subcat9]],
                    "type": "column",
                    
                    "valueField": "value9"
                }, {
                    "balloonText": "<b>[[subcat10]]</b><br><span style='font-size:14px'>[[value10]]</b></span>",
                    "fillAlphas": 0.8,
                    "labelText": "[[value10]]",
                    "lineAlpha": 0.3,
                    "title": [[subcat10]],
                    "type": "column",
                    
                    "valueField": "value10"
                }, {
                    "balloonText": "<b>[[subcat11]]</b><br><span style='font-size:14px'>[[value11]]</b></span>",
                    "fillAlphas": 0.8,
                    "labelText": "[[value11]]",
                    "lineAlpha": 0.3,
                    "title": [[subcat11]],
                    "type": "column",
                    
                    "valueField": "value11"
                }, {
                    "balloonText": "<b>[[subcat12]]</b><br><span style='font-size:14px'>[[value12]]</b></span>",
                    "fillAlphas": 0.8,
                    "labelText": "[[value12]]",
                    "lineAlpha": 0.3,
                    "title": [[subcat12]],
                    "type": "column",
                    
                    "valueField": "value12"
                }, {
                    "balloonText": "<b>[[subcat13]]</b><br><span style='font-size:14px'>[[value13]]</b></span>",
                    "fillAlphas": 0.8,
                    "labelText": "[[value13]]",
                    "lineAlpha": 0.3,
                    "title": [[subcat13]],
                    "type": "column",
                    
                    "valueField": "value13"
                }, {
                    "balloonText": "<b>[[subcat14]]</b><br><span style='font-size:14px'>[[value14]]</b></span>",
                    "fillAlphas": 0.8,
                    "labelText": "[[value14]]",
                    "lineAlpha": 0.3,
                    "title": [[subcat14]],
                    "type": "column",
                    
                    "valueField": "value14"
                }, {
                    "balloonText": "<b>[[subcat15]]</b><br><span style='font-size:14px'>[[value15]]</b></span>",
                    "fillAlphas": 0.8,
                    "labelText": "[[value15]]",
                    "lineAlpha": 0.3,
                    "title": [[subcat15]],
                    "type": "column",
                    
                    "valueField": "value15"
                }, {
                    "balloonText": "<b>[[subcat16]]</b><br><span style='font-size:14px'>[[value16]]</b></span>",
                    "fillAlphas": 0.8,
                    "labelText": "[[value16]]",
                    "lineAlpha": 0.3,
                    "title": [[subcat16]],
                    "type": "column",
                    
                    "valueField": "value16"
                },{
                    "balloonText": "<b>[[subcat17]]</b><br><span style='font-size:14px'>[[value17]]</b></span>",
                    "fillAlphas": 0.8,
                    "labelText": "[[value17]]",
                    "lineAlpha": 0.3,
                    "title": [[subcat17]],
                    "type": "column",
                    
                    "valueField": "value17"
                }],
                "marginTop": 30,
                "marginRight": 0,
                "marginLeft": 0,
                "marginBottom": 40,
                "autoMargins": false,
                "categoryField": "Hour",
                "categoryAxis": {
                    "gridPosition": "start",
                    "axisAlpha": 0,
                    "gridAlpha": 0
                },
                "export": {
                    "enabled": true
                }

            });
        }

        function getAnnotations() {

            window.AmCharts.cachedAnnotations = chart.export.getAnnotations({}, function (items) {
                alert("Cached " + items.length + " annotations!\nReenter the annotation mode to repply the cached annotations!");
                console.log("Cached items: ", items);
            });
        }

        function applyAnnotations() {
            if (!window.AmCharts.cachedAnnotations || !window.AmCharts.cachedAnnotations.length) {
                alert("No cached annotations available!");
                return;
            }
            chart.export.setAnnotations({
                data: window.AmCharts.cachedAnnotations
            });
        }
    </script>

    <script type="text/javascript">
        
</script>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        $('body').addClass('skin-green sidebar-collapse sidebar-mini pos');
    </script>
    <div class="box-body">
        <div class="col-sm-12">
            <div class="row">
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box bg-aqua">
                        <span class="info-box-icon"><i class="fa fa-shopping-cart" style="line-height: 2 !important;"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text">Sales Value</span> <span class="info-box-number" id="spnsalevalue">0</span>
                            <div class="progress">
                                <div style="width: 100%" class="progress-bar">
                                </div>
                            </div>
                            <span class="progress-description" id="spnsalevalueprg">0</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box bg-yellow">
                        <span class="info-box-icon"><i class="fa fa-plus"  style="line-height: 2 !important;"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text">Purchases Value</span> <span class="info-box-number" id="spnpurchase">0.00</span>
                            <div class="progress">
                                <div style="width: 0%" class="progress-bar">
                                </div>
                            </div>
                            <span class="progress-description" id="spnpurchaseprg">0 </span>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box bg-red">
                        <span class="info-box-icon"><i class="fa fa-circle-o"  style="line-height: 2 !important;"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text">Expenses Value</span> <span class="info-box-number" id="spnexpences">0.00</span> 
                            <div class="progress">
                                <div style="width: 0%" class="progress-bar">
                                </div>
                            </div>
                            <span class="progress-description" id="spnexpencesprg">0</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box bg-green">
                        <span class="info-box-icon"><i class="fa fa-dollar"  style="line-height: 2 !important;"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text">Profit and/or Loss</span> <span class="info-box-number" id="spnprofitorloss">0</span>
                            <div class="progress">
                                <div style="width: 100%" class="progress-bar">
                                </div>
                            </div>
                            <span class="progress-description" id="spnprofitprogress">0</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix">
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="box box-primary">
                                <div class="box-header">
                                    <h3 class="box-title">
                                        Category Sale Value (today) </h3>
                                </div>
                                <div class="box-body">
                                    <div id="divmarketing" style="height: 300px;">
                                    </div>
                                    <%--<div id="chart" style="height:300px;" data-highcharts-chart="0"><div class="highcharts-container" id="highcharts-0" style="position: relative; overflow: hidden; width: 692px; height: 300px; text-align: left; line-height: normal; z-index: 0; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"><svg version="1.1" style="font-family:&quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif;font-size:12px;" xmlns="http://www.w3.org/2000/svg" width="692" height="300"><desc>Created with Highcharts 4.1.6</desc><defs><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-1"><stop offset="0" stop-color="#7cb5ec" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(48,105,160)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-2"><stop offset="0" stop-color="#434348" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(0,0,0)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-3"><stop offset="0" stop-color="#90ed7d" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(68,161,49)" stop-opacity="1"></stop></radialGradient><clipPath id="highcharts-4"><rect x="0" y="0" width="636" height="209"></rect></clipPath><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-13"><stop offset="0" stop-color="rgb(149,206,255)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(73,130,185)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-14"><stop offset="0" stop-color="rgb(92,92,97)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(25,25,25)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-15"><stop offset="0" stop-color="rgb(169,255,150)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(93,186,74)" stop-opacity="1"></stop></radialGradient></defs><rect x="0" y="0" width="692" height="300" strokeWidth="0" fill="#FFFFFF" class=" highcharts-background"></rect><g class="highcharts-grid" zIndex="1"></g><g class="highcharts-grid" zIndex="1"><path fill="none" d="M 46 219.5 L 682 219.5" stroke="#D8D8D8" stroke-width="1" zIndex="1" opacity="1"></path><path fill="none" d="M 46 149.5 L 682 149.5" stroke="#D8D8D8" stroke-width="1" zIndex="1" opacity="1"></path><path fill="none" d="M 46 80.5 L 682 80.5" stroke="#D8D8D8" stroke-width="1" zIndex="1" opacity="1"></path><path fill="none" d="M 46 9.5 L 682 9.5" stroke="#D8D8D8" stroke-width="1" zIndex="1" opacity="1"></path></g><g class="highcharts-axis" zIndex="2"><path fill="none" d="M 682.5 219 L 682.5 229" stroke="#C0D0E0" stroke-width="1" opacity="1"></path><path fill="none" d="M 45.5 219 L 45.5 229" stroke="#C0D0E0" stroke-width="1" opacity="1"></path><path fill="none" d="M 46 219.5 L 682 219.5" stroke="#C0D0E0" stroke-width="1" zIndex="7" visibility="visible"></path></g><g class="highcharts-axis" zIndex="2"></g><g class="highcharts-series-group" zIndex="3"><g class="highcharts-series highcharts-tracker" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" style="" clip-path="url(#highcharts-4)"><rect x="164.5" y="11.5" width="306" height="10" stroke="#FFFFFF" stroke-width="1" fill="url(#highcharts-1)" rx="0" ry="0"></rect></g><g class="highcharts-markers" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" clip-path="none"></g><g class="highcharts-series highcharts-tracker" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" style="" clip-path="url(#highcharts-4)"><rect x="164.5" y="21.5" width="306" height="0" stroke="#FFFFFF" stroke-width="1" fill="url(#highcharts-2)" rx="0" ry="0"></rect></g><g class="highcharts-markers" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" clip-path="none"></g><g class="highcharts-series highcharts-tracker" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" style="" clip-path="url(#highcharts-4)"><rect x="164.5" y="21.5" width="306" height="188" stroke="#FFFFFF" stroke-width="1" fill="url(#highcharts-3)" rx="0" ry="0"></rect></g><g class="highcharts-markers" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" clip-path="none"></g></g><g class="highcharts-legend" zIndex="7" transform="translate(231,256)"><g zIndex="1"><g><g class="highcharts-legend-item" zIndex="1" transform="translate(8,3)"><text x="21" style="color:#333333;font-size:12px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start" zIndex="2" y="15">Tax</text><rect x="0" y="4" width="16" height="12" zIndex="3" fill="url(#highcharts-1)"></rect></g><g class="highcharts-legend-item" zIndex="1" transform="translate(73.6875,3)"><text x="21" y="15" style="color:#333333;font-size:12px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start" zIndex="2">Discount</text><rect x="0" y="4" width="16" height="12" zIndex="3" fill="url(#highcharts-2)"></rect></g><g class="highcharts-legend-item" zIndex="1" transform="translate(169.34375,3)"><text x="21" y="15" style="color:#333333;font-size:12px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start" zIndex="2">Sales</text><rect x="0" y="4" width="16" height="12" zIndex="3" fill="url(#highcharts-3)"></rect></g></g></g></g><g class="highcharts-axis-labels highcharts-xaxis-labels" zIndex="7"><text x="364" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:662px;text-overflow:clip;" text-anchor="middle" transform="translate(0,0)" y="238" opacity="1">Oct-2018</text></g><g class="highcharts-axis-labels highcharts-yaxis-labels" zIndex="7"><text x="31" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:218px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="222" opacity="1">0</text><text x="31" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:218px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="152" opacity="1">50</text><text x="31" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:218px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="82" opacity="1">100</text><text x="31" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:218px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="13" opacity="1">150</text></g><g class="highcharts-tooltip" zIndex="8" style="cursor:default;padding:0;white-space:nowrap;" transform="translate(493,-9999)" opacity="0"><path fill="rgba(249, 249, 249, .85)" d="M 3 0 L 131 0 C 134 0 134 0 134 3 L 134 125 C 134 128 134 128 131 128 L 3 128 C 0 128 0 128 0 125 L 0 3 C 0 0 0 0 3 0"></path></g></svg><div class="highcharts-tooltip" style="position: absolute; left: 493px; top: -9999px; visibility: visible;"><span style="position: absolute; font-family: &quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif; font-size: 14px; white-space: nowrap; color: rgb(0, 0, 0); margin-left: 0px; margin-top: 0px; left: 0px; top: 0px;" zindex="1"><div class="well well-sm" style="margin-bottom:0;"><span style="font-size:12px">Oct-2018</span><table class="table table-striped" style="margin-bottom:0;"><tbody><tr><td style="color:[object Object];padding:4px">Tax: </td><td style="color:[object Object];padding:4px;text-align:right;"> <b>6.75</b></td></tr><tr><td style="color:[object Object];padding:4px">Discount: </td><td style="color:[object Object];padding:4px;text-align:right;"> <b>0</b></td></tr><tr><td style="color:[object Object];padding:4px">Sales: </td><td style="color:[object Object];padding:4px;text-align:right;"> <b>135</b></td></tr></tbody></table></div></span></div></div></div>--%>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="box box-primary">
                                <div class="box-header">
                                    <h3 class="box-title">
                                        Hour Wise Sale Value (Yesterday)</h3>
                                </div>
                                <div class="box-body">
                                    <div id="div1" style="height: 500px;">
                                    </div>
                                    <%--<div id="chart" style="height:300px;" data-highcharts-chart="0"><div class="highcharts-container" id="highcharts-0" style="position: relative; overflow: hidden; width: 692px; height: 300px; text-align: left; line-height: normal; z-index: 0; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"><svg version="1.1" style="font-family:&quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif;font-size:12px;" xmlns="http://www.w3.org/2000/svg" width="692" height="300"><desc>Created with Highcharts 4.1.6</desc><defs><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-1"><stop offset="0" stop-color="#7cb5ec" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(48,105,160)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-2"><stop offset="0" stop-color="#434348" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(0,0,0)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-3"><stop offset="0" stop-color="#90ed7d" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(68,161,49)" stop-opacity="1"></stop></radialGradient><clipPath id="highcharts-4"><rect x="0" y="0" width="636" height="209"></rect></clipPath><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-13"><stop offset="0" stop-color="rgb(149,206,255)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(73,130,185)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-14"><stop offset="0" stop-color="rgb(92,92,97)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(25,25,25)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-15"><stop offset="0" stop-color="rgb(169,255,150)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(93,186,74)" stop-opacity="1"></stop></radialGradient></defs><rect x="0" y="0" width="692" height="300" strokeWidth="0" fill="#FFFFFF" class=" highcharts-background"></rect><g class="highcharts-grid" zIndex="1"></g><g class="highcharts-grid" zIndex="1"><path fill="none" d="M 46 219.5 L 682 219.5" stroke="#D8D8D8" stroke-width="1" zIndex="1" opacity="1"></path><path fill="none" d="M 46 149.5 L 682 149.5" stroke="#D8D8D8" stroke-width="1" zIndex="1" opacity="1"></path><path fill="none" d="M 46 80.5 L 682 80.5" stroke="#D8D8D8" stroke-width="1" zIndex="1" opacity="1"></path><path fill="none" d="M 46 9.5 L 682 9.5" stroke="#D8D8D8" stroke-width="1" zIndex="1" opacity="1"></path></g><g class="highcharts-axis" zIndex="2"><path fill="none" d="M 682.5 219 L 682.5 229" stroke="#C0D0E0" stroke-width="1" opacity="1"></path><path fill="none" d="M 45.5 219 L 45.5 229" stroke="#C0D0E0" stroke-width="1" opacity="1"></path><path fill="none" d="M 46 219.5 L 682 219.5" stroke="#C0D0E0" stroke-width="1" zIndex="7" visibility="visible"></path></g><g class="highcharts-axis" zIndex="2"></g><g class="highcharts-series-group" zIndex="3"><g class="highcharts-series highcharts-tracker" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" style="" clip-path="url(#highcharts-4)"><rect x="164.5" y="11.5" width="306" height="10" stroke="#FFFFFF" stroke-width="1" fill="url(#highcharts-1)" rx="0" ry="0"></rect></g><g class="highcharts-markers" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" clip-path="none"></g><g class="highcharts-series highcharts-tracker" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" style="" clip-path="url(#highcharts-4)"><rect x="164.5" y="21.5" width="306" height="0" stroke="#FFFFFF" stroke-width="1" fill="url(#highcharts-2)" rx="0" ry="0"></rect></g><g class="highcharts-markers" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" clip-path="none"></g><g class="highcharts-series highcharts-tracker" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" style="" clip-path="url(#highcharts-4)"><rect x="164.5" y="21.5" width="306" height="188" stroke="#FFFFFF" stroke-width="1" fill="url(#highcharts-3)" rx="0" ry="0"></rect></g><g class="highcharts-markers" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" clip-path="none"></g></g><g class="highcharts-legend" zIndex="7" transform="translate(231,256)"><g zIndex="1"><g><g class="highcharts-legend-item" zIndex="1" transform="translate(8,3)"><text x="21" style="color:#333333;font-size:12px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start" zIndex="2" y="15">Tax</text><rect x="0" y="4" width="16" height="12" zIndex="3" fill="url(#highcharts-1)"></rect></g><g class="highcharts-legend-item" zIndex="1" transform="translate(73.6875,3)"><text x="21" y="15" style="color:#333333;font-size:12px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start" zIndex="2">Discount</text><rect x="0" y="4" width="16" height="12" zIndex="3" fill="url(#highcharts-2)"></rect></g><g class="highcharts-legend-item" zIndex="1" transform="translate(169.34375,3)"><text x="21" y="15" style="color:#333333;font-size:12px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start" zIndex="2">Sales</text><rect x="0" y="4" width="16" height="12" zIndex="3" fill="url(#highcharts-3)"></rect></g></g></g></g><g class="highcharts-axis-labels highcharts-xaxis-labels" zIndex="7"><text x="364" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:662px;text-overflow:clip;" text-anchor="middle" transform="translate(0,0)" y="238" opacity="1">Oct-2018</text></g><g class="highcharts-axis-labels highcharts-yaxis-labels" zIndex="7"><text x="31" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:218px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="222" opacity="1">0</text><text x="31" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:218px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="152" opacity="1">50</text><text x="31" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:218px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="82" opacity="1">100</text><text x="31" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:218px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="13" opacity="1">150</text></g><g class="highcharts-tooltip" zIndex="8" style="cursor:default;padding:0;white-space:nowrap;" transform="translate(493,-9999)" opacity="0"><path fill="rgba(249, 249, 249, .85)" d="M 3 0 L 131 0 C 134 0 134 0 134 3 L 134 125 C 134 128 134 128 131 128 L 3 128 C 0 128 0 128 0 125 L 0 3 C 0 0 0 0 3 0"></path></g></svg><div class="highcharts-tooltip" style="position: absolute; left: 493px; top: -9999px; visibility: visible;"><span style="position: absolute; font-family: &quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif; font-size: 14px; white-space: nowrap; color: rgb(0, 0, 0); margin-left: 0px; margin-top: 0px; left: 0px; top: 0px;" zindex="1"><div class="well well-sm" style="margin-bottom:0;"><span style="font-size:12px">Oct-2018</span><table class="table table-striped" style="margin-bottom:0;"><tbody><tr><td style="color:[object Object];padding:4px">Tax: </td><td style="color:[object Object];padding:4px;text-align:right;"> <b>6.75</b></td></tr><tr><td style="color:[object Object];padding:4px">Discount: </td><td style="color:[object Object];padding:4px;text-align:right;"> <b>0</b></td></tr><tr><td style="color:[object Object];padding:4px">Sales: </td><td style="color:[object Object];padding:4px;text-align:right;"> <b>135</b></td></tr></tbody></table></div></span></div></div></div>--%>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="box box-success">
                                <div class="box-header">
                                    <h3 class="box-title">
                                         Inward Details</h3>
                                </div>
                                <div class="box-body">
                                    <div id="divdailypurchase" style="width: 100%; height: 300px;">
                                    </div>
                                    <%--<div id="chart2" style="height:300px;" data-highcharts-chart="1"><div class="highcharts-container" id="highcharts-5" style="position: relative; overflow: hidden; width: 321px; height: 300px; text-align: left; line-height: normal; z-index: 0; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"><svg version="1.1" style="font-family:&quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif;font-size:12px;" xmlns="http://www.w3.org/2000/svg" width="321" height="300"><desc>Created with Highcharts 4.1.6</desc><defs><clipPath id="highcharts-6"><rect x="0" y="0" width="301" height="275"></rect></clipPath><radialGradient cx="150.5" cy="86.5" r="178.5" id="highcharts-7" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#7cb5ec" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(48,105,160)" stop-opacity="1"></stop></radialGradient><radialGradient cx="150.5" cy="86.5" r="178.5" id="highcharts-8" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#434348" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(0,0,0)" stop-opacity="1"></stop></radialGradient><radialGradient cx="150.5" cy="86.5" r="178.5" id="highcharts-16" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="rgb(149,206,255)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(73,130,185)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-17"><stop offset="0" stop-color="rgb(124,181,236)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(48,105,160)" stop-opacity="1"></stop></radialGradient></defs><rect x="0" y="0" width="321" height="300" strokeWidth="0" fill="#FFFFFF" class=" highcharts-background"></rect><g class="highcharts-series-group" zIndex="3"><path fill="url(#highcharts-17)" d="M 0 0"></path><g class="highcharts-series highcharts-tracker" visibility="visible" zIndex="0.1" transform="translate(10,10) scale(1 1)" style="cursor:pointer;"><path fill="url(#highcharts-7)" d="M 150.47403166652887 10.000002644526859 A 127.5 127.5 0 1 1 106.99574606822634 257.34836206573607 L 150.5 137.5 A 0 0 0 1 0 150.5 137.5 Z" stroke="#FFFFFF" stroke-width="1" stroke-linejoin="round" transform="translate(0,0)"></path><path fill="url(#highcharts-8)" d="M 106.87591947826049 257.3047978948789 A 127.5 127.5 0 0 1 150.32290505789587 10.000122990720172 L 150.5 137.5 A 0 0 0 0 0 150.5 137.5 Z" stroke="#FFFFFF" stroke-width="1" stroke-linejoin="round" transform="translate(0,0)"></path></g><g class="highcharts-markers" visibility="visible" zIndex="0.1" transform="translate(10,10) scale(1 1)"></g></g><g class="highcharts-legend" zIndex="7"><g zIndex="1"><g></g></g></g><g class="highcharts-tooltip" zIndex="8" style="cursor:default;padding:0;white-space:nowrap;" transform="translate(68,-9999)" opacity="0"><path fill="rgba(249, 249, 249, .85)" d="M 3 0 L 153 0 C 156 0 156 0 156 3 L 156 67 C 156 70 156 70 153 70 L 3 70 C 0 70 0 70 0 67 L 0 3 C 0 0 0 0 3 0"></path></g></svg><div class="highcharts-tooltip" style="position: absolute; left: 68px; top: -9999px; visibility: visible;"><span style="position: absolute; font-family: &quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif; font-size: 14px; white-space: nowrap; color: rgb(0, 0, 0); margin-left: 0px; margin-top: 0px; left: 0px; top: 0px;" zindex="1"><div class="well well-sm" style="margin-bottom:0;"><span style="font-size:12px">Minion Banana (TOY02)</span><table class="table table-striped" style="margin-bottom:0;"><tbody><tr><td style="color:;padding:4px">Total Sold: </td><td style="color:;padding:4px;text-align:right;"> <b>5</b></td></tr></tbody></table></div></span></div></div></div>--%>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="box box-danger">
                                <div class="box-header">
                                    <h3 class="box-title">
                                         Expences Details</h3>
                                </div>
                                <div class="box-body">
                                    <div id="divexpences" style="width: 100%; height: 300px;">
                                    </div>
                                    <%--<div id="chart2" style="height:300px;" data-highcharts-chart="1"><div class="highcharts-container" id="highcharts-5" style="position: relative; overflow: hidden; width: 321px; height: 300px; text-align: left; line-height: normal; z-index: 0; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"><svg version="1.1" style="font-family:&quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif;font-size:12px;" xmlns="http://www.w3.org/2000/svg" width="321" height="300"><desc>Created with Highcharts 4.1.6</desc><defs><clipPath id="highcharts-6"><rect x="0" y="0" width="301" height="275"></rect></clipPath><radialGradient cx="150.5" cy="86.5" r="178.5" id="highcharts-7" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#7cb5ec" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(48,105,160)" stop-opacity="1"></stop></radialGradient><radialGradient cx="150.5" cy="86.5" r="178.5" id="highcharts-8" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#434348" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(0,0,0)" stop-opacity="1"></stop></radialGradient><radialGradient cx="150.5" cy="86.5" r="178.5" id="highcharts-16" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="rgb(149,206,255)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(73,130,185)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-17"><stop offset="0" stop-color="rgb(124,181,236)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(48,105,160)" stop-opacity="1"></stop></radialGradient></defs><rect x="0" y="0" width="321" height="300" strokeWidth="0" fill="#FFFFFF" class=" highcharts-background"></rect><g class="highcharts-series-group" zIndex="3"><path fill="url(#highcharts-17)" d="M 0 0"></path><g class="highcharts-series highcharts-tracker" visibility="visible" zIndex="0.1" transform="translate(10,10) scale(1 1)" style="cursor:pointer;"><path fill="url(#highcharts-7)" d="M 150.47403166652887 10.000002644526859 A 127.5 127.5 0 1 1 106.99574606822634 257.34836206573607 L 150.5 137.5 A 0 0 0 1 0 150.5 137.5 Z" stroke="#FFFFFF" stroke-width="1" stroke-linejoin="round" transform="translate(0,0)"></path><path fill="url(#highcharts-8)" d="M 106.87591947826049 257.3047978948789 A 127.5 127.5 0 0 1 150.32290505789587 10.000122990720172 L 150.5 137.5 A 0 0 0 0 0 150.5 137.5 Z" stroke="#FFFFFF" stroke-width="1" stroke-linejoin="round" transform="translate(0,0)"></path></g><g class="highcharts-markers" visibility="visible" zIndex="0.1" transform="translate(10,10) scale(1 1)"></g></g><g class="highcharts-legend" zIndex="7"><g zIndex="1"><g></g></g></g><g class="highcharts-tooltip" zIndex="8" style="cursor:default;padding:0;white-space:nowrap;" transform="translate(68,-9999)" opacity="0"><path fill="rgba(249, 249, 249, .85)" d="M 3 0 L 153 0 C 156 0 156 0 156 3 L 156 67 C 156 70 156 70 153 70 L 3 70 C 0 70 0 70 0 67 L 0 3 C 0 0 0 0 3 0"></path></g></svg><div class="highcharts-tooltip" style="position: absolute; left: 68px; top: -9999px; visibility: visible;"><span style="position: absolute; font-family: &quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif; font-size: 14px; white-space: nowrap; color: rgb(0, 0, 0); margin-left: 0px; margin-top: 0px; left: 0px; top: 0px;" zindex="1"><div class="well well-sm" style="margin-bottom:0;"><span style="font-size:12px">Minion Banana (TOY02)</span><table class="table table-striped" style="margin-bottom:0;"><tbody><tr><td style="color:;padding:4px">Total Sold: </td><td style="color:;padding:4px;text-align:right;"> <b>5</b></td></tr></tbody></table></div></span></div></div></div>--%>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-12">
                            <div class="box box-primary">
                                <div class="box-header">
                                    <h3 class="box-title">
                                        Category Sale Value</h3>
                                </div>
                                <div class="box-body">
                                    <div id="divhrsale" style="height: 300px;">
                                    </div>
                                    <%--<div id="chart" style="height:300px;" data-highcharts-chart="0"><div class="highcharts-container" id="highcharts-0" style="position: relative; overflow: hidden; width: 692px; height: 300px; text-align: left; line-height: normal; z-index: 0; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"><svg version="1.1" style="font-family:&quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif;font-size:12px;" xmlns="http://www.w3.org/2000/svg" width="692" height="300"><desc>Created with Highcharts 4.1.6</desc><defs><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-1"><stop offset="0" stop-color="#7cb5ec" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(48,105,160)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-2"><stop offset="0" stop-color="#434348" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(0,0,0)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-3"><stop offset="0" stop-color="#90ed7d" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(68,161,49)" stop-opacity="1"></stop></radialGradient><clipPath id="highcharts-4"><rect x="0" y="0" width="636" height="209"></rect></clipPath><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-13"><stop offset="0" stop-color="rgb(149,206,255)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(73,130,185)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-14"><stop offset="0" stop-color="rgb(92,92,97)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(25,25,25)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-15"><stop offset="0" stop-color="rgb(169,255,150)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(93,186,74)" stop-opacity="1"></stop></radialGradient></defs><rect x="0" y="0" width="692" height="300" strokeWidth="0" fill="#FFFFFF" class=" highcharts-background"></rect><g class="highcharts-grid" zIndex="1"></g><g class="highcharts-grid" zIndex="1"><path fill="none" d="M 46 219.5 L 682 219.5" stroke="#D8D8D8" stroke-width="1" zIndex="1" opacity="1"></path><path fill="none" d="M 46 149.5 L 682 149.5" stroke="#D8D8D8" stroke-width="1" zIndex="1" opacity="1"></path><path fill="none" d="M 46 80.5 L 682 80.5" stroke="#D8D8D8" stroke-width="1" zIndex="1" opacity="1"></path><path fill="none" d="M 46 9.5 L 682 9.5" stroke="#D8D8D8" stroke-width="1" zIndex="1" opacity="1"></path></g><g class="highcharts-axis" zIndex="2"><path fill="none" d="M 682.5 219 L 682.5 229" stroke="#C0D0E0" stroke-width="1" opacity="1"></path><path fill="none" d="M 45.5 219 L 45.5 229" stroke="#C0D0E0" stroke-width="1" opacity="1"></path><path fill="none" d="M 46 219.5 L 682 219.5" stroke="#C0D0E0" stroke-width="1" zIndex="7" visibility="visible"></path></g><g class="highcharts-axis" zIndex="2"></g><g class="highcharts-series-group" zIndex="3"><g class="highcharts-series highcharts-tracker" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" style="" clip-path="url(#highcharts-4)"><rect x="164.5" y="11.5" width="306" height="10" stroke="#FFFFFF" stroke-width="1" fill="url(#highcharts-1)" rx="0" ry="0"></rect></g><g class="highcharts-markers" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" clip-path="none"></g><g class="highcharts-series highcharts-tracker" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" style="" clip-path="url(#highcharts-4)"><rect x="164.5" y="21.5" width="306" height="0" stroke="#FFFFFF" stroke-width="1" fill="url(#highcharts-2)" rx="0" ry="0"></rect></g><g class="highcharts-markers" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" clip-path="none"></g><g class="highcharts-series highcharts-tracker" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" style="" clip-path="url(#highcharts-4)"><rect x="164.5" y="21.5" width="306" height="188" stroke="#FFFFFF" stroke-width="1" fill="url(#highcharts-3)" rx="0" ry="0"></rect></g><g class="highcharts-markers" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" clip-path="none"></g></g><g class="highcharts-legend" zIndex="7" transform="translate(231,256)"><g zIndex="1"><g><g class="highcharts-legend-item" zIndex="1" transform="translate(8,3)"><text x="21" style="color:#333333;font-size:12px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start" zIndex="2" y="15">Tax</text><rect x="0" y="4" width="16" height="12" zIndex="3" fill="url(#highcharts-1)"></rect></g><g class="highcharts-legend-item" zIndex="1" transform="translate(73.6875,3)"><text x="21" y="15" style="color:#333333;font-size:12px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start" zIndex="2">Discount</text><rect x="0" y="4" width="16" height="12" zIndex="3" fill="url(#highcharts-2)"></rect></g><g class="highcharts-legend-item" zIndex="1" transform="translate(169.34375,3)"><text x="21" y="15" style="color:#333333;font-size:12px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start" zIndex="2">Sales</text><rect x="0" y="4" width="16" height="12" zIndex="3" fill="url(#highcharts-3)"></rect></g></g></g></g><g class="highcharts-axis-labels highcharts-xaxis-labels" zIndex="7"><text x="364" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:662px;text-overflow:clip;" text-anchor="middle" transform="translate(0,0)" y="238" opacity="1">Oct-2018</text></g><g class="highcharts-axis-labels highcharts-yaxis-labels" zIndex="7"><text x="31" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:218px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="222" opacity="1">0</text><text x="31" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:218px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="152" opacity="1">50</text><text x="31" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:218px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="82" opacity="1">100</text><text x="31" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:218px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="13" opacity="1">150</text></g><g class="highcharts-tooltip" zIndex="8" style="cursor:default;padding:0;white-space:nowrap;" transform="translate(493,-9999)" opacity="0"><path fill="rgba(249, 249, 249, .85)" d="M 3 0 L 131 0 C 134 0 134 0 134 3 L 134 125 C 134 128 134 128 131 128 L 3 128 C 0 128 0 128 0 125 L 0 3 C 0 0 0 0 3 0"></path></g></svg><div class="highcharts-tooltip" style="position: absolute; left: 493px; top: -9999px; visibility: visible;"><span style="position: absolute; font-family: &quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif; font-size: 14px; white-space: nowrap; color: rgb(0, 0, 0); margin-left: 0px; margin-top: 0px; left: 0px; top: 0px;" zindex="1"><div class="well well-sm" style="margin-bottom:0;"><span style="font-size:12px">Oct-2018</span><table class="table table-striped" style="margin-bottom:0;"><tbody><tr><td style="color:[object Object];padding:4px">Tax: </td><td style="color:[object Object];padding:4px;text-align:right;"> <b>6.75</b></td></tr><tr><td style="color:[object Object];padding:4px">Discount: </td><td style="color:[object Object];padding:4px;text-align:right;"> <b>0</b></td></tr><tr><td style="color:[object Object];padding:4px">Sales: </td><td style="color:[object Object];padding:4px;text-align:right;"> <b>135</b></td></tr></tbody></table></div></span></div></div></div>--%>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="box box-primary">
                                <div class="box-header">
                                    <h3 class="box-title">
                                        Category Sale Value</h3>
                                </div>
                                <div class="box-body">
                                    <div id="chartdiv" style="height: 300px;">
                                    </div>
                                    <%--<div id="chart" style="height:300px;" data-highcharts-chart="0"><div class="highcharts-container" id="highcharts-0" style="position: relative; overflow: hidden; width: 692px; height: 300px; text-align: left; line-height: normal; z-index: 0; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"><svg version="1.1" style="font-family:&quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif;font-size:12px;" xmlns="http://www.w3.org/2000/svg" width="692" height="300"><desc>Created with Highcharts 4.1.6</desc><defs><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-1"><stop offset="0" stop-color="#7cb5ec" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(48,105,160)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-2"><stop offset="0" stop-color="#434348" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(0,0,0)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-3"><stop offset="0" stop-color="#90ed7d" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(68,161,49)" stop-opacity="1"></stop></radialGradient><clipPath id="highcharts-4"><rect x="0" y="0" width="636" height="209"></rect></clipPath><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-13"><stop offset="0" stop-color="rgb(149,206,255)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(73,130,185)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-14"><stop offset="0" stop-color="rgb(92,92,97)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(25,25,25)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-15"><stop offset="0" stop-color="rgb(169,255,150)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(93,186,74)" stop-opacity="1"></stop></radialGradient></defs><rect x="0" y="0" width="692" height="300" strokeWidth="0" fill="#FFFFFF" class=" highcharts-background"></rect><g class="highcharts-grid" zIndex="1"></g><g class="highcharts-grid" zIndex="1"><path fill="none" d="M 46 219.5 L 682 219.5" stroke="#D8D8D8" stroke-width="1" zIndex="1" opacity="1"></path><path fill="none" d="M 46 149.5 L 682 149.5" stroke="#D8D8D8" stroke-width="1" zIndex="1" opacity="1"></path><path fill="none" d="M 46 80.5 L 682 80.5" stroke="#D8D8D8" stroke-width="1" zIndex="1" opacity="1"></path><path fill="none" d="M 46 9.5 L 682 9.5" stroke="#D8D8D8" stroke-width="1" zIndex="1" opacity="1"></path></g><g class="highcharts-axis" zIndex="2"><path fill="none" d="M 682.5 219 L 682.5 229" stroke="#C0D0E0" stroke-width="1" opacity="1"></path><path fill="none" d="M 45.5 219 L 45.5 229" stroke="#C0D0E0" stroke-width="1" opacity="1"></path><path fill="none" d="M 46 219.5 L 682 219.5" stroke="#C0D0E0" stroke-width="1" zIndex="7" visibility="visible"></path></g><g class="highcharts-axis" zIndex="2"></g><g class="highcharts-series-group" zIndex="3"><g class="highcharts-series highcharts-tracker" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" style="" clip-path="url(#highcharts-4)"><rect x="164.5" y="11.5" width="306" height="10" stroke="#FFFFFF" stroke-width="1" fill="url(#highcharts-1)" rx="0" ry="0"></rect></g><g class="highcharts-markers" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" clip-path="none"></g><g class="highcharts-series highcharts-tracker" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" style="" clip-path="url(#highcharts-4)"><rect x="164.5" y="21.5" width="306" height="0" stroke="#FFFFFF" stroke-width="1" fill="url(#highcharts-2)" rx="0" ry="0"></rect></g><g class="highcharts-markers" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" clip-path="none"></g><g class="highcharts-series highcharts-tracker" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" style="" clip-path="url(#highcharts-4)"><rect x="164.5" y="21.5" width="306" height="188" stroke="#FFFFFF" stroke-width="1" fill="url(#highcharts-3)" rx="0" ry="0"></rect></g><g class="highcharts-markers" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" clip-path="none"></g></g><g class="highcharts-legend" zIndex="7" transform="translate(231,256)"><g zIndex="1"><g><g class="highcharts-legend-item" zIndex="1" transform="translate(8,3)"><text x="21" style="color:#333333;font-size:12px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start" zIndex="2" y="15">Tax</text><rect x="0" y="4" width="16" height="12" zIndex="3" fill="url(#highcharts-1)"></rect></g><g class="highcharts-legend-item" zIndex="1" transform="translate(73.6875,3)"><text x="21" y="15" style="color:#333333;font-size:12px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start" zIndex="2">Discount</text><rect x="0" y="4" width="16" height="12" zIndex="3" fill="url(#highcharts-2)"></rect></g><g class="highcharts-legend-item" zIndex="1" transform="translate(169.34375,3)"><text x="21" y="15" style="color:#333333;font-size:12px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start" zIndex="2">Sales</text><rect x="0" y="4" width="16" height="12" zIndex="3" fill="url(#highcharts-3)"></rect></g></g></g></g><g class="highcharts-axis-labels highcharts-xaxis-labels" zIndex="7"><text x="364" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:662px;text-overflow:clip;" text-anchor="middle" transform="translate(0,0)" y="238" opacity="1">Oct-2018</text></g><g class="highcharts-axis-labels highcharts-yaxis-labels" zIndex="7"><text x="31" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:218px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="222" opacity="1">0</text><text x="31" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:218px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="152" opacity="1">50</text><text x="31" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:218px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="82" opacity="1">100</text><text x="31" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:218px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="13" opacity="1">150</text></g><g class="highcharts-tooltip" zIndex="8" style="cursor:default;padding:0;white-space:nowrap;" transform="translate(493,-9999)" opacity="0"><path fill="rgba(249, 249, 249, .85)" d="M 3 0 L 131 0 C 134 0 134 0 134 3 L 134 125 C 134 128 134 128 131 128 L 3 128 C 0 128 0 128 0 125 L 0 3 C 0 0 0 0 3 0"></path></g></svg><div class="highcharts-tooltip" style="position: absolute; left: 493px; top: -9999px; visibility: visible;"><span style="position: absolute; font-family: &quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif; font-size: 14px; white-space: nowrap; color: rgb(0, 0, 0); margin-left: 0px; margin-top: 0px; left: 0px; top: 0px;" zindex="1"><div class="well well-sm" style="margin-bottom:0;"><span style="font-size:12px">Oct-2018</span><table class="table table-striped" style="margin-bottom:0;"><tbody><tr><td style="color:[object Object];padding:4px">Tax: </td><td style="color:[object Object];padding:4px;text-align:right;"> <b>6.75</b></td></tr><tr><td style="color:[object Object];padding:4px">Discount: </td><td style="color:[object Object];padding:4px;text-align:right;"> <b>0</b></td></tr><tr><td style="color:[object Object];padding:4px">Sales: </td><td style="color:[object Object];padding:4px;text-align:right;"> <b>135</b></td></tr></tbody></table></div></span></div></div></div>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:content>
