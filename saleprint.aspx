<%@ Page Language="C#" AutoEventWireup="true" CodeFile="saleprint.aspx.cs" Inherits="saleprint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
    <link href="https://spos.tecdiary.com/themes/default/assets/dist/css/styles.css"
        rel="stylesheet" type="text/css">
    <link href="css/styles.css" rel="stylesheet" type="text/css" />
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
            var sgsttot = 0;
            var cgsttot = 0;
            var sumtotal = 0;
            var taxtotal = 0;
            var grandttol = 0;

            var gsttwopointfive = 0;
            var gsttwlve = 0;
            var gsteightenn = 0;
            var gsttwentyeight = 0;
            var withoutgstgrandtotal = 0;
            var results = '<table class="table table-striped table-condensed">';
            results += '<thead><tr> <th class="text-center" style="width: 50%; border-bottom: 2px solid #ddd;"> Description </th> <th class="text-center" style="width: 12%; border-bottom: 2px solid #ddd;"> Quantity </th> <th class="text-center" style="width: 24%; border-bottom: 2px solid #ddd;">Price </th> </tr></thead></tbody>';
            var outward_subdetails = msg[0].SubOutward;
            outward = msg[0].OutwardDetails;
            for (var i = 0; i < outward_subdetails.length; i++) {
                var sgst = outward_subdetails[i].sgst;
                var cgst = outward_subdetails[i].cgst;
                var PerUnitRs = outward_subdetails[i].PerUnitRs;
                var Quantity = outward_subdetails[i].Quantity;
                var subtotal = parseFloat(PerUnitRs) * parseFloat(Quantity);

                results += '<tr>';
                results += '<td style="text-align: center;">' + outward_subdetails[i].productname + '</td>';
                results += '<td style="text-align: center;">' + outward_subdetails[i].Quantity + ' <br></td>';
                //results += '<td style="text-align: center;">' + outward_subdetails[i].PerUnitRs + '</td>';
                results += '<td style="text-align: right;">' + outward_subdetails[i].TotalCost + '</td></tr>';
                withoutgstgrandtotal += (parseFloat(outward_subdetails[i].TotalCost));
                var taxablevalue = outward_subdetails[i].TotalCost;
                sumtotal += (parseFloat(taxablevalue));
                var ordertax = outward_subdetails[i].ordertax;
                taxtotal += (parseFloat(ordertax));
                if (sgst == "2.5") {
                    gsttwopointfive += parseFloat(ordertax);
                }
                if (sgst == "6") {
                    gsttwlve += parseFloat(ordertax);
                }
                if (sgst == "9") {
                    gsteightenn += parseFloat(ordertax);
                }
                if (sgst == "14") {
                    gsttwentyeight += parseFloat(ordertax);
                }
//                if (sgst != "0") {
//                    results += '<tr>';
//                    results += '<td style="text-align: center; font-size:12px;">SGST@' + sgst + '%, CGST@' + cgst + '%</td>';
//                    results += '<td style="text-align: center;"></td>';
//                    results += '<td style="text-align: center;"></td>';
//                    results += '<td style="text-align: center;font-size:12px;">' + parseFloat(outward_subdetails[i].ordertax).toFixed(2) + '</td></tr>';
//                }
            }

//            results += '<tr>';
//            results += '<td style="text-align: center;">GST(%)</td>';
//            results += '<td style="text-align: center;">SGST</td>';
//            results += '<td style="text-align: center;">CGST</td></tr>';


//            results += '<tr>';
//            var sgstamt = parseFloat(gsttwopointfive) / 2;
//            results += '<td  style="text-align: center;">5</td>';
//            results += '<td  style="text-align: center;">' + sgstamt.toFixed(2) + '</td>';
//            results += '<td  style="text-align: center;">' + sgstamt.toFixed(2) + '</td></tr>';

//            results += '<tr>';
//            var sgstamtt = parseFloat(gsttwlve) / 2;
//            results += '<td  style="text-align: center;">12</td>';
//            results += '<td  style="text-align: center;">' + sgstamtt.toFixed(2) + '</td>';
//            results += '<td  style="text-align: center;">' + sgstamtt.toFixed(2) + '</td></tr>';

//            results += '<tr>';
//            var sgstammt = parseFloat(gsteightenn) / 2;
//            results += '<td  style="text-align: center;">18</td>';
//            results += '<td  style="text-align: center;">' + sgstammt.toFixed(2) + '</td>';
//            results += '<td  style="text-align: center;">' + sgstammt.toFixed(2) + '</td></tr>';

