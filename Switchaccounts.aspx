<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Switchaccounts.aspx.cs" Inherits="Switchaccounts" %>

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
            get_employewise_parlor_details();
        });
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
        function get_employewise_parlor_details() {
            var data = { 'op': 'get_employewise_parlor_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillparlordetails(msg);
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

        function fillparlordetails(msg) {
            var results = '<div  class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbl_Stores_value">';
            results += '<thead><tr role="row" class="trbgclrcls"><th scope="col" style="width: 10px">Sno</th><th scope="col">Parlor Name</th><th scope="col">Phone No</th><th scope="col">GSTIN No</th><th scope="col" style="font-weight: bold;">Switch To Account</th></tr></thead></tbody>';
            var totalsalevalue = 0;
            var totalpurchasevalue = 0;
            var totalexpencesvalue = 0;
            var totalprofit = 0;
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr><td scope="row" style="text-align: center; font-weight: bold;">' + k + '</td>';
                results += '<td scope="row" class="1" style="text-align: center; font-weight: bold;" >' + msg[i].parlorname + '</td>';
                results += '<td scope="row" class="2" style="text-align: center; font-weight: bold;" >' + msg[i].phone + '</td>';
                results += '<td scope="row" class="3" style="text-align: center; font-weight: bold;" >' + msg[i].gstin + '</td>';
                results += '<td style="text-align: center;"><a href="#" onclick="viewdetails(this);" title="View Details" class="tip btn btn-success btn-xs"><i class="fa fa-2x fa-plus-circle"></i></a></td>';
                results += '<td style="display:none" class="4">' + msg[i].parlorid + '</td></tr>';
            }
            results += '</table></div>';
            $("#divsaledata").html(results);
        }

        var bid = "";
        function viewdetails(thisid) {
            scrollTo(0, 0);
            var branchid = $(thisid).parent().parent().children('.4').html();
            var data = { 'op': 'get_branchassigntoemp_details', 'branchid': branchid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        window.open("distibutorsale.aspx", "_self");
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
        </div>
    </div>
</section>
</asp:content>
