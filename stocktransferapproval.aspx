<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="stocktransferapproval.aspx.cs" Inherits="stocktransferapproval" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(function () {
            get_stocktransfer_details();
        });

       function get_stocktransfer_details() {
            var data = { 'op': 'get_stocktransfer_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillstocktransferdtls(msg);
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

        var stocktransfer_subdetails = [];
        function fillstocktransferdtls(msg) {
            scrollTo(0, 0);
            stocktransfer_subdetails = msg[0].SubInward;
            var itemresults = '<div class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbl_Stores_value">';
            itemresults += '<thead><tr role="row"><th>Sno</th><th scope="col">Date</th><th scope="col">From Branch</th><th scope="col">To Branch</th><th scope="col">Invoice No</th><th scope="col">TotalValue</th><th scope="col">status</th><th scope="col" style="font-weight: bold;">Actions</th></tr></thead></tbody>';
            var inward = msg[0].InwardDetails;
            for (var i = 0; i < inward.length; i++) {
                var k = i + 1;
                itemresults += '<tr role="row" style="text-align: center;">';
                itemresults += '<td  class="1">' + k + '</td>';
                itemresults += '<td  class="2">' + inward[i].date + '</td>';
                itemresults += '<td  class="3">' + inward[i].fromname + '</td>';
                itemresults += '<td  class="4">' + inward[i].toname + '</td>';
                itemresults += '<td  class="4">' + inward[i].mrnno + '</td>';
                itemresults += '<td  class="5">' + inward[i].totalvalue + '</td>';
                itemresults += '<td  class="6">' + inward[i].status + '</td>';
                itemresults += '<td style="text-align: center;"><a href="#" onclick="getmethisedit(this);" title="Edit Inward" class="tip btn btn-warning btn-xs"><i class="fa fa-edit"></i></a> <a href="#" onclick="getmebranchdelete(this);" title="Delete Inward" class="tip btn btn-danger btn-xs"><i class="fa fa-trash-o"></i></a></td>';
                itemresults += '<td  class="11"  style="display:none;">' + inward[i].description + '</td>';
                itemresults += '<td  class="9"  style="display:none;">' + inward[i].frombranch + '</td>';
                itemresults += '<td  class="7" style="display:none;">' + inward[i].tobranch + '</td>';
                itemresults += '<td class="8" style="display:none;">' + inward[i].sno + '</td>';
                itemresults += '</tr>';
            }
            itemresults += '</table>';
            $("#divsaledata").html(itemresults);

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

        function getmethisdelete(thisid) {
            return confirm('You are going to delete Sale, please Contact To Management.');
        }
        function getmethisedit(thisid) {
            scrollTo(0, 0);
            $("#divtodaysale").modal({ backdrop: "static" })
            var sno = $(thisid).parent().parent().children('.8').html();
            document.getElementById('lbl_sno').innerHTML = sno;
            var data = { 'op': 'get_stocktransferpending_details', 'sno': sno };
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
            var Inward_subdetails = msg[0].SubInward;
            Inward = msg[0].InwardDetails;
            for (var i = 0; i < Inward_subdetails.length; i++) {
                results += '<tr>';
                results += '<td style="text-align: center;">' + Inward_subdetails[i].productname + '</td>';
                results += '<td style="text-align: center;">' + Inward_subdetails[i].Quantity + '</td>';
                results += '<td style="text-align: center;">' + Inward_subdetails[i].PerUnitRs + '</td>';
                results += '<td style="text-align: center;">' + Inward_subdetails[i].TotalCost + '</td></tr>';
                var taxablevalue = Inward_subdetails[i].TotalCost;
                sumtotal += (parseFloat(taxablevalue));
                var ordertax = Inward_subdetails[i].ordertax;
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
            for (var i = 0; i < Inward.length; i++) {
                var date = Inward[i].date;
                var saleno = Inward[i].sno;
                var frombranch = Inward[i].fromname;
                var tobranch = Inward[i].toname;
                var amount = Inward[i].totalvalue
                var Remarks = Inward[i].description

                document.getElementById('spndate').innerHTML = date;
                document.getElementById('spnrefno').innerHTML = saleno;
                document.getElementById('spncname').innerHTML = frombranch;
                document.getElementById('spntname').innerHTML = tobranch;
                document.getElementById('spnrmks').innerHTML = Remarks;
                document.getElementById('spnpayamt').innerHTML = amount;
            }
        }

        function btnapproveclick() {
            var sno = document.getElementById('lbl_sno').innerHTML;
            var data = { 'op': 'stocktranfer_approveclick', 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        get_storereturn_details();
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
                    <button type="button" class="close mr10" onclick="window.print();">
                        <i class="fa fa-print"></i>
                    </button>
                    <h4 class="modal-title" id="H2">
                        Today Sale Details
                    </h4>
                </div>
                <form id="Form2" method="post" accept-charset="utf-8">
                <div class="modal-body">
                    <div>
                        <div style="width: auto; max-width: 580px; min-width: 250px; margin: 0 auto;">
                            <div>
                                <div>
                                    <p>
                                        Date: <span id="spndate"></span>
                                        <br>
                                        Sale No/Ref: <span id="spnrefno"></span>
                                        <br>
                                        From Branch: <span id="spncname"></span>
                                        <br>
                                        To Branch: <span id="spntname"></span>
                                        <br>
                                        Remarks : <span id="spnrmks"></span>
                                    </p>
                                    <div style="clear: both;">
                                    </div>
                                    <div id="div_OutwardValue">
                                    </div>
                                    <table class="table table-striped table-condensed" style="margin-top: 10px; display:none;">
                                        <tbody>
                                            <tr>
                                                <td class="text-right">
                                                    Amount :
                                                </td>
                                                <td>
                                                    <span id="spnpayamt"></span>
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
                    <button type="button" class="btn btn-primary" id="btnapprove" data-dismiss="modal" onclick="btnapproveclick();">
                        Approve
                    </button>
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
    <div hidden>
                                <label id="lbl_sno">
                                </label>
                        </div>
</asp:content>

