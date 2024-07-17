<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Cashclosingdetails.aspx.cs" Inherits="Cashclosingdetails" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(function () {
            get_cashclosingdetails_details();
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
        function get_cashclosingdetails_details() {
            var data = { 'op': 'get_cashclosingdetails_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillclosingdetails(msg);
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

        function fillclosingdetails(msg) {
            var results = '<div  class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbl_Stores_value">';
            results += '<thead><tr role="row" class="trbgclrcls"><th scope="col" style="width: 10px">Sno</th><th scope="col">Date</th><th scope="col">Cashinhand</th><th scope="col">Cash Sale</th><th scope="col">Cheque Sale</th><th scope="col">Gift Card Sale</th><th scope="col">CreditCrad Sale</th><th scope="col">Stripe Sale</th><th scope="col">Other Sale</th><th scope="col">Total Sale</th><th scope="col">Expenses</th><th scope="col">Total Cash</th><th scope="col">Submitted Cash</th><th scope="col" style="font-weight: bold;">Actions</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr><td scope="row" style="text-align: center; font-weight: bold;">' + k + '</td>';
                results += '<td scope="row" class="1" style="text-align: center; font-weight: bold;" >' + msg[i].doe + '</td>';
                results += '<td data-title="code" class="2" style="text-align: center; font-weight: bold;">' + msg[i].cashinhand + '</th>';
                results += '<td data-title="code" class="2" style="text-align: center; font-weight: bold;">' + msg[i].cashsale + '</th>';
                results += '<td data-title="code" class="2" style="text-align: center; font-weight: bold;">' + msg[i].chequesale + '</th>';
                results += '<td data-title="code" class="2" style="text-align: center; font-weight: bold;">' + msg[i].giftcardsale + '</th>';
                results += '<td data-title="code" class="2" style="text-align: center; font-weight: bold;">' + msg[i].ccsale + '</th>';
                results += '<td data-title="code" class="2" style="text-align: center; font-weight: bold;">' + msg[i].stripesale + '</th>';
                results += '<td data-title="code" class="2" style="text-align: center; font-weight: bold;">' + msg[i].othersale + '</th>';
                results += '<td data-title="code" class="2" style="text-align: center; font-weight: bold;">' + msg[i].totalsale + '</th>';
                results += '<td data-title="code" class="2" style="text-align: center; font-weight: bold;">' + msg[i].expenses + '</th>';
                results += '<td data-title="code" class="2" style="text-align: center; font-weight: bold;">' + msg[i].totalcash + '</th>';
                results += '<td data-title="code" class="2" style="text-align: center; font-weight: bold;">' + msg[i].submittedcash + '</th>';
//                results += '<td style="text-align: center;"><a href="#" onclick="getmethisedit(this);" title="View Sale" class="tip btn btn-warning btn-xs"><i class="fa fa-list"></i></a> <a href="#" onclick="getmethisdelete(this);" title="Delete Company" class="tip btn btn-danger btn-xs"><i class="fa fa-trash-o"></i></a></td>';
                results += '<td style="display:none" class="4">' + msg[i].sno + '</td></tr>';
            }
            results += '</table></div>';
            $("#divsaledata").html(results);
        }
        function getmethisdelete(thisid) {
            return confirm('You are going to delete Sale, please Contact To Management.');
        }
        function getmethisedit(thisid) {
            scrollTo(0, 0);
            $("#divtodaysale").modal({ backdrop: "static" })
            var sno = $(thisid).parent().parent().children('.4').html();
            var data = { 'op': 'get_paidpossale_details', 'sno': sno };
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

        function CallPrint(strid) {
            var divToPrint = document.getElementById(strid);
            var newWin = window.open('', 'Print-Window', 'width=400,height=400,top=100,left=100');
            newWin.document.open();
            newWin.document.write('<html><body   onload="window.print()">' + divToPrint.innerHTML + '</body></html>');
            newWin.document.close();
        }
    </script>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <div class="row" id="div1">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div id="divsaledata">
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
                    <button type="button" class="close mr10" onclick="javascript:CallPrint('divprint');">
                        <i class="fa fa-print"></i>
                    </button>
                    <h4 class="modal-title" id="H2">
                        Today Sale Details
                    </h4>
                </div>
                <form id="Form2" method="post" accept-charset="utf-8">
                <div class="modal-body" id="divprint">
                    <div>
                        <div style="width: auto; max-width: 580px; min-width: 250px; margin: 0 auto;">
                            <div>
                                <div>
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
                                                    Discount :
                                                </td>
                                                <td>
                                                    <span id="spndiscount"></span>
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
                                </div>
                                <div style="clear: both;">
                                </div>
                            </div>
                        </div>
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
</asp:content>

