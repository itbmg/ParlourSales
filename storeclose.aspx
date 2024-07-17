<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="storeclose.aspx.cs" Inherits="storeclose" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript">
    $(function () {
        getregistervalues();
        get_denamination_details();
    });
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
    function get_denamination_details() {
        var data = { 'op': 'get_denamination_details' };
        var s = function (msg) {
            if (msg) {
                if (msg.length > 0) {
                    filldenaminationdetails(msg);
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
    function filldenaminationdetails(msg) {
        var results = '<div  class="box-body"><table class="table table-bordered dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbldino">';
        results += '<thead><tr><th scope="col">Sno</th><th scope="col">Denamination Type</th><th scope="col">Count</th></tr></thead></tbody>';
        for (var i = 0; i < msg.length; i++) {
            var k = i + 1;
            results += '<tr>';
            results += '<td scope="row" class="1" >' + k + '</td>';
            results += '<td scope="row" class="2" style="text-align: center; font-weight: bold;" ><span id="spn_dinamination">' + msg[i].dinaminationtype + '</span></td>';
            results += '<td><input id="txt_quantity" type="text" class="form-control" value="" name="quantity"/></td>';
            results += '<td style="display:none" class="7"><input id="hdnsno" type="hidden" value="' + msg[i].sno + '"></td></tr>';
        }
        results += '</table></div>';
        $("#divdinaminationdata").html(results);
    }
    function getregistervalues() {
        var data = { 'op': 'get_daywiseregister_details' };
        var s = function (msg) {
            if (msg) {
                if (msg.length > 0) {
                    var totalsale = 0;
                    var cashinhand = 0;
                    for (var i = 0; i < msg.length; i++) {
                        var saletype = msg[i].saletype;
                        var salevalue = msg[i].salevalue;
                        if (saletype == "cashinhand") {
                            document.getElementById("spncregcashinhand").innerHTML = salevalue;
                            cashinhand = salevalue;
                        }
                        if (saletype == "cash") {
                            document.getElementById("spncregcashsale").innerHTML = salevalue;
                        }
                        if (saletype == "CC") {
                            document.getElementById("spncregccsale").innerHTML = salevalue;
                        }
                        if (saletype == "cheque") {
                            document.getElementById("spncregchequesale").innerHTML = salevalue;
                        }
                        if (saletype == "gift_card") {
                            document.getElementById("spncreggiftcardsale").innerHTML = salevalue;
                        }
                        if (saletype == "stripe") {
                            document.getElementById("spncregstripesale").innerHTML = salevalue;
                        }
                        if (saletype == "other") {
                            document.getElementById("spncregothersale").innerHTML = salevalue;
                        }
                        if (saletype == "Paytm") {
                            document.getElementById("spncpaytmamt").innerHTML = salevalue;
                        }
                        if (saletype == "Phonepay") {
                            document.getElementById("spncphonepayamt").innerHTML = salevalue;
                        }
                        totalsale += parseFloat(salevalue);
                    }
                    document.getElementById("spncregtotalsale").innerHTML = totalsale;
                    var expenses = 0;
                    document.getElementById("spncregexpenses").innerHTML = expenses;
                    document.getElementById("spncregtotalcash").innerHTML = totalsale - expenses;
                    document.getElementById("txttotal_cash_submitted").value = totalsale - expenses;

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
    function btncloseregistordetails() {
        var cashinhand = document.getElementById("spncregcashinhand").innerHTML;
        var cashsale = document.getElementById("spncregcashsale").innerHTML;
        var chequesale = document.getElementById("spncregchequesale").innerHTML;
        var giftcardsale = document.getElementById("spncreggiftcardsale").innerHTML;
        var ccsale = document.getElementById("spncregccsale").innerHTML;
        var stripesale = document.getElementById("spncregstripesale").innerHTML;
        var othersale = document.getElementById("spncregothersale").innerHTML;
        var totalsale = document.getElementById("spncregtotalsale").innerHTML;
        var expenses = document.getElementById("spncregexpenses").innerHTML;
        var totalcash = document.getElementById("spncregtotalcash").innerHTML;
        var submittedcash = document.getElementById("txttotal_cash_submitted").value;
        var submittedslips = document.getElementById("total_cc_slips_submitted").value;
        var submittedchecks = document.getElementById("total_cheques_submitted").value;
        var description = document.getElementById("Textarea1").value;

        var paytm = document.getElementById("spncpaytmamt").innerHTML;
        var phonepay = document.getElementById("spncphonepayamt").innerHTML;

        var btnreg = "closereg";

        var closeitems = [];
        $('#tbldino> tbody > tr').each(function () {
            var dinamination = $(this).find('#spn_dinamination').text();
            var Quantity = $(this).find('#txt_quantity').val();
            var hdnproductsno = $(this).find('#hdnsno').val();
            if (hdnproductsno == "" || hdnproductsno == "0") {
            }
            else {
                closeitems.push({ 'dinamination': dinamination, 'Quantity': Quantity, 'hdnproductsno': hdnproductsno });
            }
        });
        if (closeitems.length == 0) {
            alert("Please Enter the Dinamination Details");
            return false;
        }
        var data = { 'op': 'backdatesave_parlorerclosingregister', 'cashinhand': cashinhand, 'cashsale': cashsale, 'chequesale': chequesale, 'giftcardsale': giftcardsale, 'ccsale': ccsale,
            'stripesale': stripesale, 'othersale': othersale, 'totalsale': totalsale, 'expenses': expenses, 'totalcash': totalcash, 'submittedcash': submittedcash, 'submittedslips': submittedslips,
            'submittedchecks': submittedchecks, 'description': description, 'btnreg': btnreg, 'paytm': paytm, 'phonepay': phonepay, 'closeitems': closeitems
        };
        var s = function (msg) {
            if (msg) {
                if (msg.length > 0) {
                    alert(msg);
                    window.open("vpos.aspx", "_self");
                }
            }
            else {
            }
        };
        var e = function (x, h, e) {
        };
        $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
        CallHandlerUsingJson(data, s, e);
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
<div class="modal-dialog modal-success" style="margin-top: 0px !important;margin-right: auto !important;margin-bottom: 0px !important; margin-left: auto !important;">
            <div class="modal-content">
                <div class="modal-header modal-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <button type="button" class="close mr10" onclick="window.print();">
                        <i class="fa fa-print"></i>
                    </button>
                    <h4 class="modal-title" id="H3">
                        Today Sale Details
                    </h4>
                </div>
                <form id="Form3" method="post" accept-charset="utf-8">
                <div class="modal-body">
                    <table width="100%" class="stable">
                        <tbody>
                            <tr> 
                                <td style="border-bottom: 1px solid #EEE;">
                                    <h4>
                                        Cash in hand: </h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #EEE;">
                                    <h4>
                                        <span id="spncregcashinhand">0.00</span></h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #EEE;">
                                    <h4>
                                       Cash Sales: </h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #EEE;">
                                    <h4>
                                       <span id="spncregcashsale">0.00</span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #EEE;">
                                    <h4>
                                      Cheque Sales: </h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #EEE;">
                                    <h4>
                                       <span id="spncregchequesale">0.00 </span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #EEE;">
                                    <h4>
                                        Gift Card Sales: </h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #EEE;">
                                    <h4>
                                      <span id="spncreggiftcardsale">0.00</span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #EEE;">
                                    <h4>
                                      Credit Card Sales: </h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #EEE;">
                                    <h4>
                                      <span id="spncregccsale">0.00</span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #DDD;">
                                    <h4>
                                       Stripe: </h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #DDD;">
                                    <h4>
                                      <span id="spncregstripesale">0.00</span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #DDD;">
                                    <h4>
                                       Paytm: </h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #DDD;">
                                    <h4>
                                      <span id="spncpaytmamt">0.00</span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #DDD;">
                                    <h4>
                                       Phone Pay: </h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #DDD;">
                                    <h4>
                                      <span id="spncphonepayamt">0.00</span>
                                    </h4>
                                </td>
                            </tr>
                            
                            <tr>
                                <td style="border-bottom: 1px solid #008d4c;">
                                    <h4>
                                        Others: </h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #008d4c;">
                                    <h4>
                                        <span id="spncregothersale">0.00</span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td width="300px;" style="font-weight: bold;">
                                    <h4>
                                       <strong> Total Sales: </strong></h4>
                                </td>
                                <td width="200px;" style="font-weight: bold; text-align: right;">
                                    <h4>
                                      <strong>  <span id="spncregtotalsale">0.00 </span></strong>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td width="300px;" style="font-weight: bold;">
                                    <h4>
                                      <strong>  Expenses: </strong></h4>
                                </td>
                                <td width="200px;" style="font-weight: bold; text-align: right;">
                                    <h4>
                                       <strong> <span id="spncregexpenses">0.00</span> </strong>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td width="300px;" style="font-weight: bold;">
                                    <h4>
                                        <strong>Total Cash</strong>:</h4>
                                </td>
                                <td style="text-align: right;">
                                    <h4>
                                        <strong><span id="spncregtotalcash">0.00</span></strong>
                                    </h4>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <hr>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for="total_cash_submitted">
                                    Total Cash</label>
                                <input type="hidden" name="total_cash" value="11">
                                <input type="text" name="total_cash_submitted"  class="form-control input-tip"
                                    id="txttotal_cash_submitted" required="required">
                            </div>
                            <div class="form-group">
                                <label for="total_cheques_submitted">
                                    Total Cheques</label>
                                <input type="hidden" name="total_cheques" value="0">
                                <input type="text" name="total_cheques_submitted" value="0" class="form-control input-tip"
                                    id="total_cheques_submitted" required="required">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for="total_cc_slips_submitted">
                                    Total Credit Card Slips</label>
                                <input type="hidden" name="total_cc_slips" value="0">
                                <input type="text" name="total_cc_slips_submitted" value="0" class="form-control input-tip"
                                    id="total_cc_slips_submitted" required="required">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="note">
                            Note</label>
                        <textarea name="note" id="Textarea1" class="pa form-control kb-text"></textarea>
                    </div>
                    <div>
                    <div id="divdinaminationdata"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">
                        Close</button>
                    <button type="button" onclick="window.print();" class="btn btn-default">
                        Print</button>
                    <input type="button" name="closeregister" value="Close Register" class="btn btn-primary" onclick="btncloseregistordetails();">
                </div>
                </form>
            </div>
        </div>
</asp:Content>

