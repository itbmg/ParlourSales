<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
    <script src="https://www.amcharts.com/lib/3/serial.js"></script>
    <script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
    <link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css"
        type="text/css" media="all" />
    <script src="https://www.amcharts.com/lib/3/themes/light.js"></script>
    <script src="https://www.amcharts.com/lib/3/pie.js"></script>
    <!-- Styles -->
    <!-- Chart code -->
    <script type="text/javascript">
        $(function () {
            get_possalevalue_details();
            //get_sale_details();
            // get_overallitemwisesalevalue();
            get_weekwisepossale_details();
            get_lastweekpossalevalue_details();
            get_currentweekpossalevalue_details();
            var branchid = '<%=Session["BranchID"] %>';
            var leveltype = '<%=Session["leveltype"] %>';
            if (leveltype == "Manager   ") {
                $('#divquicklinks').css('display', 'none');
            }
            if (leveltype == "User      ") {
                $('#divquicklinks').css('display', 'none');
            }
            if (leveltype == "Accounts  ") {
                $('#divquicklinks').css('display', 'none');
            }
        });

        function get_monthwisepossale_details() {
            var fromdate = document.getElementById('txtfromdate').value;
            var todate = document.getElementById('txttodate').value;
            var data = { 'op': 'get_monthwisepossale_details', 'frmdate': fromdate, 'todate': todate };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        monthbind(msg);
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

        var mnthTotalDate = []; var mnthtotattendance = [];
        function monthbind(msg) {
            mnthTotalDate = msg[0].Allbiomertcdates;
            mnthtotattendance = msg[0].salevalue;
            var results = '<div class="box-body"><table id="tblbiologs" style="font-weight: 800 !important;" class="table table-bordered  dataTable no-footer" role="grid" aria-="" describedby="example2_info">';
            results += '<thead><tr role="row" class="trbgclrcls">';
            results += '<th scope="col" style="text-align:center;"> Sno</th>';
            results += '<th scope="col" style="text-align:center;"><i class="fa fa-user" aria-hidden="true"></i> Parlor Id</th>';
            results += '<th scope="col" style="text-align:center;"><i class="fa fa-user" aria-hidden="true"></i> Parlor Name</th>';
            for (var i = 0; i < mnthTotalDate.length; i++) {
                results += '<th scope="col" id="txtDate"><i class="fa fa-calendar" aria-hidden="true"></i> ' + mnthTotalDate[i].Betweendates + '</th>';
            }
            results += '</tr></thead></tbody>';
            for (var i = 0; i < mnthtotattendance.length; i++) {
                if (mnthtotattendance[i].week1 != "" && mnthtotattendance[i].week1 != null) {
                    var k = i + 1;
                    results += '<tr><td scope="row" style="text-align: right; font-weight: bold;">' + k + '</td>';
                    results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + mnthtotattendance[i].parlorid + '</td>';
                    results += '<td scope="row" class="2" style="text-align: right; font-weight: bold;" >' + mnthtotattendance[i].parlorname + '</td>';

                    var m1 = mnthtotattendance[i].week1;
                    if (m1 != "") {
                        results += '<td scope="row" class="3" style="text-align: right; font-weight: bold;"><a id="' + mnthtotattendance[i].linkval1 + '"  onclick="mnthlogsclick1(this);" title="' + mnthtotattendance[i].linkval1 + '" data-toggle="modal" data-target="#divwm" style="cursor: pointer !important;">' + mnthtotattendance[i].week1 + '</a></td>';
                    }
                    var m2 = mnthtotattendance[i].week2;
                    if (m2 != "" && m2 != null) {
                        results += '<td scope="row" class="3" style="text-align: right; font-weight: bold;"><a id="' + mnthtotattendance[i].linkval2 + '"  onclick="mnthlogsclick2(this);" title="' + mnthtotattendance[i].linkval2 + '" data-toggle="modal" data-target="#divwm" style="cursor: pointer !important;">' + mnthtotattendance[i].week2 + '</a></td>';
                    }
                    var m3 = mnthtotattendance[i].week3;
                    if (m3 != "" && m3 != null) {
                        results += '<td scope="row" class="3" style="text-align: right; font-weight: bold;"><a id="' + mnthtotattendance[i].linkval3 + '"  onclick="mnthlogsclick2(this);" title="' + mnthtotattendance[i].linkval3 + '" data-toggle="modal" data-target="#divwm" style="cursor: pointer !important;">' + mnthtotattendance[i].week3 + '</a></td>';
                    }
                    var m4 = mnthtotattendance[i].week4;
                    if (m4 != "" && m4 != null) {
                        results += '<td scope="row" class="3" style="text-align: right; font-weight: bold;"><a id="' + mnthtotattendance[i].linkval4 + '"  onclick="mnthlogsclick2(this);" title="' + mnthtotattendance[i].linkval4 + '" data-toggle="modal" data-target="#divwm" style="cursor: pointer !important;">' + mnthtotattendance[i].week4 + '</a></td>';
                    }

                    results += '<td style="display:none" class="11">' + mnthtotattendance[i].parlorid + '</td></tr>';
                }
            }
            results += '</table></div>';
            $("#divmnthsalevalue").html(results);
        }

        function mnthlogsclick1(thisid) {
            var parlorid = $(thisid).attr('title');
            var data = { 'op': 'get_mnthweekwisepossale_details', 'parlorid': parlorid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillmnthdatevalue(msg)
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function mnthlogsclick2(thisid) {
            var parlorid = $(thisid).attr('title');
            var data = { 'op': 'get_mnthweekwisepossale_details', 'parlorid': parlorid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillmnthdatevalue(msg)
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        var emptytable6 = [];
        var weekTotalDate = []; var weekattendancearry = []; var weektotattendance = []; var weekemptytable4 = [];
        function fillmnthdatevalue(msg) {
            weekTotalDate = msg[0].Allbiomertcdates;
            weektotattendance = msg[0].salevalue;
            var results = '<div class="box-body"><table id="tblbiologs" style="font-weight: 800 !important;" class="table table-bordered  dataTable no-footer" role="grid" aria-="" describedby="example2_info">';
            results += '<thead><tr role="row" class="trbgclrcls">';
            results += '<th scope="col" style="text-align:center;"> Sno</th>';
            results += '<th scope="col" style="text-align:center;"><i class="fa fa-user" aria-hidden="true"></i> Parlor Id</th>';
            results += '<th scope="col" style="text-align:center;"><i class="fa fa-user" aria-hidden="true"></i> Parlor Name</th>';
            for (var i = 0; i < weekTotalDate.length; i++) {
                results += '<th scope="col" id="txtDate"><i class="fa fa-calendar" aria-hidden="true"></i> ' + weekTotalDate[i].Betweendates + '</th>';
            }
            results += '</tr></thead></tbody>';
            for (var i = 0; i < weektotattendance.length; i++) {
                var k = i + 1;
                results += '<tr><td scope="row" style="text-align: right; font-weight: bold;">' + k + '</td>';
                results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + weektotattendance[i].parlorid + '</td>';
                results += '<td scope="row" class="2" style="text-align: right; font-weight: bold;" >' + weektotattendance[i].parlorname + '</td>';
                results += '<td scope="row" class="3" style="text-align: right; font-weight: bold;"><a id="' + weektotattendance[i].linkval1 + '"  onclick="mweeklogsclick1(this);" title="' + weektotattendance[i].linkval1 + '" data-toggle="modal" data-target="#divmwdv" style="cursor: pointer !important;">' + weektotattendance[i].week1 + '</a></td>';
                results += '<td scope="row" class="3" style="text-align: right; font-weight: bold;"><a id="' + weektotattendance[i].linkval2 + '"  onclick="mweeklogsclick2(this);" title="' + weektotattendance[i].linkval2 + '" data-toggle="modal" data-target="#divmwdv" style="cursor: pointer !important;">' + weektotattendance[i].week2 + '</a></td>';
                results += '<td scope="row" class="3" style="text-align: right; font-weight: bold;"><a id="' + weektotattendance[i].linkval3 + '"  onclick="mweeklogsclick3(this);" title="' + weektotattendance[i].linkval3 + '" data-toggle="modal" data-target="#divmwdv" style="cursor: pointer !important;">' + weektotattendance[i].week3 + '</a></td>';
                results += '<td scope="row" class="3" style="text-align: right; font-weight: bold;"><a id="' + weektotattendance[i].linkval4 + '"  onclick="mweeklogsclick4(this);" title="' + weektotattendance[i].linkval4 + '" data-toggle="modal" data-target="#divmwdv" style="cursor: pointer !important;">' + weektotattendance[i].week4 + '</a></td>';
                results += '<td scope="row" class="3" style="text-align: right; font-weight: bold;"><a id="' + weektotattendance[i].linkval5 + '"  onclick="mweeklogsclick4(this);" title="' + weektotattendance[i].linkval5 + '" data-toggle="modal" data-target="#divmwdv" style="cursor: pointer !important;">' + weektotattendance[i].week5 + '</a></td>';


                results += '<td scope="row" class="7" style="text-align: right; font-weight: bold; display:none" >' + weektotattendance[i].linkval1 + '</td>';
                results += '<td data-title="code" class="8" style="text-align: right; font-weight: bold; display:none">' + weektotattendance[i].linkval2 + '</th>';
                results += '<td data-title="code" class="9" style="text-align: right; font-weight: bold; display:none">' + weektotattendance[i].linkval3 + '</th>';
                results += '<td data-title="code" class="10" style="text-align: right; font-weight: bold; display:none">' + weektotattendance[i].linkval4 + '</th>';
                results += '<td style="display:none" class="11">' + weektotattendance[i].parlorid + '</td></tr>';
            }
            results += '</table></div>';
            $("#divmnthdate").html(results);
        }


        function mweeklogsclick4(thisid) {
            var parlorid = $(thisid).attr('title');
            var data = { 'op': 'get_weekpossalevalue_details', 'parlorid': parlorid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillmweekdatevalue(msg)
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }

        function mweeklogsclick1(thisid) {
            var parlorid = $(thisid).attr('title');
            var data = { 'op': 'get_weekpossalevalue_details', 'parlorid': parlorid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillmweekdatevalue(msg)
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }

        function mweeklogsclick2(thisid) {
            var parlorid = $(thisid).attr('title');
            var data = { 'op': 'get_weekpossalevalue_details', 'parlorid': parlorid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillmweekdatevalue(msg)
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }

        function mweeklogsclick3(thisid) {
            var parlorid = $(thisid).attr('title');
            var data = { 'op': 'get_weekpossalevalue_details', 'parlorid': parlorid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillmweekdatevalue(msg)
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }


        function fillmweekdatevalue(msg) {
            TotalDate = msg[0].Allbiomertcdates;
            totattendance = msg[0].salevalue;
            var results = '<div class="box-body" style="padding:0px !important;"><table id="tblbiologs" style="font-weight: 800 !important;" class="table table-bordered  dataTable no-footer" role="grid" aria-="" describedby="example2_info">';
            results += '<thead><tr role="row" class="trbgclrcls">';
            results += '<th scope="col" style="text-align:left;"><i class="fa fa-user" aria-hidden="true"></i> Parlor Name</th>';
            for (var i = 0; i < TotalDate.length; i++) {
                results += '<th scope="col" id="txtDate"><i class="fa fa-calendar" aria-hidden="true"></i> ' + TotalDate[i].Betweendates + '</th>';
            }
            results += '</tr></thead></tbody>';
            for (var i = 0; i < totattendance.length; i++) {
                results += '<tr>';
                var parlorname = totattendance[i].parlorname
                if (emptytable5.indexOf(parlorname) == -1) {
                    results += '<td data-title="brandstatus" class="4" style="text-align:left;">' + totattendance[i].parlorname + '</td>';
                    results += '<td style="display:none" data-title="brandstatus" class="3">' + totattendance[i].parlorid + '</td>';
                    emptytable5.push(parlorname);
                    for (var j = 0; j < TotalDate.length; j++) {
                        var d = 1;
                        for (var k = 0; k < totattendance.length; k++) {
                            if (TotalDate[j].Betweendates == totattendance[k].LogDate && parlorname == totattendance[k].parlorname) {
                                if (totattendance[k].salevalue != "") {
                                    var st = totattendance[k].parlorid + '-' + totattendance[k].LogDate;
                                    //20/Jan(Sunday)
                                    var logdt = totattendance[k].LogDate;
                                    var res = logdt.split("/");
                                    var mnth = res[1];
                                    var res2 = mnth.split("(");
                                    var mnth2 = res2[1];
                                    results += '<td class="1" style="display:none"><input class="form-control" type="text" name="empid" id="txtempid"  value="' + st + '"/></td>';
                                    if (mnth2 == "Sunday)") {
                                        results += '<td style="text-align:right;" onmouseover="ChangeBackgroundColor(this)" onmouseout="RestoreBackgroundColor(this)"  id="' + st + '" data-title="brandstatus" class="1"><a id="' + st + '"  onclick="mWEEKDATElogsclick(this);" title="' + st + '" data-toggle="modal" data-target="#divmvdsd" style="color: brown; cursor: pointer !important;">' + totattendance[k].salevalue + '</a></td>';
                                    }
                                    else {
                                        results += '<td style="text-align:right;" onmouseover="ChangeBackgroundColor(this)" onmouseout="RestoreBackgroundColor(this)"  id="' + st + '" data-title="brandstatus" class="1"><a id="' + st + '"  onclick="mWEEKDATElogsclick(this);" title="' + st + '" data-toggle="modal" data-target="#divmvdsd" style="cursor: pointer !important;">' + totattendance[k].salevalue + '</a></td>';
                                    }
                                    results += '<td style="display:none" data-title="brandstatus" class="2">' + totattendance[k].LogDate + '</td>';
                                    d = 0;
                                }
                            }
                        }
                        if (d == 1) {
                            var status = "A"
                            st = 1 + '-' + 1;
                            results += '<td class="1" style="display:none"><input class="form-control" type="text" name="empid" id="txtempid"  value="' + st + '"/></td>';
                            results += '<td id="' + st + '" data-title="brandstatus" class="1"><a id="' + st + '"   title="' + st + '" data-toggle="modal" data-target="#myModals">0</a></td>';
                            results += '<td style="display:none" data-title="brandstatus" class="2"></td>';
                        }
                    }
                    results += '</tr>';
                }
            }
            results += '</table></div>';
            $("#divmwdval").html(results);
            emptytable5 = [];
        }

        function mWEEKDATElogsclick(thisid) {
            var parlorid = $(thisid).attr('title');
            var data = { 'op': 'getdatewise_WEEKsubcategorywisesalevalue', 'parlorid': parlorid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillmWEEKsubcategorydatewisesalevalue(msg)
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }


        function fillmWEEKsubcategorydatewisesalevalue(msg) {
            var results = '<div  class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbl_Stores_value">';
            results += '<thead><tr role="row" class="trbgclrcls"><th scope="col" style="width: 10px">Sno</th><th scope="col">Sub Category Name</th><th scope="col">Sale Value</th><th scope="col">Quantity</th></tr></thead></tbody>';
            var totalsubcatsalevalue = 0;
            var totalsubcatAvgsale = 0;

            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr><td scope="row" style="text-align: left; font-weight: bold;">' + k + '</td>';
                results += '<td scope="row" class="1" style="text-align: left; font-weight: bold;" >' + msg[i].subcategoryname + '</td>';
                results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + parseFloat(msg[i].totvalue).toFixed(0) + '</td>';
                totalsubcatsalevalue += parseFloat(msg[i].totvalue);
                results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;">' + parseFloat(msg[i].Avgsale).toFixed(0) + '</th>';
                results += '<td style="display:none" class="5">' + msg[i].subcategoryid + '</td></tr>';
            }
            results += '<tr style="background-color: cadetblue;color: whitesmoke;"><td scope="row" style="text-align: right; font-weight: bold;"></td>';
            results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >Total</td>';
            results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + parseFloat(totalsubcatsalevalue).toFixed(0) + '</td>';
            results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;"></th>';
            results += '<td style="display:none" class="5"></td></tr>';
            results += '</table></div>';
            $("#divmweeksubcatdata").html(results);
        }

        function prevmonthclick() {
            var date = new Date();
            var n = date.getMonth() + 1;
            var year = date.getFullYear();
            if (n < 10) n = "0" + n;
            if (n == "01") {
                n = "12";
                year = (parseFloat(year) - 1);
            }
            else {
                n = n - 1;
            }
            var data = { 'op': 'get_weekwisepossale_details', 'month': n, 'year': year };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        weekbind(msg);
                        rightbind(msg);
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
        function nextmonthclick() {
            var date = new Date();
            var n = date.getMonth() + 1;
            var year = date.getFullYear();
            var data = { 'op': 'get_weekwisepossale_details', 'month': n, 'year': year };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        weekbind(msg);
                        rightbind(msg);
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


        function get_weekwisepossale_details() {
            var n = "";
            var year = "";
            var data = { 'op': 'get_weekwisepossale_details', 'month': n, 'year': year };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        weekbind(msg);
                        rightbind(msg);
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

        function isFloat(evt) {
            var charCode = (event.which) ? event.which : event.keyCode;
            if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            else {
                //if dot sign entered more than once then don't allow to enter dot sign again. 46 is the code for dot sign
                var parts = evt.srcElement.value.split('.');
                if (parts.length > 1 && charCode == 46)
                    return false;
                return true;
            }
        }
        function ValidateAlpha(evt) {
            var keyCode = (evt.which) ? evt.which : evt.keyCode
            if ((keyCode < 65 || keyCode > 90) && (keyCode < 97 || keyCode > 123) && keyCode != 32)

                return false;
            return true;
        }
        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
        var TableBackgroundNormalColor = "#ffffff";
        var TableBackgroundMouseoverColor = "#f3eded";

        // These two functions need no customization.
        function ChangeBackgroundColor(row) {
            row.style.backgroundColor = TableBackgroundMouseoverColor;
        }

        function RestoreBackgroundColor(row) {
            row.style.backgroundColor = TableBackgroundNormalColor;
        }

        function get_lastweekpossalevalue_details() {
            var data = { 'op': 'get_lastweekpossalevalue_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        lastweekBindsalvalueGrid(msg);
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
        var lastweekTotalDate = []; var lastweekattendancearry = []; var lastweektotattendance = []; var lastweekemptytable4 = [];
        function lastweekBindsalvalueGrid(msg) {
            lastweekTotalDate = msg[0].Allbiomertcdates;
            lastweektotattendance = msg[0].salevalue;
            var results = '<div class="box-body" style="padding:0px !important;"><table id="posTable" style="font-weight: 800 !important; text-align: right;" class="table table-bordered  dataTable no-footer" role="grid" aria-="" describedby="example2_info">';
            results += '<thead><tr role="row" class="trbgclrcls">';
            results += '<th scope="col" style="text-align:left;width: 150px;"><i class="fa fa-user" aria-hidden="true"></i> Parlor Name</th>';
            for (var i = 0; i < lastweekTotalDate.length; i++) {
                var dta = lastweekTotalDate[i].Betweendates;
                var mysplit = dta.split("(");
                var dm = mysplit[0];
                var day = mysplit[1]
                results += '<th scope="col" id="txtDate" style="width: 59px;"><i class="fa fa-calendar" aria-hidden="true"></i> ' + dm + ' </br> (' + day + '</th>';
            }

            results += '</tr></thead></tbody>';
            var totalpossalevalue = 0;
            for (var i = 0; i < lastweektotattendance.length; i++) {
                results += '<tr>';
                var parlorname = lastweektotattendance[i].parlorname
                if (lastweekemptytable4.indexOf(parlorname) == -1) {
                    results += '<td data-title="brandstatus" class="4" style="text-align:left;">' + lastweektotattendance[i].parlorname + '</td>';
                    results += '<td style="display:none" data-title="brandstatus" class="3">' + lastweektotattendance[i].parlorid + '</td>';
                    lastweekemptytable4.push(parlorname);
                    for (var j = 0; j < lastweekTotalDate.length; j++) {
                        var d = 1;
                        for (var k = 0; k < lastweektotattendance.length; k++) {
                            if (lastweekTotalDate[j].Betweendates == lastweektotattendance[k].LogDate && parlorname == lastweektotattendance[k].parlorname) {
                                if (lastweektotattendance[k].salevalue != "") {
                                    var st = lastweektotattendance[k].parlorid + '-' + lastweektotattendance[k].LogDate;
                                    //20/Jan(Sunday)
                                    var logdt = lastweektotattendance[k].LogDate;
                                    var mysplit = logdt.split("(");
                                    var sp = mysplit[0];
                                    var res = logdt.split("/");
                                    var mnth = res[1];
                                    var res2 = mnth.split("(");
                                    var mnth2 = res2[1];
                                    var cmpid = lastweektotattendance[k].cmpid;
                                    results += '<td class="1" style="display:none"><input class="form-control" type="text" name="empid" id="txtempid"  value="' + st + '"/></td>';
                                    if (mnth2 == "Sunday)" || sp == "26/Jan") {
                                        results += '<td onmouseover="ChangeBackgroundColor(this)" onmouseout="RestoreBackgroundColor(this)"  id="' + st + '" data-title="brandstatus" class="1"><a id="' + st + '"  onclick="logsclick(this);" title="' + st + '" data-toggle="modal" data-target="#myModal" style="color: brown; cursor: pointer !important;"><span id="spnsalevalue">' + lastweektotattendance[k].salevalue + '</span></a></td>';
                                    }
                                    else {
                                        results += '<td onmouseover="ChangeBackgroundColor(this)" onmouseout="RestoreBackgroundColor(this)"  id="' + st + '" data-title="brandstatus" class="1"><a id="' + st + '"  onclick="logsclick(this);" title="' + st + '" data-toggle="modal" data-target="#myModal" style="cursor: pointer !important;"><span id="spnsalevalue">' + lastweektotattendance[k].salevalue + '</span></a></td>';
                                    }
                                    results += '<td style="display:none" data-title="brandstatus" class="2">' + lastweektotattendance[k].LogDate + '</td>';
                                    results += '<td style="display:none" data-title="brandstatus" class="2"><span id="spnparlorid">' + lastweektotattendance[k].parlorid + '</span></td>';
                                    results += '<td style="display:none" data-title="brandstatus" class="clsmoniterqty">' + lastweektotattendance[k].salevalue + '</td>';
                                    d = 0;
                                }
                            }
                        }
                        if (d == 1) {
                            var status = "A"
                            st = 1 + '-' + 1;
                            results += '<td class="1" style="display:none"><input class="form-control" type="text" name="empid" id="txtempid"  value="' + st + '"/></td>';
                            results += '<td id="' + st + '" data-title="brandstatus" class="1"><a id="' + st + '"   title="' + st + '" data-toggle="modal" data-target="#myModals">0</a></td>';
                            results += '<td style="display:none" data-title="brandstatus" class="2"></td>';
                        }
                    }
                    results += '</tr>';
                }
            }
            results += '</table></div>';
            $("#divsaledata").html(results);
            lastweekemptytable4 = [];
            //GetTotalCal3();
        }
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
            var results = '<div class="box-body" style="padding:0px !important;"><table id="posTable" style="font-weight: 800 !important; text-align: right;" class="table table-bordered  dataTable no-footer" role="grid" aria-="" describedby="example2_info">';
            results += '<thead><tr role="row" class="trbgclrcls">';
            results += '<th scope="col" style="text-align:left;width: 150px;display:none"><i class="fa fa-user" aria-hidden="true"></i> Parlor Name</th>';
            for (var i = 0; i < currentweekTotalDate.length; i++) {
                var dta = currentweekTotalDate[i].Betweendates;
                var mysplit = dta.split("(");
                var dm = mysplit[0];
                var day = mysplit[1]
                results += '<th scope="col" id="txtDate" style=""><i class="fa fa-calendar" aria-hidden="true"></i> ' + dm + ' </br> (' + day + '</th>';
            }
            results += '<th scope="col" style="text-align:left;"> Total</th>';
            results += '</tr></thead></tbody>';
            var totalpossalevalue = 0;
            for (var i = 0; i < currentweektotattendance.length; i++) {
                results += '<tr>';
                var parlorname = currentweektotattendance[i].parlorname
                if (currentweekemptytable4.indexOf(parlorname) == -1) {
                    results += '<td data-title="brandstatus" class="4" style="text-align:left;display:none;">' + currentweektotattendance[i].parlorname + '</td>';
                    results += '<td style="display:none" data-title="brandstatus" class="3">' + currentweektotattendance[i].parlorid + '</td>';
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
                                    var mysplit = logdt.split("(");
                                    var sp = mysplit[0];
                                    var res = logdt.split("/");
                                    var mnth = res[1];
                                    var res2 = mnth.split("(");
                                    var mnth2 = res2[1];
                                    var cmpid = currentweektotattendance[k].cmpid;
                                    results += '<td class="1" style="display:none"><input class="form-control" type="text" name="empid" id="txtempid"  value="' + st + '"/></td>';
                                    if (mnth2 == "Sunday)" || sp == "26/Jan") {
                                        results += '<td onmouseover="ChangeBackgroundColor(this)" onmouseout="RestoreBackgroundColor(this)"  id="' + st + '" data-title="brandstatus" class="1"><a id="' + st + '"  onclick="logsclick(this);" title="' + st + '" data-toggle="modal" data-target="#myModal" style="color: #126b16 !important; cursor: pointer !important;"><span id="spnsalevalue">' + currentweektotattendance[k].salevalue + '</span></a></td>';
                                    }
                                    else {
                                        results += '<td onmouseover="ChangeBackgroundColor(this)" onmouseout="RestoreBackgroundColor(this)"  id="' + st + '" data-title="brandstatus" class="1"><a id="' + st + '"  onclick="logsclick(this);" title="' + st + '" data-toggle="modal" data-target="#myModal" style="color: #126b16 !important; cursor: pointer !important;"><span id="spnsalevalue">' + currentweektotattendance[k].salevalue + '</span></a></td>';
                                    }
                                    totalbranchvalue += parseFloat(currentweektotattendance[k].salevalue);
                                    results += '<td style="display:none" data-title="brandstatus" class="2">' + currentweektotattendance[k].LogDate + '</td>';
                                    results += '<td style="display:none" data-title="brandstatus" class="2"><span id="spnparlorid">' + currentweektotattendance[k].parlorid + '</span></td>';
                                    results += '<td style="display:none" data-title="brandstatus" class="clsmoniterqty">' + currentweektotattendance[k].salevalue + '</td>';
                                    d = 0;
                                }
                                else {

                                }
                            }
                            else {

                            }

                        }

                        if (d == 1) {
                            var status = "A"
                            st = 1 + '-' + 1;
                            results += '<td class="1" style="display:none"><input class="form-control" type="text" name="empid" id="txtempid"  value="' + st + '"/></td>';
                            results += '<td id="' + st + '" data-title="brandstatus" class="1"><a id="' + st + '"   title="' + st + '" data-toggle="modal" data-target="#myModals">0</a></td>';
                            results += '<td style="display:none" data-title="brandstatus" class="2"></td>';
                        }
                    }
                    results += '<td style="color: #009270;" data-title="brandstatus" class="clsmoniterqty">' + totalbranchvalue + '</td>';
                    results += '</tr>';
                }
            }
            results += '</table></div>';
            $("#divsaleval").html(results);
            currentweekemptytable4 = [];
            //GetTotalCal3();
        }


        function get_possalevalue_details() {
            var data = { 'op': 'get_possalevalue_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        BindsalvalueGrid(msg);
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
        var TotalDate = []; var attendancearry = []; var totattendance = []; var emptytable4 = [];
        function BindsalvalueGrid(msg) {
            TotalDate = msg[0].Allbiomertcdates;
            totattendance = msg[0].salevalue;
            var results = '<div class="box-body" style=""><table id="posTable" style="font-weight: 800 !important; text-align: right;" class="table table-bordered  dataTable no-footer" role="grid" aria-="" describedby="example2_info">';
            results += '<thead><tr role="row" class="trbgclrcls">';
            results += '<th scope="col" style="text-align:left;width: 150px;display:none;"><i class="fa fa-user" aria-hidden="true"></i> Parlor Name</th>';
            for (var i = 0; i < TotalDate.length; i++) {
                var dta = TotalDate[i].Betweendates;
                var mysplit = dta.split("(");
                var dm = mysplit[0];
                var day = mysplit[1]
                results += '<th scope="col" id="txtDate" style="width: 59px;"><i class="fa fa-calendar" aria-hidden="true"></i> ' + dm + ' </br> (' + day + '</th>';
            }

            results += '</tr></thead></tbody>';
            var totalpossalevalue = 0;
            for (var i = 0; i < totattendance.length; i++) {
                results += '<tr>';
                var parlorname = totattendance[i].parlorname
                if (emptytable4.indexOf(parlorname) == -1) {
                    results += '<td data-title="brandstatus" class="4" style="text-align:left;display:none;">' + totattendance[i].parlorname + '</td>';
                    results += '<td style="display:none" data-title="brandstatus" class="3">' + totattendance[i].parlorid + '</td>';
                    emptytable4.push(parlorname);
                    for (var j = 0; j < TotalDate.length; j++) {
                        var d = 1;
                        for (var k = 0; k < totattendance.length; k++) {
                            if (TotalDate[j].Betweendates == totattendance[k].LogDate && parlorname == totattendance[k].parlorname) {
                                if (totattendance[k].salevalue != "") {
                                    var st = totattendance[k].parlorid + '-' + totattendance[k].LogDate;
                                    //20/Jan(Sunday)
                                    var logdt = totattendance[k].LogDate;
                                    var mysplit = logdt.split("(");
                                    var sp = mysplit[0];
                                    var res = logdt.split("/");
                                    var mnth = res[1];
                                    var res2 = mnth.split("(");
                                    var mnth2 = res2[1];
                                    var cmpid = totattendance[k].cmpid;
                                    results += '<td class="1" style="display:none"><input class="form-control" type="text" name="empid" id="txtempid"  value="' + st + '"/></td>';
                                    if (mnth2 == "Sunday)" || sp == "26/Jan") {
                                        results += '<td onmouseover="ChangeBackgroundColor(this)" onmouseout="RestoreBackgroundColor(this)"  id="' + st + '" data-title="brandstatus" class="1"><a id="' + st + '"  onclick="logsclick(this);" title="' + st + '" data-toggle="modal" data-target="#myModal" style="color: brown; cursor: pointer !important;"><span id="spnsalevalue">' + totattendance[k].salevalue + '</span></a></td>';
                                    }
                                    else {
                                        results += '<td onmouseover="ChangeBackgroundColor(this)" onmouseout="RestoreBackgroundColor(this)"  id="' + st + '" data-title="brandstatus" class="1"><a id="' + st + '"  onclick="logsclick(this);" title="' + st + '" data-toggle="modal" data-target="#myModal" style="cursor: pointer !important;"><span id="spnsalevalue">' + totattendance[k].salevalue + '</span></a></td>';
                                    }
                                    results += '<td style="display:none" data-title="brandstatus" class="2">' + totattendance[k].LogDate + '</td>';
                                    results += '<td style="display:none" data-title="brandstatus" class="2"><span id="spnparlorid">' + totattendance[k].parlorid + '</span></td>';
                                    results += '<td style="display:none" data-title="brandstatus" class="clsmoniterqty">' + totattendance[k].salevalue + '</td>';
                                    d = 0;
                                }
                            }
                        }
                        if (d == 1) {
                            var status = "A"
                            st = 1 + '-' + 1;
                            results += '<td class="1" style="display:none"><input class="form-control" type="text" name="empid" id="txtempid"  value="' + st + '"/></td>';
                            results += '<td id="' + st + '" data-title="brandstatus" class="1"><a id="' + st + '"   title="' + st + '" data-toggle="modal" data-target="#myModals">0</a></td>';
                            results += '<td style="display:none" data-title="brandstatus" class="2"></td>';
                        }
                    }
                    results += '</tr>';
                }
            }
            results += '</table></div>';
            $("#divoverallsaledata").html(results);
            emptytable4 = [];
            //GetTotalCal3();
        }
        var DataTable = [];
        function GetTotalCal3() {

        }
        function calculateColumn(index) {
            var total = 0;
            $('table tr').each(function () {
                var value = parseInt($('td', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('table tfoot td').eq(index).text('Total: ' + total);
        }
        var rweekTotalDate = []; var rweekattendancearry = []; var rweektotattendance = []; var rweekemptytable4 = [];
        function rightbind(msg) {
            rweekTotalDate = msg[0].Allbiomertcdates;
            rweektotattendance = msg[0].salevalue;
            var results = '<div class="box-body"><table id="tblbiologs" style="font-weight: 800 !important;" class="table table-bordered  dataTable no-footer" role="grid" aria-="" describedby="example2_info">';
            results += '<thead><tr role="row" class="trbgclrcls">';
            results += '<th scope="col" style="text-align:left;display:none;"> Sno</th>';
            results += '<th scope="col" style="text-align:left;display:none;"><i class="fa fa-user" aria-hidden="true"></i> Parlor Id</th>';
            results += '<th scope="col" style="text-align:left;"><i class="fa fa-user" aria-hidden="true"></i> Parlor Name</th>';
            for (var i = 0; i < rweekTotalDate.length; i++) {
                var dta = rweekTotalDate[i].Betweendates;
                var mysplit = dta.split("_");
                var dm = mysplit[0];
                var day = mysplit[1]
                var day2 = mysplit[2]
                // W1_01 / Jan_08 / Jan
                results += '<th scope="col" id="txtDate"><i class="fa fa-calendar" aria-hidden="true"></i> ' + dm + ' </br> (' + day + '-' + day2 + ')</th>';
                //results += '<th scope="col" id="txtDate"><i class="fa fa-calendar" aria-hidden="true"></i> ' + rweekTotalDate[i].Betweendates + '</th>';
            }
            results += '</tr></thead></tbody>';
            for (var i = 0; i < rweektotattendance.length; i++) {
                var k = i + 1;
                var totalval = 0;
                results += '<tr><td scope="row" style="text-align: left; font-weight: bold; display:none;">' + k + '</td>';
                results += '<td scope="row" class="1" style="text-align: left; font-weight: bold; display:none;" >' + rweektotattendance[i].parlorid + '</td>';
                results += '<td scope="row" class="2" style="text-align: left; font-weight: bold;" >' + rweektotattendance[i].parlorname + '</td>';

                var week1 = rweektotattendance[i].week1;
                if (week1 == "") {
                    week1 = "0";
                }
                var week2 = rweektotattendance[i].week2;
                if (week2 == "") {
                    week2 = "0";
                }
                var week3 = rweektotattendance[i].week3;
                if (week3 == "") {
                    week3 = "0";
                }
                var week4 = rweektotattendance[i].week4;
                if (week4 == "") {
                    week4 = "0";
                }

                results += '<td scope="row" onmouseover="ChangeBackgroundColor(this)" onmouseout="RestoreBackgroundColor(this)" class="3" style="text-align: right; font-weight: bold;"><a id="' + rweektotattendance[i].linkval1 + '"  onclick="rweeklogsclick1(this);" title="' + rweektotattendance[i].linkval1 + '" data-toggle="modal" data-target="" style="cursor: pointer !important;">' + week1 + '</a></td>';
                results += '<td scope="row" onmouseover="ChangeBackgroundColor(this)" onmouseout="RestoreBackgroundColor(this)" class="3" style="text-align: right; font-weight: bold;"><a id="' + rweektotattendance[i].linkval2 + '"  onclick="rweeklogsclick2(this);" title="' + rweektotattendance[i].linkval2 + '" data-toggle="modal" data-target="" style="cursor: pointer !important;">' + week2 + '</a></td>';
                results += '<td scope="row" onmouseover="ChangeBackgroundColor(this)" onmouseout="RestoreBackgroundColor(this)" class="3" style="text-align: right; font-weight: bold;"><a id="' + rweektotattendance[i].linkval3 + '"  onclick="rweeklogsclick3(this);" title="' + rweektotattendance[i].linkval3 + '" data-toggle="modal" data-target="" style="cursor: pointer !important;">' + week3 + '</a></td>';
                results += '<td scope="row" onmouseover="ChangeBackgroundColor(this)" onmouseout="RestoreBackgroundColor(this)" class="3" style="text-align: right; font-weight: bold;"><a id="' + rweektotattendance[i].linkval4 + '"  onclick="rweeklogsclick4(this);" title="' + rweektotattendance[i].linkval4 + '" data-toggle="modal" data-target="" style="cursor: pointer !important;">' + week4 + '</a></td>';
                totalval = parseFloat(rweektotattendance[i].week1) + parseFloat(rweektotattendance[i].week2) + parseFloat(rweektotattendance[i].week3) + parseFloat(rweektotattendance[i].week4)
                //                results += '<td style="" class="10">' + parseFloat(totalval) + '</td>';
                results += '<td style="display:none" class="11">' + rweektotattendance[i].parlorid + '</td></tr>';
            }
            results += '</table></div>';
            $("#divrsaledata").html(results);
        }


        var weekTotalDate = []; var weekattendancearry = []; var weektotattendance = []; var weekemptytable4 = [];
        function weekbind(msg) {
            weekTotalDate = msg[0].Allbiomertcdates;
            weektotattendance = msg[0].salevalue;
            var results = '<div class="box-body"><table id="tblbiologs" style="font-weight: 800 !important;" class="table table-bordered  dataTable no-footer" role="grid" aria-="" describedby="example2_info">';
            results += '<thead><tr role="row" class="trbgclrcls">';
            results += '<th scope="col" style="text-align:left;"> Sno</th>';
            results += '<th scope="col" style="text-align:left;"><i class="fa fa-user" aria-hidden="true"></i> Parlor Id</th>';
            results += '<th scope="col" style="text-align:left;"><i class="fa fa-user" aria-hidden="true"></i> Parlor Name</th>';
            for (var i = 0; i < weekTotalDate.length; i++) {
                results += '<th scope="col" id="txtDate"><i class="fa fa-calendar" aria-hidden="true"></i> ' + weekTotalDate[i].Betweendates + '</th>';
            }
            results += '</tr></thead></tbody>';
            for (var i = 0; i < weektotattendance.length; i++) {
                var k = i + 1;
                results += '<tr><td scope="row" style="text-align: left; font-weight: bold;">' + k + '</td>';
                results += '<td scope="row" class="1" style="text-align: left; font-weight: bold;" >' + weektotattendance[i].parlorid + '</td>';
                results += '<td scope="row" class="2" style="text-align: left; font-weight: bold;" >' + weektotattendance[i].parlorname + '</td>';
                results += '<td scope="row" class="3" style="text-align: right; font-weight: bold;"><a id="' + weektotattendance[i].linkval1 + '"  onclick="weeklogsclick1(this);" title="' + weektotattendance[i].linkval1 + '" data-toggle="modal" data-target="#divweekwisedate" style="cursor: pointer !important;">' + weektotattendance[i].week1 + '</a></td>';
                results += '<td scope="row" class="3" style="text-align: right; font-weight: bold;"><a id="' + weektotattendance[i].linkval2 + '"  onclick="weeklogsclick2(this);" title="' + weektotattendance[i].linkval2 + '" data-toggle="modal" data-target="#divweekwisedate" style="cursor: pointer !important;">' + weektotattendance[i].week2 + '</a></td>';
                results += '<td scope="row" class="3" style="text-align: right; font-weight: bold;"><a id="' + weektotattendance[i].linkval3 + '"  onclick="weeklogsclick3(this);" title="' + weektotattendance[i].linkval3 + '" data-toggle="modal" data-target="#divweekwisedate" style="cursor: pointer !important;">' + weektotattendance[i].week3 + '</a></td>';
                results += '<td scope="row" class="3" style="text-align: right; font-weight: bold;"><a id="' + weektotattendance[i].linkval4 + '"  onclick="weeklogsclick4(this);" title="' + weektotattendance[i].linkval4 + '" data-toggle="modal" data-target="#divweekwisedate" style="cursor: pointer !important;">' + weektotattendance[i].week4 + '</a></td>';


                results += '<td scope="row" class="7" style="text-align: right; font-weight: bold; display:none" >' + weektotattendance[i].linkval1 + '</td>';
                results += '<td data-title="code" class="8" style="text-align: right; font-weight: bold; display:none">' + weektotattendance[i].linkval2 + '</th>';
                results += '<td data-title="code" class="9" style="text-align: right; font-weight: bold; display:none">' + weektotattendance[i].linkval3 + '</th>';
                results += '<td data-title="code" class="10" style="text-align: right; font-weight: bold; display:none">' + weektotattendance[i].linkval4 + '</th>';
                results += '<td style="display:none" class="11">' + weektotattendance[i].parlorid + '</td></tr>';
            }
            results += '</table></div>';
            $("#divweekvalue").html(results);
        }

        function weeklogsclick1(thisid) {
            var parlorid = $(thisid).attr('title');
            var data = { 'op': 'get_weekpossalevalue_details', 'parlorid': parlorid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillweekdatevalue(msg)
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function weeklogsclick2(thisid) {
            var parlorid = $(thisid).attr('title');
            var data = { 'op': 'get_weekpossalevalue_details', 'parlorid': parlorid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillweekdatevalue(msg)
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function weeklogsclick3(thisid) {
            var parlorid = $(thisid).attr('title');
            var data = { 'op': 'get_weekpossalevalue_details', 'parlorid': parlorid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillweekdatevalue(msg)
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function weeklogsclick4(thisid) {
            var parlorid = $(thisid).attr('title');
            var data = { 'op': 'get_weekpossalevalue_details', 'parlorid': parlorid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillweekdatevalue(msg)
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }


        function rweeklogsclick4(thisid) {
            var parlorid = $(thisid).attr('title');
            var data = { 'op': 'get_weekpossalevalue_details', 'parlorid': parlorid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        rfillweekdatevalue(msg)
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }

        function rweeklogsclick3(thisid) {
            var parlorid = $(thisid).attr('title');
            var data = { 'op': 'get_weekpossalevalue_details', 'parlorid': parlorid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        rfillweekdatevalue(msg)
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }

        function rweeklogsclick2(thisid) {
            var parlorid = $(thisid).attr('title');
            var data = { 'op': 'get_weekpossalevalue_details', 'parlorid': parlorid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        rfillweekdatevalue(msg)
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }

        function rweeklogsclick1(thisid) {
            var parlorid = $(thisid).attr('title');
            var data = { 'op': 'get_weekpossalevalue_details', 'parlorid': parlorid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        rfillweekdatevalue(msg)
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        var emptytable5 = [];
        function fillweekdatevalue(msg) {
            TotalDate = msg[0].Allbiomertcdates;
            totattendance = msg[0].salevalue;
            var results = '<div class="box-body" style="padding:0px !important;"><table id="tblbiologs" style="font-weight: 800 !important;" class="table table-bordered  dataTable no-footer" role="grid" aria-="" describedby="example2_info">';
            results += '<thead><tr role="row" class="trbgclrcls">';
            results += '<th scope="col" style="text-align:left;"><i class="fa fa-user" aria-hidden="true"></i> Parlor Name</th>';
            for (var i = 0; i < TotalDate.length; i++) {
                results += '<th scope="col" id="txtDate"><i class="fa fa-calendar" aria-hidden="true"></i> ' + TotalDate[i].Betweendates + '</th>';
            }
            results += '</tr></thead></tbody>';
            for (var i = 0; i < totattendance.length; i++) {
                results += '<tr>';
                var parlorname = totattendance[i].parlorname
                if (emptytable5.indexOf(parlorname) == -1) {
                    results += '<td data-title="brandstatus" class="4">' + totattendance[i].parlorname + '</td>';
                    results += '<td style="display:none" data-title="brandstatus" class="3">' + totattendance[i].parlorid + '</td>';
                    emptytable5.push(parlorname);
                    for (var j = 0; j < TotalDate.length; j++) {
                        var d = 1;
                        for (var k = 0; k < totattendance.length; k++) {
                            if (TotalDate[j].Betweendates == totattendance[k].LogDate && parlorname == totattendance[k].parlorname) {
                                if (totattendance[k].salevalue != "") {
                                    var st = totattendance[k].parlorid + '-' + totattendance[k].LogDate;
                                    //20/Jan(Sunday)
                                    var logdt = totattendance[k].LogDate;
                                    var res = logdt.split("/");
                                    var mnth = res[1];
                                    var res2 = mnth.split("(");
                                    var mnth2 = res2[1];
                                    results += '<td class="1" style="display:none"><input class="form-control" type="text" name="empid" id="txtempid"  value="' + st + '"/></td>';
                                    if (mnth2 == "Sunday)") {
                                        results += '<td style="text-align:right;" onmouseover="ChangeBackgroundColor(this)" onmouseout="RestoreBackgroundColor(this)"  id="' + st + '" data-title="brandstatus" class="1"><a id="' + st + '"  onclick="WEEKDATElogsclick(this);" title="' + st + '" data-toggle="modal" data-target="#divws" style="color: brown;cursor: pointer !important;">' + totattendance[k].salevalue + '</a></td>';
                                    }
                                    else {
                                        results += '<td style="text-align:right;" onmouseover="ChangeBackgroundColor(this)" onmouseout="RestoreBackgroundColor(this)"  id="' + st + '" data-title="brandstatus" class="1"><a id="' + st + '"  onclick="WEEKDATElogsclick(this);" title="' + st + '" data-toggle="modal" data-target="#divws" style="cursor: pointer !important;">' + totattendance[k].salevalue + '</a></td>';
                                    }
                                    results += '<td style="display:none" data-title="brandstatus" class="2">' + totattendance[k].LogDate + '</td>';
                                    d = 0;
                                }
                            }
                        }
                        if (d == 1) {
                            var status = "A"
                            st = 1 + '-' + 1;
                            results += '<td class="1" style="display:none"><input class="form-control" type="text" name="empid" id="txtempid"  value="' + st + '"/></td>';
                            results += '<td id="' + st + '" data-title="brandstatus" class="1"><a id="' + st + '"   title="' + st + '" data-toggle="modal" data-target="#myModals">0</a></td>';
                            results += '<td style="display:none" data-title="brandstatus" class="2"></td>';
                        }
                    }
                    results += '</tr>';
                }
            }
            results += '</table></div>';
            $("#divweekdate").html(results);
            emptytable5 = []
        }


        var emptytable5 = [];
        function rfillweekdatevalue(msg) {
            TotalDate = msg[0].Allbiomertcdates;
            totattendance = msg[0].salevalue;
            var results = '<div class="box-body" style="padding:0px !important;"><table id="tblbiologs" style="font-weight: 800 !important;" class="table table-bordered  dataTable no-footer" role="grid" aria-="" describedby="example2_info">';
            results += '<thead><tr role="row" class="trbgclrcls">';
            results += '<th scope="col" style="text-align:left;width: 150px;"><i class="fa fa-user" aria-hidden="true"></i> Parlor Name</th>';
            for (var i = 0; i < TotalDate.length; i++) {
                var dta = TotalDate[i].Betweendates;
                var mysplit = dta.split("(");
                var dm = mysplit[0];
                var day = mysplit[1]
                results += '<th scope="col" id="txtDate" style="width: 59px;"><i class="fa fa-calendar" aria-hidden="true"></i> ' + dm + ' </br> (' + day + '</th>';
            }
            results += '</tr></thead></tbody>';
            for (var i = 0; i < totattendance.length; i++) {
                results += '<tr>';
                var parlorname = totattendance[i].parlorname
                if (emptytable5.indexOf(parlorname) == -1) {
                    results += '<td data-title="brandstatus" class="4">' + totattendance[i].parlorname + '</td>';
                    results += '<td style="display:none" data-title="brandstatus" class="3">' + totattendance[i].parlorid + '</td>';
                    emptytable5.push(parlorname);
                    for (var j = 0; j < TotalDate.length; j++) {
                        var d = 1;
                        for (var k = 0; k < totattendance.length; k++) {
                            if (TotalDate[j].Betweendates == totattendance[k].LogDate && parlorname == totattendance[k].parlorname) {
                                if (totattendance[k].salevalue != "") {
                                    var st = totattendance[k].parlorid + '-' + totattendance[k].LogDate;
                                    //20/Jan(Sunday)
                                    var logdt = totattendance[k].LogDate;
                                    var res = logdt.split("/");
                                    var mnth = res[1];
                                    var res2 = mnth.split("(");
                                    var mnth2 = res2[1];
                                    results += '<td class="1" style="display:none"><input class="form-control" type="text" name="empid" id="txtempid"  value="' + st + '"/></td>';
                                    if (mnth2 == "Sunday)") {
                                        results += '<td style="text-align:right;" onmouseover="ChangeBackgroundColor(this)" onmouseout="RestoreBackgroundColor(this)"  id="' + st + '" data-title="brandstatus" class="1"><a id="' + st + '"  onclick="WEEKDATElogsclick(this);" title="' + st + '" data-toggle="modal" data-target="#divws" style="color: brown; cursor: pointer !important;">' + totattendance[k].salevalue + '</a></td>';
                                    }
                                    else {
                                        results += '<td style="text-align:right;" onmouseover="ChangeBackgroundColor(this)" onmouseout="RestoreBackgroundColor(this)"  id="' + st + '" data-title="brandstatus" class="1"><a id="' + st + '"  onclick="WEEKDATElogsclick(this);" title="' + st + '" data-toggle="modal" data-target="#divws" style="cursor: pointer !important;">' + totattendance[k].salevalue + '</a></td>';
                                    }
                                    results += '<td style="display:none" data-title="brandstatus" class="2">' + totattendance[k].LogDate + '</td>';
                                    d = 0;
                                }
                            }
                        }
                        if (d == 1) {
                            var status = "A"
                            st = 1 + '-' + 1;
                            results += '<td class="1" style="display:none"><input class="form-control" type="text" name="empid" id="txtempid"  value="' + st + '"/></td>';
                            results += '<td id="' + st + '" data-title="brandstatus" class="1"><a id="' + st + '"   title="' + st + '" data-toggle="modal" data-target="#myModals">0</a></td>';
                            results += '<td style="display:none" data-title="brandstatus" class="2"></td>';
                        }
                    }
                    results += '</tr>';
                }
            }
            results += '</table></div>';
            $("#divsaleval").html(results);
            emptytable5 = []
        }

        function WEEKDATElogsclick(thisid) {
            var parlorid = $(thisid).attr('title');
            var data = { 'op': 'getdatewise_WEEKsubcategorywisesalevalue', 'parlorid': parlorid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillWEEKsubcategorydatewisesalevalue(msg)
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }

        function fillWEEKsubcategorydatewisesalevalue(msg) {
            var results = '<div  class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbl_Stores_value">';
            results += '<thead><tr role="row" class="trbgclrcls"><th scope="col" style="width: 10px">Sno</th><th scope="col">Sub Category Name</th><th scope="col">Sale Value</th><th scope="col">Quantity</th></tr></thead></tbody>';
            var totalsubcatsalevalue = 0;
            var totalsubcatAvgsale = 0;

            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr><td scope="row" style="text-align: left; font-weight: bold;">' + k + '</td>';
                results += '<td scope="row" class="1" style="text-align: left; font-weight: bold;" >' + msg[i].subcategoryname + '</td>';
                results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + parseFloat(msg[i].totvalue).toFixed(0) + '</td>';
                totalsubcatsalevalue += parseFloat(msg[i].totvalue);
                results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;">' + parseFloat(msg[i].Avgsale).toFixed(0) + '</th>';
                results += '<td style="text-align: right;"><a href="#" onclick="viewitemSUBCATwisedetails(this);"  title="View Details" data-toggle="modal" data-target="#divcatsubdata" class="tip btn btn-warning btn-xs"><i class="fa fa-list"></i></a></td>';
                results += '<td style="display:none" class="6">' + msg[i].parlorid + '</td>';
                results += '<td style="display:none" class="5">' + msg[i].subcategoryid + '</td></tr>';
            }
            results += '<tr style="background-color: cadetblue;color: whitesmoke;"><td scope="row" style="text-align: right; font-weight: bold;"></td>';
            results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >Total</td>';
            results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + parseFloat(totalsubcatsalevalue).toFixed(0) + '</td>';
            results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;"></th>';
            results += '<td style="display:none" class="5"></td></tr>';
            results += '</table></div>';
            $("#divweeksubcatdata").html(results);
        }


        function logsclick(thisid) {
            var parlorid = $(thisid).attr('title');
            var data = { 'op': 'getdatewise_subcategorywisesalevalue', 'parlorid': parlorid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillsubcategorydatewisesalevalue(msg)
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }

        function fillsubcategorydatewisesalevalue(msg) {
            var results = '<div  class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbl_Stores_value">';
            results += '<thead><tr role="row" class="trbgclrcls"><th scope="col" style="width: 10px">Sno</th><th scope="col">Sub Category Name</th><th scope="col">Sale Value</th><th scope="col">Quantity</th></tr></thead></tbody>';
            var totalsubcatsalevalue = 0;
            var totalsubcatAvgsale = 0;

            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr><td scope="row" style="text-align: left; font-weight: bold;">' + k + '</td>';
                results += '<td scope="row" class="1" style="text-align: left; font-weight: bold;" >' + msg[i].subcategoryname + '</td>';
                results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + parseFloat(msg[i].totvalue).toFixed(0) + '</td>';
                totalsubcatsalevalue += parseFloat(msg[i].totvalue);
                results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;">' + parseFloat(msg[i].Avgsale).toFixed(0) + '</th>';
                results += '<td style="text-align: right;"><a href="#" onclick="viewitemSUBCATwisedetails(this);" data-toggle="modal" data-target="#divcatsubdata" title="View Details" class="tip btn btn-warning btn-xs"><i class="fa fa-list"></i></a></td>';
                results += '<td style="display:none" class="6">' + msg[i].parlorid + '</td>';
                results += '<td style="display:none" class="5">' + msg[i].subcategoryid + '</td></tr>';
            }
            results += '<tr style="background-color: cadetblue;color: whitesmoke;"><td scope="row" style="text-align: right; font-weight: bold;"></td>';
            results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >Total</td>';
            results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + parseFloat(totalsubcatsalevalue).toFixed(0) + '</td>';
            results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;"></th>';
            results += '<td style="display:none" class="5"></td></tr>';
            results += '</table></div>';
            $("#divsubcatdata1").html(results);
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
        function get_sale_details() {
            var data = { 'op': 'get_parlorwisesale_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillsaledetails(msg);
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }

        function fillsaledetails(msg) {
            var results = '<div  class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbl_Stores_value">';
            results += '<thead><tr role="row" class="trbgclrcls"><th scope="col" style="width: 10px">Sno</th><th scope="col">Parlor Name</th><th scope="col">Sale Value</th></tr></thead></tbody>';
            var totalsalevalue = 0;
            var totalpurchasevalue = 0;
            var totalexpencesvalue = 0;
            var totalprofit = 0;
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr><td scope="row" style="text-align: right; font-weight: bold;">' + k + '</td>';
                results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + msg[i].branchname + '</td>';
                results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + parseFloat(msg[i].salevalue).toFixed(0) + '</td>';
                //                results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;">' + parseFloat(msg[i].purchasevalue).toFixed(0) + '</th>';
                //                results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;">' + parseFloat(msg[i].expencesvalue).toFixed(0) + '</th>';
                //                results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;">' + parseFloat(msg[i].profit).toFixed(0) + '</th>';
                results += '<td style="text-align: right;"><a href="#" onclick="viewdetails(this);" title="View Details" class="tip btn btn-warning btn-xs"><i class="fa fa-list"></i></a></td>';
                results += '<td style="display:none" class="4">' + msg[i].parlorid + '</td></tr>';
                totalsalevalue += parseFloat(msg[i].salevalue);
                totalpurchasevalue += parseFloat(msg[i].purchasevalue);
                totalexpencesvalue += parseFloat(msg[i].expencesvalue);
                totalprofit += parseFloat(msg[i].profit);
            }
            results += '<tr style="background-color: cadetblue;color: whitesmoke;">';
            results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" ></td>';
            results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >Total</td>';
            results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + parseFloat(totalsalevalue).toFixed(0) + '</td>';
            //            results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;">' + parseFloat(totalpurchasevalue).toFixed(0) + '</th>';
            //            results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;">' + parseFloat(totalexpencesvalue).toFixed(0) + '</th>';
            //            results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;">' + parseFloat(totalprofit).toFixed(0) + '</th>';
            results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;"></th>';
            results += '<td style="display:none" class="4"></td></tr>';
            results += '</table></div>';
            $("#divsaledata").html(results);
        }
        function getmethisdelete(thisid) {
            return confirm('You are going to delete Sale, please Contact To Management.');
        }
        var bid = "";
        function viewdetails(thisid) {
            scrollTo(0, 0);
            $("#divtodaysale").modal({ backdrop: "static" })
            var sno = $(thisid).parent().parent().children('.4').html();
            bid = sno;
            var data = { 'op': 'get_subcategorywisesalevalue_details', 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillsubcategorywisesale(msg);
                    }
                    else {
                        var results = '<div  class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbl_Stores_value">';
                        results += '<thead><tr role="row" class="trbgclrcls"><th scope="col" style="width: 10px">Sno</th><th scope="col">Sub Category Name</th><th scope="col">Sale Value</th><th scope="col">Quantity</th><th scope="col" style="font-weight: bold;">Actions</th></tr></thead></tbody>';
                        results += '</table></div>';
                        $("#divsubcatdata").html(results);
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
            var results = '<div  class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbl_Stores_value">';
            results += '<thead><tr role="row" class="trbgclrcls"><th scope="col" style="width: 10px">Sno</th><th scope="col">Category Name</th><th scope="col">Sale Value</th><th scope="col">Quantity</th><th scope="col" style="font-weight: bold;">Actions</th></tr></thead></tbody>';
            var totalsubcatsalevalue = 0;
            var totalsubcatAvgsale = 0;

            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr><td scope="row" style="text-align: right; font-weight: bold;">' + k + '</td>';
                results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + msg[i].subcategoryname + '</td>';
                results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + parseFloat(msg[i].totvalue).toFixed(0) + '</td>';
                totalsubcatsalevalue += parseFloat(msg[i].totvalue);
                results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;">' + parseFloat(msg[i].Avgsale).toFixed(0) + '</th>';
                results += '<td style="text-align: right;"><a href="#" onclick="viewitemSUBCATwisedetails(this);" data-toggle="modal" data-target="#divcatsubdata" title="View Details" class="tip btn btn-warning btn-xs"><i class="fa fa-list"></i></a></td>';
                results += '<td style="display:none" class="6">' + msg[i].parlorid + '</td>';
                results += '<td style="display:none" class="5">' + msg[i].subcategoryid + '</td></tr>';
            }
            results += '<tr style="background-color: cadetblue;color: whitesmoke;"><td scope="row" style="text-align: right; font-weight: bold;"></td>';
            results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >Total</td>';
            results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + parseFloat(totalsubcatsalevalue).toFixed(0) + '</td>';
            results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;"></th>';
            results += '<td style="display:none" class="22"></td></tr>';
            results += '</table></div>';
            $("#divsubcatdata").html(results);
        }

        //

        function viewitemSUBCATwisedetails(thisid) {
            scrollTo(0, 0);
            var catid = $(thisid).parent().parent().children('.5').html();
            var branchid = $(thisid).parent().parent().children('.6').html();
            var data = { 'op': 'get_subcatitemwisesalevalue_details', 'catid': catid, 'branchid': branchid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillsubcatitemwisesalevalue(msg);
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

        function fillsubcatitemwisesalevalue(msg) {
            var results = '<div  class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbl_Stores_value">';
            results += '<thead><tr role="row" class="trbgclrcls"><th scope="col" style="width: 10px">Sno</th><th scope="col">Sub Category Name</th><th scope="col">Sale Value</th><th scope="col">Quantity</th><th scope="col" style="font-weight: bold;">Actions</th></tr></thead></tbody>';
            var totalsubcatsalevalue = 0;
            var totalsubcatAvgsale = 0;

            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr><td scope="row" style="text-align: right; font-weight: bold;">' + k + '</td>';
                results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + msg[i].subcategoryname + '</td>';
                results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + parseFloat(msg[i].totvalue).toFixed(0) + '</td>';
                totalsubcatsalevalue += parseFloat(msg[i].totvalue);
                results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;">' + parseFloat(msg[i].Avgsale).toFixed(0) + '</th>';
                results += '<td style="text-align: right;"><a href="#" onclick="viewitemwisedetails(this);" data-toggle="modal" data-target="#divitemws" title="View Details" class="tip btn btn-warning btn-xs"><i class="fa fa-list"></i></a></td>';
                results += '<td style="display:none" class="6">' + msg[i].parlorid + '</td>';
                results += '<td style="display:none" class="7">' + msg[i].categoryid + '</td>';
                results += '<td style="display:none" class="5">' + msg[i].subcategoryid + '</td></tr>';
            }
            results += '<tr style="background-color: cadetblue;color: whitesmoke;"><td scope="row" style="text-align: right; font-weight: bold;"></td>';
            results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >Total</td>';
            results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + parseFloat(totalsubcatsalevalue).toFixed(0) + '</td>';
            results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;"></th>';
            results += '<td style="display:none" class="22"></td></tr>';
            results += '</table></div>';
            $("#divcatwisesubdata").html(results);
        }



        function viewitemwisedetails(thisid) {
            scrollTo(0, 0);
            var subcatid = $(thisid).parent().parent().children('.5').html();
            var branchid = $(thisid).parent().parent().children('.6').html();
            var categoryid = $(thisid).parent().parent().children('.7').html();

            var data = { 'op': 'get_itemwisesalevalue_details', 'subcatid': subcatid, 'branchid': branchid, 'categoryid': categoryid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillitemwisesalevalue(msg);
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
        function fillitemwisesalevalue(msg) {
            var results = '<div  class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbl_Stores_value">';
            results += '<thead><tr role="row" class="trbgclrcls"><th scope="col" style="width: 10px">Sno</th><th scope="col">Item Name</th><th scope="col">Sale Value</th><th scope="col">Quantity</th><th scope="col">Tax Value</th></tr></thead></tbody>';
            var totalitemsalevalue = 0;
            var totalitemordertaxvalue = 0;
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr><td scope="row" style="text-align: right; font-weight: bold;">' + k + '</td>';

                results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + msg[i].subcategoryname + '</td>';
                results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + parseFloat(msg[i].totvalue).toFixed(2) + '</td>';
                totalitemsalevalue += parseFloat(msg[i].totvalue);
                results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;">' + parseFloat(msg[i].Avgsale).toFixed(2) + '</th>';
                results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;">' + parseFloat(msg[i].ordertax).toFixed(2) + '</th>';
                totalitemordertaxvalue += parseFloat(msg[i].ordertax);
                results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;display:none">' + parseFloat(msg[i].Avgtax).toFixed(2) + '</th>';
                results += '<td style="display:none" class="6">' + msg[i].parlorid + '</td>';
                results += '<td style="display:none" class="5">' + msg[i].subcategoryid + '</td></tr>';
            }
            results += '<tr style="background-color: cadetblue;color: whitesmoke;"><td scope="row" style="text-align: right; font-weight: bold;"></td>';
            results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" ></td>';
            results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + parseFloat(totalitemsalevalue).toFixed(2) + '</td>';
            results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;"></th>';
            results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;">' + parseFloat(totalitemordertaxvalue).toFixed(2) + '</th>';
            results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;"></th>';
            results += '<td style="display:none" class="5"></td></tr>';
            results += '</table></div>';
            $("#divitemsale").html(results);
        }


        function get_overallitemwisesalevalue() {
            var data = { 'op': 'get_overallitemwisesalevalue' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        filloitemsaledetails(msg);
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }

        function filloitemsaledetails(msg) {
            var results = '<div  class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbl_Stores_value">';
            results += '<thead><tr role="row" class="trbgclrcls"><th scope="col" style="width: 10px">Sno</th><th scope="col">Item Name</th><th scope="col">Sale Value</th><th scope="col">Quantity</th><th scope="col">Billing Sale Value</th><th scope="col">Avg Billing Sale Value</th><th scope="col">Balance</th></tr></thead></tbody>';
            var totalitemsalevalue = 0;
            var totalitembillingsalevalue = 0;
            var totalitemprofitvalue = 0;
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr><td scope="row" style="text-align: right; font-weight: bold;">' + k + '</td>';
                results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + msg[i].productname + '</td>';
                results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + parseFloat(msg[i].Salevalue).toFixed(0) + '</td>';
                results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;">' + parseFloat(msg[i].AvgSalevalue).toFixed(0) + '</th>';
                results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;">' + parseFloat(msg[i].Billingpricevalue).toFixed(0) + '</th>';
                results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;">' + parseFloat(msg[i].AvgBillingpricevalue).toFixed(0) + '</th>';
                var profit = 0;
                var salevalue = parseFloat(msg[i].Salevalue).toFixed(0)
                var Billingpricevalue = parseFloat(msg[i].Billingpricevalue).toFixed(0)
                totalitemsalevalue += parseFloat(msg[i].Salevalue);
                totalitembillingsalevalue += parseFloat(msg[i].Billingpricevalue);
                profit = salevalue - Billingpricevalue;
                totalitemprofitvalue += profit;
                results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;">' + profit + '</th>';
                results += '<td style="display:none" class="4"></td></tr>';
            }
            results += '<tr style="background-color: cadetblue;color: whitesmoke;"><td scope="row" style="text-align: right; font-weight: bold;"></td>';
            results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >Total</td>';
            results += '<td scope="row" class="1" style="text-align: right; font-weight: bold;" >' + parseFloat(totalitemsalevalue).toFixed(0) + '</td>';
            results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;"></th>';
            results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;">' + parseFloat(totalitembillingsalevalue).toFixed(0) + '</th>';
            results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;"></th>';
            results += '<td data-title="code" class="2" style="text-align: right; font-weight: bold;">' + parseFloat(totalitemprofitvalue).toFixed(0) + '</th>';
            results += '<td style="display:none" class="4"></td></tr>';
            results += '</table></div>';
            $("#divoverallsaledata").html(results);
        }

        var outward = [];
        function BindGrid(msg) {
            var sgsttot = 0;
            var cgsttot = 0;
            var sumtotal = 0;
            var taxtotal = 0;
            var grandttol = 0;
            var results = '<table class="table table-striped table-condensed">';
            results += '<thead><tr> <th class="text-center" style="width: 50%; border-bottom: 2px solid #ddd;"> Description </th> <th class="text-center" style="width: 12%; border-bottom: 2px solid #ddd;"> Quantity </th> <th class="text-center" style="width: 24%; border-bottom: 2px solid #ddd;">Price </th> <th class="text-center" style="width: 26%; border-bottom: 2px solid #ddd;"> Subtotal </th> </tr></thead></tbody>';
            var outward_subdetails = msg[0].SubOutward;
            outward = msg[0].OutwardDetails;
            for (var i = 0; i < outward_subdetails.length; i++) {
                results += '<tr>';
                results += '<td style="text-align: right;">' + outward_subdetails[i].productname + '</td>';
                results += '<td style="text-align: right;">' + parseFloat(outward_subdetails[i].Quantity).toFixed(0) + '</td>';
                results += '<td style="text-align: right;">' + parseFloat(outward_subdetails[i].PerUnitRs).toFixed(0) + '</td>';
                results += '<td style="text-align: right;">' + parseFloat(outward_subdetails[i].TotalCost).toFixed(0) + '</td></tr>';
                var taxablevalue = outward_subdetails[i].TotalCost;
                sumtotal += (parseFloat(taxablevalue));
                var ordertax = outward_subdetails[i].ordertax;
                taxtotal += (parseFloat(ordertax));
            }

            var grandtotal = sumtotal + taxtotal;
            var ordertax = taxtotal;
            var grandtotalvalue = parseFloat(grandtotal);
            var grandtotal1 = grandtotalvalue.toFixed(0);
            var diff = 0;
            if (grandtotalvalue > grandtotal1) {
                diff = grandtotalvalue - grandtotal1;
            }
            else {
                diff = grandtotal1 - grandtotalvalue;
            }
            results += '<tr>';
            results += '<td colspan="2" style="text-align: right;">Total</td>';
            results += '<td colspan="2" style="text-align: right;padding-right: 13px;"><span id="spntotalamt">' + sumtotal.toFixed(2) + '</span></td></tr>';

            results += '<tr>';
            results += '<td colspan="2" style="text-align: right;">Order Tax(cgst+sgst)</td>';
            results += '<td colspan="2" style="text-align: right;padding-right: 13px;"><span id="spnordertax">' + ordertax.toFixed(2) + '</span></td></tr>';


            results += '<tr>';
            results += '<td colspan="2" style="text-align: right;">Rounding</td>';
            results += '<td colspan="2" style="text-align: right;padding-right: 13px;"><span id="spnrountoff">' + diff.toFixed(2) + '</span></td></tr>';

            results += '<tr>';
            results += '<td colspan="2" style="text-align: right;">Grand Total	</td>';
            results += '<td colspan="2" style="text-align: right;padding-right: 13px;"><span id="spngrdtotal">' + Math.round(grandtotalvalue).toFixed(2) + '</span></td></tr>';
            results += '</table>';
            grandttol = grandtotalvalue;
            $("#div_OutwardValue").html(results);
            var UserName = '<%=Session["UserName"] %>';
            for (var i = 0; i < outward.length; i++) {
                var date = outward[i].doe;
                var saleno = outward[i].saleno;
                var cname = outward[i].custmorname;
                var saleperson = UserName;
                var modeofcash = outward[i].modeofpay;
                var amount = outward[i].totalpaying
                var change = outward[i].balance;
                var discount = outward[i].discount;
                var dsicountvalue = (grandttol * discount) / 100;
                document.getElementById('spndate').innerHTML = date;
                document.getElementById('spnrefno').innerHTML = saleno;
                document.getElementById('spncname').innerHTML = cname;
                document.getElementById('ssaleperson').innerHTML = saleperson;
                document.getElementById('spnpaymode').innerHTML = modeofcash;
                document.getElementById('spnpayamt').innerHTML = amount;
                document.getElementById('spnchange').innerHTML = Math.round(change).toFixed(0);
                document.getElementById('spndiscount').innerHTML = Math.round(dsicountvalue).toFixed(0);
            }
        }
    </script>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        $('body').addClass('skin-green sidebar-collapse sidebar-mini pos');
    </script>
    <h1>
        Dashboard</h1>
    <ol class="breadcrumb">
        <li><a href="https://vyshnavi/"><i class="fa fa-dashboard"></i>Home</a></li>
        <li class="active">Dashboard</li>
    </ol>
    <section class="content">

    <div class="row">
        <div class="col-xs-12">
            <div class="box box-success" id="divquicklinks">
                <div class="box-header">
                    <h3 class="box-title">Quick Links</h3>
                </div>
                <div class="box-body"  style="padding-top: 9px !important;padding-right: 9px !important; padding-bottom: 9px !important;padding-left: 9px !important;">
                                        <a class="btn btn-app" href="Vpos.aspx">
                        <i class="fa fa-th"></i> POS</a>
                                        <a class="btn btn-app" href="itemmaster.aspx">
                        <i class="fa fa-barcode"></i> Products </a>
                                        <a class="btn btn-app" href="sales.aspx">
                        <i class="fa fa-shopping-cart"></i> Sales                    </a>
                    <a class="btn btn-app" href="opendbills.aspx">
                        <!-- <span class="badge bg-yellow">1</span> -->
                        <i class="fa fa-bell-o"></i> Opened Bills                    </a>
                                        <a class="btn btn-app" href="minimasters.aspx">
                        <i class="fa fa-folder-open"></i> Categories                    </a>
                   
                    <a class="btn btn-app" href="suppliermaster.aspx">
                        <i class="fa fa-users"></i> Customers                    </a>
                                       
                    <a class="btn btn-app" href="#">
                        <i class="fa fa-bar-chart-o"></i> Reports                    </a>
                    <a class="btn btn-app" href="suppliermaster.aspx">
                        <i class="fa fa-users"></i> Users                    </a>
                                   <a class="btn btn-app" href="#">
                        <i class="fa fa-cogs"></i> Settings                    </a>
                                   <a class="btn btn-app" href="#">
                        <i class="fa fa-credit-card"></i> Gift Card                    </a>     
                                       
                                        <a class="btn btn-app" href="#">
                        <i class="fa fa-database"></i> Backups                    </a>
                                      
                                    </div>
            </div>

            <div class="row" id="div3">
            <div class="col-xs-5" style="width: 49% !important;padding-right: 0px !important;padding-left: 15px !important;">
            <div class="box box-primary">
            <div class="box-header" style="text-align: right;">
            
              <h3 class="box-title">Week Wise Sale Value</h3>
             </div>
                
                 <div id="divrsaledata"> </div>
                <div class="dataTables_paginate paging_simple_numbers" id="prTables_paginate" style="text-align: center;"><ul class="pagination"><li class="paginate_button previous" id="prTables_previous"><a href="#" Onclick="prevmonthclick();">Previous</a></li><li class="paginate_button active"><a href="#" aria-controls="prTables" data-dt-idx="1" tabindex="0"></a></li><li class="paginate_button next" id="prTables_next"><a href="#" Onclick="nextmonthclick();">Next</a></li></ul></div>
            </div>
        </div>
        <div class="col-xs-7" style="width:51% !important; padding-right: 0px !important;padding-left: 0px !important;">
            <div class="box box-primary">
            <div class="box-header" style="text-align: right;">
          <a id="a3" href="livegraphchart.aspx" data-toggle="modal" data-target="" style="font-size: 17px;">View Chart</a> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp   <a id="a2" onclick="get_currentweekpossalevalue_details();" data-toggle="modal" data-target="" style="font-size: 17px;">Default</a> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <a id="aweek" onclick="get_weekwisepossale_details();" data-toggle="modal" data-target="#divweek" style="font-size: 17px;">Weekly</a> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <a id="a1" onclick="get_monthwisepossale_details();" data-toggle="modal" data-target="#divmnthsv" style="font-size: 17px;">Monthly</a> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <h3 class="box-title">Day Wise Sale Value</h3>
             </div>
                
                 <div id="divsaleval"> </div>
                 <br />
                
            </div>
        </div>
        
    </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-primary">
                        <div class="box-header">
                            <h3 class="box-title">Parlor Wise Sale Value</h3>
                        </div>
                        <div class="box-body">
                        <div id="divsaledata">
                          </div>
                        </div>
                    </div>
                </div>
            </div>

             <div class="row" style="display:none;">
                <div class="col-md-12">
                    <div class="box box-primary">
                        <div class="box-header">
                            <h3 class="box-title">Parlor Wise Sale Value</h3>
                        </div>
                        <div class="box-body">
                        <div id="divoverallsaledata">
                          </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6" style="display:none;">
                    <div class="box box-primary">
                        <div class="box-header">
                            <h3 class="box-title">Purchase Details</h3>
                        </div>
                        <div class="box-body">
                        <div id="div1">
                          </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6" style="display:none;">
                    <div class="box box-primary">
                        <div class="box-header">
                            <h3 class="box-title">Expences Details</h3>
                        </div>
                        <div class="box-body">
                        <div id="div2">
                          </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


     <div id="ajaxCall">
        <i class="fa fa-spinner fa-pulse"></i>
    </div>
    <div class="modal" data-easein="flipYIn" id="divtodaysale" tabindex="-1" role="dialog"
        aria-labelledby="cModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header modal-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <button type="button" class="close mr10" onclick="window.print();">
                        <i class="fa fa-print"></i>
                    </button>
                    <h4 class="modal-title" id="H2">
                        Today Sale Details
                    </h4>
                </div>
                <form id="Form2" method="post" accept-charset="utf-8">
                <div class="modal-body">
                    <div id="divsubcatdata">
                        
                    </div>
                </div>
                <div class="modal-footer" style="margin-top: 0;">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">
                        Close
                    </button>
                </div>
                </form>
            </div>
        </div>
    </div>

    
    


    <div class="modal" data-easein="flipYIn" id="myModal" tabindex="-1" role="dialog"
        aria-labelledby="cModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header modal-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <button type="button" class="close mr10" onclick="javascript:CallPrint('divprint');">
                        <i class="fa fa-print"></i>
                    </button>
                    <h4 class="modal-title" id="H3">
                        Subcategory Sale Details
                    </h4>
                </div>
                <form id="Form3" method="post" accept-charset="utf-8">
                <div class="modal-body" id="divprint">
                    <div id="divsubcatdata1">
                        
                    </div>
                </div>
                <div class="modal-footer" style="margin-top: 0;">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">
                        Close
                    </button>
                </div>
                </form>
            </div>
        </div>
    </div>

    

    <div class="modal" data-easein="flipYIn" id="divweek" tabindex="-1" role="dialog"
        aria-labelledby="cModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width: 63%;">
            <div class="modal-content" style="width: 100%;">
                <div class="modal-header modal-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <button type="button" class="close mr10" onclick="window.print();">
                        <i class="fa fa-print"></i>
                    </button>
                    <h4 class="modal-title" id="H4">
                        Weekly Sale Details
                    </h4>
                </div>
                <form id="Form4" method="post" accept-charset="utf-8">
                <div class="modal-body">
                    <div id="divweekvalue">
                        
                    </div>
                </div>
                <div class="modal-footer" style="margin-top: 0;">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">
                        Close
                    </button>
                </div>
                </form>
            </div>
        </div>
    </div>


    <div class="modal" data-easein="flipYIn" id="divweekwisedate" tabindex="-1" role="dialog"
        aria-labelledby="cModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width: 90%;">
            <div class="modal-content" style="width: 100%;">
                <div class="modal-header modal-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <button type="button" class="close mr10" onclick="window.print();">
                        <i class="fa fa-print"></i>
                    </button>
                    <h4 class="modal-title" id="H5">
                        Day Wise Sale Details
                    </h4>
                </div>
                <form id="Form5" method="post" accept-charset="utf-8">
                <div class="modal-body">
                    <div id="divweekdate">
                        
                    </div>
                </div>
                <div class="modal-footer" style="margin-top: 0;">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">
                        Close
                    </button>
                </div>
                </form>
            </div>
        </div>
    </div>


    <div class="modal" data-easein="flipYIn" id="divws" tabindex="-1" role="dialog"
        aria-labelledby="cModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width: 37%;">
            <div class="modal-content" style="width: 100%;">
                <div class="modal-header modal-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <button type="button" class="close mr10" onclick="window.print();">
                        <i class="fa fa-print"></i>
                    </button>
                    <h4 class="modal-title" id="H6">
                        Day Wise Sale Details
                    </h4>
                </div>
                <form id="Form6" method="post" accept-charset="utf-8">
                <div class="modal-body">
                    <div id="divweeksubcatdata">
                        
                    </div>
                </div>
                <div class="modal-footer" style="margin-top: 0;">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">
                        Close
                    </button>
                </div>
                </form>
            </div>
        </div>
    </div>


    <div class="modal" data-easein="flipYIn" id="divmnthsv" tabindex="-1" role="dialog"
        aria-labelledby="cModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width: 53%;">
            <div class="modal-content" style="width: 90%;">
                <div class="modal-header modal-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <button type="button" class="close mr10" onclick="window.print();">
                        <i class="fa fa-print"></i>
                    </button>
                    <h4 class="modal-title" id="H7">
                        Month Wise Sale Details
                    </h4>
                </div>
                <form id="Form7" method="post" accept-charset="utf-8">
                <div class="modal-body">
                <div>
                 <table>
                        <tr>
                            <td>
                                <label>
                                    From Date:</label>
                            </td>
                            <td>
                                <input type="date" id="txtfromdate" class="form-control" />
                            </td>
                            <td>
                                <label>
                                    To Date:</label>
                            </td>
                            <td>
                                <input type="date" id="txttodate" class="form-control" />
                            </td>

                           

                            <td style="width: 5px;">
                            </td>
                            <td>
                                <div class="input-group">
                                    <div class="input-group-addon">
                                         <span id="btn_save" class="btn btn-block btn-primary" onclick="get_monthwisepossale_details();">Get Details</span>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                    <div id="divmnthsalevalue">
                        
                    </div>
                </div>
                <div class="modal-footer" style="margin-top: 0;">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">
                        Close
                    </button>
                </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal" data-easein="flipYIn" id="divwm" tabindex="-1" role="dialog"
        aria-labelledby="cModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width: 90%;">
            <div class="modal-content" style="width: 90%;">
                <div class="modal-header modal-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <button type="button" class="close mr10" onclick="window.print();">
                        <i class="fa fa-print"></i>
                    </button>
                    <h4 class="modal-title" id="H8">
                        Week Wise Sale Details
                    </h4>
                </div>
                <form id="Form8" method="post" accept-charset="utf-8">
                <div class="modal-body">
                    <div id="divmnthdate">
                        
                    </div>
                </div>
                <div class="modal-footer" style="margin-top: 0;">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">
                        Close
                    </button>
                </div>
                </form>
            </div>
        </div>
    </div>
    
    <div class="modal" data-easein="flipYIn" id="divmwdv" tabindex="-1" role="dialog"
        aria-labelledby="cModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width: 90%;">
            <div class="modal-content" style="width: 90%;">
                <div class="modal-header modal-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <button type="button" class="close mr10" onclick="window.print();">
                        <i class="fa fa-print"></i>
                    </button>
                    <h4 class="modal-title" id="H9">
                       Day Wise Sale Details
                    </h4>
                </div>
                <form id="Form9" method="post" accept-charset="utf-8">
                <div class="modal-body">
                    <div id="divmwdval">
                        
                    </div>
                </div>
                <div class="modal-footer" style="margin-top: 0;">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">
                        Close
                    </button>
                </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal" data-easein="flipYIn" id="divmvdsd" tabindex="-1" role="dialog"
        aria-labelledby="cModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width: 37%;">
            <div class="modal-content" style="width: 90%;">
                <div class="modal-header modal-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <button type="button" class="close mr10" onclick="window.print();">
                        <i class="fa fa-print"></i>
                    </button>
                    <h4 class="modal-title" id="H10">
                       Day Wise Sale Details
                    </h4>
                </div>
                <form id="Form10" method="post" accept-charset="utf-8">
                <div class="modal-body">
                    <div id="divmweeksubcatdata">
                        
                    </div>
                </div>
                <div class="modal-footer" style="margin-top: 0;">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">
                        Close
                    </button>
                </div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal" data-easein="flipYIn" id="divcatsubdata" tabindex="-1" role="dialog" 
        aria-labelledby="cModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header modal-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <button type="button" class="close mr10" onclick="window.print();">
                        <i class="fa fa-print"></i>
                    </button>
                    <h4 class="modal-title" id="H11">
                        Today Sale Details
                    </h4>
                </div>
                <form id="Form11" method="post" accept-charset="utf-8">
                <div class="modal-body">
                    <div id="divcatwisesubdata">
                        
                    </div>
                </div>
                <div class="modal-footer" style="margin-top: 0;">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">
                        Close
                    </button>
                </div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal" data-easein="flipYIn" id="divitemws" tabindex="-1" role="dialog"
        aria-labelledby="cModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header modal-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <button type="button" class="close mr10" onclick="window.print();">
                        <i class="fa fa-print"></i>
                    </button>
                    <h4 class="modal-title" id="H1">
                        ItemWise Sale Details
                    </h4>
                </div>
                <form id="Form1" method="post" accept-charset="utf-8">
                <div class="modal-body">
                    <div id="divitemsale">
                        
                    </div>
                </div>
                <div class="modal-footer" style="margin-top: 0;">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">
                        Close
                    </button>
                </div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal" data-easein="flipYIn" id="posModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
    </div>
    <div class="modal" data-easein="flipYIn" id="posModal2" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel2" aria-hidden="true">
    </div>
</section>
</asp:content>
