<%@ Page Language="C#" AutoEventWireup="true" CodeFile="print.aspx.cs" Inherits="print" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
    <link href="https://spos.tecdiary.com/themes/default/assets/dist/css/styles.css" rel="stylesheet" type="text/css">
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
            var data = { 'op': 'get_posproducthold_details' };
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
            var sgsttot = 0;
            var cgsttot = 0;
            var sumtotal = 0;
            var taxtotal = 0;
            var results = '<table class="table table-striped table-condensed">';
            results += '<thead><tr> <th class="text-center" style="width: 50%; border-bottom: 2px solid #ddd;"> Description </th> <th class="text-center" style="width: 12%; border-bottom: 2px solid #ddd;"> Quantity </th> <th class="text-center" style="width: 24%; border-bottom: 2px solid #ddd;">Price </th> <th class="text-center" style="width: 26%; border-bottom: 2px solid #ddd;"> Subtotal </th> </tr></thead></tbody>';
            var outward_subdetails = msg[0].SubOutward;
            outward = msg[0].OutwardDetails;
            for (var i = 0; i < outward_subdetails.length; i++) {
                results += '<tr>';
                results += '<td style="text-align: center;">' + outward_subdetails[i].productname + '</td>';
                results += '<td style="text-align: center;">' + outward_subdetails[i].Quantity + '</td>';
                results += '<td style="text-align: center;">' + outward_subdetails[i].PerUnitRs + '</td>';
                results += '<td style="text-align: center;">' + outward_subdetails[i].TotalCost + '</td></tr>';

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
            $("#div_OutwardValue").html(results);

            for (var i = 0; i < outward.length; i++) {
                var date = outward[i].doe;
                var saleno = outward[i].saleno;
                var cname = outward[i].custmorname;
                var saleperson = "admin";
                var modeofcash = outward[i].modeofpay;
                var amount = outward[i].totalpaying
                var change = outward[i].balance;

                document.getElementById('spndate').innerHTML = date;
                document.getElementById('spnrefno').innerHTML = saleno;
                document.getElementById('spncname').innerHTML = cname;
                document.getElementById('ssaleperson').innerHTML = saleperson;
                document.getElementById('spnpaymode').innerHTML = modeofcash;
                document.getElementById('spnpayamt').innerHTML = amount;
                document.getElementById('spnchange').innerHTML = Math.round(change).toFixed(0);
            }
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
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div style="width: auto; max-width: 580px; min-width: 250px; margin: 0 auto;">
            <div>
                <div>
                    <div style="text-align: center;">
                        VyshnaviPOS<p style="text-align: center;">
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
                                    <span id="spnpaymode"></span>
                                </td>
                                <td class="text-right">
                                    Amount :
                                </td>
                                <td>
                                    <span id="spnpayamt"></span>
                                </td>
                                <td class="text-right">
                                    Change :
                                </td>
                                <td>
                                    <span id="spnchange"></span>
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
    </form>
</body>
</html>
