<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Default2.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="Charts/amcharts.js" type="text/javascript"></script>
    <script src="Charts/serial.js" type="text/javascript"></script>
    <script src="Charts/light.js" type="text/javascript"></script>
    <link href="//www.amcharts.com/lib/3/plugins/export/export.css" rel="stylesheet" />
    <script src="//www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
    <script src="//www.amcharts.com/lib/3/plugins/responsive/responsive.min.js"></script>
    <style type="text/css">
        #chartdiv
        {
            height: 300px;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            multigraph();
            barchart();
        });
        function multigraph() {
            var chart1 = AmCharts.makeChart("chartdiv", {
                "type": "serial",
                "theme": "light",
                "dataDateFormat": "YYYY-MM-DD",
                "precision": 2,
                "valueAxes": [{
                    "id": "v1",
                    "title": "Sales",
                    "position": "left",
                    "autoGridCount": false,
                    "labelFunction": function (value) {
                        return "$" + Math.round(value) + "M";
                    }
                }, {
                    "id": "v2",
                    "title": "Market Days",
                    "gridAlpha": 0,
                    "position": "right",
                    "autoGridCount": false
                }],
                "graphs": [{
                    "id": "g3",
                    "valueAxis": "v1",
                    "lineColor": "#e1ede9",
                    "fillColors": "#e1ede9",
                    "fillAlphas": 1,
                    "type": "column",
                    "title": "Actual Sales",
                    "valueField": "sales2",
                    "clustered": false,
                    "columnWidth": 0.5,
                    "legendValueText": "$[[value]]M",
                    "balloonText": "[[title]]<br/><b style='font-size: 130%'>$[[value]]M</b>"
                }, {
                    "id": "g4",
                    "valueAxis": "v1",
                    "lineColor": "#62cf73",
                    "fillColors": "#62cf73",
                    "fillAlphas": 1,
                    "type": "column",
                    "title": "Target Sales",
                    "valueField": "sales1",
                    "clustered": false,
                    "columnWidth": 0.3,
                    "legendValueText": "$[[value]]M",
                    "balloonText": "[[title]]<br/><b style='font-size: 130%'>$[[value]]M</b>"
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
                    "title": "Market Days",
                    "useLineColorForBulletBorder": true,
                    "valueField": "market1",
                    "balloonText": "[[title]]<br/><b style='font-size: 130%'>[[value]]</b>"
                }, {
                    "id": "g2",
                    "valueAxis": "v2",
                    "bullet": "round",
                    "bulletBorderAlpha": 1,
                    "bulletColor": "#FFFFFF",
                    "bulletSize": 5,
                    "hideBulletsCount": 50,
                    "lineThickness": 2,
                    "lineColor": "#e1ede9",
                    "type": "smoothedLine",
                    "dashLength": 5,
                    "title": "Market Days ALL",
                    "useLineColorForBulletBorder": true,
                    "valueField": "market2",
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
                "categoryField": "date",
                "categoryAxis": {
                    "parseDates": true,
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
                "dataProvider": [{
                    "date": "2013-01-16",
                    "market1": 71,
                    "market2": 75,
                    "sales1": 5,
                    "sales2": 8
                }, {
                    "date": "2013-01-17",
                    "market1": 74,
                    "market2": 78,
                    "sales1": 4,
                    "sales2": 6
                }, {
                    "date": "2013-01-18",
                    "market1": 78,
                    "market2": 88,
                    "sales1": 5,
                    "sales2": 2
                }, {
                    "date": "2013-01-19",
                    "market1": 85,
                    "market2": 89,
                    "sales1": 8,
                    "sales2": 9
                }, {
                    "date": "2013-01-20",
                    "market1": 82,
                    "market2": 89,
                    "sales1": 9,
                    "sales2": 6
                }, {
                    "date": "2013-01-21",
                    "market1": 83,
                    "market2": 85,
                    "sales1": 3,
                    "sales2": 5
                }, {
                    "date": "2013-01-22",
                    "market1": 88,
                    "market2": 92,
                    "sales1": 5,
                    "sales2": 7
                }, {
                    "date": "2013-01-23",
                    "market1": 85,
                    "market2": 90,
                    "sales1": 7,
                    "sales2": 6
                }, {
                    "date": "2013-01-24",
                    "market1": 85,
                    "market2": 91,
                    "sales1": 9,
                    "sales2": 5
                }, {
                    "date": "2013-01-25",
                    "market1": 80,
                    "market2": 84,
                    "sales1": 5,
                    "sales2": 8
                }, {
                    "date": "2013-01-26",
                    "market1": 87,
                    "market2": 92,
                    "sales1": 4,
                    "sales2": 8
                }, {
                    "date": "2013-01-27",
                    "market1": 84,
                    "market2": 87,
                    "sales1": 3,
                    "sales2": 4
                }, {
                    "date": "2013-01-28",
                    "market1": 83,
                    "market2": 88,
                    "sales1": 5,
                    "sales2": 7
                }, {
                    "date": "2013-01-29",
                    "market1": 84,
                    "market2": 87,
                    "sales1": 5,
                    "sales2": 8
                }, {
                    "date": "2013-01-30",
                    "market1": 81,
                    "market2": 85,
                    "sales1": 4,
                    "sales2": 7
                }]
            });
        }
        function barchart() {
            var chart2 = AmCharts.makeChart("chartdiv1", {
                "type": "serial",
                "theme": "light",
                "titles": [{
                    "text": "This is a possibly very long title that will not fit well on smaller resolutions or screens"
                }],
                "dataProvider": [{
                    "country": "USA",
                    "visits": 2025
                }, {
                    "country": "China",
                    "visits": 1882
                }, {
                    "country": "Japan",
                    "visits": 1809
                }, {
                    "country": "Germany",
                    "visits": 1322
                }, {
                    "country": "UK",
                    "visits": 1122
                }, {
                    "country": "France",
                    "visits": 1114
                }, {
                    "country": "India",
                    "visits": 984
                }, {
                    "country": "Spain",
                    "visits": 711
                }, {
                    "country": "Netherlands",
                    "visits": 665
                }, {
                    "country": "Russia",
                    "visits": 580
                }, {
                    "country": "South Korea",
                    "visits": 443
                }, {
                    "country": "Canada",
                    "visits": 441
                }, {
                    "country": "Brazil",
                    "visits": 395
                }],
                "graphs": [{
                    "fillAlphas": 0.9,
                    "lineAlpha": 0.2,
                    "type": "column",
                    "valueField": "visits"
                }],
                "categoryField": "country",

                /**
                * Below are responsive rules that kick
                * in at specific resolutions and override
                * chart's titles with appropriate versions
                */
                "responsive": {
                    "enabled": true,
                    "addDefaultRules": false,
                    "rules": [{
                        "maxWidth": 600,
                        "overrides": {
                            "titles": {
                                "text": "Slightly shorter version of title for 600px wide charts"
                            }
                        }
                    }, {
                        "maxWidth": 400,
                        "overrides": {
                            "titles": {
                                "text": "Even shorter title kicks in at 400px"
                            }
                        }
                    }, {
                        "maxWidth": 250,
                        "overrides": {
                            "titles": {
                                "text": ""
                            }
                        }
                    }]
                }
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
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">
                        Category Sale Value</h3>
                </div>
                <div class="box-body">
                    <div id="chartdiv">
                    </div>
                    <%--<div id="chart" style="height:300px;" data-highcharts-chart="0"><div class="highcharts-container" id="highcharts-0" style="position: relative; overflow: hidden; width: 692px; height: 300px; text-align: left; line-height: normal; z-index: 0; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"><svg version="1.1" style="font-family:&quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif;font-size:12px;" xmlns="http://www.w3.org/2000/svg" width="692" height="300"><desc>Created with Highcharts 4.1.6</desc><defs><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-1"><stop offset="0" stop-color="#7cb5ec" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(48,105,160)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-2"><stop offset="0" stop-color="#434348" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(0,0,0)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-3"><stop offset="0" stop-color="#90ed7d" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(68,161,49)" stop-opacity="1"></stop></radialGradient><clipPath id="highcharts-4"><rect x="0" y="0" width="636" height="209"></rect></clipPath><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-13"><stop offset="0" stop-color="rgb(149,206,255)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(73,130,185)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-14"><stop offset="0" stop-color="rgb(92,92,97)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(25,25,25)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-15"><stop offset="0" stop-color="rgb(169,255,150)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(93,186,74)" stop-opacity="1"></stop></radialGradient></defs><rect x="0" y="0" width="692" height="300" strokeWidth="0" fill="#FFFFFF" class=" highcharts-background"></rect><g class="highcharts-grid" zIndex="1"></g><g class="highcharts-grid" zIndex="1"><path fill="none" d="M 46 219.5 L 682 219.5" stroke="#D8D8D8" stroke-width="1" zIndex="1" opacity="1"></path><path fill="none" d="M 46 149.5 L 682 149.5" stroke="#D8D8D8" stroke-width="1" zIndex="1" opacity="1"></path><path fill="none" d="M 46 80.5 L 682 80.5" stroke="#D8D8D8" stroke-width="1" zIndex="1" opacity="1"></path><path fill="none" d="M 46 9.5 L 682 9.5" stroke="#D8D8D8" stroke-width="1" zIndex="1" opacity="1"></path></g><g class="highcharts-axis" zIndex="2"><path fill="none" d="M 682.5 219 L 682.5 229" stroke="#C0D0E0" stroke-width="1" opacity="1"></path><path fill="none" d="M 45.5 219 L 45.5 229" stroke="#C0D0E0" stroke-width="1" opacity="1"></path><path fill="none" d="M 46 219.5 L 682 219.5" stroke="#C0D0E0" stroke-width="1" zIndex="7" visibility="visible"></path></g><g class="highcharts-axis" zIndex="2"></g><g class="highcharts-series-group" zIndex="3"><g class="highcharts-series highcharts-tracker" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" style="" clip-path="url(#highcharts-4)"><rect x="164.5" y="11.5" width="306" height="10" stroke="#FFFFFF" stroke-width="1" fill="url(#highcharts-1)" rx="0" ry="0"></rect></g><g class="highcharts-markers" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" clip-path="none"></g><g class="highcharts-series highcharts-tracker" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" style="" clip-path="url(#highcharts-4)"><rect x="164.5" y="21.5" width="306" height="0" stroke="#FFFFFF" stroke-width="1" fill="url(#highcharts-2)" rx="0" ry="0"></rect></g><g class="highcharts-markers" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" clip-path="none"></g><g class="highcharts-series highcharts-tracker" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" style="" clip-path="url(#highcharts-4)"><rect x="164.5" y="21.5" width="306" height="188" stroke="#FFFFFF" stroke-width="1" fill="url(#highcharts-3)" rx="0" ry="0"></rect></g><g class="highcharts-markers" visibility="visible" zIndex="0.1" transform="translate(46,10) scale(1 1)" clip-path="none"></g></g><g class="highcharts-legend" zIndex="7" transform="translate(231,256)"><g zIndex="1"><g><g class="highcharts-legend-item" zIndex="1" transform="translate(8,3)"><text x="21" style="color:#333333;font-size:12px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start" zIndex="2" y="15">Tax</text><rect x="0" y="4" width="16" height="12" zIndex="3" fill="url(#highcharts-1)"></rect></g><g class="highcharts-legend-item" zIndex="1" transform="translate(73.6875,3)"><text x="21" y="15" style="color:#333333;font-size:12px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start" zIndex="2">Discount</text><rect x="0" y="4" width="16" height="12" zIndex="3" fill="url(#highcharts-2)"></rect></g><g class="highcharts-legend-item" zIndex="1" transform="translate(169.34375,3)"><text x="21" y="15" style="color:#333333;font-size:12px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start" zIndex="2">Sales</text><rect x="0" y="4" width="16" height="12" zIndex="3" fill="url(#highcharts-3)"></rect></g></g></g></g><g class="highcharts-axis-labels highcharts-xaxis-labels" zIndex="7"><text x="364" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:662px;text-overflow:clip;" text-anchor="middle" transform="translate(0,0)" y="238" opacity="1">Oct-2018</text></g><g class="highcharts-axis-labels highcharts-yaxis-labels" zIndex="7"><text x="31" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:218px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="222" opacity="1">0</text><text x="31" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:218px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="152" opacity="1">50</text><text x="31" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:218px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="82" opacity="1">100</text><text x="31" style="color:#606060;cursor:default;font-size:11px;fill:#606060;width:218px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="13" opacity="1">150</text></g><g class="highcharts-tooltip" zIndex="8" style="cursor:default;padding:0;white-space:nowrap;" transform="translate(493,-9999)" opacity="0"><path fill="rgba(249, 249, 249, .85)" d="M 3 0 L 131 0 C 134 0 134 0 134 3 L 134 125 C 134 128 134 128 131 128 L 3 128 C 0 128 0 128 0 125 L 0 3 C 0 0 0 0 3 0"></path></g></svg><div class="highcharts-tooltip" style="position: absolute; left: 493px; top: -9999px; visibility: visible;"><span style="position: absolute; font-family: &quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif; font-size: 14px; white-space: nowrap; color: rgb(0, 0, 0); margin-left: 0px; margin-top: 0px; left: 0px; top: 0px;" zindex="1"><div class="well well-sm" style="margin-bottom:0;"><span style="font-size:12px">Oct-2018</span><table class="table table-striped" style="margin-bottom:0;"><tbody><tr><td style="color:[object Object];padding:4px">Tax: </td><td style="color:[object Object];padding:4px;text-align:right;"> <b>6.75</b></td></tr><tr><td style="color:[object Object];padding:4px">Discount: </td><td style="color:[object Object];padding:4px;text-align:right;"> <b>0</b></td></tr><tr><td style="color:[object Object];padding:4px">Sales: </td><td style="color:[object Object];padding:4px;text-align:right;"> <b>135</b></td></tr></tbody></table></div></span></div></div></div>--%>
                </div>
            </div>
        </div>
        <div class="col-md-12">
            <div class="box box-success">
                <div class="box-header">
                    <h3 class="box-title">
                        Daily Purchase Details</h3>
                </div>
                <div class="box-body">
                    <div id="chartdiv1">
                    </div>
                    <%--<div id="chart2" style="height:300px;" data-highcharts-chart="1"><div class="highcharts-container" id="highcharts-5" style="position: relative; overflow: hidden; width: 321px; height: 300px; text-align: left; line-height: normal; z-index: 0; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"><svg version="1.1" style="font-family:&quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif;font-size:12px;" xmlns="http://www.w3.org/2000/svg" width="321" height="300"><desc>Created with Highcharts 4.1.6</desc><defs><clipPath id="highcharts-6"><rect x="0" y="0" width="301" height="275"></rect></clipPath><radialGradient cx="150.5" cy="86.5" r="178.5" id="highcharts-7" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#7cb5ec" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(48,105,160)" stop-opacity="1"></stop></radialGradient><radialGradient cx="150.5" cy="86.5" r="178.5" id="highcharts-8" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#434348" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(0,0,0)" stop-opacity="1"></stop></radialGradient><radialGradient cx="150.5" cy="86.5" r="178.5" id="highcharts-16" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="rgb(149,206,255)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(73,130,185)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-17"><stop offset="0" stop-color="rgb(124,181,236)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(48,105,160)" stop-opacity="1"></stop></radialGradient></defs><rect x="0" y="0" width="321" height="300" strokeWidth="0" fill="#FFFFFF" class=" highcharts-background"></rect><g class="highcharts-series-group" zIndex="3"><path fill="url(#highcharts-17)" d="M 0 0"></path><g class="highcharts-series highcharts-tracker" visibility="visible" zIndex="0.1" transform="translate(10,10) scale(1 1)" style="cursor:pointer;"><path fill="url(#highcharts-7)" d="M 150.47403166652887 10.000002644526859 A 127.5 127.5 0 1 1 106.99574606822634 257.34836206573607 L 150.5 137.5 A 0 0 0 1 0 150.5 137.5 Z" stroke="#FFFFFF" stroke-width="1" stroke-linejoin="round" transform="translate(0,0)"></path><path fill="url(#highcharts-8)" d="M 106.87591947826049 257.3047978948789 A 127.5 127.5 0 0 1 150.32290505789587 10.000122990720172 L 150.5 137.5 A 0 0 0 0 0 150.5 137.5 Z" stroke="#FFFFFF" stroke-width="1" stroke-linejoin="round" transform="translate(0,0)"></path></g><g class="highcharts-markers" visibility="visible" zIndex="0.1" transform="translate(10,10) scale(1 1)"></g></g><g class="highcharts-legend" zIndex="7"><g zIndex="1"><g></g></g></g><g class="highcharts-tooltip" zIndex="8" style="cursor:default;padding:0;white-space:nowrap;" transform="translate(68,-9999)" opacity="0"><path fill="rgba(249, 249, 249, .85)" d="M 3 0 L 153 0 C 156 0 156 0 156 3 L 156 67 C 156 70 156 70 153 70 L 3 70 C 0 70 0 70 0 67 L 0 3 C 0 0 0 0 3 0"></path></g></svg><div class="highcharts-tooltip" style="position: absolute; left: 68px; top: -9999px; visibility: visible;"><span style="position: absolute; font-family: &quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif; font-size: 14px; white-space: nowrap; color: rgb(0, 0, 0); margin-left: 0px; margin-top: 0px; left: 0px; top: 0px;" zindex="1"><div class="well well-sm" style="margin-bottom:0;"><span style="font-size:12px">Minion Banana (TOY02)</span><table class="table table-striped" style="margin-bottom:0;"><tbody><tr><td style="color:;padding:4px">Total Sold: </td><td style="color:;padding:4px;text-align:right;"> <b>5</b></td></tr></tbody></table></div></span></div></div></div>--%>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="box box-danger">
                <div class="box-header">
                    <h3 class="box-title">
                        Daily Expences Details</h3>
                </div>
                <div class="box-body">
                    <div id="chartdiv2">
                    </div>
                    <%--<div id="chart2" style="height:300px;" data-highcharts-chart="1"><div class="highcharts-container" id="highcharts-5" style="position: relative; overflow: hidden; width: 321px; height: 300px; text-align: left; line-height: normal; z-index: 0; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"><svg version="1.1" style="font-family:&quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif;font-size:12px;" xmlns="http://www.w3.org/2000/svg" width="321" height="300"><desc>Created with Highcharts 4.1.6</desc><defs><clipPath id="highcharts-6"><rect x="0" y="0" width="301" height="275"></rect></clipPath><radialGradient cx="150.5" cy="86.5" r="178.5" id="highcharts-7" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#7cb5ec" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(48,105,160)" stop-opacity="1"></stop></radialGradient><radialGradient cx="150.5" cy="86.5" r="178.5" id="highcharts-8" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="#434348" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(0,0,0)" stop-opacity="1"></stop></radialGradient><radialGradient cx="150.5" cy="86.5" r="178.5" id="highcharts-16" gradientUnits="userSpaceOnUse"><stop offset="0" stop-color="rgb(149,206,255)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(73,130,185)" stop-opacity="1"></stop></radialGradient><radialGradient cx="0.5" cy="0.3" r="0.7" id="highcharts-17"><stop offset="0" stop-color="rgb(124,181,236)" stop-opacity="1"></stop><stop offset="1" stop-color="rgb(48,105,160)" stop-opacity="1"></stop></radialGradient></defs><rect x="0" y="0" width="321" height="300" strokeWidth="0" fill="#FFFFFF" class=" highcharts-background"></rect><g class="highcharts-series-group" zIndex="3"><path fill="url(#highcharts-17)" d="M 0 0"></path><g class="highcharts-series highcharts-tracker" visibility="visible" zIndex="0.1" transform="translate(10,10) scale(1 1)" style="cursor:pointer;"><path fill="url(#highcharts-7)" d="M 150.47403166652887 10.000002644526859 A 127.5 127.5 0 1 1 106.99574606822634 257.34836206573607 L 150.5 137.5 A 0 0 0 1 0 150.5 137.5 Z" stroke="#FFFFFF" stroke-width="1" stroke-linejoin="round" transform="translate(0,0)"></path><path fill="url(#highcharts-8)" d="M 106.87591947826049 257.3047978948789 A 127.5 127.5 0 0 1 150.32290505789587 10.000122990720172 L 150.5 137.5 A 0 0 0 0 0 150.5 137.5 Z" stroke="#FFFFFF" stroke-width="1" stroke-linejoin="round" transform="translate(0,0)"></path></g><g class="highcharts-markers" visibility="visible" zIndex="0.1" transform="translate(10,10) scale(1 1)"></g></g><g class="highcharts-legend" zIndex="7"><g zIndex="1"><g></g></g></g><g class="highcharts-tooltip" zIndex="8" style="cursor:default;padding:0;white-space:nowrap;" transform="translate(68,-9999)" opacity="0"><path fill="rgba(249, 249, 249, .85)" d="M 3 0 L 153 0 C 156 0 156 0 156 3 L 156 67 C 156 70 156 70 153 70 L 3 70 C 0 70 0 70 0 67 L 0 3 C 0 0 0 0 3 0"></path></g></svg><div class="highcharts-tooltip" style="position: absolute; left: 68px; top: -9999px; visibility: visible;"><span style="position: absolute; font-family: &quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif; font-size: 14px; white-space: nowrap; color: rgb(0, 0, 0); margin-left: 0px; margin-top: 0px; left: 0px; top: 0px;" zindex="1"><div class="well well-sm" style="margin-bottom:0;"><span style="font-size:12px">Minion Banana (TOY02)</span><table class="table table-striped" style="margin-bottom:0;"><tbody><tr><td style="color:;padding:4px">Total Sold: </td><td style="color:;padding:4px;text-align:right;"> <b>5</b></td></tr></tbody></table></div></span></div></div></div>--%>
                </div>
            </div>
        </div>
    </div>
</asp:content>
