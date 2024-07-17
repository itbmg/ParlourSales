<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="InwardReport.aspx.cs" Inherits="InwardReport" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="js/jquery-1.4.4.js" type="text/javascript"></script>
    <style type="text/css">
        th
        {
            text-align: center;
        }
    </style>
    <script type="text/javascript">
        function CallPrint(strid) {
            document.getElementById("tbl_inward").style.borderCollapse = "collapse";
            var divToPrint = document.getElementById(strid);
            var newWin = window.open('', 'Print-Window', 'width=400,height=400,top=100,left=100');
            newWin.document.open();
            newWin.document.write('<html><body   onload="window.print()">' + divToPrint.innerHTML + '</body></html>');
            newWin.document.close();
        }
    </script>
    <script type="text/javascript">
        $(function () {
            var date = new Date();
            var day = date.getDate();
            var month = date.getMonth() + 1;
            var year = date.getFullYear();
            if (month < 10) month = "0" + month;
            if (day < 10) day = "0" + day;
            today = year + "-" + month + "-" + day;
            $('#txtfromdate').val(today);
              $('#txttodate').val(today);
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
        function get_inward_details_click() {
            var fromdate = document.getElementById('txtfromdate').value;
            var todate = document.getElementById('txttodate').value;
            if (fromdate == "") {
                alert("Please select From Date");
                return false;
            }
            if (todate == "") {
                alert("Please select To Date");
                return false;
            }
            var type = document.getElementById('ddlsclttype').value;
            var data = { 'op': 'get_inward_details_click', 'fromdate': fromdate, 'todate': todate, 'type': type };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        filldetails(msg);
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

        function filldetails(msg) {
            var status = "A";
            var results = '<div  style="overflow:auto;"><table class="table table-bordered table-hover dataTable no-footer">';
            results += '<thead><tr><th scope="col"></th><th scope="col">Ref No</th><th scope="col">MRN No</th><th scope="col">Inward Date</th><th scope="col">Invoice No</th><th scope="col">Status</th><th scope="col">Description</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                if (status == msg[i].status) {

                    results += '<tr>';
                    results += '<td data-title="brandstatus"><button type="button" title="Click Here To Print!" class="btn btn-info btn-outline btn-circle btn-lg m-r-5 printcls"  onclick="printclick(this)"><span class="glyphicon glyphicon-print" style="top: 0px !important;"></span></button></td>';
                    results += '<td scope="row" class="1"  style="text-align:center;">' + msg[i].sno + '</td>';
                    results += '<td scope="row" class="2"  style="text-align:center;">' + msg[i].mrnno + '</td>';
                    results += '<td data-title="brandstatus" style="text-align:center;" class="3">' + msg[i].inwarddate + '</td>';
                    results += '<td data-title="brandstatus" style="text-align:center;" class="4">' + msg[i].invoiceno + '</td>';
                    results += '<td data-title="brandstatus" style="text-align:center;" class="5">' + msg[i].remarks + '</td>';
                    results += '<td data-title="brandstatus" style="text-align:center;" class="6">' + msg[i].status + '</td></tr>';
                }
                else {
                    results += '<tr>';
                    results += '<td data-title="brandstatus"><button type="button" title="Click Here To Print!" class="btn btn-info btn-outline btn-circle btn-lg m-r-5 printcls"  onclick="printclick(this)"><span class="glyphicon glyphicon-print" style="top: 0px !important;"></span></button></td>';
                    results += '<td scope="row" class="1"  style="text-align:center;">' + msg[i].sno + '</td>';
                    results += '<td scope="row" class="2"  style="text-align:center;">' + msg[i].mrnno + '</td>';
                    results += '<td data-title="brandstatus" style="text-align:center;" class="3">' + msg[i].inwarddate + '</td>';
                    results += '<td data-title="brandstatus" style="text-align:center;" class="4">' + msg[i].invoiceno + '</td>';
                    results += '<td data-title="brandstatus" style="text-align:center;" class="5">' + msg[i].remarks + '</td>';
                    results += '<td data-title="brandstatus" style="text-align:center;" class="6">' + msg[i].status + '</td></tr>';
                }
            }
            results += '</table></div>';
            $("#div_InwardData").html(results);
        }
        var amountfri = 0; var amountvat = 0; var vatamount = 0; var amountfright = 0;
         function printclick(thisid) {
            var pono = $(thisid).parent().parent().children('.1').html();
           var data = { 'op': 'get_inwardOrder_details', 'pono': pono,  };

            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        $('#divPrint').css('display', 'block');
                        $('#Button2').css('display', 'block');
                        var po_details = msg[0].podetails;
                        var po_sub_details = msg[0].subpurchasedetails;
                        document.getElementById('invoicedate').innerHTML = po_details[0].invoicedate; //using inward number
                        //document.getElementById('indentnumber').innerHTML = po_details[0].inwardno;
                        document.getElementById('mrnnumber').innerHTML = po_details[0].mrnno;
                        document.getElementById('indentdate').innerHTML = po_details[0].inwarddate;
                        document.getElementById('tinnumber').innerHTML = po_details[0].suppliergstin;
                        document.getElementById('spn_state').innerHTML = po_details[0].supplierstate;
                        document.getElementById('spn_branch_state').innerHTML = po_details[0].branchstate;
                        document.getElementById('spn_branch_name').innerHTML = po_details[0].branchname;
                        document.getElementById('spn_branch_gstin').innerHTML = po_details[0].branchgstin;
                        document.getElementById('remarks').innerHTML = po_details[0].remarks;
                        document.getElementById('Invoicenumber').innerHTML = po_details[0].invoiceno;
                        document.getElementById('suppliername').innerHTML = po_details[0].name;
                        document.getElementById('purchasedby').innerHTML = po_details[0].modeofinward;
                        document.getElementById('address').innerHTML = po_details[0].address;
                        document.getElementById('paymenttype').innerHTML = po_details[0].paymenttype;
                        document.getElementById('spnAddress').innerHTML = po_details[0].Add_ress;
                        document.getElementById('spn_gstin').innerHTML = "GSTIN :" + po_details[0].session_gstin;
                        document.getElementById('spnbankacno').innerHTML = po_details[0].sup_bank_acc_no;
                        document.getElementById('spnbankifsc').innerHTML = po_details[0].sup_bank_ifsc_code;
                        document.getElementById('spn_pono').innerHTML = po_details[0].pono;
                        document.getElementById('spn_podate').innerHTML = po_details[0].podate;
                        document.getElementById('spn_rev_chrg').innerHTML = po_details[0].rev_chrg;
                        if (po_details[0].status == "A") {
                            document.getElementById('spn_heading').innerHTML = "GRN";
                        }
                        else {
                            document.getElementById('spn_heading').innerHTML = "INWARD";
                        }
                        var rev_chrg = po_details[0].rev_chrg;
                        fill_sub_inward_details_gst(po_sub_details, rev_chrg);
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

        var grandtotal_gst = 0;
        function fill_sub_inward_details_gst(msg, rev_chrg) {
            var rev_chrg = rev_chrg;
            var gst_exists = msg[0].gst_exists;
            if (gst_exists == "1") {
                var results = '<div><table id="tbl_inward" class="table table-bordered table-hover dataTable no-footer" border="2" style="width:100%;">';
                results += '<thead><tr style="font-size:12px;background: antiquewhite;"><th scope="col" rowspan="2">Sno</th><th scope="col" rowspan="2">Item Code</th><th scope="col" rowspan="2">Item Description</th><th scope="col" rowspan="2">HSN Code</th><th scope="col" rowspan="2">UOM</th><th scope="col" rowspan="2">Qty</th><th scope="col" rowspan="2">Rate (Rs.)</th><th scope="col" rowspan="2">Discount</th><th scope="col" rowspan="2">Taxable</th><th scope="col" colspan="2">SGST</th><th scope="col" colspan="2">CGST</th><th scope="col" colspan="2">IGST</th><th scope="col" rowspan="2">Total Amount</th></tr><tr style="background: antiquewhite;"><th scope="col">%</th><th scope="col">Amt(Rs.)</th><th scope="col">%</th><th scope="col">Amt(Rs.)</th><th scope="col">%</th><th scope="col">Amt(Rs.)</th></tr></thead></tbody>';
                var j = 1;
                var k = 1;
                var sgst_per = 0, cgst_per = 0, igst_per = 0, sgst = 0, cgst = 0, igst = 0, tot_taxable = 0;
                for (var i = 0; i < msg.length; i++) {
                    var qty = 0;
                    qty = parseFloat(msg[i].qty);
                    var cost = 0;
                    var taxvalue = 0;
                    var totaltax = 0;
                    cost = parseFloat(msg[i].cost);
                    var price = parseFloat(cost);
                    var amount = 0; var amt = 0;
                    amt = qty * cost;
                    amount1 = parseFloat(amt) || 0;
                    disamt = parseFloat(msg[i].disamt) || 0;
                    diswithamount = amount1 - disamt;
                    amount = parseFloat(diswithamount) || 0;
                    sgst_per = parseFloat(msg[i].sgst_per);
                    cgst_per = parseFloat(msg[i].cgst_per);
                    igst_per = parseFloat(msg[i].igst_per);
                    pf = parseFloat(msg[i].pfamount) || 0;;
                    if (j == msg.length) {
                        amountfright = parseFloat(msg[i].freigntamt) || 0;
                    }
                    else {
                        amountfright = 0;
                    }

                    if (k == msg.length) {
                        transport = parseFloat(msg[i].transport) || 0;
                    }
                    else {
                        transport = 0;
                    }
                    totamount += diswithamount;
                    var pf_amount = 0;
                    pf_amount = (diswithamount * pf) / 100 || 0;
                    totpf += pf_amount;
                    var taxable = 0;
                    taxable = diswithamount + pf_amount;
                    tot_taxable += taxable;
                    var sgst_amt = 0;
                    sgst_amt = (taxable * sgst_per) / 100 || 0;
                    sgst += sgst_amt;
                    var cgst_amt = 0;
                    cgst_amt = (taxable * cgst_per) / 100 || 0;
                    cgst += cgst_amt;
                    var igst_amt = 0;
                    igst_amt = (taxable * igst_per) / 100 || 0;
                    igst += igst_amt;
                    var grandtotal = 0;
//                    if (rev_chrg == "N") {
                        grandtotal = taxable +  igst_amt+cgst_amt+sgst_amt;
//                    }
//                    else if(rev_chrg == "Y") {
//                        grandtotal = taxable+ igst_amt;
//                    }
//                    else{
//                        grandtotal = taxable + igst_amt;
//                    }
                    grandtotal_gst += grandtotal;
                    results += '<tr style="font-size: 11px;"><th scope="row" class="1" style="text-align:center;">' + j + '</th>';
                    results += '<td class="2">' + msg[i].itemcode + '</td>';
                    results += '<td class="8">' + msg[i].productname + '</td>';
                    results += '<td class="9">' + msg[i].hsn_code + '</td>';
                    results += '<td class="9">' + msg[i].uim + '</td>';
                    results += '<td class="3">' + qty + '</td>';
                    results += '<td class="4">' + price.toFixed(2) + '</td>';
                    results += '<td class="4">' + disamt.toFixed(2) + '</td>';
                    results += '<td class="4"><div style="float:right; padding-right:30%;">' + taxable.toFixed(2) + '</div></td>';
                    results += '<td class="4">' + sgst_per + '</td>';
                    results += '<td class="4">' + sgst_amt.toFixed(2) + '</td>';
                    results += '<td class="4">' + cgst_per + '</td>';
                    results += '<td class="4">' + cgst_amt.toFixed(2) + '</td>';
                    results += '<td class="4">' + igst_per + '</td>';
                    results += '<td class="4">' + igst_amt.toFixed(2) + '</td>';
                    results += '<td class="tammountcls"><div style="float:right; padding-right:30%;">' + parseFloat(grandtotal).toFixed(2) + '</div></td></tr>';
                    j++;
                    k++;
                }
                $('#lbled').hide();
                document.getElementById('spn_ed').innerHTML = "";
                if (totpf != 0) {
                    document.getElementById('SspanP&f').innerHTML = parseFloat(totpf).toFixed(2);;
                    $('#lblpf').show();
                    totpf = 0;
                }
                else {
                    $('#lblpf').hide();
                    document.getElementById('SspanP&f').innerHTML = "";
                }

                $('#spntaxheading').hide();
                document.getElementById('spn_cst').innerHTML = "";
                if (amountfright != 0) {
                    document.getElementById('spn_fright_amount').innerHTML = parseFloat(amountfright).toFixed(2);
                    $('#lblfright').show();
                }
                else {
                    $('#lblfright').hide();
                    document.getElementById('spn_fright_amount').innerHTML = "";
                }
                if (transport != 0) {
                    document.getElementById('Spntansport').innerHTML = parseFloat(transport).toFixed(2);
                    $('#lbltansport').show();
                }
                else {
                    $('#lbltansport').hide();
                    document.getElementById('Spntansport').innerHTML = "";
                }
                var t2 = "Total";
                results += '<tr style="font-size:11px;"><td scope="row" class="1 tdmaincls" colspan="8" style="text-align:center;background: antiquewhite;">' + t2 + '</td>';
                results += '<td data-title="brandstatus"  class="6 tdmaincls"><div style="float:right; padding-right:18%;">' + tot_taxable.toFixed(2) + '</div></td>';
                results += '<td data-title="brandstatus" class="5 tdmaincls" colspan="2">' + sgst.toFixed(2) + '</td>';
                results += '<td data-title="brandstatus" class="5 tdmaincls" colspan="2">' + cgst.toFixed(2) + '</td>';
                results += '<td data-title="brandstatus" class="5 tdmaincls" colspan="2">' + igst.toFixed(2) + '</td>';
                results += '<td data-title="brandstatus" class="7 tdmaincls"><div style="float:right; padding-right:23%;"><span id="totalcls"></span></div></td></tr>';
                results += '</table></div>';
                $("#div_itemdetails").html(results);
                document.getElementById('totalcls').innerHTML = parseFloat(grandtotal_gst).toFixed(2);
                totamount = 0;
                var final_amount = grandtotal_gst + amountfright + transport;
                var grand_total = parseFloat(final_amount);
                var grand_total1 = grand_total.toFixed(0);
                var diff = 0;
                if (grand_total > grand_total1) {
                    diff = grand_total - grand_total1;
                }
                else {
                    diff = grand_total1 - grand_total;
                }
                document.getElementById('spn_totalpoamt').innerHTML = parseFloat(grand_total).toFixed(2);
                document.getElementById('spn_roundoffamt').innerHTML = parseFloat(diff).toFixed(2);
                document.getElementById('spn_grandtotal').innerHTML = parseFloat(grand_total1).toFixed(2);
                $("#lbl_total").hide();
                document.getElementById('recevied').innerHTML = inWords(parseInt(grand_total));
                grandtotal_gst = 0;
                tot_amount1 = 0;
            }
            else {
                fill_sub_inward_details(msg);
               }
        }

        var ed = 0; var tax = 0; var pf = 0; var disamt = 0; var totamount = 0; var toted = 0; var totpf = 0; var tot_amount1 = 0; var grandtotal1 = 0; var totpf = 0; var totcst = 0; var amountfright1 = 0;
        function fill_sub_inward_details(msg) {
            var results = '<div  style="overflow:auto;"><table id="tbl_inward" class="table table-bordered table-hover dataTable no-footer" border="2" style="width:100%;">';
            results += '<thead><tr><th scope="col">Sno</th><th scope="col">Item Code</th><th scope="col">Item Description</th><th scope="col">UOM</th><th scope="col">Qty</th><th scope="col">Rate</th><th scope="col">Discount</th><th scope="col">Amount</th></tr></thead></tbody>';
            var j = 1;
            var k = 1;
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].status == "p") {//using inward number
                    var qty = 0;
                    qty = parseFloat(msg[i].qty);
                    var cost = 0;
                    var taxvalue = 0;
                    var totaltax = 0;
                    cost = parseFloat(msg[i].cost);
                    var price = parseFloat(cost).toFixed(2);
                    var amount = 0; var amt = 0;
                    amt = qty * cost;
                    amount1 = parseFloat(amt).toFixed(2) || 0;
                    disamt = parseFloat(msg[i].disamt).toFixed(2) || 0;
                    diswithamount = amount1 - disamt;
                    amount = parseFloat(diswithamount).toFixed(2) || 0;
                    ed = parseFloat(msg[i].edtax) || 0;;
                    taxid = msg[i].taxtype;
                    pf = parseFloat(msg[i].pfamount) || 0; ;
                    tax = parseFloat(msg[i].tax) || 0; ;
                    if (j == msg.length) {
                        amountfright = parseFloat(msg[i].freigntamt) || 0;
                    }
                    else {
                        amountfright = 0;
                    }

                    if (k == msg.length) {
                        transport = parseFloat(msg[i].transport) || 0;
                    }
                    else {
                        transport = 0;
                    }
                    
                    results += '<tr><th scope="row" class="1" style="text-align:center;">' + j + '</th>';
                    results += '<td data-title="brandstatus" class="2">' + msg[i].code + '</td>';
                    results += '<td data-title="brandstatus" class="8">' + msg[i].productname + '</td>';
                    results += '<td data-title="brandstatus" class="9">' + msg[i].uim + '</td>';
                    results += '<td data-title="brandstatus" class="3">' + qty + '</td>';
                    results += '<td data-title="brandstatus" class="4">' + price + '</td>';
                    results += '<td data-title="brandstatus" class="4">' + disamt + '</td>';
                    results += '<td data-title="brandstatus" class="tammountcls">' + amount + '</td></tr>'
                    j++;
                    k++;

                    totamount += diswithamount;
                    var edamount = 0;
                    edamount = (diswithamount * ed) / 100 || 0;
                    toted += edamount
                    var pf_amount = 0;
                    pf_amount = (diswithamount * pf) / 100 || 0;
                    totpf += pf_amount;
                    var tot_amount = 0;
                    tot_amount = diswithamount + edamount + pf_amount;
                    tot_amount1 += tot_amount;
                    var cst = 0;
                    cst = (tot_amount * tax) / 100 || 0;
                    totcst += cst;
                    var grandtotal = 0;
                    grandtotal = tot_amount + cst + transport + amountfright;
                    grandtotal1 += grandtotal;
                }
                else {
                    var qty = 0; //using po number
                    qty = parseFloat(msg[i].qty);
                    var cost = 0;
                    var taxvalue = 0;
                    var totaltax = 0;
                    cost = parseFloat(msg[i].cost);
                    var price = parseFloat(cost).toFixed(2);
                    var amt = 0; var amount = 0; var price
                    amt = qty * price;
                    amount1 = parseFloat(amt).toFixed(2) || 0;
                    disamt = parseFloat(msg[i].disamt).toFixed(2) || 0;
                    diswithamount = amount1 - disamt ;
                    amount = parseFloat(diswithamount).toFixed(2) || 0;
                    ed = parseFloat(msg[i].edtax) || 0;;
                    taxid = msg[i].taxtype;//msg[i].ed;
                    pf = parseFloat(msg[i].pfamount) || 0; ;
                    tax = parseFloat(msg[i].tax) || 0; ;
                    if (j == msg.length) {
                        amountfright = parseFloat(msg[i].freigntamt) || 0;
                    }
                    else {
                        amountfright = 0;
                    }
                    
                    if (k == msg.length) {
                        transport = parseFloat(msg[i].transport) || 0;
                    }
                    else {
                        transport = 0;
                    }
                    results += '<tr><th scope="row" class="1" style="text-align:center;">' + j + '</th>';
                    results += '<td data-title="brandstatus" class="2">' + msg[i].code + '</td>';
                    results += '<td data-title="brandstatus" class="8">' + msg[i].productname + '</td>';
                    results += '<td data-title="brandstatus" class="9">' + msg[i].uim + '</td>';
                    results += '<td data-title="brandstatus" class="3">' + qty + '</td>';
                    results += '<td data-title="brandstatus" class="4">' + price + '</td>';
                    results += '<td data-title="brandstatus" class="4">' + disamt + '</td>';
                    results += '<td data-title="brandstatus" class="tammountcls">' + amount + '</td></tr>'
                    j++;
                    k++;

                    totamount += diswithamount;
                    var edamount = 0;
                    edamount = (diswithamount * ed) / 100 || 0;
                    toted += edamount
                    var pf_amount = 0;
                    pf_amount = (diswithamount * pf) / 100 || 0;
                    totpf += pf_amount;
                    var tot_amount = 0;
                    tot_amount = diswithamount + edamount + pf_amount;
                    tot_amount1 += tot_amount;
                    var cst = 0;
                    cst = (tot_amount * tax) / 100 || 0;
                    totcst += cst;
                    
                    var grandtotal = 0;
                    grandtotal = tot_amount + cst + transport + amountfright;
                    grandtotal1 += grandtotal;
                }
            }

            if (toted != 0) {
                document.getElementById('spn_ed').innerHTML = parseFloat(toted).toFixed(2);
                $('#lbled').show();
                toted = 0;
            }
            else {
                $('#lbled').hide();
                document.getElementById('spn_ed').innerHTML = "";
            }
            if (totpf != 0) {
                document.getElementById('SspanP&f').innerHTML = parseFloat(totpf).toFixed(2);;
                $('#lblpf').show();
                totpf = 0;
            }
            else {
                $('#lblpf').hide();
                document.getElementById('SspanP&f').innerHTML = "";
            }
            if (totcst != 0) {
                document.getElementById('spn_cst').innerHTML = parseFloat(totcst).toFixed(2);;
                totcst = 0;
                document.getElementById('spntaxheading').innerHTML = taxid;
                 $('#spntaxheading').show();
                
            }
            else {
                $('#spntaxheading').hide();
                document.getElementById('spn_cst').innerHTML = "";
            }
            if (amountfright != 0) {
                document.getElementById('spn_fright_amount').innerHTML = parseFloat(amountfright).toFixed(2);
                $('#lblfright').show();
            }
            else {
                $('#lblfright').hide();
                document.getElementById('spn_fright_amount').innerHTML = "";
            }
            if (transport != 0) {
                document.getElementById('Spntansport').innerHTML = parseFloat(transport).toFixed(2);
                $('#lbltansport').show();
            }
            else {
                $('#lbltansport').hide();
                document.getElementById('Spntansport').innerHTML = "";
            }
            var grand_total = parseFloat(grandtotal1);
            var grand_total1 = grand_total.toFixed(2);
            var diff = 0;
            if (grand_total > grand_total1) {
                diff = grand_total - grand_total1;
            }
            else {
                diff = grand_total1 - grand_total;
            }
            document.getElementById('spn_totalpoamt').innerHTML = grand_total;
            document.getElementById('spn_roundoffamt').innerHTML = diff;
            document.getElementById('spn_grandtotal').innerHTML = grand_total1;
            document.getElementById('spn_Total').innerHTML = parseFloat(tot_amount1).toFixed(2);
            var grand_total = parseFloat(tot_amount1).toFixed(2);
            document.getElementById('recevied').innerHTML = inWords(parseInt(grand_total));
            grandtotal1 = 0;

            tot_amount1 = 0;

            var t2 = "Total";
            results += '<tr><th scope="row" class="1" style="text-align:center;"></th>';
            results += '<td data-title="brandstatus" class="2"></td>';
            results += '<td data-title="brandstatus" class="3"></td>';
            results += '<td data-title="brandstatus" class="4"></td>';
            results += '<td data-title="brandstatus" class="5"></td>';
            results += '<td data-title="brandstatus" class="5"></td>';
            results += '<td data-title="brandstatus"  class="6">' + t2 + '</td>';
            results += '<td data-title="brandstatus" class="7"><span id="totalcls"></span></td></tr>';
            results += '</table></div>';
            $("#div_itemdetails").html(results);
            document.getElementById('totalcls').innerHTML = parseFloat(totamount).toFixed(2);
            totamount = 0;
        }
        function GetTotalCal() {
            var totamount = 0;
            $('.tammountcls').each(function (i, obj) {
                var qtyclass = $(this).text();
                if (qtyclass == "" || qtyclass == "0") {
                }
                else {
                    totamount += parseFloat(qtyclass);
                }
            });
            document.getElementById('totalcls').innerHTML = parseFloat(totamount).toFixed(2);
            var edamount = 0;
            edamount = (totamount * ed) / 100 || 0;
            if (edamount != 0) {
                document.getElementById('spn_ed').innerHTML = parseFloat(edamount).toFixed(2);
                $('#lbled').show();
            }
            else {
                $('#lbled').hide();
                document.getElementById('spn_ed').innerHTML = "";
            }
            var pf_amount = 0;
            pf_amount = (totamount * pf) / 100 || 0;
            if (pf_amount != 0) {
                document.getElementById('SspanP&f').innerHTML = parseFloat(pf_amount).toFixed(2); ;
                $('#lblpf').show();
            }
            else {
                $('#lblpf').hide();
                document.getElementById('SspanP&f').innerHTML = "";
            }
            var tot_amount = 0;
            tot_amount = totamount + edamount + pf_amount;
            document.getElementById('spn_Total').innerHTML = parseFloat(tot_amount).toFixed(2);
            if (amountfright != 0) {
                document.getElementById('spn_fright_amount').innerHTML = parseFloat(amountfright).toFixed(2);
                $('#lblfright').show();
            }
            else {
                $('#lblfright').hide();
                document.getElementById('spn_fright_amount').innerHTML = "";
            }
            if (transport != 0) {
                document.getElementById('Spntansport').innerHTML = parseFloat(transport).toFixed(2);
                $('#lbltansport').show();
            }
            else {
                $('#lbltansport').hide();
                document.getElementById('Spntansport').innerHTML = "";
            }
            var cst = 0;
            cst = (tot_amount * tax) / 100 || 0;
            if (cst != 0) {
                document.getElementById('spn_cst').innerHTML = parseFloat(cst).toFixed(2); ;
                $('#lblcst').show();
            }
            else {
                $('#lblcst').hide();
                document.getElementById('spn_cst').innerHTML = "";
            }
            var grandtotal = 0;
            grandtotal = tot_amount + amountfright + cst + transport;
            var grand_total = parseFloat(grandtotal);
            var grand_total1 = grand_total.toFixed(2);
            var diff = 0;
            if (grand_total > grand_total1) {
                diff = grand_total - grand_total1;
            }
            else {
                diff = grand_total1 - grand_total;
            }
            document.getElementById('spn_totalpoamt').innerHTML = grand_total;
            document.getElementById('spn_roundoffamt').innerHTML = diff;
            document.getElementById('spn_grandtotal').innerHTML = grand_total1;
            var grand_total = parseFloat(grandtotal).toFixed(2);
            document.getElementById('recevied').innerHTML = inWords(parseInt(grand_total));
            spngrandtotal,spnstreturn,spnroundoffamt
        }

        var a = ['', 'one ', 'two ', 'three ', 'four ', 'five ', 'six ', 'seven ', 'eight ', 'nine ', 'ten ', 'eleven ', 'twelve ', 'thirteen ', 'fourteen ', 'fifteen ', 'sixteen ', 'seventeen ', 'eighteen ', 'nineteen '];
        var b = ['', '', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety'];

        function inWords(num) {
            if ((num = num.toString()).length > 9) return 'overflow';
            n = ('000000000' + num).substr(-9).match(/^(\d{2})(\d{2})(\d{2})(\d{1})(\d{2})$/);
            if (!n) return; var str = '';
            str += (n[1] != 0) ? (a[Number(n[1])] || b[n[1][0]] + ' ' + a[n[1][1]]) + 'crore ' : '';
            str += (n[2] != 0) ? (a[Number(n[2])] || b[n[2][0]] + ' ' + a[n[2][1]]) + 'lakh ' : '';
            str += (n[3] != 0) ? (a[Number(n[3])] || b[n[3][0]] + ' ' + a[n[3][1]]) + 'thousand ' : '';
            str += (n[4] != 0) ? (a[Number(n[4])] || b[n[4][0]] + ' ' + a[n[4][1]]) + 'hundred ' : '';
            str += (n[5] != 0) ? ((str != '') ? 'and ' : '') + (a[Number(n[5])] || b[n[5][0]] + ' ' + a[n[5][1]]) + 'only ' : '';
            return str;
        }

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content-header">
        <h1>
               Inward Report<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Reports</a></li>
            <li><a href="#"> Inward Report</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="fa fa-cog"></i> Inward Report
                </h3>
            </div>
            <div class="box-body">
                <div runat="server" id="d">
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

                            <td>
                                <label>
                                    Select Type</label>
                            </td>
                           
                           <td>
                                <select id="ddlsclttype" class="form-control">
                                    <option value="A">Approval</option>
                                    <option value="p">Pending</option>
                                  
                                </select>
                            </td>

                            <td style="width: 5px;">
                            </td>
                            <td>
                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <span class="glyphicon glyphicon-flash" onclick="get_inward_details_click();"></span> <span id="btn_save" onclick="get_inward_details_click();">Get Details</span>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <div id="div_InwardData" style="height: 300px; overflow-y: scroll;">
                    </div>
                </div>
                <div>
                </div>
                <div id="divPrint" style="display:none;">
                    <div style="border: 2px solid gray;">
                        <div style="width: 17%; float: right; padding-top:5px;">
                            <img src="Images/Vyshnavilogo.png" alt="Vyshnavi" width="100px" height="72px" />
                            <br />
                        </div>
                        <div style="border: 1px solid gray; height:8%;">
                            <div style="font-family: Arial; font-size: 22px; font-weight: bold; color: Black;text-align: center;">
                                <span>Sri Vyshnavi Dairy Specialities (P) Ltd </span>
                                <br />
                            </div>
                            <div style="width:68%;text-align: center;padding-left: 16%;">
                            <span id="spnAddress" class="spanrpt"></span>
                            <span id="spn_gstin" class="spanrpt" style="padding:10px;"></span>
                            </div>
                            <div style="width:40%;padding:40px">
                            <span id="spnstate" class="spanrpt" style="display:none;"></span><br />
                            </div>
                           
                        </div>
                       
                        <div style="width: 100%;">
                        <div align="center" style="border-bottom: 1px solid gray; border-top: 1px solid gray;background-color: antiquewhite;">
                            <span id="spn_heading" style="font-size: 18px; font-weight: bold;">INWARD</span>
                        </div>
                            <table style="width: 100%;">
                                <tr>
                                    <td style="width: 49%; border:2px solid gray; padding-left:2%;">
                                     <label class="labelrpt" style="font-weight: bold;">
                                             Supplier Name:</label>
                                        <span id="suppliername" style="font-weight:bold"></span>
                                        <br />
                                        <label class="labelrpt" style="font-weight: bold;">
                                              Address:</label>
                                        <span id="address" class="spanrpt"></span>
                                        <br />
                                        <label class="labelrpt" style="font-weight:bold;">
                                            From State:
                                        </label>
                                        <span id="spn_state" class="spanrpt"></span>
                                        <br />
                                        <label class="labelrpt" style="font-weight: bold;">
                                              GSTIN:</label>
                                        <span id="tinnumber" class="spanrpt"></span>
                                        <br />
                                        <%--<label class="labelrpt" style="font-weight: bold;">
                                            Refen Number :</label>
                                        <span id="indentnumber" class="spanrpt"></span>
                                        <br />--%>
                                        <label class="labelrpt" style="font-weight: bold;">
                                            Invoice Number:</label>
                                        <span id="Invoicenumber" class="spanrpt"></span>
                                        <br />
                                        <label class="labelrpt" style="font-weight: bold;">
                                            Invoice date:</label>
                                        <span id="invoicedate" class="spanrpt"></span>
                                        <br />
                                        <label class="labelrpt" style="font-weight: bold;">Reverse Charge(Y/N):</label>
                                        <span id="spn_rev_chrg" class="spanrpt"></span>
                                        <br />
                                        
                                    </td>
                                    <td style="width: 49%; border:2px solid gray; padding-left:2%;">
                                        <label class="labelrpt" style="font-weight: bold;">
                                            Purchased by:</label>
                                        <span id="spn_branch_name" class="spanrpt"></span>
                                        <br />
                                        <label class="labelrpt" style="font-weight:bold;">To State:</label>
                                        <span id="spn_branch_state" class="spanrpt"></span>
                                        <br />
                                        <label class="labelrpt" style="font-weight: bold;">
                                            GSTIN :</label>
                                        <span id="spn_branch_gstin" class="spanrpt"></span>
                                        <br />
                                        <label class="labelrpt" style="font-weight: bold;">
                                           Purchased as:</label>
                                        <span id="purchasedby" class="spanrpt"></span>
                                        <br />
                                        <label class="labelrpt" style="font-weight: bold">
                                            PO Number:</label>
                                        <span id="spn_pono" class="spanrpt"></span>
                                        <br />
                                        <label class="labelrpt" style="font-weight: bold">
                                            PO Date:</label>
                                        <span id="spn_podate" class="spanrpt"></span>
                                        <br />
                                        <label class="labelrpt" style="font-weight: bold;">
                                            MRN Number:</label>
                                        <span id="mrnnumber" class="spanrpt"></span>
                                        <br />
                                          <label class="labelrpt" style="font-weight: bold;">
                                            MRN date:</label>
                                        <span id="indentdate" class="spanrpt"></span>
                                        <br />
                                        <label class="labelrpt" style="font-weight: bold;">
                                             Payment Type:</label>
                                        <span id="paymenttype" class="spanrpt"></span>
                                    </td>
                                </tr>
                                <tr>
                                <td>
                            
                            
                                </td>
                                </tr>
                            </table>
                            <div style="width: 100%;">
                        
                                
                            </div>
                        </div>
                        
                        <div id="div_itemdetails">
                        </div>
                        <div>
                            <table class="table table-bordered table-hover dataTable no-footer"  style="width: 100%;">
                             <tr>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td colspan="2">
                                        <label class="labelrpt" style="font-weight: bold;" id="lblpf" >
                                            P&f:</label>
                                    </td>
                                    <td>
                                        <span id="SspanP&f"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:15%;">
                                    </td>
                                    <td style="width:15%;">
                                    </td>
                                    <td style="width:15%;">
                                    </td>
                                    <td style="width:15%;">
                                    </td>
                                    <td style="width:15%;">
                                    </td>
                                    <td style="width:15%;">
                                        <label class="labelrpt" style="font-weight: bold;" id="lbled">
                                            ED:</label>
                                    </td>
                                    <td style="width:15%;">
                                        <span id="spn_ed" class="spanrpt"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <label id="lbl_total" class="labelrpt" style="font-weight: bold;">
                                            Total:</label>
                                    </td>
                                    <td>
                                        <span id="spn_Total" class="spanrpt"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td colspan="2">
                                        <label class="labelrpt" style="font-weight: bold;" id="lblfright">
                                            Fright Amount:</label>
                                    </td>
                                    <td>
                                        <span id="spn_fright_amount" class="spanrpt"></span>
                                    </td>
                                </tr>
                                 <tr>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td colspan="2">
                                        <label class="labelrpt" style="font-weight: bold;" id="lbltansport">
                                            Trasport Charges:</label>
                                    </td>
                                    <td>
                                        <span id="Spntansport" class="spanrpt"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <span class="labelrpt" id="spntaxheading" style="font-weight: bold;"></span>
                                    </td>
                                    <td>
                                        <span id="spn_cst" style="font-weight: bold;" class="spanrpt"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td colspan="2">
                                        <label style="font-size: 13px;">
                                            TOTAL PO AMOUNT :</label>
                                    </td>
                                    <td>
                                        <span id="spn_totalpoamt" style="font-size: 12px;"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td colspan="2">
                                        <label style="font-size: 13px;">
                                            Round off Diff Amount :</label>
                                    </td>
                                    <td>
                                        <span id="spn_roundoffamt" style="font-size: 12px;"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td colspan="2">
                                        <label class="labelrpt" style="font-weight: bold;">
                                            Grand Total:</label>
                                    </td>
                                    <td>
                                        <span id="spn_grandtotal" class="spanrpt"></span>
                                    </td>
                                </tr>
                            </table>
                            <table class="table table-bordered table-hover dataTable no-footer" style="width:30%; display:none;">
                                <tr>
                                    <td style="padding-left: 12%; background:antiquewhite;">
                                       Bank Details
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                       Bank A/C : <span id="spnbankacno" class="spanrpt"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                       Bank IFSC : <span id="spnbankifsc" class="spanrpt"></span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <br />
                    <br />
                    <table style="width: 100%;">
                          <tr>
                                <td style="width: 49%; float: left;">
                                    <span id="Span1"></span>
                                    <br />
                                    <label style="font-size: 16px;font-weight: bold;">
                                        Description :</label>
                                    <span id="remarks" class="spanrpt"></span>
                                    <br />
                                    <label style="font-size: 16px;font-weight: bold;">
                                        Received:
                                             </label><label>Rs.</label>
                                    <span id="recevied" onclick="test.rnum.value = toWords(test.inum.value);" value="To Words" class="spanrpt"></span>
                                </td>
                            </tr>
                    </table>
                    <br />
                    <br />
                    <table style="width: 100%;">
                        <tr>
                            <td style="width: 25%;">
                                <span style="font-weight: bold; font-size: 12px;">PREPARED BY </span>
                            </td>
                            <td style="width: 25%;">
                                <span style="font-weight: bold; font-size: 12px;">INSPECTED  BY</span>
                                <br />
                                <span style="font-weight: bold; font-size: 12px;"></span>
                            </td>
                            <td style="width: 25%;">
                                <span style="font-weight: bold; font-size: 12px;">STORES(MANAGER)</span>
                            </td>
                             <td style="width: 25%;">
                                <span style="font-weight: bold; font-size: 12px;">APPROVED BY</span>
                            </td>
                        </tr>
                        <tr>
                        <td style="width: 25%;">
                        </td>
                         <td style="width: 25%;">
                        </td>
                         <td style="width: 25%;">
                        </td>
                        
                           <td style="width: 25%;">
                        </td>
                        
                        </tr>
                         <tr>
                        <td style="width: 25%;">
                        </td>
                         <td style="width: 25%;">
                        </td>
                         <td style="width: 25%;">
                        </td>
                        
                         <td  colspan="3" style="width: 25%;height:25%;" >
                                <span style="font-weight: bold; font-size: 12px;">GENERAL MANAGER </span>
                            </td>
                        
                        </tr>
                    </table>
                </div>
                <div class="input-group" id="Button2" style="display:none;padding-right: 90%;">
                    <div class="input-group-addon">
                        <span class="glyphicon glyphicon-print" onclick="javascript: CallPrint('divPrint');"></span> <span id="Span2" onclick="javascript: CallPrint('divPrint');">Print</span>
                    </div>
                </div>
                <asp:Label ID="lblmsg" runat="server" Font-Size="20px" ForeColor="Red" Text=""></asp:Label>
            </div>
        </div>
    </section>
</asp:Content>