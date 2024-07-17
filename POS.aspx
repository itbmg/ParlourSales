<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="POS.aspx.cs" Inherits="POS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="https://spos.tecdiary.com/themes/default/assets/dist/css/styles.css"
        rel="stylesheet" type="text/css">
    <style type="text/css" media="all">
        body
        {
            color: #000;
        }
        #wrapper
        {
            max-width: 520px;
            margin: 0 auto;
            padding-top: 20px;
        }
        .btn
        {
            margin-bottom: 5px;
        }
        .table
        {
            border-radius: 3px;
        }
        .table th
        {
            background: #f5f5f5;
        }
        .table th, .table td
        {
            vertical-align: middle !important;
        }
        h3
        {
            margin: 5px 0;
        }
        
        @media print
        {
            .no-print
            {
                display: none;
            }
            #wrapper
            {
                max-width: 480px;
                width: 100%;
                min-width: 250px;
                margin: 0 auto;
            }
        }
        tfoot tr th:first-child
        {
            text-align: right;
        }
    </style>
    <script type='text/javascript'>
        $(function () {
            get_posproductsale_details();
        });
        $(document).ready(function () {
            $('#print').click(function (e) {
                e.preventDefault();
                var link = $(this).attr('href');
                $.get(link);
                return false;
            });
        });
        function get_posproductsale_details() {
            var data = { 'op': 'get_posproductsale_details' };
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
        function BindGrid(msg) {
            var results = '<table class="table table-striped table-condensed">';
            results += '<thead><tr> <th class="text-center" style="width: 50%; border-bottom: 2px solid #ddd;"> Description </th> <th class="text-center" style="width: 12%; border-bottom: 2px solid #ddd;"> Quantity </th> <th class="text-center" style="width: 24%; border-bottom: 2px solid #ddd;">Price </th> <th class="text-center" style="width: 26%; border-bottom: 2px solid #ddd;"> Subtotal </th> </tr></thead></tbody>';
            var outward_subdetails = msg[0].SubOutward;
            outward = msg[0].OutwardDetails;
            for (var i = 0; i < outward_subdetails.length; i++) {
                results += '<tr>';
                results += '<td>' + outward_subdetails[i].productname + '</td>';
                results += '<td style="text-align: center;">' + outward_subdetails[i].Quantity + '</td>';
                results += '<td class="text-right">' + outward_subdetails[i].PerUnitRs + '</td>';
                results += '<td class="text-right">' + outward_subdetails[i].TotalCost + '</td></tr>';
            }
            results += '<tr>';
            results += '<td colspan="2">Total</td>';
            results += '<td colspan="2" class="text-right"><span id="spntotalamt">15.00</span>/td></tr>';

            results += '<tr>';
            results += '<td colspan="2">Order Tax(cgst,sgst)</td>';
            results += '<td colspan="2" class="text-right"><span id="spnordertax">15.00</span>/td></tr>';

            results += '<tr>';
            results += '<td colspan="2">Rounding</td>';
            results += '<td colspan="2" class="text-right"><span id="spnrountoff">15.00</span>/td></tr>';

            results += '<tr>';
            results += '<td colspan="2">Grand Total	</td>';
            results += '<td colspan="2" class="text-right"><span id="spngrdtotal">15.00</span>/td></tr>';
            results += '</table>';
            $("#div_OutwardValue").html(results);
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
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <div>
        <div style="width: auto; max-width: 580px; min-width: 250px; margin: 0 auto;">
            <div>
                <div>
                    <div style="text-align: center;">
                        <img src="https://spos.tecdiary.com/uploads/logo.png" alt="SimplePOS"><p style="text-align: center;">
                            NO.25, Vyshnavi House, TNHB Colony, Korattur<br>
                            Chennai-600080<br>
                            012345678</p>
                        <p>
                        </p>
                    </div>
                    <p>
                        Date: <span id="spndate"></span>
                        <br>
                        Sale No/Ref: <span id="spnrefno"></span>
                        <br>
                        Customer: <span id="spncname"></span>
                        <br>
                        Sales Person: <span id="ssaleperson"></span>
                        <br>
                    </p>
                    <div style="clear: both;">
                    </div>
                    <div id="div_OutwardValue">
                    </div>
                    <table class="table table-striped table-condensed" style="margin-top: 10px;">
                        <tbody>
                            <tr>
                                <td class="text-right">
                                    Paid by :
                                </td>
                                <td>
                                    <span id="spnpaymode">15.00</span>
                                </td>
                                <td class="text-right">
                                    Amount :
                                </td>
                                <td>
                                    <span id="spnpayamt">15.00</span>
                                </td>
                                <td class="text-right">
                                    Change :
                                </td>
                                <td>
                                    <span id="spnchange">15.00</span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="well well-sm" style="margin-top: 10px;">
                        <div style="text-align: center;">
                            Thank You For Shoping ! Have a Nice Day</div>
                    </div>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <!-- start -->
            <div id="buttons" style="padding-top: 10px; text-transform: uppercase;" class="no-print">
                <hr>
                <span class="pull-right col-xs-12">
                    <button onclick="window.print();" class="btn btn-block btn-primary">
                        Print</button>
                </span><span class="col-xs-12"><a class="btn btn-block btn-warning" href="Vpos.aspx">
                    Back to POS</a> </span>
                <div style="clear: both;">
                </div>
            </div>
            <!-- end -->
        </div>
    </div>
</asp:content>
