<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="salevaluedashboard.aspx.cs" Inherits="salevaluedashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type='text/javascript'>
    $(function () {
        get_possalevalue_details();
    });
    $(document).ready(function () {
        $('#print').click(function (e) {
            e.preventDefault();
            var link = $(this).attr('href');
            $.get(link);
            return false;
        });
    });
    function get_possalevalue_details() {
        var data = { 'op': 'get_possalevalue_details' };
        var s = function (msg) {
            if (msg) {
                if (msg.length > 0) {
                    BindGrid(msg);
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
    function BindGrid(msg) {
        TotalDate = msg[0].Allbiomertcdates;
        totattendance = msg[0].salevalue;
        var results = '<div class="box-body"><table id="tblbiologs" class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info">';
        results += '<thead><tr role="row" class="trbgclrcls">';
        results += '<th scope="col" style="text-align:center;"><i class="fa fa-user" aria-hidden="true"></i> Parlor Name</th>';
        for (var i = 0; i < TotalDate.length; i++) {
            results += '<th scope="col" id="txtDate"><i class="fa fa-calendar" aria-hidden="true"></i> ' + TotalDate[i].Betweendates + '</th>';
        }
        results += '</tr></thead></tbody>';
        for (var i = 0; i < totattendance.length; i++) {
            results += '<tr>';
            var parlorname = totattendance[i].parlorname
            if (emptytable4.indexOf(parlorname) == -1) {
                results += '<td data-title="brandstatus" class="4">' + totattendance[i].parlorname + '</td>';
                results += '<td style="display:none" data-title="brandstatus" class="3">' + totattendance[i].parlorid + '</td>';
                emptytable4.push(parlorname);
                for (var j = 0; j < TotalDate.length; j++) {
                    var d = 1;
                    for (var k = 0; k < totattendance.length; k++) {
                        if (TotalDate[j].Betweendates == totattendance[k].LogDate && parlorname == totattendance[k].parlorname) {
                            if (totattendance[k].salevalue != "") {
                                var st = totattendance[k].parlorid + '-' + totattendance[k].LogDate;
                                results += '<td class="1" style="display:none"><input class="form-control" type="text" name="empid" id="txtempid"  value="' + st + '"/></td>';
                                results += '<td id="' + st + '" data-title="brandstatus" class="1"><a id="' + st + '"  onclick="logsclick(this);" title="' + st + '" data-toggle="modal" data-target="#myModal">' + totattendance[k].salevalue + '</a></td>';
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
    }
    function logsclick(thisid) {
        var parlorid = $(thisid).attr('title');
        var data = { 'op': 'getdatewise_subcategorywisesalevalue', 'parlorid': parlorid };
        var s = function (msg) {
            if (msg) {
                if (msg.length > 0) {
                    fillsubcategorywisesale(msg)
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

    function fillsubcategorywisesale(msg) {
        var results = '<div  class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbl_Stores_value">';
        results += '<thead><tr role="row" class="trbgclrcls"><th scope="col" style="width: 10px">Sno</th><th scope="col">Sub Category Name</th><th scope="col">Sale Value</th><th scope="col">Avg Sale Value</th></tr></thead></tbody>';
        var totalsubcatsalevalue = 0;
        var totalsubcatAvgsale = 0;

        for (var i = 0; i < msg.length; i++) {
            var k = i + 1;
            results += '<tr><td scope="row" style="text-align: center; font-weight: bold;">' + k + '</td>';
            results += '<td scope="row" class="1" style="text-align: center; font-weight: bold;" >' + msg[i].subcategoryname + '</td>';
            results += '<td scope="row" class="1" style="text-align: center; font-weight: bold;" >' + parseFloat(msg[i].totvalue).toFixed(0) + '</td>';
            totalsubcatsalevalue += parseFloat(msg[i].totvalue);
            results += '<td data-title="code" class="2" style="text-align: center; font-weight: bold;">' + parseFloat(msg[i].Avgsale).toFixed(0) + '</th>';
            results += '<td style="display:none" class="5">' + msg[i].subcategoryid + '</td></tr>';
        }
        results += '<tr style="background-color: cadetblue;color: whitesmoke;"><td scope="row" style="text-align: center; font-weight: bold;"></td>';
        results += '<td scope="row" class="1" style="text-align: center; font-weight: bold;" >Total</td>';
        results += '<td scope="row" class="1" style="text-align: center; font-weight: bold;" >' + parseFloat(totalsubcatsalevalue).toFixed(0) + '</td>';
        results += '<td data-title="code" class="2" style="text-align: center; font-weight: bold;"></th>';
        results += '<td style="display:none" class="5"></td></tr>';
        results += '</table></div>';
        $("#divsubcatdata").html(results);
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

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="row" id="div1">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div id="divsaleval">
                </div>
            </div>
        </div>
    </div>

    <div id="ajaxCall">
        <i class="fa fa-spinner fa-pulse"></i>
    </div>

    
</asp:Content>

