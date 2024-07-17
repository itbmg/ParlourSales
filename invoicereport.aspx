<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="invoicereport.aspx.cs" Inherits="invoicereport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .container
        {
            max-width: 100%;
        }
        th
        {
            text-align: center;
        }
        .tdsize
        {
            font-size: 12px;
        }
        .tdheading
        {
            font-size: 12px;
            font-weight: bold;
        }
    </style>
    <script type="text/javascript">
        function CallPrint(strid) {
            document.getElementById("tbl_outward").style.borderCollapse = "collapse";
            var divToPrint = document.getElementById(strid);
            var newWin = window.open('', 'Print-Window', 'width=400,height=400,top=100,left=100');
            newWin.document.open();
            newWin.document.write('<html><body   onload="window.print()">' + divToPrint.innerHTML + '</body></html>');
            newWin.document.close();
        }
    </script>
    <script type="text/javascript">
        $(function () {
            var refdcno1 = '<%=Session["StockSno"] %>';
            if (refdcno1 != "") {
                //get_StockTransfer_Sub_details1_click();
            }
            $('#hiderefno').css('display', 'none');
            $('#Button2').css('display', 'none');
            get_subdistibutor_details();
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
        function get_distibutorsale_details() {
            var distibutorid = document.getElementById('ddlsubdistibutor').value;
            var fromdate = document.getElementById('txtfromdate').value;
            var todate = document.getElementById('txttodate').value;
            if (fromdate == "") {
                alert("Please select from date");
                return false;
            }
            if (todate == "") {
                alert("Please select to date");
                return false;
            }
            var data = { 'op': 'get_distibutorsale_details_click', 'fromdate': fromdate, 'todate': todate, 'distibutorid': distibutorid };
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

        var freight_main = 0;
        function filldetails(msg) {
            var status = "A";
            var results = '<div  style="overflow:auto;"><table class="table table-bordered dataTable no-footer">';
            results += '<thead><tr><th scope="col"></th><th scope="col">Ref No</th><th scope="col">Name</th><th scope="col">Invoice Date</th><th scope="col">Invoice No</th><th scope="col">Total Value</th><th scope="col">Status</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                results += '<tr>';
                results += '<td data-title="brandstatus"><button type="button" title="Click Here To Print!" class="tip btn btn-primary btn-xs" onclick="printclick(this)"><i class="fa fa-print"></i></button></td>';
                results += '<td scope="row" class="1"  style="text-align:center;">' + msg[i].sno + '</td>';
                results += '<td data-title="brandstatus" style="text-align:center;" class="2">' + msg[i].distibutorname + '</td>';
                results += '<td data-title="brandstatus" style="text-align:center;" class="5">' + msg[i].date + '</td>';
                results += '<td data-title="brandstatus" style="text-align:center;" class="5">' + msg[i].invoiceno + '</td>';
                results += '<td data-title="brandstatus" style="text-align:center;" class="5">' + msg[i].totalvalue + '</td>';
                results += '<td data-title="brandstatus" style="text-align:center;" class="5">' + msg[i].status + '</td>';
                results += '<td data-title="brandstatus" style="text-align:center; display:none;" class="6">' + msg[i].sno + '</td>';
                results += '<td data-title="brandstatus"  style="text-align:center; display:none;" class="4">' + msg[i].stateid + '</td></tr>';
            }
            results += '</table></div>';
            $("#divPOdata").html(results);
        }
        var stock_details = [];
        var stock_sub_details = [];
        function printclick(thisid) {
            var refdcno = $(thisid).parent().parent().children('.1').html();
            var data = { 'op': 'get_distibutorsales_Sub_details_click', 'refdcno': refdcno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        stock_details = msg[0].distibutorsaleDetails;
                        stock_sub_details = msg[0].Subdistibutorsale;
                        if (stock_details.length > 0 && stock_sub_details.length > 0) {
                            $('#divPrint').css('display', 'block');
                            $('#Button2').css('display', 'block');
                            document.getElementById('frombranchname').innerHTML = stock_details[0].frombrancname; //"PUNABAKA";
                            document.getElementById('spn_frombranch_addr').innerHTML = stock_details[0].fromaddress; //"PUNABAKA";
                            document.getElementById('spn_frombranch_gstin').innerHTML = stock_details[0].fromgstin; //"PUNABAKA";
                            document.getElementById('fromstatename').innerHTML = stock_details[0].fromstatename; //"PUNABAKA";
                            document.getElementById('fromstatecode').innerHTML = stock_details[0].fromstatecode; //"PUNABAKA";
                            document.getElementById('Spaninvoiceno').innerHTML = stock_details[0].invoiceno; //"PUNABAKA";
                            document.getElementById('spninvoicedate').innerHTML = stock_details[0].date; //"PUNABAKA";
                            document.getElementById('spn_ref_no').innerHTML = stock_details[0].sno; //"PUNABAKA";


                            document.getElementById('tobranchname').innerHTML = stock_details[0].distibutorname; //"PUNABAKA";
                            document.getElementById('spn_tobranch_addr').innerHTML = stock_details[0].address; //"PUNABAKA";
                            document.getElementById('spn_tobranch_gstin').innerHTML = stock_details[0].gstno; //"PUNABAKA";
                            document.getElementById('tostatename').innerHTML = stock_details[0].fromstatename; //"PUNABAKA";
                            document.getElementById('tostatecode').innerHTML = stock_details[0].fromstatecode; //"PUNABAKA";
                            document.getElementById('spn_transport_mode').innerHTML = stock_details[0].modeoftransport; //"PUNABAKA";
                            document.getElementById('spn_vehicle_no').innerHTML = stock_details[0].vehicleno; //"PUNABAKA";
                            document.getElementById('spn_dotransfer').innerHTML = stock_details[0].date;

                            var fromstate_sno = stock_details[0].fromstateid;
                            var tostate_sno = stock_details[0].stateid;
                            var branch_type = stock_details[0].branchtype;
                            if (fromstate_sno == tostate_sno) {
                                if (branch_type == "Own") {
                                    document.getElementById('spn_inv_title').innerHTML = "Stock Transfer";
                                    document.getElementById('lblsttype').innerHTML = "St No :";
                                    document.getElementById('lblstdate').innerHTML = "St Date :";
                                    document.getElementById('spndtype').innerHTML = "Date of Transfer :";

                                }
                                else {
                                    document.getElementById('spn_inv_title').innerHTML = "Invoice/Bill Of Supply";
                                    document.getElementById('lblsttype').innerHTML = "Invoice No :";
                                    document.getElementById('lblstdate').innerHTML = "Invoice Date :";
                                    document.getElementById('spndtype').innerHTML = "Date of Supply :";
                                }
                            }
                            else {
                                document.getElementById('spn_inv_title').innerHTML = "Invoice/Bill Of Supply";
                                document.getElementById('lblsttype').innerHTML = "Invoice No :";
                                document.getElementById('lblstdate').innerHTML = "Invoice Date :";
                                document.getElementById('spndtype').innerHTML = "Date of Supply :";
                            }
                            fill_stock_Sub_details_click_gst(stock_sub_details);
                        }
                        else {
                            alert("NO DATA FOUND");
                            return false;
                        }
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

        function fill_stock_Sub_details_click_gst(msg) {
            var gst_exists = "1";
            if (gst_exists == "1") {
                var results = '<div><table id="tbl_outward" class="table table-bordered table-hover dataTable no-footer" border="2" style="width:100%;">';
                results += '<thead><tr style="background: antiquewhite;"><th scope="col" class="tdheading" rowspan="2">Sno</th><th scope="col" rowspan="2" class="tdheading">Item Code</th><th scope="col" class="tdheading" rowspan="2">Item Description</th><th scope="col" rowspan="2" class="tdheading">HSN CODE</th><th scope="col" rowspan="2" class="tdheading">UOM</th><th scope="col" rowspan="2" class="tdheading">Price (Rs.)</th><th scope="col" rowspan="2" class="tdheading">Qty</th><th scope="col" rowspan="2" class="tdheading">Taxable Value</th><th scope="col" colspan="2" class="tdheading">SGST</th><th scope="col" colspan="2" class="tdheading">CGST</th><th scope="col" colspan="2" class="tdheading">IGST</th><th scope="col" rowspan="2" class="tdheading">Total Amount</th></tr><tr style="background: antiquewhite;"><th class="tdheading">%</th><th class="tdheading">Amt (Rs.)</th><th class="tdheading">%</th><th class="tdheading">Amt (Rs.)</th><th class="tdheading">%</th><th class="tdheading">Amt (Rs.)</th></tr></thead></tbody>';
                var j = 1;
                var total_amount = 0; var freigtamt_gst = 0; var taxable = 0; var tot_freight = 0;
                var sgst = 0; var cgst = 0; var igst = 0; var grand_total = 0; var tot_amt = 0;
                for (var i = 0; i < msg.length; i++) {
                    var Quantity = 0; var Amount = 0; var sgst_per = 0; var sgst_amt = 0; var cgst_per = 0; var cgst_amt = 0; var igst_per = 0; var igst_amt = 0;
                    Quantity = parseFloat(msg[i].Quantity);
                    Price = parseFloat(msg[i].PerUnitRs);
                    Amount = Quantity * Price;
                    Amount = parseFloat(Amount).toFixed(2);
                    taxable += parseFloat(Amount);
                    sgst_per = msg[i].sgst;
                    sgst_amt = (parseFloat(Amount) * parseFloat(sgst_per)) / 100;
                    sgst += sgst_amt;
                    cgst_per = msg[i].cgst;
                    cgst_amt = (parseFloat(Amount) * parseFloat(cgst_per)) / 100;
                    cgst += cgst_amt;
                    igst_per = msg[i].igst;
                    igst_amt = (parseFloat(Amount) * parseFloat(igst_per)) / 100;
                    igst += igst_amt;
                    tot_amt = parseFloat(Amount) + parseFloat(sgst_amt) + parseFloat(cgst_amt) + parseFloat(igst_amt);
                    total_amount += parseFloat(tot_amt);
                    //document.getElementById('spninvoicedate').innerHTML = stock_sub_details[0].invoicedate;
                    //document.getElementById('Spaninvoiceno').innerHTML = stock_sub_details[0].invoiceno;

                    results += '<tr style="font-size:11px;"><th scope="row" class="1" style="text-align:center;">' + j + '</th>';
                    results += '<td style="text-align:center;" class="2">' + msg[i].itemcode + '</td>';
                    results += '<td style="text-align:center;" class="2">' + msg[i].productname + '</td>';
                    results += '<td style="text-align:center;" class="2 ">' + msg[i].hsncode + '</td>';
                    results += '<td style="text-align:center;" class="2 ">' + msg[i].uim + '</td>';
                    results += '<td style="text-align:center;" class="3">' + Price.toFixed(2) + '</td>';
                    results += '<td style="text-align:center;">' + Quantity + '</td>';
                    results += '<td style="text-align:center;">' + Amount + '</td>';
                    results += '<td style="text-align:center;" class="2">' + msg[i].sgst + '</td>';
                    results += '<td style="text-align:center;" class="2">' + parseFloat(sgst_amt).toFixed(2) + '</td>';
                    results += '<td style="text-align:center;" class="2">' + msg[i].cgst + '</td>';
                    results += '<td style="text-align:center;" class="2">' + parseFloat(cgst_amt).toFixed(2) + '</td>';
                    results += '<td style="text-align:center;" class="2">' + msg[i].igst + '</td>';
                    results += '<td style="text-align:center;" class="2">' + parseFloat(igst_amt).toFixed(2) + '</td>';
                    results += '<td style="text-align:center;" class="amountcls"><div style="float:right;padding-right: 33%;">' + tot_amt.toFixed(2) + '</div></td></tr>';
                    j++;
                }
                var tot = "";
                var tqty = "Total";
                results += '<tr>';
                results += '<td data-title="brandstatus" colspan="6" style="text-align:center;background: antiquewhite;" class="2 tdheading">' + tqty + '</td>';
                results += '<td></td>';
                results += '<td data-title="brandstatus" class="4 tdheading" style="text-align:center;">' + parseFloat(taxable).toFixed(2) + '</td>';
                results += '<td data-title="brandstatus" colspan="2" style="text-align:center;" class="4 tdheading">' + parseFloat(sgst).toFixed(2) + '</td>';
                results += '<td data-title="brandstatus" colspan="2" style="text-align:center;" class="4 tdheading">' + parseFloat(cgst).toFixed(2) + '</td>';
                results += '<td data-title="brandstatus" colspan="2" style="text-align:center;" class="4 tdheading">' + parseFloat(igst).toFixed(2) + '</td>';
                results += '<td data-title="brandstatus" style="text-align:center;" class="3 tdheading"><span id="totamcls">' + total_amount.toFixed(2) + '</span></td></tr>';
                results += '</table></div>';
                $("#div_itemdetails").html(results);
                grand_total = parseFloat(total_amount) + parseFloat(tot_freight) + parseFloat(freight_main);
                if (freigtamt_gst != 0) {
                    document.getElementById('spn_fright_amount').innerHTML = parseFloat(tot_freight).toFixed(2); ;
                    $('#lblfright').show();
                }
                else {
                    $('#lblfright').hide();
                    document.getElementById('spn_fright_amount').innerHTML = "";
                }
                if (freight_main != 0) {
                    document.getElementById('spn_fright_amount').innerHTML = parseFloat(freight_main).toFixed(2); ;
                    $('#lblfright').show();
                }
                else {
                    $('#lblfright').hide();
                    document.getElementById('spn_fright_amount').innerHTML = "";
                }
                $('#lbltax').hide();
                var grandtotal = parseFloat(grand_total);
                var grandtotal1 = grandtotal.toFixed(0);
                var diff = 0;
                if (grandtotal > grandtotal1) {
                    diff = grandtotal - grandtotal1;
                }
                else {
                    diff = grandtotal1 - grandtotal;
                }
                document.getElementById('spn_totalpoamt').innerHTML = parseFloat(grandtotal).toFixed(2);
                document.getElementById('spn_roundoffamt').innerHTML = parseFloat(diff).toFixed(2);
                document.getElementById('spn_grandtotal').innerHTML = parseFloat(grandtotal1).toFixed(2);
                var grand_total1 = parseFloat(grand_total).toFixed(2);
                document.getElementById('spn_grandtotal_words').innerHTML = inWords(parseInt(grandtotal1));
            }
            else {
                fill_stock_Sub_details_click(msg);
            }
        }

        var tax = 0; var freigtamt = 0; var taxamt = 0;
        function fill_stock_Sub_details_click(msg) {
            var results = '<div  style="overflow:auto;"><table id="tbl_outward" class="table table-bordered table-hover dataTable no-footer" border="2" style="width:100%;">';
            results += '<thead><tr><th scope="col" class="tdheading">Sno</th><th scope="col" class="tdheading">Product Name</th><th scope="col" class="tdheading">Price</th><th scope="col" class="tdheading">Qty</th><th scope="col" class="tdheading">Total Amount</th></tr></thead></tbody>';
            var j = 1;
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].invoicetype == "WithOutInvoice") {
                    var Quantity = 0; var Amount = 0;
                    Quantity = parseFloat(msg[i].quantity);
                    Price = parseFloat(msg[i].price);
                    Amount = Quantity * Price;
                    Amount = parseFloat(Amount).toFixed(2);
                    taxtype = msg[i].taxtype;
                    tax = parseFloat(msg[i].taxvalue);
                    freigtamt = parseFloat(msg[i].freigtamt);
                    document.getElementById('spninvoicedate').innerHTML = stock_sub_details[0].invoicedate;
                    document.getElementById('Spaninvoiceno').innerHTML = stock_sub_details[0].invoiceno;
                    results += '<tr><th scope="row" class="1 tdsize" style="text-align:center;">' + j + '</th>';
                    results += '<td data-title="brandstatus" style="text-align:center;" class="2 tdsize">' + msg[i].productname + '</td>';
                    results += '<td data-title="brandstatus" style="text-align:center;" class="3 tdsize">' + Price.toFixed(2) + '</td>';
                    results += '<td data-title="brandstatus" style="text-align:center;" class="tdsize">' + Quantity + '</td>';
                    results += '<td data-title="brandstatus" style="text-align:center;" class="amountcls tdsize">' + Amount + '</td></tr>';
                    j++;
                }
                else {
                    var Quantity = 0; var Amount = 0; // var taxtype = 0; var tax = 0; var freightamt = 0;
                    Quantity = parseFloat(msg[i].quantity);
                    Price = parseFloat(msg[i].price);
                    Amount = Quantity * Price;
                    Amount = parseFloat(Amount).toFixed(2);
                    taxtype = msg[i].taxtype;
                    tax = parseFloat(msg[i].taxvalue);
                    freigtamt = parseFloat(msg[i].freigtamt) || 0;
                    document.getElementById('spninvoicedate').innerHTML = stock_sub_details[0].invoicedate;
                    document.getElementById('Spaninvoiceno').innerHTML = stock_sub_details[0].invoiceno;
                    results += '<tr><th scope="row" class="1 tdsize" style="text-align:center;">' + j + '</th>';
                    results += '<td data-title="brandstatus" style="text-align:center;" class="2 tdsize">' + msg[i].productname + '</td>';
                    results += '<td data-title="brandstatus" style="text-align:center;" class="3 tdsize">' + Price + '</td>';
                    results += '<td data-title="brandstatus" style="text-align:center; class="tdsize">' + Quantity + '</td>';
                    results += '<td data-title="brandstatus" style="text-align:center;" class="amountcls tdsize">' + Amount + '</td></tr>';
                    j++;
                }
            }
            var tot = "";
            var tqty = "Total"
            results += '<tr><th scope="row" class="1" style="text-align:center;"></th>';
            results += '<td data-title="brandstatus" class="4"></td>';
            results += '<td data-title="brandstatus" class="4"></td>';
            results += '<td data-title="brandstatus" class="2 tdheading">' + tqty + '</td>';
            results += '<td data-title="brandstatus" class="3 tdheading"><span id="totamcls"></span></td></tr>';
            results += '</table></div>';
            $("#div_itemdetails").html(results);
            GetTotalQty();
        }
        function GetTotalQty() {
            var Total = 0; var totalamount = 0;
            $('.amountcls').each(function (i, obj) {
                var qty = $(this).text();
                if (qty == "" || qty == "0") {
                }
                else {
                    Total += parseFloat(qty);
                }
            });
            document.getElementById('totamcls').innerHTML = parseFloat(Total).toFixed(2);
            var taxamt = 0;
            taxamt = (Total * tax) / 100 || 0;
            if (taxamt != 0) {
                document.getElementById('spn_Tax').innerHTML = parseFloat(taxamt).toFixed(2); ;
                $('#lbltax').show();
            }
            else {
                $('#lbltax').hide();
                document.getElementById('spn_Tax').innerHTML = "";
            }
            totalamount = Total + taxamt; ;
            var grandtotal = totalamount + freigtamt;
            if (freigtamt != 0) {
                document.getElementById('spn_fright_amount').innerHTML = parseFloat(freigtamt).toFixed(2);
                $('#lblfright').show();
            }
            else {
                $('#lblfright').hide();
                document.getElementById('spn_fright_amount').innerHTML = "";
            }
            var grand_total = parseFloat(grandtotal);
            var grandtotal1 = grandtotal.toFixed(0);
            var diff = 0;
            if (grand_total > grandtotal1) {
                diff = grand_total - grandtotal1;
            }
            else {
                diff = grandtotal1 - grand_total;
            }
            document.getElementById('spn_totalpoamt').innerHTML = grand_total;
            document.getElementById('spn_roundoffamt').innerHTML = diff;
            document.getElementById('spn_grandtotal').innerHTML = grandtotal1;
            var grand_total = parseFloat(grandtotal).toFixed(2);
            document.getElementById('spn_grandtotal_words').innerHTML = inWords(parseInt(grandtotal1));
        }
        function get_subdistibutor_details() {
            var data = { 'op': 'get_subdistibutor_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillsubdetails(msg);
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
        function fillsubdetails(msg) {
            var data = document.getElementById('ddlsubdistibutor');
            var length = data.options.length;
            document.getElementById('ddlsubdistibutor').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select Distibutor";
            opt.value = "Select  Distibutor";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            data.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].parlorname != null) {
                    var opt = document.createElement('option');
                    opt.innerHTML = msg[i].parlorname;
                    opt.value = msg[i].sno;
                    data.appendChild(opt);
                }
            }
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
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="fa fa-cog"></i> Invoice Report
                </h3>
            </div>
            <div class="box-body">
                <div runat="server" id="d">
                    <table>
                        <tr>
                        <td>
                                <label>
                                   Branch Name:</label>
                            </td>
                            <td>
                                <select id="ddlsubdistibutor" class="form-control"></select>
                            </td>
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
                                        <span class="glyphicon glyphicon-flash" class="btn btn-primary" onclick="get_distibutorsale_details();"></span> <span id="btn_save" class="btn btn-primary" onclick="get_distibutorsale_details();">Get Details</span>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <div id="divPOdata" style="height: 300px; overflow-y: scroll;">
                    </div>
                </div>
                <div>
                </div>
                <div id="divPrint" style="display: none;">
                    <div style="border: 2px solid gray;">
                        <div style="width: 17%; float: right; padding-top:5px;">
                            <img src="Images/Vyshnavilogo.png" alt="Vyshnavi" width="100px" height="72px" />
                            <br />
                        </div>
                        <div style="border: 1px solid gray;">
                            <div style="font-family: Arial; font-size: 22px; font-weight: bold; color: Black;text-align: center;">
                                <span>Sri Vyshnavi Dairy Specialities (P) Ltd </span>
                                <br />
                            </div>
                            <div style="width:68%;text-align: center;padding-left: 14%;">
                            <span id="spnAddress" class="spanrpt"></span>
                            <span id="spn_gstin" class="spanrpt"></span>
                            </div>
                            <div style="width:40%;">
                            <span id="spnstate" class="spanrpt" style="display:none;"></span><br />
                            </div>
                        </div>
                   <div align="center" style="border-bottom: 1px solid gray; border-top: 1px solid gray;background-color: antiquewhite;">
                        <span id="spn_inv_title" style="font-size: 18px; font-weight: bold;">Delivery Challan/Invoice</span>
                   </div>
                   <div style="width: 100%;">
                        <table style="width: 100%;">
                            <tr style="background-color: antiquewhite; border:2px solid gray;">
                                <td style="text-align:center;" class="labelrpt">
                                    <label><b>
                                        Bill From </b></label>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="width: 49%;  padding-left:2%; border:2px solid gray;">
                                    <label><b>
                                        Name :</b></label>
                                    <span class="labelrpt" style="font-weight:bold;" id="frombranchname"></span>
                                    <br />
                                    <label class="labelrpt"><b>
                                        Address :</b></label>
                                    <span id="spn_frombranch_addr" class="spanrpt"></span>
                                    <br />
                                    <label class="labelrpt"><b>
                                        GSTIN :</b></label>
                                    <span id="spn_frombranch_gstin" class="spanrpt"></span>
                                    <br />
                                    <label class="labelrpt"><b>State :</b></label>
                                    <span id="fromstatename" class="spanrpt"></span>
                                    <br />
                                    <label class="labelrpt"><b>Code :</b></label>
                                    <span id="fromstatecode" class="spanrpt"></span>
                                </td>
                                <td style="width: 50%;  padding-left:2%;border:2px solid gray;" >
                                    <label id="lblsttype" class="spanrpt" style="font-weight:bold !important;">
                                        </label>
                                    <span id="Spaninvoiceno" class="tdsize"></span>
                                    <br />
                                    <label id="lblstdate" class="spanrpt" style="font-weight:bold;">
                                        </label>
                                    <span id="spninvoicedate" class="tdsize"></span>
                                    <br />
                                    <label id="lbl_ref_no" style="font-size:12px;font-weight:bold">Reference Number</label>
                                    <span id="spn_ref_no"></span>

                                </td>
                            </tr>
                        
                            <tr style="background-color: antiquewhite; border:2px solid gray;">
                                <td class="labelrpt" style="text-align:center;"> 
                                    <label><b>
                                        Bill To </b></label>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="width: 49%; padding-left:2%;border:2px solid gray; padding-bottom:5%;">
                                    <label class="labelrpt"><b>
                                        Name :</b></label>
                                    <span id="tobranchname" class="spanrpt"></span>
                                    <br />
                                    <label class="labelrpt"><b>
                                        Address :</b></label>
                                    <span id="spn_tobranch_addr" class="spanrpt"></span>
                                    <br />
                                    <label class="labelrpt"><b>
                                        GSTIN :</b></label>
                                    <span id="spn_tobranch_gstin" class="spanrpt"></span>
                                    <br />
                                    <label class="labelrpt"><b>
                                        State :</b></label>
                                    <span id="tostatename" class="spanrpt"></span>
                                    <br />
                                    <label class="labelrpt"><b>Code :</b></label>
                                    <span id="tostatecode" class="spanrpt"></span>
                                </td>
                                <td style="width: 50%;  padding-left:2%; border:2px solid gray;">
                                    <label><b>
                                        Tranport Mode:</b></label>
                                    <span id="spn_transport_mode"></span>
                                    <br />
                                    <label><b>
                                        Vehicle No:</b></label>
                                    <span id="spn_vehicle_no"></span>
                                    <br />
                                    <label><b>
                                        <span id="spndtype"></span></b></label>
                                    <span id="spn_dotransfer"></span>
                                </td>
                            </tr>
                        </table>
                        
                        </div>
                         <div  style="border-bottom: 1px solid gray; border-top: 1px solid gray;text-align: center;">
                       <br />
                    </div>
                        <div id="div_itemdetails">
                        </div>
                        <div>
                            <table class="table table-bordered table-hover dataTable no-footer" style="width:100%;">
                                <tr>
                                    <td style="width: 15%;">
                                    </td>
                                    <td style="width: 15%;">
                                    </td>
                                    <td style="width: 15%;">
                                    </td>
                                    <td style="width: 15%;" colspan="2">
                                        <label class="tdheading" id="lblfright">
                                            Fright Amount:</label>
                                    </td>
                                    <td style="width: 15%;">
                                        <span id="spn_fright_amount" class="tdsize"></span>
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
                                        <label class="tdheading" id="lbltax">
                                            Tax</label>
                                    </td>
                                    <td>
                                        <span id="spn_Tax" class="tdsize"></span>
                                    </td>
                                </tr>
                                <tr>
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
                                    <td colspan="2">
                                        <label class="tdheading">
                                            Total Amount:</label>
                                    </td>
                                    <td>
                                        <span id="spn_grandtotal" class="tdheading"></span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        Rupees in Words :&nbsp;<span id="spn_grandtotal_words" class="spanrpt"></span>
                    </div>
                    <div>
                    <label class="tdheading">
                            1. Remarks :</label>
                        <span id="spnremarks" class="spanrpt"></span>
                    </div>
                    <br />
                    <table style="width: 100%;">
                        <tr>
                            <td style="width: 25%;">
                                <span style="font-weight: bold;" class="tdsize">INDENTED BY</span>
                            </td>
                            <td style="width: 25%;">
                                <span style="font-weight: bold;" class="tdsize">APPROVED BY</span>
                            </td>
                            <td style="width: 25%;">
                                <span style="font-weight: bold;" class="tdsize">STORES</span>
                            </td>
                            <td style="width: 25%;">
                                <span style="font-weight: bold;" class="tdsize">RECEIVER SIGNATURE</span>
                            </td>
                        </tr>
                    </table>
                </div>
                <br />
                <br />
                
                <asp:Label ID="lblmsg" runat="server" Font-Size="20px" ForeColor="Red" Text=""></asp:Label>
            </div>
        </div>
        <div class="input-group" id="Button2" style="display:none;padding-right: 90%;">
                    <div class="input-group-addon">
                        <span class="glyphicon glyphicon-print" onclick="javascript: CallPrint('divPrint');"></span> <span id="Span1" onclick="javascript: CallPrint('divPrint');">Print</span>
                    </div>
                </div>
    </section>
</asp:Content>

