<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="stocktransfer.aspx.cs" Inherits="stocktransfer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type='text/javascript'>
        $(function () {
            get_product_details();
            get_parlor_details();
            get_stocktransfer_details();
            $("#btnaddclick").click(function () {
                $('#divitem').css('display', 'block');
                $('#divbind').css('display', 'none');
            })
            $("#btnclose").click(function () {
                $('#divitem').css('display', 'none');
                $('#divbind').css('display', 'block');
            })
        });

        function get_parlor_details() {
            var data = { 'op': 'get_parlor_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillfrmsupplierdetails(msg);
                        filltosupplierdetails(msg);
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
       
        function fillfrmsupplierdetails(msg) {
            var data = document.getElementById('slctfrmbranch');
            var length = data.options.length;
            document.getElementById('slctfrmbranch').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select Branch";
            opt.value = "Select Branch";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            data.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].parlorname != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].parlorname;
                    option.value = msg[i].sno;
                    data.appendChild(option);
                }
            }
        }
        function filltosupplierdetails(msg) {
            var data = document.getElementById('slcttobranch');
            var length = data.options.length;
            document.getElementById('slcttobranch').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select Branch";
            opt.value = "Select Branch";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            data.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].parlorname != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].parlorname;
                    option.value = msg[i].sno;
                    data.appendChild(option);
                }
            }
        }
        $(document).click(function () {
            $('#posTable').on('change', '.price', calTotal)
                  .on('change', '.quantity', calTotal);
            function calTotal() {
                var $row = $(this).closest('tr');
                price = $row.find('.price').val();
                quantity = $row.find('.quantity').val();
                var prod_total = price * quantity;
                prod_total = prod_total.toFixed(2);
                var total = parseFloat(prod_total);
                $row.find('#txtTotal').text(parseFloat(total).toFixed(2));
                $row.find('#txt_quantity').text(parseFloat(quantity).toFixed(2));
                clstotalval();
            }
        });
        var itemlist = [];
        var dupliitemlist = [];
        function clstotalval() {
            var totaamount = 0; //var totalpfamount = 0;
            var tottaxamount = 0; //var totalpfamount = 0;
            var rowcount = 0;
            $('.clstotal').each(function (i, obj) {
                var totlclass = $(this).html();
                if (totlclass == "" || totlclass == "0") {
                }
                else {
                    totaamount += parseFloat(totlclass);
                }
                rowcount = rowcount + 1;
            });
            var totalamount1 = parseFloat(totaamount);
            var grandtotal = parseFloat(totalamount1);
            var grandtotal1 = grandtotal.toFixed(2);
            var diff = 0;
            if (grandtotal > grandtotal1) {
                diff = grandtotal - grandtotal1;
            }
            else {
                diff = grandtotal1 - grandtotal;
            }
            document.getElementById('total').innerHTML = grandtotal.toFixed(2);
            document.getElementById('count').innerHTML = rowcount;
        }
        function amountchange() {
            var totalamount = document.getElementById('spntwt').innerHTML;
            var amount = document.getElementById('txtamount').value;
            document.getElementById('spntotal_paying').innerHTML = amount;
            var tamt = parseFloat(totalamount);
            var balamt = (parseFloat(amount) - tamt);
            document.getElementById('balance').innerHTML = balamt;
        }
        var productdetails = [];
        function get_product_details() {
            var subcatid = "0";
            var data = { 'op': 'get_product_details', 'subcatid': subcatid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        productdetails = msg;
                        filldata(msg);
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
        function qtychage(thisid) {
            var price = 0;
            var quantity = 0;
            var total = 0;
            price = $(thisid).closest("tr").find('#txt_perunitrs').val();
            quantity = $(thisid).closest("tr").find('#txt_quantity').val();
            if (quantity != "") {
                price = parseFloat(price);
                quantity = parseFloat(quantity);
                total = price * quantity;
                //$(thisid).closest("tr").find('#txtTotal').val(parseFloat(total).toFixed(2));
                var rows = $("#tabledetails tr:gt(0)");
                $(rows).each(function (i, obj) {
                    if ($(this).find('#spn_Productname').text() != "") {
                        var productname = $(this).find('#spn_Productname').text();
                        var Quantity = $(this).find('#txt_quantity').val();

                    }
                });

            }
            else {
                $(thisid).closest("tr").find('#txtTotal').val("0");
            }
        }


        var productdetails = [];
        function getcode1() {
            var data = { 'op': 'get_product_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        filldata(msg);
                        productdetails = msg;
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
        var compiledList = [];
        function filldata(msg) {
            for (var i = 0; i < msg.length; i++) {
                var productname = msg[i].productname;
                compiledList.push(productname);
            }
            $('#txtitem').autocomplete({
                source: compiledList,
                change: test1,
                autoFocus: true
            });
        }


        var DataTable;
        var ProductTable = [];
        function test1() {
            var txtbarcode = document.getElementById('txtitem').value;
            productdetails;
            DummyTable1;
            DataTable = [];
            var rows = $("#posTable tr:gt(0)");
            var txtsno = 0;
            var rowsno = 1;
            var taxtype = 0;
            var ed = 0;
            var disamt = 0;
            var dis = 0;
            var tax = 0;
            var edtax = 0;
            $(rows).each(function (i, obj) {
                if ($(this).find('#spn_Productname').text() != "") {
                    txtsno = rowsno;
                    productname = $(this).find('#spn_Productname').text();
                    price = $(this).find('#txt_perunitrs').val();
                    Quantity = $(this).find('#txt_quantity').val();
                    TotalCost = $(this).find('#txtTotal').text();
                    productid = $(this).find('#hdnproductsno').val();
                    DataTable.push({ Sno: txtsno, productname: productname, price: price, Quantity: Quantity, TotalCost: TotalCost, productid: productid });
                    rowsno++;
                }
            });
            var productname = 0;
            var price = 0;
            var Quantity = 0;
            var TotalCost = 0;
            var productid = 0;
            var Sno = parseInt(txtsno) + 1;
            if (txtbarcode != "") {
                if (ProductTable.indexOf(txtbarcode) == -1) {
                    for (var i = 0; i < productdetails.length; i++) {
                        if (txtbarcode == productdetails[i].productname) {
                            productname = productdetails[i].productname;
                            price = productdetails[i].price;
                            productid = productdetails[i].productid;
                            var cgst = productdetails[i].cgst;
                            var sgst = productdetails[i].sgst;
                            var igst = productdetails[i].igst;
                            DataTable.push({ Sno: Sno, productname: productname, price: price, Quantity: Quantity, TotalCost: TotalCost, productid: productid });
                            ProductTable.push(txtbarcode);
                        }
                    }
                }
                else {
                    alert("Product Name already added");
                    document.getElementById('txtitem').value = "";
                    return false;
                }
            }
            if (DataTable.length > 0) {
                var itemresults = '<table id="posTable" class="table table-striped table-condensed table-hover list-table" style="margin: 0px;" data-height="100"><thead> <tr class="success"><th> Product</th> <th style="width: 15%; text-align: center;"> Price </th><th style="width: 15%; text-align: center;"> Qty</th><th style="width: 20%; text-align: center;">Subtotal </th> <th style="width: 20px;" class="satu"><i class="fa fa-trash-o"></i> </th></tr></thead> ';
                for (var i = 0; i < DataTable.length; i++) {
                    itemresults += '<tr>';
                    itemresults += '<td  class="1" style="display:none;">' + DataTable[i].productname + '</td>';
                    if (i % 2 == 0) {
                        itemresults += '<td style="text-align: center;"><span class="sname" id="spn_Productname">' + DataTable[i].productname + '</span></td>';
                    }
                    else {
                        itemresults += '<td style="text-align: center;"><span class="sname" id="spn_Productname">' + DataTable[i].productname + '</span></td>';
                    }
                    var itemprice = parseFloat(DataTable[i].price);
                    itemresults += '<td style="width:20%; text-align: center;"><span class="text-right sprice" id="sprice_1541067686388" style="display:none;">' + itemprice + '</span><input id="txt_perunitrs" name="prices" class="price" type="text" value="' + itemprice + '"/></td>';
                    itemresults += '<td style="width:20%; text-align: center;"><input id="txt_quantity" type="text" class="quantity" onkeyup="qtychage(this);" value="' + DataTable[i].Quantity + '" name="quantity"/></td>';
                    itemresults += '<td style="width:20%; text-align: center;"><span class="clstotal text-right ssubtotal" id="txtTotal">' + DataTable[i].TotalCost + '</span></td>';
                    itemresults += '<td class="text-center"><span onclick="removerow(this);" style="cursor: pointer;color: red;"><i class="fa fa-trash-o"></i></span></td>';
                    itemresults += '<td class="text-center"><input id="hdnproductsno" type="hidden" value="' + DataTable[i].productid + '"></td>';
                    itemresults += '</tr>';
                }
                itemresults += '</table>';
                $("#div_itemData").html(itemresults);
                clstotalval();
                document.getElementById('txtitem').value = "";
            }
        }
        function tesdddddt1() {
            var val = document.getElementById('txtitem').value;
            for (var i = 0; i < productdetails.length; i++) {
                if (val == productdetails[i].productname) {
                    val = productdetails[i].productid;
                }
            }
            var checkflag = true;
            if (dupliitemlist.indexOf(val) == -1) {
                for (var i = 0; i < productdetails.length; i++) {
                    if (val == productdetails[i].productid) {
                        var productname = productdetails[i].productname;
                        var price = productdetails[i].price;
                        var productid = productdetails[i].productid;
                        var cgst = productdetails[i].cgst;
                        var sgst = productdetails[i].sgst;
                        var igst = productdetails[i].igst;
                        itemlist.push({ productname: productname, price: price, sgst: sgst, cgst: cgst, igst: igst, productid: productid });
                        dupliitemlist.push(productid);
                    }
                }
                if (itemlist.length > 0) {
                    var itemresults = '<table id="posTable" class="table table-striped table-condensed table-hover list-table" style="margin: 0px;" data-height="100"><thead> <tr class="success"><th> Product</th> <th style="width: 15%; text-align: center;"> Price </th><th style="width: 15%; text-align: center;"> Qty</th><th style="width: 20%; text-align: center;">Subtotal </th> <th style="width: 20px;" class="satu"><i class="fa fa-trash-o"></i> </th></tr></thead> ';
                    for (var i = 0; i < itemlist.length; i++) {
                        itemresults += '<tr>';
                        itemresults += '<td  class="1" style="display:none;">' + itemlist[i].productname + '</td>';
                        if (i % 2 == 0) {
                            itemresults += '<td style="text-align: center;"><span class="sname" id="spn_Productname">' + itemlist[i].productname + '</span></td>';
                        }
                        else {
                            itemresults += '<td style="text-align: center;"><span class="sname" id="spn_Productname">' + itemlist[i].productname + '</span></td>';
                        }
                        var itemprice = parseFloat(itemlist[i].price);
                        itemresults += '<td style="width:20%; text-align: center;"><span class="text-right sprice" id="sprice_1541067686388" style="display:none;">' + itemprice + '</span><input id="txt_perunitrs" name="prices" class="price" type="text" value="' + itemprice + '"/></td>';
                        itemresults += '<td style="width:20%; text-align: center;"><input id="txt_quantity" type="text" class="quantity" onkeyup="qtychage(this);"  name="quantity"/></td>';
                        itemresults += '<td style="width:20%; text-align: center;"><span class="clstotal text-right ssubtotal" id="txtTotal"></span></td>';
                        itemresults += '<td class="text-center"><span onclick="removerow(this);" style="cursor: pointer;color: red;"><i class="fa fa-trash-o"></i></span></td>';
                        itemresults += '<td class="text-center"><input id="hdnproductsno" type="hidden" value="' + itemlist[i].productid + '"></td>';
                        itemresults += '</tr>';
                    }
                    itemresults += '</table>';
                    $("#div_itemData").html(itemresults);
                    clstotalval();
                    document.getElementById('txtitem').value = "";
                }
            }
            else {
                alert("Product Name already added");
                var empt = "";
                $(thisid).val(empt);
                return false;
            }
        }
        function removerow1(thisid) {
            $(thisid).parents('tr').remove();
            clstotalval();
        }
        var DummyTable1 = [];
        function removerow(thisid) {
            DataTable = []
            var rows = $("#posTable tr:gt(0)");
            $(rows).each(function (i, obj) {
                if ($(this).find('#spn_Productname').text() != "") {
                    txtsno = rowsno;
                    productname = $(this).find('#spn_Productname').text();
                    price = $(this).find('#txt_perunitrs').val();
                    Quantity = $(this).find('#txt_quantity').val();
                    TotalCost = $(this).find('#txtTotal').text();
                    productid = $(this).find('#hdnproductsno').val();
                    DataTable.push({ Sno: txtsno, productname: productname, price: price, Quantity: Quantity, TotalCost: TotalCost, productid: productid });
                    rowsno++;
                }
            });
            var product_name = $(thisid).parent().parent().children('.1').html();
            var txtsno = 0;
            var rowsno = 1;
            var dummyitem = [];
            var rdummyitem = [];
            dupliitemlist = [];
            for (var i = 0; i < DataTable.length; i++) {
                if (product_name == DataTable[i].productname) {
                }
                else {
                    var productname = DataTable[i].productname;
                    var PerUnitRs = DataTable[i].price;
                    var Quantity = DataTable[i].Quantity;
                    var TotalCost = DataTable[i].TotalCost;
                    var productid = DataTable[i].productid;
                    var sumprice = parseFloat(PerUnitRs);
                    dummyitem.push({ productname: productname, price: PerUnitRs, Quantity: Quantity, TotalCost: TotalCost, productid: productid });
                    rdummyitem.push({ productname: productname, price: sumprice, Quantity: Quantity, TotalCost: TotalCost, productid: productid });
                    dupliitemlist.push(productid);
                }
            }
            if (dummyitem.length > 0) {
                itemlist = [];
                itemlist = rdummyitem;
                var itemresults = '<table id="posTable" class="table table-striped table-condensed table-hover list-table" style="margin: 0px;" data-height="100"><thead> <tr class="success"><th> Product</th> <th style="width: 15%; text-align: center;"> Price </th><th style="width: 15%; text-align: center;"> Qty</th><th style="width: 20%; text-align: center;">Subtotal </th> <th style="width: 20px;" class="satu"><i class="fa fa-trash-o"></i> </th></tr></thead> ';
                for (var i = 0; i < dummyitem.length; i++) {
                    itemresults += '<tr>';
                    itemresults += '<td  class="1" style="display:none;">' + dummyitem[i].productname + '</td>';
                    if (i % 2 == 0) {
                        itemresults += '<td style="text-align: center;"><span class="sname" id="spn_Productname">' + dummyitem[i].productname + '</span></td>';
                    }
                    else {
                        itemresults += '<td style="text-align: center;"><span class="sname" id="spn_Productname">' + dummyitem[i].productname + '</span></td>';
                    }
                    var itemprice = parseFloat(dummyitem[i].price);
                    itemresults += '<td style="width:20%; text-align: center;"><span class="text-right sprice" id="sprice_1541067686388" style="display:none;">' + itemprice + '</span><input id="txt_perunitrs" name="prices" class="price" type="text" value="' + itemprice + '"/></td>';
                    itemresults += '<td style="width:20%; text-align: center;"><input id="txt_quantity" type="text" class="quantity" onkeyup="qtychage(this);" value="' + dummyitem[i].Quantity + '" name="quantity"/></td>';
                    itemresults += '<td style="width:20%; text-align: center;"><span class="clstotal text-right ssubtotal" id="txtTotal">' + dummyitem[i].TotalCost + '</span></td>';
                    itemresults += '<td class="text-center"><span onclick="removerow(this);" style="cursor: pointer;color: red;"><i class="fa fa-trash-o"></i></span></td>';
                    itemresults += '<td class="text-center"><input id="hdnproductsno" type="hidden" value="' + dummyitem[i].productid + '"></td>';
                    itemresults += '</tr>';
                }
                itemresults += '</table>';
                $("#div_itemData").html(itemresults);
                clstotalval();
            }
        }

        function btnsave_click() {
            var date = document.getElementById('txt_Date').value;
            var refno = document.getElementById('txtrefno').value;
            var frombranch = document.getElementById('slctfrmbranch').value;
            var tobranch = document.getElementById('slcttobranch').value;
            var description = document.getElementById('txtaddress').value;
            var totalvalue = document.getElementById('total').innerHTML;
            var btnvalue = document.getElementById('btnsave').value;
            var sno = document.getElementById('lbl_sno').innerHTML;
            var fillitems = [];
            $('#posTable> tbody > tr').each(function () {
                var productname = $(this).find('#spn_Productname').text();
                var PerUnitRs = $(this).find('#txt_perunitrs').val();
                var Quantity = $(this).find('#txt_quantity').val();
                var TotalCost = $(this).find('#txtTotal').text();
                var hdnproductsno = $(this).find('#hdnproductsno').val();
                if (hdnproductsno == "" || hdnproductsno == "0") {
                }
                else {
                    fillitems.push({ 'productname': productname, 'PerUnitRs': PerUnitRs, 'Quantity': Quantity, 'TotalCost': TotalCost, 'hdnproductsno': hdnproductsno });
                }
            });
            if (fillitems.length == 0) {
                alert("Please Select Items Names");
                return false;
            }
            var Data = { 'op': 'save_stocktransfer_details', 'date': date, 'refnote': refno, 'frombranch': frombranch, 'tobranch': tobranch, 'description': description, 'btnvalue': btnvalue, 'totalvalue': totalvalue, 'sno': sno, 'fillitems': fillitems };
            var s = function (msg) {
                if (msg) {
                    alert(msg);
                    get_stocktransfer_details();
                    //                    forclearall();
                    //                    getinwarddetails();
                }
            }
            var e = function (x, h, e) {
            };
            CallHandlerUsingJson(Data, s, e);
        }

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
                itemresults += '<td style="text-align: center;"><a href="#" onclick="edit(this);" title="Edit Inward" class="tip btn btn-warning btn-xs"><i class="fa fa-edit"></i></a> <a href="#" onclick="getmebranchdelete(this);" title="Delete Inward" class="tip btn btn-danger btn-xs"><i class="fa fa-trash-o"></i></a></td>';
                itemresults += '<td  class="11"  style="display:none;">' + inward[i].description + '</td>';
                itemresults += '<td  class="9"  style="display:none;">' + inward[i].frombranch + '</td>';
                itemresults += '<td  class="7" style="display:none;">' + inward[i].tobranch + '</td>';
                itemresults += '<td class="8" style="display:none;">' + inward[i].sno + '</td>';
                itemresults += '</tr>';
            }
            itemresults += '</table>';
            $("#divSTOCKTRANSFERdata").html(itemresults);

        }

        function()


        function forclearall() {
            document.getElementById('txt_Date').value = "";
            document.getElementById('txtrefno').value = "";
            document.getElementById('slctstate').selectedIndex = "0";
            document.getElementById('slctcstatus').selectedIndex = "1";
            document.getElementById('total').innerHTML = "0";
            document.getElementById('txtaddress').value = "";
            itemlist = [];
            dupliitemlist = [];
            var results = "";
            $("#div_itemData").html(results);

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
            var btnreg = "closereg";
            var data = { 'op': 'save_parlorerclosingregister', 'cashinhand': cashinhand, 'cashsale': cashsale, 'chequesale': chequesale, 'giftcardsale': giftcardsale, 'ccsale': ccsale,
                'stripesale': stripesale, 'othersale': othersale, 'totalsale': totalsale, 'expenses': expenses, 'totalcash': totalcash, 'submittedcash': submittedcash, 'submittedslips': submittedslips,
                'submittedchecks': submittedchecks, 'description': description, 'btnreg': btnreg
            };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
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
    <script type="text/javascript">
        $('body').addClass('skin-green sidebar-collapse sidebar-mini pos');
    </script>
    <section class="content">
    <div class="row"  id="divitem" style="display:none;">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">Stock Transfer</h3>
                </div>
                <div class="box-body">
                    <div class="col-lg-12">
                        <div class="clearfix"></div>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="well well-sm">
                                     <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="cancel_sale">Date</label>
                                                 <input type="date" class="form-control" id="txt_Date" style="border-radius: 0px; important">
                                            </div>
                                        </div>

                                        
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="focus_add_item">Referance No</label> 
                                                <input type="text" name="focus_add_item" value="" class="form-control tip" id="txtrefno">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="cancel_sale">From Branch</label>
                                                 <select class="form-control" id="slctfrmbranch" required="required" style="width:100%;" tabindex="-1" aria-hidden="true">
                                                 </select>
                                            </div>
                                        </div>
                                         <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="cancel_sale">To Branch</label>
                                                 <select class="form-control" id="slcttobranch" required="required" style="width:100%;" tabindex="-1" aria-hidden="true">
                                                   
                                                 </select>
                                            </div>
                                        </div>
                                        
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="close_register">Description</label>
                                                 <textarea id="txtaddress" class="form-control"></textarea>
                                            </div>
                                        </div>
                                        <div class="col-md-12 col-sm-12">
                                            <div class="form-group">
                                                <input type="text" name="focus_add_item" value="" class="form-control ui-autocomplete-input" id="txtitem" placeholder="Search product by code or name, you can scan barcode too">
                                            </div>
                                        </div>
                                        <div id="div_itemData"></div>

                                        <div id="totaldiv">
                                            <table id="totaltbl" class="table table-condensed totals" style="margin-bottom: 10px;">
                                                <tbody>
                                                    <tr class="info">
                                                        <td width="25%">
                                                            Total Items
                                                        </td>
                                                        <td class="text-right" style="padding-right: 10px;">
                                                            <span id="count">0</span>
                                                        </td>
                                                        <td width="25%">
                                                            Total
                                                        </td>
                                                        <td class="text-right" colspan="2" style="text-align: center;">
                                                            <span id="total">0</span>
                                                        </td>
                                                    </tr>
                                                    
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="well well-sm">
                                        
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                                
                            </div>
                            <input type="submit" name="update" value="Save" class="btn btn-primary" id="btnsave" onclick="btnsave_click();" /> <input type="button" name="update" value="Close" class="btn btn-primary" id="btnclose"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" id="divbind">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">Stock Transfer</h3>
                </div><div style="float: right; padding-right: 14px;padding-bottom: 5px;"><input type="button" name="AddIteam" value="Add" class="btn btn-primary" id="btnaddclick"></br></div>
                         

                        <div id="divSTOCKTRANSFERdata"></div>
        </div>

                
            </div>
        </div>
        <div hidden>
                                <label id="lbl_sno">
                                </label>
                        </div>
    </section>
</asp:content>