//            results += '<tr>';
//            var sgsttamt = parseFloat(gsttwentyeight) / 2;
//            results += '<td  style="text-align: center;">28</td>';
//            results += '<td  style="text-align: center;">' + sgsttamt.toFixed(2) + '</td>';
//            results += '<td  style="text-align: center;">' + sgsttamt.toFixed(2) + '</td></tr>';



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
            results += '<td></td>';
            results += '<td style="text-align: center;">Total</td>';
            results += '<td style="text-align: right;"><span id="spntotalamt">' + withoutgstgrandtotal.toFixed(2) + '</span></td></tr>';

            if (gsttwopointfive != 0) {
                results += '<tr>';
                var sgstamt = parseFloat(gsttwopointfive) / 2;
                results += '<td style="text-align: center;">SGST 2.5(%)</td>';
                results += '<td></td>';
                results += '<td style="text-align: right;"><span id="spntotalamt">' + sgstamt.toFixed(2) + '</span></td></tr>';
                results += '<tr>';
                var sgstamt = parseFloat(gsttwopointfive) / 2;
                results += '<td style="text-align: center;">CGST 2.5(%)</td>';
                results += '<td></td>';
                results += '<td style="text-align: right;"><span id="spntotalamt">' + sgstamt.toFixed(2) + '</span></td></tr>';
            }

            if (gsttwlve != 0) {
                results += '<tr>';
                var sgstamTt = parseFloat(gsttwlve) / 2;
                results += '<td style="text-align: center;">SGST 6(%)</td>';
                results += '<td></td>';
                results += '<td style="text-align: right; "><span id="spntotalamt">' + sgstamTt.toFixed(2) + '</span></td></tr>';

                results += '<tr>';
                results += '<td style="text-align: center;">CGST 6(%)</td>';
                results += '<td></td>';
                results += '<td style="text-align: right; "><span id="spntotalamt">' + sgstamTt.toFixed(2) + '</span></td></tr>';
            }
            if (gsteightenn != 0) {
                results += '<tr>';
                var sgstammt = parseFloat(gsteightenn) / 2;
                results += '<td style="text-align: center;">SGST 9(%)</td>';
                results += '<td></td>';
                results += '<td style="text-align: right; "><span id="spntotalamt">' + sgstammt.toFixed(2) + '</span></td></tr>';

                results += '<tr>';
                results += '<td style="text-align: center;">CGST 9(%)</td>';
                results += '<td></td>';
                results += '<td style="text-align: right; "><span id="spntotalamt">' + sgstammt.toFixed(2) + '</span></td></tr>';
            }
            if (gsttwentyeight != 0) {
                results += '<tr>';
                var sgsttamt = parseFloat(gsttwentyeight) / 2;
                results += '<td style="text-align: center;">SGST 14(%)</td>';
                results += '<td></td>';
                results += '<td style="text-align: right; "><span id="spntotalamt">' + sgsttamt.toFixed(2) + '</span></td></tr>';

                results += '<tr>';
                var sgstamt = parseFloat(gsttwopointfive) / 2;
                results += '<td style="text-align: center;">CGST 14(%)</td>';
                results += '<td></td>';
                results += '<td style="text-align: right; "><span id="spntotalamt">' + sgsttamt.toFixed(2) + '</span></td></tr>';
            }

//            results += '<tr>';
//            results += '<td></td>';
//            results += '<td></td>';
//            results += '<td  style="text-align: center;">Rounding</td>';
//            results += '<td  style="text-align: right; "><span id="spnrountoff">' + diff.toFixed(2) + '</span></td></tr>';

            results += '<tr>';
            results += '<td></td>';
            results += '<td  style="text-align: center;">Grand Total	</td>';
            results += '<td  style="text-align: right; "><span id="spngrdtotal">' + Math.round(grandtotalvalue).toFixed(2) + '</span></td></tr>';

            results += '<tr>';
            results += '<td></td>';
            results += '<td  style="text-align: center;">Discount :	</td>';
            results += '<td  style="text-align: right; "> <span id="spndiscount"></span></td></tr>';
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
                document.getElementById('spnpayamt').innerHTML = Math.round(amount).toFixed(0);
                document.getElementById('spnchange').innerHTML = Math.round(change).toFixed(0);
                document.getElementById('spndiscount').innerHTML = Math.round(dsicountvalue).toFixed(0);
                document.getElementById('spnaddres').innerHTML = outward[i].address;
                document.getElementById('spnphno').innerHTML = outward[i].phone;
                document.getElementById('spngstin').innerHTML = outward[i].gstin;
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
        <div style="width: auto; max-width: 580px; min-width: 250px; margin: 0 auto; font-weight: bold;">
            <div>
                <div>
                    <div style="text-align: center;">
                        <img src="images/Vyshnavilogo.png" />
                       <p style="text-align: center;">
                            <span id="spnaddres"></span>
                            <br>
                            Contact No: <span id="spnphno"></span>
                            <br>
                            GSTIN : <span id="spngstin"></span>
                        </p>
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
