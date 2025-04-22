<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Vpos.aspx.cs" Inherits="Vpos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <title>POS | SimplePOS</title>
    <link rel="shortcut icon" href="">
    <link href="css/styles.css" rel="stylesheet" type="text/css" />
    <script src="css/jQuery-2.1.4.min.js" type="text/javascript"></script>
    <link href="autocomplete/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script type='text/javascript'>
        $(function () {
            var branchid = '<%=Session["BranchID"] %>';
            var UserName = '<%=Session["UserName"] %>';
            var leveltype = '<%=Session["leveltype"] %>';
            var branchid = '<%=Session["BranchID"] %>';
            var leveltype = '<%=Session["leveltype"] %>';

            if (leveltype == "Admin     ") {
                $('#lidefault').css('display', 'block');
                $('#lidashboard').css('display', 'block ');
                $('#lipos').css('display', 'block ');
                $('#lirecipe').css('display', 'block');
                $('#limaster').css('display', 'block ');
                $('#lisales').css('display', 'block');
                $('#litransactions').css('display', 'block');
                $('#ligiftcards').css('display', 'block');
                $('#lireports').css('display', 'block ');
            }
            if (leveltype == "User      ") {
                $('#lidefault').css('display', 'none');
                $('#lidashboard').css('display', 'none ');
                $('#lipos').css('display', 'block ');
                $('#lirecipe').css('display', 'none');
                $('#limaster').css('display', 'none ');
                $('#lisales').css('display', 'block');
                $('#litransactions').css('display', 'block');
                $('#ligiftcards').css('display', 'none');
                $('#lireports').css('display', 'none ');
            }
            if (leveltype == "Manager   ") {
                $('#lidefault').css('display', 'block');
                $('#lidashboard').css('display', 'none');
                $('#lipos').css('display', 'none ');
                $('#lirecipe').css('display', 'none');
                $('#limaster').css('display', 'none ');
                $('#lisales').css('display', 'block');
                $('#litransactions').css('display', 'block');
                $('#ligiftcards').css('display', 'none');
                $('#lireports').css('display', 'block ');
            }
            if (leveltype == "Accounts  ") {

                $('#lidefault').css('display', 'none');
                $('#lidashboard').css('display', 'none');
                $('#lipos').css('display', 'none ');
                $('#lirecipe').css('display', 'none');
                $('#limaster').css('display', 'none ');
                $('#lisales').css('display', 'none');
                $('#litransactions').css('display', 'none');
                $('#ligiftcards').css('display', 'none');
                $('#lireports').css('display', 'block ');

            }
            if (leveltype == "SuperAdmin") {
                $('#lidefault').css('display', 'block');
                $('#lidashboard').css('display', 'block ');
                $('#lipos').css('display', 'block ');
                $('#lirecipe').css('display', 'block');
                $('#limaster').css('display', 'block ');
                $('#lisales').css('display', 'block');
                $('#litransactions').css('display', 'block');
                $('#ligiftcards').css('display', 'block');
                $('#lireports').css('display', 'block ');
            }

            if (leveltype == "Distibutor") {
                $('#lidefault').css('display', 'none');
                $('#lidashboard').css('display', 'none ');
                $('#lipos').css('display', 'block ');
                $('#lirecipe').css('display', 'none');
                $('#limaster').css('display', 'none ');
                $('#lisales').css('display', 'none');
                $('#litransactions').css('display', 'none');
                $('#ligiftcards').css('display', 'none');
                $('#lireports').css('display', 'none ');
                $('#lidistibutor').css('display', 'block ');


            }

            document.getElementById("spnuserrole").innerHTML = leveltype;
            document.getElementById("spnusername").innerHTML = UserName;

            checkregistordetails();
            get_product_details();
            get_subcategory_details();
            fillcustmoerdetails();
            get_denamination_details();
            $("#btnpayment").click(function () {
                document.getElementById("spnbtnval").innerHTML = "Save";
                $("#payModal").modal({ backdrop: "static" })
            })
            $("#btnsuspend").click(function () {
                document.getElementById("spnbtnval").innerHTML = "Hold";
                $("#payModal").modal({ backdrop: "static" })
            })
            $("#btnregdtls").click(function () {
                getregistervalues();
                $("#divregistermodel").modal({ backdrop: "static" })
            })
            $("#btntodaysaledtls").click(function () {
                getregistervalues();
                $("#divtodaysale").modal({ backdrop: "static" })
            })
            $("#btncloseregister").click(function () {
                getregistervalues();
                $("#divcloseregister").modal({ backdrop: "static" })
            })
            $("#btnshartcut").click(function () { $("#divshartcutkeys").modal({ backdrop: "static" }) })
        });
        function barcode() {
            var txtbarcode = document.getElementById('txtitem').value;
            test1();
            //$('#posTable').on('change', '.price', calTotal)
            //    .on('change', '.quantity', calTotal);
            //calTotal()
        }
        $(document).click(function () {
            $('#txtitem').keypress(function (e) {
                var key = e.which;
                if (key == 13)  // the enter key code
                {
                    $('input[name = butAssignProd]').click();
                    return false;
                }
            });

            $('input[name="butAssignProd"]').click(function () {
                test1();
            });
            


            $('#posTable').on('change', '.price', calTotal)
                .on('change', '.quantity', calTotal);
            function calTotal() {
                var $row = $(this).closest('tr');
                price = $row.find('.price').val();
                quantity = $row.find('.quantity').val();
                taxprice = $row.find('.igstval').val();
                var hdntaxprice = $row.find('#hdntaxprice').val();
                var prod_total = price * quantity;
                prod_total = prod_total.toFixed(2);
                var total = parseFloat(prod_total);
                var taxtotal = hdntaxprice * quantity;
                $row.find('#txtTotal').text(parseFloat(total).toFixed(2));
                $row.find('#txttax').text(parseFloat(taxtotal).toFixed(2));
                clstotalval();
            }
        });

       
        function checkregistordetails() {
            var data = { 'op': 'get_registordetails' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {

                        if (msg == "Please Close The Yesterday Registor Details") {
                            alert(msg);
                            window.open("storeclose.aspx", "_self");
                        }
                        if (msg == "Please Open The Registor Details") {
                            alert(msg);
                            window.open("storeopen.aspx", "_self");
                        }
                        if (msg == "ok") {


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

        function get_subcategory_details() {
            var data = { 'op': 'get_subcategory_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillsubcatdetails(msg);
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
        function fillsubcatdetails(msg) {
            var results = '<div id="category-sidebar-menu" style="overflow: hidden; width: 100%; height: 250px;">';
            results += ' <ul class="control-sidebar-menu">';
            results += '<li><a href="#" class="category active" id="0" onclick=agetmethis(this.id); return false;">All</a></li>';
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                var subcatname = msg[i].subcategory;
                var sno = msg[i].sno;
                results += '<li><a href="#" class="category active" id=' + sno + ' onclick=agetmethis(this.id); return false;">' + subcatname + '</a></li>';
            }
            results += '</table></div>';
            $("#divcategory").html(results);
        }
        function agetmethis(clickid) {
            var subcatid = clickid;
            productdetails = [];
            compiledList = [];
            var data = { 'op': 'get_product_details', 'subcatid': subcatid };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        productdetails = msg;
                        BindGrid(msg);
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
                                document.getElementById("spnregcashinhand").innerHTML = salevalue;
                                document.getElementById("spncregcashinhand").innerHTML = salevalue;
                                cashinhand = salevalue;
                            }
                            if (saletype == "cash") {
                                document.getElementById("spnregcashsale").innerHTML = salevalue;
                                document.getElementById("spncregcashsale").innerHTML = salevalue;
                                document.getElementById("spntodaycashsale").innerHTML = salevalue;
                            }
                            if (saletype == "CC") {
                                document.getElementById("spnregccsale").innerHTML = salevalue;
                                document.getElementById("spncregccsale").innerHTML = salevalue;
                                document.getElementById("spntodayccsale").innerHTML = salevalue;
                            }
                            if (saletype == "cheque") {
                                document.getElementById("spnregchequesale").innerHTML = salevalue;
                                document.getElementById("spncregchequesale").innerHTML = salevalue;
                                document.getElementById("spntodaychequesale").innerHTML = salevalue;
                            }
                            if (saletype == "gift_card") {
                                document.getElementById("spnreggiftcardsale").innerHTML = salevalue;
                                document.getElementById("spncreggiftcardsale").innerHTML = salevalue;
                                document.getElementById("spntodaygiftcardsale").innerHTML = salevalue;
                            }
                            if (saletype == "stripe") {
                                document.getElementById("spnregstripesale").innerHTML = salevalue;
                                document.getElementById("spncregstripesale").innerHTML = salevalue;
                                document.getElementById("spntodaystripesale").innerHTML = salevalue;
                            }
                            if (saletype == "other") {
                                document.getElementById("spnregothersale").innerHTML = salevalue;
                                document.getElementById("spncregothersale").innerHTML = salevalue;
                                document.getElementById("spntodayothersale").innerHTML = salevalue;
                            }
                            if (saletype == "Paytm") {
                                document.getElementById("spnpaytmamt").innerHTML = salevalue;
                                document.getElementById("spncpaytmamt").innerHTML = salevalue;
                                document.getElementById("spntodaypaytmamt").innerHTML = salevalue;
                            }
                            if (saletype == "PhonePay") {
                                document.getElementById("spnphonepayamt").innerHTML = salevalue;
                                document.getElementById("spncphonepayamt").innerHTML = salevalue;
                                document.getElementById("spntodayphonepayamt").innerHTML = salevalue;
                            }
                            totalsale += parseFloat(salevalue);
                        }
                        document.getElementById("spnregtotalsale").innerHTML = totalsale;
                        document.getElementById("spncregtotalsale").innerHTML = totalsale;
                        document.getElementById("spntodaytotalsale").innerHTML = totalsale - cashinhand;
                        var expenses = 0;
                        document.getElementById("spnregexpenses").innerHTML = expenses;
                        document.getElementById("spncregexpenses").innerHTML = expenses;
                        document.getElementById("spnregtotalcash").innerHTML = totalsale - expenses;
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

            $('.clstax').each(function (i, obj) {
                var totltax = $(this).html();
                if (totltax == "" || totltax == "0") {
                }
                else {
                    tottaxamount += parseFloat(totltax);
                }
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
            document.getElementById('ts_con').innerHTML = tottaxamount.toFixed(2);
            document.getElementById('total').innerHTML = grandtotal.toFixed(2);
            var totalpayable = grandtotal + tottaxamount;
            document.getElementById('total-payable').innerHTML = Math.round(totalpayable,2);
            document.getElementById('count').innerHTML = rowcount;
            document.getElementById('spnitem_count').innerHTML = rowcount;
            document.getElementById('spntwt').innerHTML = totalpayable.toFixed(2);
            document.getElementById('spntotal_paying').innerHTML = totalpayable.toFixed(2);
            document.getElementById('txtamount').value = totalpayable.toFixed(2);
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
                        BindGrid(msg);
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
        function BindGrid(msg) {
            var results = '';
            for (var i = 0; i < msg.length; i++) {
                results += '<button type="button" data-name="' + msg[i].productname + '" id="' + msg[i].productid + '" value="' + msg[i].productid + '" class="btn btn-both btn-flat product" onclick="getme(this)">';
                results += '<span class="bg-img"><img src="images/13.jpg" alt="' + msg[i].productname + '" style="width: 100px; height: 100px;"></span><span><span class="1">' + msg[i].productname + '</span></span></button>';
            }
            $("#div_ProductData").html(results);
        }
        var itemlist = [];
        var dupliitemlist = [];
        function getme(thisid) {
            var val = $(thisid).val();
            var checkflag = true;
            itemlist = [];
            var rows = $("#posTable tr:gt(0)");
            var txtsno = 0;
            var rowsno = 1;
            var taxtype = 0;
            var perunittax = 0;
            var igst = 0;
            var dis = 0;
            var tax = 0;
            var edtax = 0;
            $(rows).each(function (i, obj) {
                if ($(this).find('#spn_Productname').text() != "") {
                    txtsno = rowsno;
                    productname = $(this).find('#spn_Productname').text();
                    price = $(this).find('#txt_orgprice').text();
                    Quantity = $(this).find('#txt_quantity').val();
                    TotalCost = $(this).find('#txtTotal').text();
                    productid = $(this).find('#hdnproductsno').val();
                    perunittax = $(this).find('#txt_perunittax').val();
                    igst = $(this).find('#txt_igst').val();
                    itemlist.push({ Sno: txtsno, productname: productname, price: price, Quantity: Quantity, TotalCost: TotalCost, productid: productid, perunittax: perunittax, igst: igst });
                    rowsno++;
                }
            });
            var productname = 0;
            var price = 0;
            var Quantity = 1;
            var TotalCost = 0;
            var productid = 0;
            var perunittax = 0;
            var igst = 0;
            var Sno = parseInt(txtsno) + 1;
            if (dupliitemlist.indexOf(val) == -1) {
                for (var i = 0; i < productdetails.length; i++) {
                    if (val == productdetails[i].productid) {
                        productname = productdetails[i].productname;
                        price = productdetails[i].price;
                        productid = productdetails[i].productid;
                        var cgst = productdetails[i].cgst;
                        var sgst = productdetails[i].sgst;
                        igst = productdetails[i].igst;
                        itemlist.push({ Sno: txtsno, productname: productname, price: price, Quantity: Quantity, TotalCost: TotalCost, productid: productid, perunittax: perunittax, igst: igst });
                        dupliitemlist.push(val);
                    }
                }
                if (itemlist.length > 0) {
                    var itemresults = '<table id="posTable" class="table table-striped table-condensed table-hover list-table" style="margin: 0px;" data-height="100"><thead> <tr class="success"><th> Product</th> <th style="width: 15%; text-align: center;"> Price </th><th style="width: 15%; text-align: center;"> Qty</th><th style="width: 20%; text-align: center;">Subtotal </th> <th style="width: 20px;" class="satu"><i class="fa fa-trash-o"></i> </th></tr></thead> ';
                    for (var i = 0; i < itemlist.length; i++) {
                        itemresults += '<tr>';
                        itemresults += '<td style="display:none;"><span class="sname" id="txt_orgprice">' + itemlist[i].price + '</span></td>';
                        itemresults += '<td  class="1" style="display:none;">' + itemlist[i].productname + '</td>';
                        if (i % 2 == 0) {
                            itemresults += '<td  class="btn bg-purple btn-block btn-xs edit"><span class="sname" id="spn_Productname">' + itemlist[i].productname + '</span></td>';
                        }
                        else {
                            itemresults += '<td  class="btn btn-block btn-xs edit btn-warning"><span class="sname" id="spn_Productname">' + itemlist[i].productname + '</span></td>';
                        }
                        var igst = parseFloat(itemlist[i].igst);
                        var itemprice = parseFloat(itemlist[i].price);
                        var divisionval = 100 + igst;
                        var taxprice = (itemprice * igst);
                        taxprice = taxprice / divisionval;


                        var withouttaxrate = (itemprice - taxprice);
                        withouttaxrate = withouttaxrate.toFixed(2);
                        itemresults += '<td  class="text-right" style="width:20%"><span class="text-right sprice" id="sprice_1541067686388">' + withouttaxrate + '</span><input id="txt_perunitrs" name="prices" class="price" type="text" value="' + withouttaxrate + '" style="display:none;"/></td>';
                        itemresults += '<td class="text-right" style="width:20%"><input id="txt_quantity" type="text" class="quantity form-control input-qty kb-pad text-center rquantity" style="width: 52% !important;float: right !important;" onkeyup="qtychage(this);"    value="' + itemlist[i].Quantity + '" name="quantity"/></td>';
                        var it = itemlist[i].Quantity;
                        var subtotal = it * withouttaxrate;
                        subtotal = subtotal.toFixed(2);
                        var taxvalue = it * taxprice;
                        itemresults += '<td  class="text-right" style="width:20%"><span class="clstotal text-right ssubtotal" id="txtTotal">' + subtotal + '</span></td>';
                        itemresults += '<td class="text-center"><span onclick="removerow(this);" style="cursor: pointer;color: red;"><i class="fa fa-trash-o"></i></span></td>';
                        itemresults += '<td class="text-center"><input id="hdnproductsno" type="hidden" value="' + itemlist[i].productid + '"></td>';
                        itemresults += '<td class="text-center"><input id="hdntaxprice" type="hidden" value="' + taxprice + '"></td>';
                        itemresults += '<td  class="text-right" style="display:none;"><span class="clstax text-right ssubtotal" id="txttax">' + taxvalue + '</span><input id="txt_perunittax" name="tax" class="taxval" type="text" value="' + taxvalue + '" style="display:none;"/></td>';
                        itemresults += '<td  class="text-right" style="display:none;"><span class="clsigst text-right ssubtotal" id="txtigst">' + igst + '</span><input id="txt_igst" name="igst" class="igstval" type="text" value="' + igst + '" style="display:none;"/></td>';
                        itemresults += '</tr>';
                    }
                    itemresults += '</table>';
                    $("#div_itemData").html(itemresults);
                    clstotalval();
                }
            }
            else {
                alert("Product Name already added");
                var empt = "";
                $(thisid).val(empt);
                return false;
            }
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
        function test1() {
            var val = document.getElementById('txtitem').value;
            for (var i = 0; i < productdetails.length; i++) {
                if (val == productdetails[i].productname || val == productdetails[i].sku) {
                    val = productdetails[i].productid;
                }
            }
            var checkflag = true;
            itemlist = [];
            var rows = $("#posTable tr:gt(0)");
            var txtsno = 0;
            var rowsno = 1;
            var taxtype = 0;
            var perunittax = 0;
            var igst = 0;
            var dis = 0;
            var tax = 0;
            var edtax = 0;
            $(rows).each(function (i, obj) {
                if ($(this).find('#spn_Productname').text() != "") {
                    txtsno = rowsno;
                    productname = $(this).find('#spn_Productname').text();
                    price = $(this).find('#txt_orgprice').text();
                    Quantity = $(this).find('#txt_quantity').val();
                    TotalCost = $(this).find('#txtTotal').text();
                    productid = $(this).find('#hdnproductsno').val();
                    perunittax = $(this).find('#txt_perunittax').val();
                    igst = $(this).find('#txt_igst').val();
                    itemlist.push({ Sno: txtsno, productname: productname, price: price, Quantity: Quantity, TotalCost: TotalCost, productid: productid, perunittax: perunittax, igst: igst });
                    rowsno++;
                }
            });
            var productname = 0;
            var price = 0;
            var Quantity = 1;
            var TotalCost = 0;
            var productid = 0;
            var perunittax = 0;
            var igst = 0;
            var Sno = parseInt(txtsno) + 1;
            if (dupliitemlist.indexOf(val) == -1) {
                for (var i = 0; i < productdetails.length; i++) {
                    if (val == productdetails[i].productid) {
                        var productname = productdetails[i].productname;
                        var price = productdetails[i].price;
                        var productid = productdetails[i].productid;
                        var cgst = productdetails[i].cgst;
                        var sgst = productdetails[i].sgst;
                        var igst = productdetails[i].igst;
                        itemlist.push({ Sno: Sno, productname: productname, price: price, Quantity: Quantity, TotalCost: TotalCost, productid: productid, perunittax: perunittax, igst: igst });
                        dupliitemlist.push(productid);
                    }
                }
                if (itemlist.length > 0) {
                    var itemresults = '<table id="posTable" class="table table-striped table-condensed table-hover list-table" style="margin: 0px;" data-height="100"><thead> <tr class="success"><th> Product</th> <th style="width: 15%; text-align: center;"> Price </th><th style="width: 15%; text-align: center;"> Qty</th><th style="width: 20%; text-align: center;">Subtotal </th> <th style="width: 20px;" class="satu"><i class="fa fa-trash-o"></i> </th></tr></thead> ';
                    for (var i = 0; i < itemlist.length; i++) {
                        itemresults += '<tr>';
                        itemresults += '<td style="display:none;"><span class="sname" id="txt_orgprice">' + itemlist[i].price + '</span></td>';
                        itemresults += '<td  class="1" style="display:none;">' + itemlist[i].productname + '</td>';
                        if (i % 2 == 0) {
                            itemresults += '<td  class="btn bg-purple btn-block btn-xs edit"><span class="sname" id="spn_Productname">' + itemlist[i].productname + '</span></td>';
                        }
                        else {
                            itemresults += '<td  class="btn btn-block btn-xs edit btn-warning"><span class="sname" id="spn_Productname">' + itemlist[i].productname + '</span></td>';
                        }
                        var itemprice = parseFloat(itemlist[i].price);
                        var igst = parseFloat(itemlist[i].igst);
                        var divisonvalue = 100 + igst;
                        var taxamt = (itemprice * igst) / divisonvalue;
                        var withouttaxprice = itemprice - taxamt;
                        withouttaxprice = withouttaxprice.toFixed(2);
                        itemresults += '<td  class="text-right" style="width:20%"><span class="text-right sprice" id="sprice_1541067686388">' + withouttaxprice + '</span><input id="txt_perunitrs" name="prices" class="price" type="text" value="' + withouttaxprice + '" style="display:none;"/></td>';
                        itemresults += '<td class="text-right" style="width:20%"><input id="txt_quantity" type="text" class="quantity form-control input-qty kb-pad text-center rquantity" style="width: 52% !important;float: right !important;" onkeyup="qtychage(this);" value="' + itemlist[i].Quantity + '" name="quantity"/></td>';
                        var it = itemlist[i].Quantity;
                        var subtotal = it * withouttaxprice;
                        subtotal = subtotal.toFixed(2);
                        var taxvalue = it * taxamt;
                        itemresults += '<td  class="text-right" style="width:20%"><span class="clstotal text-right ssubtotal" id="txtTotal">' + subtotal + '</span></td>';
                        itemresults += '<td class="text-center"><span onclick="removerow(this);" style="cursor: pointer;color: red;"><i class="fa fa-trash-o"></i></span></td>';
                        itemresults += '<td class="text-center"><input id="hdnproductsno" type="hidden" value="' + itemlist[i].productid + '"></td>';
                        itemresults += '<td class="text-right" style="display:none;"><span class="clstax text-right ssubtotal" id="txttax">' + taxvalue + '</span><input id="txt_perunittax" name="tax" class="taxval" type="text" value="' + taxvalue + '" style="display:none;"/></td>';
                        itemresults += '<td class="text-right" style="display:none;"><span class="clsigst text-right" id="txtigst">' + igst + '</span><input id="txt_igst" name="igst" class="taxigst" type="text" value="' + igst + '" style="display:none;"/></td>';
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
            itemlist = []
            var rows = $("#posTable tr:gt(0)");
            $(rows).each(function (i, obj) {
                if ($(this).find('#spn_Productname').text() != "") {
                    txtsno = rowsno;
                    var productname = $(this).find('#spn_Productname').text();
                    var PerUnitRs = $(this).find('#txt_perunitrs').val();
                    var Quantity = $(this).find('#txt_quantity').val();
                    var TotalCost = $(this).find('#txtTotal').text();
                    var Totaltax = $(this).find('#txttax').text();
                    var igst = $(this).find('#txtigst').text();
                    var hdnproductsno = $(this).find('#hdnproductsno').val();
                    itemlist.push({ Sno: txtsno, productname: productname, price: PerUnitRs, Quantity: Quantity, TotalCost: TotalCost, perunittax: Totaltax, igst: igst, productid: hdnproductsno });
                }
            });
            var product_name = $(thisid).parent().parent().children('.1').html();
            var txtsno = 0;
            var rowsno = 1;
            var dummyitem = [];
            var rdummyitem = [];
            dupliitemlist = [];
            for (var i = 0; i < itemlist.length; i++) {
                if (product_name == itemlist[i].productname) {
                }
                else {
                    var productname = itemlist[i].productname;
                    var PerUnitRs = itemlist[i].price;
                    var Quantity = itemlist[i].Quantity;
                    var TotalCost = itemlist[i].TotalCost;
                    var Totaltax = itemlist[i].perunittax;
                    var igst = itemlist[i].igst;
                    var productid = itemlist[i].productid;
                    var sumprice = parseFloat(PerUnitRs) + parseFloat(Totaltax);
                    dummyitem.push({ productname: productname, price: PerUnitRs, Quantity: Quantity, TotalCost: TotalCost, Totaltax: Totaltax, igst: igst, productid: productid, sumprice: sumprice });
                    rdummyitem.push({ Sno: txtsno, productname: productname, price: sumprice, Quantity: Quantity, TotalCost: TotalCost, perunittax: Totaltax, igst: igst, productid: productid });
                    dupliitemlist.push(productid);
                }
            }
            if (dummyitem.length > 0) {
                itemlist = [];
                itemlist = rdummyitem;
                var itemresults = '<table id="posTable" class="table table-striped table-condensed table-hover list-table" style="margin: 0px;" data-height="100"><thead> <tr class="success"><th> Product</th> <th style="width: 15%; text-align: center;"> Price </th><th style="width: 15%; text-align: center;"> Qty</th><th style="width: 20%; text-align: center;">Subtotal </th> <th style="width: 20px;" class="satu"><i class="fa fa-trash-o"></i> </th></tr></thead> ';
                for (var i = 0; i < dummyitem.length; i++) {
                    itemresults += '<tr>';
                    itemresults += '<td  style="display:none;"><span class="sname" id="txt_orgprice">' + dummyitem[i].sumprice + '</span></td>';
                    itemresults += '<td  class="1" style="display:none;">' + dummyitem[i].productname + '</td>';
                    if (i % 2 == 0) {
                        itemresults += '<td  class="btn bg-purple btn-block btn-xs edit"><span class="sname" id="spn_Productname">' + dummyitem[i].productname + '</span></td>';
                    }
                    else {
                        itemresults += '<td  class="btn btn-block btn-xs edit btn-warning"><span class="sname" id="spn_Productname">' + dummyitem[i].productname + '</span></td>';
                    }
                    itemresults += '<td  class="text-right" style="width:20%"><span class="text-right sprice" id="sprice_1541067686388">' + dummyitem[i].price + '</span><input id="txt_perunitrs" name="prices" class="price" type="text" value="' + dummyitem[i].price + '" style="display:none;"/></td>';
                    itemresults += '<td class="text-right" style="width:20%"><input id="txt_quantity" type="text" class="quantity form-control input-qty kb-pad text-center rquantity" style="width: 52% !important;float: right !important;" onkeyup="qtychage(this);"    value="' + dummyitem[i].Quantity + '" name="quantity"/></td>';
                    itemresults += '<td  class="text-right" style="width:20%"><span class="clstotal text-right ssubtotal" id="txtTotal">' + dummyitem[i].TotalCost + '</span></td>';
                    itemresults += '<td class="text-center"><span onclick="removerow(this);"style="cursor: pointer;color: red;"><i class="fa fa-trash-o"></i></span></td>';
                    itemresults += '<td class="text-center" style="display:none;"><span class="clstax text-right ssubtotal" id="txttax">' + dummyitem[i].Totaltax + '</span><input id="txt_perunittax" name="tax" class="taxval" type="text" value="' + dummyitem[i].Totaltax + '" style="display:none;"/></td>';
                    itemresults += '<td class="text-center" style="display:none;"><span class="clsigst text-right " id="txtigst">' + dummyitem[i].igst + '</span><input id="txt_igst" name="igst" class="taxigst" type="text" value="' + dummyitem[i].igst + '" style="display:none;"/></td>';
                    itemresults += '<td class="text-center"><input id="hdnproductsno" type="hidden" value="' + dummyitem[i].productid + '"></td>';
                    itemresults += '</tr>';
                }
                itemresults += '</table>';
                $("#div_itemData").html(itemresults);
                clstotalval();
            }
        }

        function btncustomersaveclick() {
            var cname = document.getElementById("txtcname").value;
            var email = document.getElementById("txtcemail").value;
            var phno = document.getElementById("txtcphone").value;
            var f1 = document.getElementById("txtcf1").value;
            var f2 = document.getElementById("txtcf2").value;
            var btnSave = "Save";
            var data = { 'op': 'save_customer_details', 'cname': cname, 'email': email, 'phno': phno, 'f1': f1, 'f2': f2, 'btnSave': btnSave };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        fillcustmoerdetails();
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
        function fillcustmoerdetails() {
            var data = { 'op': 'get_customer_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillcstmer(msg);
                        $('.modal').modal('hide');
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
        function fillcstmer(msg) {
            var data = document.getElementById('ddlcustomer');
            var length = data.options.length;
            document.getElementById('ddlcustomer').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Walk-in Client";
            opt.value = "4";
            opt.setAttribute("selected", "selected");
            data.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].sectionname != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].sectionname;
                    option.value = msg[i].sno;
                    data.appendChild(option);
                }
            }
        }

        function btnsubmitsale_click() {
            var refnote = document.getElementById('hold_ref').value;
            var custmerid = document.getElementById('ddlcustomer').value;
            var custmorname = document.getElementById('ddlcustomer').selectedIndex;
            var totitems = document.getElementById('spnitem_count').innerHTML;
            var totalpayable = document.getElementById('spntwt').innerHTML;
            var totalpaying = document.getElementById('spntotal_paying').innerHTML;
            var balance = document.getElementById('balance').innerHTML;
            var description = document.getElementById('note').value;
            var modeofpay = document.getElementById('paid_by').value;
            var payingnote = document.getElementById('payment_note').value;
            var discount = document.getElementById('totds_con').innerHTML;
            var ordertax = document.getElementById('ts_con').innerHTML;
            var billtotalvalue = document.getElementById('total-payable').innerHTML;
            var btnvalue = document.getElementById("spnbtnval").innerHTML;
            var fillitems = [];
            $('#posTable> tbody > tr').each(function () {
                var productname = $(this).find('#spn_Productname').text();
                var PerUnitRs = $(this).find('#txt_perunitrs').val();
                var Quantity = $(this).find('#txt_quantity').val();
                var TotalCost = $(this).find('#txtTotal').text();
                var ordertax = $(this).find('#txttax').text();
                var hdnproductsno = $(this).find('#hdnproductsno').val();
                if (hdnproductsno == "" || hdnproductsno == "0") {
                }
                else {
                    fillitems.push({ 'productname': productname, 'PerUnitRs': PerUnitRs, 'Quantity': Quantity, 'TotalCost': TotalCost, 'ordertax': ordertax, 'hdnproductsno': hdnproductsno });
                }
            });
            if (fillitems.length == 0) {
                alert("Please Select Items Names");
                return false;
            }
            var Data = { 'op': 'save_possale', 'custmerid': custmerid, 'custmorname': custmorname, 'refnote': refnote, 'totitems': totitems, 'totalpayable': totalpayable, 'totalpaying': totalpaying, 'balance': balance, 'description': description, 'modeofpay': modeofpay, 'payingnote': payingnote, 'discount': discount, 'btnvalue': btnvalue, 'billtotalvalue': billtotalvalue, 'fillitems': fillitems };
            var s = function (msg) {
                if (msg) {
                    alert(msg);
                    forclearall();
                    if (btnvalue == "Save") {
                        window.open("saleprint.aspx", "_self");
                    }
                    else {
                        window.open("print.aspx", "_blank")
                    }
                }
            }
            var e = function (x, h, e) {
            };
            CallHandlerUsingJson(Data, s, e);
        }
        function forclearall() {
            document.getElementById('hold_ref').value = "";
            document.getElementById('spnitem_count').innerHTML = "0";
            document.getElementById('spntwt').innerHTML = "0";
            document.getElementById('spntotal_paying').innerHTML = "0";
            document.getElementById('balance').innerHTML = "0";
            document.getElementById('payment_note').value = "";
            document.getElementById('totds_con').innerHTML = "0";
            document.getElementById('count').innerHTML = "0";
            document.getElementById('total').innerHTML = "0";
            document.getElementById('total-payable').innerHTML = "0";
            document.getElementById('paid_by').value = "";
            document.getElementById('ddlcustomer').selectedIndex = 0;
            document.getElementById('txtamount').value = "";
            document.getElementById('ts_con').innerHTML = "0";
            itemlist = [];
            dupliitemlist = [];
            var results = "";
            $("#div_itemData").html(results);

        }
        function btnprintorder() {
            window.open("print.aspx", "_self");
        }
        function btnprintbill() {
            window.open("saleprint.aspx", "_self");
        }
        function btnresetclick() {
            document.getElementById('hold_ref').value = "";
            document.getElementById('spnitem_count').innerHTML = "0";
            document.getElementById('spntwt').innerHTML = "0";
            document.getElementById('spntotal_paying').innerHTML = "0";
            document.getElementById('balance').innerHTML = "0";
            document.getElementById('payment_note').value = "";
            document.getElementById('totds_con').innerHTML = "0";
            document.getElementById('count').innerHTML = "0";
            document.getElementById('total').innerHTML = "0";
            document.getElementById('total-payable').innerHTML = "0";
            document.getElementById('paid_by').value = "";
            document.getElementById('ddlcustomer').selectedIndex = 0;
            document.getElementById('txtamount').value = "";
            itemlist = [];
            dupliitemlist = [];
            var results = "";
            $("#div_itemData").html(results);
        }
        function btnholdclick() {
            var refnote = document.getElementById('hold_ref').value;
            var custmerid = document.getElementById('ddlcustomer').value;
            var custmorname = document.getElementById('ddlcustomer').selectedIndex;
            var totitems = document.getElementById('spnitem_count').innerHTML;
            var totalpayable = document.getElementById('spntwt').innerHTML;
            var totalpaying = document.getElementById('spntotal_paying').innerHTML;
            var balance = document.getElementById('balance').innerHTML;
            var description = document.getElementById('note').value;
            var modeofpay = document.getElementById('paid_by').value;
            var payingnote = document.getElementById('payment_note').value;
            var discount = document.getElementById('totds_con').innerHTML;
            var ordertax = document.getElementById('ts_con').innerHTML;
            var billtotalvalue = document.getElementById('total-payable').innerHTML;
            var btnvalue = "Hold";
            var fillitems = [];
            $('#posTable> tbody > tr').each(function () {
                var productname = $(this).find('#spn_Productname').text();
                var PerUnitRs = $(this).find('#txt_perunitrs').val();
                var Quantity = $(this).find('#txt_quantity').val();
                var TotalCost = $(this).find('#txtTotal').text();
                var ordertax = $(this).find('#txttax').text();
                var hdnproductsno = $(this).find('#hdnproductsno').val();
                if (hdnproductsno == "" || hdnproductsno == "0") {
                }
                else {
                    fillitems.push({ 'productname': productname, 'PerUnitRs': PerUnitRs, 'Quantity': Quantity, 'TotalCost': TotalCost, 'ordertax': ordertax, 'hdnproductsno': hdnproductsno });
                }
            });
            if (fillitems.length == 0) {
                alert("Please Select Items Names");
                return false;
            }
            var Data = { 'op': 'save_possale', 'custmerid': custmerid, 'custmorname': custmorname, 'refnote': refnote, 'totitems': totitems, 'totalpayable': totalpayable, 'totalpaying': totalpaying, 'balance': balance, 'description': description, 'modeofpay': modeofpay, 'payingnote': payingnote, 'discount': discount, 'btnvalue': btnvalue, 'billtotalvalue': billtotalvalue, 'fillitems': fillitems };
            var s = function (msg) {
                if (msg) {
                    alert(msg);
                    forclearall();
                    window.open("print.aspx", "_blank")
                }
            }
            var e = function (x, h, e) {
            };
            CallHandlerUsingJson(Data, s, e);
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
                results += '<td><input id="txt_qty" type="text" class="form-control" value="" name="qt"/></td>';
                results += '<td style="display:none" class="7"><input id="hdnsno" type="hidden" value="' + msg[i].sno + '"></td></tr>';
            }
            results += '</table></div>';
            $("#divdinaminationdata").html(results);
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

            var paytm = document.getElementById("spncpaytmamt").innerHTML;
            var phonepay = document.getElementById("spncphonepayamt").innerHTML;


            var submittedcash = document.getElementById("txttotal_cash_submitted").value;
            var submittedslips = document.getElementById("total_cc_slips_submitted").value;
            var submittedchecks = document.getElementById("total_cheques_submitted").value;
            var description = document.getElementById("Textarea1").value;
            var btnreg = "closereg";

            var closeitems = [];
            $('#tbldino> tbody > tr').each(function () {
                var dinamination = $(this).find('#spn_dinamination').text();
                var Quantity = $(this).find('#txt_qty').val();
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

            var data = {
                'op': 'save_parlorerclosingregister', 'cashinhand': cashinhand, 'cashsale': cashsale, 'chequesale': chequesale, 'giftcardsale': giftcardsale, 'ccsale': ccsale,
                'stripesale': stripesale, 'othersale': othersale, 'totalsale': totalsale, 'expenses': expenses, 'totalcash': totalcash, 'submittedcash': submittedcash, 'submittedslips': submittedslips,
                'submittedchecks': submittedchecks, 'description': description, 'btnreg': btnreg, 'paytm': paytm, 'phonepay': phonepay, 'closeitems': closeitems
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
            CallHandlerUsingJson(data, s, e);
        }

        function btnDiscountclick() {
            var discount = document.getElementById("txtdiscount").value;
            var totalpayable = document.getElementById("total-payable").innerHTML;
            var discountamt = (parseFloat(totalpayable) * parseFloat(discount)) / 100;
            var totalval = (parseFloat(totalpayable) - parseFloat(discountamt));
            document.getElementById("total-payable").innerHTML = Math.round(totalval,2);
            document.getElementById("totds_con").innerHTML = discount;

            document.getElementById("spntwt").innerHTML = totalval.toFixed(2);
            document.getElementById("spntotal_paying").innerHTML = totalval.toFixed(2);
            document.getElementById("txtamount").value = totalval.toFixed(2);

        }

        function btnclickcheck() {
            test1();
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
<body class="skin-green sidebar-collapse sidebar-mini pos">
    <div class="wrapper rtl rtl-inv">
        <header class="main-header">
            <a href="#" class="logo">
                <span class="logo-mini">POS</span>
                <span class="logo-lg">Simple<b>POS</b></span>
                            </a>
            <nav class="navbar navbar-static-top" role="navigation">
                
                    <div class="navbar-custom-menu">
                        <ul class="nav navbar-nav">
                            <li><a href="#" class="clock">30th October 2018 01:08 PM</a></li>
                            <li><a href="Default.aspx"><i class="fa fa-dashboard"></i></a></li>
                                                        <li style="display:none;"><a href=""><i class="fa fa-cogs"></i></a></li>
                                                                                    <li style="display:none;"><a href="" target="_blank"><i class="fa fa-desktop"></i></a></li>
                                                        <li class="hidden-xs hidden-sm" style="display:none;"><a href="" id="btnshartcut" data-toggle="modal" data-target="#myModal"><i class="fa fa-key"></i></a></li>
                                                        <li><a href="" id="btnregdtls" data-toggle="modal" data-target="#myModal">Register Details</a></li>
                                                        <li><a href="" id="btntodaysaledtls" data-toggle="modal" data-target="#myModal">Today's Sale</a></li>
                                                        <li><a href="" id="btncloseregister" data-toggle="modal" data-target="#myModal">Close Register</a></li>
                                                        <li class="dropdown user user-menu">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <img src="images/male.png" class="user-image" alt="Avatar">
                                    <span id="spnusername"></span>
                                </a>
                                <ul class="dropdown-menu">
                                    <li class="user-header">
                                        <img src="images/male.png" class="img-circle" alt="Avatar">
                                        <p>
                                            <span id="spnuserrole"></span>                                           <%-- <small>Member since Thu 25 Jun 2015 11:59 AM</small>--%>
                                        </p>
                                    </li>
                                    <li class="user-footer">
                                        <div class="pull-left">
                                            <a href="#" class="btn btn-default btn-flat">Profile</a>
                                        </div>
                                        <div class="pull-right">
                                            <a href="login.aspx" class="btn btn-default btn-flat sign_out">Sign Out</a>
                                        </div>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a href="#" data-toggle="control-sidebar" class="sidebar-icon"><i class="fa fa-folder sidebar-icon"></i></a>
                            </li>
                        </ul>
                    </div>
                </nav>
            </header>
        <aside class="main-sidebar">
                <section class="sidebar" style="height: auto;">
                    <ul class="sidebar-menu">
                <!-- <li class="header">Main Navigation</li> --> 

                <li class="mm_welcome active" id="lidefault"><a href="Default.aspx"><i class="fa fa-dashboard"></i> <span>Dashboard</span></a></li>
                                <li class="mm_pos" id="lidashboard"><a href="Dashboard.aspx"><i class="fa fa-th"></i> <span>ChartDash Board</span></a></li>
                                <li class="mm_pos" id="lipos"><a href="vpos.aspx"><i class="fa fa-th"></i> <span>POS</span></a></li>
                                <li class="mm_pos" id="lirecipe"><a href="vpos.aspx"><i class="fa fa-th"></i> <span>Recipe Management</span></a></li>
                                <li class="treeview mm_products" id="limaster">
                    <a href="#">
                        <i class="fa fa-barcode"></i>
                        <span>Masters</span>
                        <i class="fa fa-angle-left pull-right"></i>
                    </a>
                    <ul class="treeview-menu">
                        <li id="catmst"><a href="minimasters.aspx"><i class="fa fa-circle-o"></i>Mini Masters</a></li>
                        <li id="cmpmst"><a href="cmpmasters.aspx"><i class="fa fa-circle-o"></i>Company Master</a></li>
                        <li id="parmst"><a href="Branchmaster.aspx"><i class="fa fa-circle-o"></i>Parlor Master</a></li>
                        <li id="itemmst"><a href="itemmaster.aspx"><i class="fa fa-circle-o"></i>Item Master</a></li>
                        <li id="supmst"><a href="suppliermaster.aspx"><i class="fa fa-circle-o"></i>Supplier Master</a></li>
                        <li id="empmst"><a href="empmaster.aspx"><i class="fa fa-circle-o"></i>Employe Master</a></li>
                    </ul>
                </li>
                <li class="treeview mm_sales" id="lidistibutor"> 
                    <a href="#">
                        <i class="fa fa-shopping-cart"></i>
                        <span>Distibutor</span>
                        <i class="fa fa-angle-left pull-right"></i>
                    </a>
                    <ul class="treeview-menu">
                        <li id="Li10"><a href="subdistibutarmaster.aspx"><i class="fa fa-circle-o"></i>Sub Distibutor Master</a></li>
                        <li id="Li9"><a href="Distibuterindent.aspx"><i class="fa fa-circle-o"></i> Indent</a></li>
                        <li id="Li11"><a href="distibutorrate.aspx"><i class="fa fa-circle-o"></i> Rate Management</a></li>
                        <li id="Li12"><a href="distibutorsale.aspx"><i class="fa fa-circle-o"></i>Sale</a></li>
                        <li id="Li13"><a href="invoicereport.aspx"><i class="fa fa-circle-o"></i> Invoice Report</a></li>
                    </ul>
                </li>
                  <li class="treeview mm_sales" id="lisales"> 
                    <a href="#">
                        <i class="fa fa-shopping-cart"></i>
                        <span>Sales</span>
                        <i class="fa fa-angle-left pull-right"></i>
                    </a>
                    <ul class="treeview-menu">
                        <li id="sales_index"><a href="sales.aspx"><i class="fa fa-circle-o"></i> List Of Sales</a></li>
                        <li id="sales_opened"><a href="opendbills.aspx"><i class="fa fa-circle-o"></i> List Of Opened Bills</a></li>
                    </ul>
                </li>
                <li class="treeview mm_purchases" id="litransactions"> 
                    <a href="#">
                        <i class="fa fa-plus"></i>
                        <span>Transactions</span>
                        <i class="fa fa-angle-left pull-right"></i>
                    </a>
                    <ul class="treeview-menu">
                        <li id="Li1"><a href="inward.aspx"><i class="fa fa-circle-o"></i> Inward</a></li>
                        <li id="purchases_add"><a href="stocktransfer.aspx"><i class="fa fa-circle-o"></i> Stock Transfor</a></li>
                        <li id="purchases_add_expense"><a href="expences.aspx"><i class="fa fa-circle-o"></i>Add Expenses</a></li>
                        <li id="storereturn"><a href="storereturn.aspx"><i class="fa fa-circle-o"></i> Store Return</a></li>
                    </ul>
                </li>



                <li class="treeview mm_gift_cards" id="ligiftcards"> 
                    <a href="#">
                        <i class="fa fa-credit-card"></i>
                        <span>Gift Card</span>
                        <i class="fa fa-angle-left pull-right"></i>
                    </a>
                    <ul class="treeview-menu">
                        <li id="gift_cards_index"><a href="#"><i class="fa fa-circle-o"></i> List Gift Cards</a></li>
                        <li id="gift_cards_add"><a href="#"><i class="fa fa-circle-o"></i> Add Gift Card</a></li>
                    </ul>
                </li>
                
                <li class="treeview mm_reports" id="lireports">
                    <a href="#">
                        <i class="fa fa-bar-chart-o"></i>
                        <span>Reports</span>
                        <i class="fa fa-angle-left pull-right"></i>
                    </a>
                    <ul class="treeview-menu">
                        <li id="reports_daily_sales"><a href="#"><i class="fa fa-circle-o"></i> Daily Sales</a></li>
                        <li id="reports_monthly_sales"><a href="#"><i class="fa fa-circle-o"></i> Branch Wise Sales</a></li>
                        <li id="reports_index"><a href="#"><i class="fa fa-circle-o"></i> Parlor Wise Sales Report</a></li>
                        <li class="divider"></li>
                        <li id="reports_payments"><a href="#"><i class="fa fa-circle-o"></i> Parlor Wise Sales Comparision</a></li>
                        <li class="divider"></li>
                        <li id="reports_registers"><a href="#"><i class="fa fa-circle-o"></i> Supplier Wise Purchase Report</a></li>
                        <li class="divider"></li>
                        <li id="reports_top_products"><a href="#"><i class="fa fa-circle-o"></i>Item Wise Sale Rpt</a></li>
                        <li id="Li2"><a href="#"><i class="fa fa-circle-o"></i> Products Report</a></li>
                        <li id="reports_products"><a href="#"><i class="fa fa-circle-o"></i> Pening Orders Report</a></li>
                    </ul>
                </li>
                            </ul>
                </section>
            </aside>
        <div class="content-wrapper" style="min-height: 440px;">
            <div class="col-lg-12 alerts" style="display: none;">
            </div>
            <table style="width: 100%;" class="layout-table">
                <tbody>
                    <tr>
                        <td style="width: 460px;">
                            <div id="pos">
                                <form action="https://#/pos" id="pos-sale-form" method="post" accept-charset="utf-8">
                                <input type="hidden" name="spos_token" value="0dbeb4034dd067d5db67226fc01f3361">
                                <div class="well well-sm" id="leftdiv">
                                    <div id="lefttop" style="margin-bottom: 5px;">
                                        <div class="form-group" style="margin-bottom: 5px;">
                                            <div class="input-group">
                                                <select name="customer_id" id="ddlcustomer" data-placeholder="Select Customer" class="form-control"
                                                    style="width: 90%; position: absolute;">
                                                </select>
                                                <div class="input-group-addon no-print" style="padding: 2px 5px;">
                                                    <a href="#" id="add-customer" class="external" data-toggle="modal" data-target="#myModal">
                                                        <i class="fa fa-2x fa-plus-circle" id="addIcon"></i></a>
                                                </div>
                                            </div>
                                            <div style="clear: both;">
                                            </div>
                                        </div>
                                        <div class="form-group" style="margin-bottom: 5px;">
                                            <input type="text" name="hold_ref" value="" id="hold_ref" class="form-control kb-text"
                                                placeholder="Reference Note">
                                        </div>
                                        <div class="form-group" style="margin-bottom: 5px;">
                                            <input type="text" name="code" id="txtitem" onchange="barcode();" class="form-control ui-autocomplete-input"
                                                placeholder="Search product by code or name, you can scan barcode too">

                                                <input type="text" name="butAssignProd" placeholder="click here" style="display:none;">
                                        </div>
                                    </div>
                                    <div id="printhead" class="print">
                                        <p>
                                            Date: 30th October 2018</p>
                                    </div>
                                    <div id="print" class="fixed-table-container">
                                        <div class="slimScrollDiv" style="position: relative; overflow: hidden; width: auto;
                                            height: 250px;">
                                            <div id="list-table-div" style="overflow: auto; width: auto; height: 0px;">
                                                <div class="fixed-table-header">
                                                    <table class="table table-striped table-condensed table-hover list-table" style="margin: 0;">
                                                        <thead>
                                                            <tr class="success">
                                                                <th>
                                                                    Product
                                                                </th>
                                                                <th style="width: 30%; text-align: center;">
                                                                    Price
                                                                </th>
                                                                <th style="width: 15%; text-align: center;">
                                                                    Qty
                                                                </th>
                                                                <th style="width: 20%; text-align: center;">
                                                                    Subtotal
                                                                </th>
                                                                <th style="width: 20px;" class="satu">
                                                                    <i class="fa fa-trash-o"></i>
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                    </table>
                                                </div>
                                                <div id="div_itemData">
                                                </div>
                                            </div>
                                            <div class="slimScrollBar" style="background: rgb(0, 0, 0); width: 7px; position: absolute;
                                                top: 0px; opacity: 0.4; display: none; border-radius: 7px; z-index: 99; right: 1px;
                                                height: 267px;">
                                            </div>
                                            <div class="slimScrollRail" style="width: 7px; height: 100%; position: absolute;
                                                top: 0px; display: none; border-radius: 7px; background: rgb(51, 51, 51); opacity: 0.2;
                                                z-index: 90; right: 1px;">
                                            </div>
                                        </div>
                                        <div style="clear: both;">
                                        </div>
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
                                                        <td class="text-right" colspan="2">
                                                            <span id="total">0</span>
                                                        </td>
                                                    </tr>
                                                    <tr class="info">
                                                        <td width="25%">
                                                            <a href="#" id="add_discount" style="font-weight:bold; color:#333;">Discount</a>
                                                        </td>
                                                        <td class="text-right" style="padding-right: 10px;">
                                                            <span id="totds_con">0</span>
                                                        </td>
                                                        <td width="25%">
                                                            <a href="#" id="add_tax" style="font-weight:bold; color:#333;">Order Tax</a>
                                                        </td>
                                                        <td class="text-right">
                                                            <span id="ts_con">0</span>
                                                        </td>
                                                    </tr>
                                                    <tr class="success">
                                                        <td colspan="2" style="font-weight: bold;">
                                                            Total Payable <a role="button" data-toggle="modal" data-target="#noteModal"><i class="fa fa-comment">
                                                            </i></a>
                                                        </td>
                                                        <td class="text-right" colspan="2" style="font-weight: bold;">
                                                            <span id="total-payable">0</span>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div id="botbuttons" class="col-xs-12 text-center">
                                        <div class="row">
                                            <div class="col-xs-4" style="padding: 0;">
                                                <div class="btn-group-vertical btn-block">
                                                    <button type="button" class="btn btn-warning btn-block btn-flat" id="btnsuspend">
                                                        Hold</button>
                                                    <button type="button" class="btn btn-danger btn-block btn-flat" id="btnreset" onclick="btnresetclick();">
                                                        Cancel</button>
                                                </div>
                                            </div>
                                            <div class="col-xs-4" style="padding: 0 5px;">
                                                <div class="btn-group-vertical btn-block">
                                                    <button type="button" class="btn bg-purple btn-block btn-flat" id="btnprint_order"
                                                        onclick="btnprintorder();">
                                                        Print Order</button>
                                                    <button type="button" class="btn bg-navy btn-block btn-flat" id="btnprint_bill" onclick="btnprintbill();">
                                                        Print Bill</button>
                                                </div>
                                            </div>
                                            <div class="col-xs-4" style="padding: 0;">
                                                <button type="button" class="btn btn-success btn-block btn-flat" id="btnpayment"
                                                    style="height: 67px;">
                                                    Payment</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                    <span id="hidesuspend"></span>
                                    <input type="hidden" name="spos_note" value="" id="spos_note">
                                    <div id="payment-con">
                                        <input type="hidden" name="amount" id="amount_val" value="">
                                        <input type="hidden" name="balance_amount" id="balance_val" value="">
                                        <input type="hidden" name="paid_by" id="paid_by_val" value="cash">
                                        <input type="hidden" name="cc_no" id="cc_no_val" value="">
                                        <input type="hidden" name="paying_gift_card_no" id="paying_gift_card_no_val" value="">
                                        <input type="hidden" name="cc_holder" id="cc_holder_val" value="">
                                        <input type="hidden" name="cheque_no" id="cheque_no_val" value="">
                                        <input type="hidden" name="cc_month" id="cc_month_val" value="">
                                        <input type="hidden" name="cc_year" id="cc_year_val" value="">
                                        <input type="hidden" name="cc_type" id="cc_type_val" value="">
                                        <input type="hidden" name="cc_cvv2" id="cc_cvv2_val" value="">
                                        <input type="hidden" name="balance" id="balance_val" value="">
                                        <input type="hidden" name="payment_note" id="payment_note_val" value="">
                                    </div>
                                    <input type="hidden" name="customer" id="customer" value="1">
                                    <input type="hidden" name="order_tax" id="tax_val" value="5%">
                                    <input type="hidden" name="order_discount" id="discount_val" value="0">
                                    <input type="hidden" name="count" id="total_item" value="">
                                    <input type="hidden" name="did" id="is_delete" value="0">
                                    <input type="hidden" name="eid" id="is_delete" value="0">
                                    <input type="hidden" name="total_items" id="total_items" value="0">
                                    <input type="hidden" name="total_quantity" id="total_quantity" value="0">
                                    <input type="submit" id="submit" value="Submit Sale" style="display: none;">
                                </div>
                                </form>
                            </div>
                        </td>
                        <td>
                            <div class="contents" id="right-col" style="height: 184px;">
                                <div id="item-list">
                                    <div class="slimScrollDiv" style="position: relative; overflow: hidden; width: auto;
                                        height: 250px;">
                                        <div class="items" style="overflow:scroll; width: auto; height: 400px;">
                                            <div id="div_ProductData">
                                            </div>
                                        </div>
                                        <div class="slimScrollBar" style="background: rgb(0, 0, 0); width: 7px; position: absolute;
                                            top: 0px; opacity: 0.4; display: none; border-radius: 7px; z-index: 99; right: 1px;
                                            height: 537px;">
                                        </div>
                                        <div class="slimScrollRail" style="width: 7px; height: 100%; position: absolute;
                                            top: 0px; display: none; border-radius: 7px; background: rgb(51, 51, 51); opacity: 0.2;
                                            z-index: 90; right: 1px;">
                                        </div>
                                    </div>
                                </div>
                                <div class="product-nav">
                                    <div class="btn-group btn-group-justified">
                                        <div class="btn-group">
                                            <button style="z-index: 10002;" class="btn btn-warning pos-tip btn-flat" type="button"
                                                id="previous" disabled="disabled">
                                                <i class="fa fa-chevron-left"></i>
                                            </button>
                                        </div>
                                        <div class="btn-group" style="display:none;">
                                            <button style="z-index: 10003;" class="btn btn-success pos-tip btn-flat" type="button"
                                                id="sellGiftCard">
                                                <i class="fa fa-credit-card" id="addIcon"></i>Sell Gift Card</button>
                                        </div>
                                        <div class="btn-group">
                                            <button style="z-index: 10004;" class="btn btn-warning pos-tip btn-flat" type="button"
                                                id="next" disabled="disabled">
                                                <i class="fa fa-chevron-right"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <aside class="control-sidebar control-sidebar-dark" id="categories-list">
            <div class="tab-content sb">
                <div class="tab-pane active sb" id="control-sidebar-home-tab">
                    <div id="filter-categories-con">
                        <input type="text" autocomplete="off" data-list=".control-sidebar-menu" name="filter-categories" id="filter-categories" class="form-control sb col-xs-12 kb-text" placeholder="Type to filter categories" style="margin-bottom: 20px;">
                    </div>
                    <div class="clearfix sb"></div>
                    <div class="slimScrollDiv" style="position: relative; overflow: hidden; width: 100%; height: 250px;">
                    
                  <div id="divcategory"></div>
                <div class="slimScrollBar" style="background: rgb(0, 0, 0); width: 7px; position: absolute; top: 0px; opacity: 0.4; display: none; border-radius: 7px; z-index: 99; right: 1px; height: 55px;"></div><div class="slimScrollRail" style="width: 7px; height: 100%; position: absolute; top: 0px; display: none; border-radius: 7px; background: rgb(51, 51, 51); opacity: 0.2; z-index: 90; right: 1px;"></div></div>
            </div>
        </div>
    </aside>
    <div class="control-sidebar-bg sb" style="position: fixed; height: auto;">
    </div>
    <div id="order_tbl" style="display: none;">
        <span id="order_span"></span>
        <table id="order-table" class="prT table table-striped table-condensed" style="width: 100%;
            margin-bottom: 0;">
        </table>
    </div>
    <div id="bill_tbl" style="display: none;">
        <span id="bill_span"></span>
        <table id="bill-table" width="100%" class="prT table table-striped table-condensed"
            style="width: 100%; margin-bottom: 0;">
        </table>
        <table id="bill-total-table" width="100%" class="prT table table-striped table-condensed"
            style="width: 100%; margin-bottom: 0;">
        </table>
    </div>
    <div style="width: 500px; background: #FFF; display: block">
        <div id="order-data" style="display: none;" class="text-center">
            <h1>
                SimplePOS</h1>
            <h2>
                Order</h2>
            <div id="preo" class="text-left">
            </div>
        </div>
        <div id="bill-data" style="display: none;" class="text-center">
            <h1>
                SimplePOS</h1>
            <h2>
                Bill</h2>
            <div id="preb" class="text-left">
            </div>
        </div>
    </div>
    <div id="ajaxCall">
        <i class="fa fa-spinner fa-pulse"></i>
    </div>
    <div class="modal" data-easein="flipYIn" id="gcModal" tabindex="-1" role="dialog"
        aria-labelledby="mModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        Sell Gift Card</h4>
                </div>
                <div class="modal-body">
                    <p>
                        Please fill in the information below</p>
                    <div class="alert alert-danger gcerror-con" style="display: none;">
                        <button data-dismiss="alert" class="close" type="button">
                            ×</button>
                        <span id="gcerror"></span>
                    </div>
                    <div class="form-group">
                        <label for="gccard_no">
                            Card No</label>
                        *
                        <div class="input-group">
                            <input type="text" name="gccard_no" value="" class="form-control" id="gccard_no">
                            <div class="input-group-addon" style="padding-left: 10px; padding-right: 10px;">
                                <a href="#" id="genNo"><i class="fa fa-cogs"></i></a>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="gcname" value="Gift Card" id="gcname">
                    <div class="form-group">
                        <label for="gcvalue">
                            Value</label>
                        *
                        <input type="text" name="gcvalue" value="" class="form-control" id="gcvalue">
                    </div>
                    <div class="form-group">
                        <label for="gcprice">
                            Price</label>
                        *
                        <input type="text" name="gcprice" value="" class="form-control" id="gcprice">
                    </div>
                    <div class="form-group">
                        <label for="gcexpiry">
                            Expiry Date</label>
                        <input type="text" name="gcexpiry" value="" class="form-control" id="gcexpiry">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">
                        Close</button>
                    <button type="button" id="addGiftCard" class="btn btn-primary">
                        Sell Gift Card</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" data-easein="flipYIn" id="dsModal" tabindex="-1" role="dialog"
        aria-labelledby="dsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <h4 class="modal-title" id="dsModalLabel">
                        Discount (5 or 5%)</h4>
                </div>
                <div class="modal-body">
                    <input type="text" class="form-control" id="txtdiscount" value="">
                    <label class="checkbox" for="apply_to_order">
                        <div class="iradio_square-blue checked" aria-checked="false" aria-disabled="false"
                            style="position: relative;">
                            <input type="radio" name="apply_to" value="order" id="apply_to_order" checked="checked"
                                style="position: absolute; top: -20%; left: -20%; display: block; width: 140%;
                                height: 140%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px;
                                opacity: 0;">
                            <ins class="iCheck-helper" style="position: absolute; top: -20%; left: -20%; display: block;
                                width: 140%; height: 140%; margin: 0px; padding: 0px; background: rgb(255, 255, 255);
                                border: 0px; opacity: 0;"></ins>
                        </div>
                        Apply to order total
                    </label>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm pull-left" data-dismiss="modal">
                        Close</button>
                    <button type="button" id="btnDiscount" class="btn btn-primary btn-sm" onclick="btnDiscountclick();">
                        Update</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" data-easein="flipYIn" id="tsModal" tabindex="-1" role="dialog"
        aria-labelledby="tsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <h4 class="modal-title" id="tsModalLabel">
                        Tax (5 or 5%)</h4>
                </div>
                <div class="modal-body">
                    <input type="text" class="form-control input-sm kb-pad" id="get_ts" onclick="this.select();"
                        value="">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm pull-left" data-dismiss="modal">
                        Close</button>
                    <button type="button" id="updateTax" class="btn btn-primary btn-sm">
                        Update</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" data-easein="flipYIn" id="noteModal" tabindex="-1" role="dialog"
        aria-labelledby="noteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <h4 class="modal-title" id="noteModalLabel">
                        Note</h4>
                </div>
                <div class="modal-body">
                    <textarea name="snote" id="snote" class="pa form-control kb-text"></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm pull-left" data-dismiss="modal">
                        Close</button>
                    <button type="button" id="update-note" class="btn btn-primary btn-sm">
                        Update</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" data-easein="flipYIn" id="proModal" tabindex="-1" role="dialog"
        aria-labelledby="proModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header modal-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <h4 class="modal-title" id="proModalLabel">
                        Payment
                    </h4>
                </div>
                <div class="modal-body">
                    <table class="table table-bordered table-striped">
                        <tbody>
                            <tr>
                                <th style="width: 25%;">
                                    Net Price
                                </th>
                                <th style="width: 25%;">
                                    <span id="net_price"></span>
                                </th>
                                <th style="width: 25%;">
                                    Product Tax
                                </th>
                                <th style="width: 25%;">
                                    <span id="pro_tax"></span><span id="pro_tax_method"></span>
                                </th>
                            </tr>
                        </tbody>
                    </table>
                    <input type="hidden" id="row_id">
                    <input type="hidden" id="item_id">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for="nPrice">
                                    Unit Price</label>
                                <input type="text" class="form-control input-sm kb-pad" id="nPrice" onclick="this.select();"
                                    placeholder="New Price">
                            </div>
                            <div class="form-group">
                                <label for="nDiscount">
                                    Discount</label>
                                <input type="text" class="form-control input-sm kb-pad" id="nDiscount" onclick="this.select();"
                                    placeholder="Discount">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for="nQuantity">
                                    Quantity</label>
                                <input type="text" class="form-control input-sm kb-pad" id="nQuantity" onclick="this.select();"
                                    placeholder="Current Quantity">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label for="nComment">
                                    Comment</label>
                                <textarea class="form-control kb-text" id="nComment"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">
                        Close</button>
                    <button class="btn btn-success" id="editItem">
                        Update</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" data-easein="flipYIn" id="susModal" tabindex="-1" role="dialog"
        aria-labelledby="susModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <h4 class="modal-title" id="susModalLabel">
                        Suspend Sale</h4>
                </div>
                <div class="modal-body">
                    <p>
                        Type Reference Note</p>
                    <div class="form-group">
                        <label for="reference_note">
                            Reference Note</label>
                        <input type="text" name="reference_note" value="" class="form-control kb-text" id="reference_note">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">
                        Close
                    </button>
                    <button type="button" id="suspend_sale" class="btn btn-primary">
                        Submit</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" data-easein="flipYIn" id="saleModal" tabindex="-1" role="dialog"
        aria-labelledby="saleModalLabel" aria-hidden="true">
    </div>
    <div class="modal" data-easein="flipYIn" id="opModal" tabindex="-1" role="dialog"
        aria-labelledby="opModalLabel" aria-hidden="true">
    </div>
    <div class="modal" data-easein="flipYIn" id="payModal" tabindex="-1" role="dialog"
        aria-labelledby="payModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-success">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <h4 class="modal-title" id="payModalLabel">
                        Payment
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="font16">
                                <table class="table table-bordered table-condensed" style="margin-bottom: 0;">
                                    <tbody>
                                        <tr>
                                            <td width="25%" style="border-right-color: #FFF !important;">
                                                Total Items
                                            </td>
                                            <td width="25%" class="text-right">
                                                <span id="spnitem_count">0.00</span>
                                            </td>
                                            <td width="25%" style="border-right-color: #FFF !important;">
                                                Total Payable
                                            </td>
                                            <td width="25%" class="text-right">
                                                <span id="spntwt">0.00</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="border-right-color: #FFF !important;">
                                                Total Paying
                                            </td>
                                            <td class="text-right">
                                                <span id="spntotal_paying">0.00</span>
                                            </td>
                                            <td style="border-right-color: #FFF !important;">
                                                Balance
                                            </td>
                                            <td class="text-right">
                                                <span id="balance">0.00</span>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="clearfix">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="form-group">
                                        <label for="note">
                                            Note</label>
                                        <textarea name="note" id="note" class="pa form-control kb-text"></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-6">
                                    <div class="form-group">
                                        <label for="amount">
                                            Amount</label>
                                        <input name="amount" type="text" id="txtamount" onchange="amountchange();" class="pa form-control kb-pad amount">
                                    </div>
                                </div>
                                <div class="col-xs-6">
                                    <div class="form-group">
                                        <label for="paid_by">
                                            Paying by</label>
                                        <select id="paid_by" class="form-control"
                                            style="width: 100%;" tabindex="-1" aria-hidden="true">
                                            <option value="cash" selected>Cash</option>
                                            <option value="Credit">Credit </option>
                                            <option value="Paytm">Paytm</option>
                                            <option value="Phonepay">Phone pay</option>
                                            <option value="CC">Credit Card</option>
                                            <option value="cheque">Cheque</option>
                                            <option value="gift card">Gift Card</option>
                                            <option value="stripe">Stripe</option>
                                            <option value="Free">Free</option>
                                            <option value="other">Other</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="form-group gc" style="display: none;">
                                        <label for="gift_card_no">
                                            Gift Card No</label>
                                        <input type="text" id="gift_card_no" class="pa form-control kb-pad gift_card_no gift_card_input">
                                        <div id="gc_details">
                                        </div>
                                    </div>
                                    <div class="pcc" style="display: none;">
                                        <div class="form-group">
                                            <input type="text" id="swipe" class="form-control swipe swipe_input" placeholder="Swipe card here then write security code manually">
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <input type="text" id="pcc_no" class="form-control kb-pad" placeholder="Credit Card No">
                                                </div>
                                            </div>
                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <input type="text" id="pcc_holder" class="form-control kb-text" placeholder="Holder Name">
                                                </div>
                                            </div>
                                            <div class="col-xs-3">
                                                <div class="form-group">
                                                    <select id="pcc_type" class="form-control pcc_type select2 select2-hidden-accessible"
                                                        placeholder="Card Type" tabindex="-1" aria-hidden="true">
                                                        <option value="Visa">Visa</option>
                                                        <option value="MasterCard">MasterCard</option>
                                                        <option value="Amex">Amex</option>
                                                        <option value="Discover">Discover</option>
                                                    </select><span class="select2 select2-container select2-container--default" dir="ltr"
                                                        style="width: 100px;"><span class="selection"><span class="select2-selection select2-selection--single"
                                                            role="combobox" aria-autocomplete="list" aria-haspopup="true" aria-expanded="false"
                                                            tabindex="0" aria-labelledby="select2-pcc_type-container"><span class="select2-selection__rendered"
                                                                id="select2-pcc_type-container" title="Visa">Visa</span><span class="select2-selection__arrow"
                                                                    role="presentation"><b role="presentation"></b></span></span></span><span class="dropdown-wrapper"
                                                                        aria-hidden="true"></span></span>
                                                </div>
                                            </div>
                                            <div class="col-xs-3">
                                                <div class="form-group">
                                                    <input type="text" id="pcc_month" class="form-control kb-pad" placeholder="Month">
                                                </div>
                                            </div>
                                            <div class="col-xs-3">
                                                <div class="form-group">
                                                    <input type="text" id="pcc_year" class="form-control kb-pad" placeholder="Year">
                                                </div>
                                            </div>
                                            <div class="col-xs-3">
                                                <div class="form-group">
                                                    <input type="text" id="pcc_cvv2" class="form-control kb-pad" placeholder="CVV2">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="pcheque" style="display: none;">
                                        <div class="form-group">
                                            <label for="cheque_no">
                                                Cheque No</label>
                                            <input type="text" id="cheque_no" class="form-control cheque_no kb-text">
                                        </div>
                                    </div>
                                    <div class="pcash">
                                        <div class="form-group">
                                            <label for="payment_note">
                                                Payment Note</label>
                                            <input type="text" id="payment_note" class="form-control payment_note kb-text">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-3 text-center" style="display:none;">
                            <!-- <span style="font-size: 1.2em; font-weight: bold;">Quick Cash</span> -->
                            <div class="btn-group btn-group-vertical" style="width: 100%;">
                                <button type="button" class="btn btn-info btn-block quick-cash" id="quick-payable">
                                    0.00
                                </button>
                                <button type="button" class="btn btn-block btn-warning quick-cash">
                                    10</button>
                                <button type="button" class="btn btn-block btn-warning quick-cash">
                                    20</button>
                                <button type="button" class="btn btn-block btn-warning quick-cash">
                                    50</button>
                                <button type="button" class="btn btn-block btn-warning quick-cash">
                                    100</button>
                                <button type="button" class="btn btn-block btn-warning quick-cash">
                                    500</button>
                                <button type="button" class="btn btn-block btn-danger" id="clear-cash-notes">
                                    Clear</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">
                        Close
                    </button>
                    <button class="btn btn-primary" id="btnsubmit-sale" onclick="btnsubmitsale_click();"
                        data-dismiss="modal">
                        Submit</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" data-easein="flipYIn" id="customerModal" tabindex="-1" role="dialog"
        aria-labelledby="cModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header modal-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <h4 class="modal-title" id="cModalLabel">
                        Add Customer
                    </h4>
                </div>
                <form action="https://#/pos/add_customer" id="customer-form" method="post"
                accept-charset="utf-8">
                <input type="hidden" name="spos_token" value="0dbeb4034dd067d5db67226fc01f3361">
                <div class="modal-body">
                    <div id="c-alert" class="alert alert-danger" style="display: none;">
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">
                                <label class="control-label" for="code">
                                    Name
                                </label>
                                <input type="text" name="name" value="" class="form-control input-sm kb-text" id="txtcname">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-6">
                            <div class="form-group">
                                <label class="control-label" for="cemail">
                                    Email Address
                                </label>
                                <input type="text" name="email" value="" class="form-control input-sm kb-text" id="txtcemail">
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <div class="form-group">
                                <label class="control-label" for="phone">
                                    Phone
                                </label>
                                <input type="text" name="phone" value="" class="form-control input-sm kb-pad" id="txtcphone">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-6">
                            <div class="form-group">
                                <label class="control-label" for="cf1">
                                    Custom Field 1
                                </label>
                                <input type="text" name="cf1" value="" class="form-control input-sm kb-text" id="txtcf1">
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <div class="form-group">
                                <label class="control-label" for="cf2">
                                    Custom Field 2
                                </label>
                                <input type="text" name="cf2" value="" class="form-control input-sm kb-text" id="txtcf2">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="margin-top: 0;">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">
                        Close
                    </button>
                    <button type="submit" class="btn btn-primary" id="btnadd_customer" onclick="btncustomersaveclick();">
                        Add Customer
                    </button>
                </div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal" data-easein="flipYIn" id="divregistermodel" tabindex="-1" role="dialog"
        aria-labelledby="cModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header modal-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <h4 class="modal-title" id="H1">
                        Register Details
                    </h4>
                </div>
                <form id="Form1" method="post" accept-charset="utf-8">
                <div class="modal-body">
                    <table width="100%" class="stable">
                        <tbody>
                            <tr> 
                                <td style="border-bottom: 1px solid #EEE;">
                                    <h4>
                                       <strong> Cash in hand: </strong></h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #EEE;">
                                    <h4>
                                       <strong> <span id="spnregcashinhand">0.00</span></strong></h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #EEE;">
                                    <h4>
                                       <strong> Cash Sales: </strong></h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #EEE;">
                                    <h4>
                                       <strong> <span id="spnregcashsale">0.00</span></strong>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #EEE;">
                                    <h4>
                                       <strong> Cheque Sales: </strong></h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #EEE;">
                                    <h4>
                                       <strong> <span id="spnregchequesale">0.00 </span></strong>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #EEE;">
                                    <h4>
                                       <strong> Gift Card Sales: </strong></h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #EEE;">
                                    <h4>
                                       <strong> <span id="spnreggiftcardsale">0.00</span></strong>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #EEE;">
                                    <h4>
                                      <strong>  Credit Card Sales: </strong></h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #EEE;">
                                    <h4>
                                      <strong>  <span id="spnregccsale">0.00</span></strong>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #DDD;">
                                    <h4>
                                      <strong>  Stripe: </strong></h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #DDD;">
                                    <h4>
                                      <strong>  <span id="spnregstripesale">0.00</span></strong>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #DDD;">
                                    <h4>
                                      <strong>  Paytm: </strong></h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #DDD;">
                                    <h4>
                                      <strong>  <span id="spnpaytmamt">0.00</span></strong>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #DDD;">
                                    <h4>
                                      <strong>  Phone Pay: </strong></h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #DDD;">
                                    <h4>
                                      <strong>  <span id="spnphonepayamt">0.00</span></strong>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #008d4c;">
                                    <h4>
                                       <strong> Others: </strong></h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #008d4c;">
                                    <h4>
                                       <strong> <span id="spnregothersale">0.00</span></strong>
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
                                      <strong>  <span id="spnregtotalsale">0.00 </span></strong>
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
                                       <strong> <span id="spnregexpenses">0.00</span> </strong>
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
                                        <strong><span id="spnregtotalcash">0.00</span></strong>
                                    </h4>
                                </td>
                            </tr>
                        </tbody>
                    </table>
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
    <div class="modal" data-easein="flipYIn" id="divtodaysale" tabindex="-1" role="dialog"
        aria-labelledby="cModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-success">
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
                    <table width="100%" class="stable">
                        <tbody>
                            <tr>
                                <td style="border-bottom: 1px solid #008d4c;">
                                    <h4>
                                        Cash Sales:</h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #008d4c;">
                                    <h4>
                                        <span id="spntodaycashsale">0.00</span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #008d4c;">
                                    <h4>
                                        Cheque Sales:</h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #008d4c;">
                                    <h4>
                                        <span id="spntodaychequesale">0.00 </span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #008d4c;">
                                    <h4>
                                        Credit Card Sales:</h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #008d4c;">
                                    <h4>
                                        <span id="spntodayccsale">0.00 </span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #008d4c;">
                                    <h4>
                                        Gift Card Sales:</h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #008d4c;">
                                    <h4>
                                        <span id="spntodaygiftcardsale">0.00 </span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #008d4c;">
                                    <h4>
                                        Stripe:</h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #008d4c;">
                                    <h4>
                                        <span id="spntodaystripesale">0.00 </span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #008d4c;">
                                    <h4>
                                        Paytm:</h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #008d4c;">
                                    <h4>
                                        <span id="spntodaypaytmamt">0.00 </span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #008d4c;">
                                    <h4>
                                        Phone Pay:</h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #008d4c;">
                                    <h4>
                                        <span id="spntodayphonepayamt">0.00 </span>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px solid #008d4c;">
                                    <h4>
                                        Others:</h4>
                                </td>
                                <td style="text-align: right; border-bottom: 1px solid #008d4c;">
                                    <h4>
                                        <span id="spntodayothersale">0.00</span> 
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td width="300px;" style="font-weight: bold;">
                                    <h4>
                                        Total Sales:</h4>
                                </td>
                                <td width="200px;" style="font-weight: bold; text-align: right;">
                                    <h4>
                                        <span id="spntodaytotalsale">0.00</span>
                                    </h4>
                                </td>
                            </tr>
                        </tbody>
                    </table>
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
    <div class="modal" data-easein="flipYIn" id="divcloseregister" tabindex="-1" role="dialog"
        aria-labelledby="cModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-success">
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
    </div>
    <div class="modal" data-easein="flipYIn" id="divshartcutkeys" tabindex="-1" role="dialog"
        aria-labelledby="cModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header modal-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times"></i>
                    </button>
                    <h4 class="modal-title" id="H4">
                        Shortcut Keys
                    </h4>
                </div>
                <form id="Form4" method="post" accept-charset="utf-8">
                <div class="modal-body" id="pr_popover_content">
                    <table class="table table-bordered table-condensed" style="margin-bottom: 0px;">
                        <thead>
                            <tr>
                                <th>
                                    Shortcut Keys
                                </th>
                                <th>
                                    Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    ALT+F1
                                </td>
                                <td>
                                    Focus add/search item input
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ALT+F2
                                </td>
                                <td>
                                    Add Customer
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ALT+F10
                                </td>
                                <td>
                                    Toggle Category Slider
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ALT+F5
                                </td>
                                <td>
                                    Cancel Sale
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ALT+F6
                                </td>
                                <td>
                                    Suspend Sale
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ALT+F11
                                </td>
                                <td>
                                    Print Order
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ALT+F12
                                </td>
                                <td>
                                    Print Bill
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ALT+F8
                                </td>
                                <td>
                                    Finalize Sale
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Ctrl+F1
                                </td>
                                <td>
                                    Today's Sale
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Ctrl+F2
                                </td>
                                <td>
                                    Opened Bills
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ALT+F7
                                </td>
                                <td>
                                    Close Register
                                </td>
                            </tr>
                        </tbody>
                    </table>
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
    <script type="text/javascript">
        var base_url = 'https://spos.tecdiary.com/', assets = 'https://spos.tecdiary.com/themes/default/assets/';
        var dateformat = 'jS F Y', timeformat = 'h:i A';
        var Settings = { "logo": "logo1.png", "site_name": "SimplePOS", "tel": "0105292122", "dateformat": "jS F Y", "timeformat": "h:i A", "language": "english", "theme": "default", "mmode": "0", "captcha": "0", "currency_prefix": "USD", "default_customer": "1", "default_tax_rate": "5%", "rows_per_page": "100", "total_rows": "30", "header": null, "footer": null, "bsty": "3", "display_kb": "0", "default_category": "1", "default_discount": "0", "item_addition": "1", "barcode_symbology": null, "pro_limit": "10", "decimals": "2", "thousands_sep": ",", "decimals_sep": ".", "focus_add_item": "ALT+F1", "add_customer": "ALT+F2", "toggle_category_slider": "ALT+F10", "cancel_sale": "ALT+F5", "suspend_sale": "ALT+F6", "print_order": "ALT+F11", "print_bill": "ALT+F12", "finalize_sale": "ALT+F8", "today_sale": "Ctrl+F1", "open_hold_bills": "Ctrl+F2", "close_register": "ALT+F7", "java_applet": "0", "receipt_printer": "", "pos_printers": "", "cash_drawer_codes": "", "char_per_line": "42", "rounding": "1", "pin_code": "abdbeb4d8dbe30df8430a8394b7218ef", "purchase_code": null, "envato_username": null, "theme_style": "green", "after_sale_page": "1", "overselling": "1", "multi_store": "1", "qty_decimals": "2", "symbol": "", "sac": "0", "display_symbol": "0", "remote_printing": "1", "printer": "1", "order_printers": "[\"1\"]", "auto_print": "1", "local_printers": "1", "rtl": "0", "print_img": "0", "selected_language": "english" };
        var sid = false, username = 'admin', spositems = {};
        $(window).load(function () {
            $('#mm_pos').addClass('active');
            $('#pos_index').addClass('active');
        });
        var pro_limit = 10, java_applet = 0, count = 1, total = 0, an = 1, p_page = 0, page = 0, cat_id = 1, tcp = 2;
        var gtotal = 0, order_discount = 0, order_tax = 0, protect_delete = 0;
        var order_data = {}, bill_data = {};
        var csrf_hash = '0dbeb4034dd067d5db67226fc01f3361';
        var lang = new Array();
        lang['code_error'] = 'Code Error';
        lang['r_u_sure'] = '<strong>Are you sure?</strong>';
        lang['please_add_product'] = 'Please add product';
        lang['paid_less_than_amount'] = 'Paid amount is less than paying';
        lang['x_suspend'] = 'Sale can not be suspended';
        lang['discount_title'] = 'Discount (5 or 5%)';
        lang['update'] = 'Update';
        lang['tax_title'] = 'Tax (5 or 5%)';
        lang['leave_alert'] = 'You will loss the data, are you sure?';
        lang['close'] = 'Close';
        lang['delete'] = 'Delete';
        lang['no_match_found'] = 'No match found';
        lang['wrong_pin'] = 'Wrong Pin';
        lang['file_required_fields'] = 'Please fill required fields';
        lang['enter_pin_code'] = 'Enter Pin code';
        lang['incorrect_gift_card'] = 'Gift card number is wrong or card is already used.';
        lang['card_no'] = 'Card No';
        lang['value'] = 'Value';
        lang['balance'] = 'Balance';
        lang['unexpected_value'] = 'Unexpected Value Provided!';
        lang['inclusive'] = 'Inclusive';
        lang['exclusive'] = 'Exclusive';
        lang['total'] = 'Total';
        lang['total_items'] = 'Total Items';
        lang['order_tax'] = 'Order Tax';
        lang['order_discount'] = 'Order Discount';
        lang['total_payable'] = 'Total Payable';
        lang['rounding'] = 'Rounding';
        lang['grand_total'] = 'Grand Total';
        lang['register_open_alert'] = 'Register is open, are you sure to sign out?';
        lang['discount'] = 'Discount';
        lang['order'] = 'Order';
        lang['bill'] = 'Bill';
        lang['merchant_copy'] = 'Merchant Copy';

        $(document).ready(function () {

            if (get('rmspos')) {
                if (get('spositems')) { remove('spositems'); }
                if (get('spos_discount')) { remove('spos_discount'); }
                if (get('spos_tax')) { remove('spos_tax'); }
                if (get('spos_note')) { remove('spos_note'); }
                if (get('spos_customer')) { remove('spos_customer'); }
                if (get('amount')) { remove('amount'); }
                remove('rmspos');
            }
            if (!get('spos_discount')) {
                store('spos_discount', '0');
                $('#discount_val').val('0');
            }
            if (!get('spos_tax')) {
                store('spos_tax', '5%');
                $('#tax_val').val('5%');
            }

            if (ots = get('spos_tax')) {
                $('#tax_val').val(ots);
            }
            if (ods = get('spos_discount')) {
                $('#discount_val').val(ods);
            }
            bootbox.addLocale('bl', { OK: 'OK', CANCEL: 'No', CONFIRM: 'Yes' });
            bootbox.setDefaults({ closeButton: false, locale: "bl" });
        });
    </script>
    <script type="text/javascript">
        var socket = null;
        function printBill(bill) {
            if (Settings.remote_printing == 1) {
                Popup($('#bill_tbl').html());
            } else if (Settings.remote_printing == 2) {
                if (socket.readyState == 1) {
                    var socket_data = { 'printer': '', 'logo': 'https://spos.tecdiary.com/uploads/logo.png', 'text': bill };
                    socket.send(JSON.stringify({
                        type: 'print-receipt',
                        data: socket_data
                    }));
                    return false;
                } else {
                    bootbox.alert('Unable to connect to socket, please make sure that server is up and running fine.');
                    return false;
                }
            }
        }
        var order_printers = '';
        function printOrder(order) {
            if (Settings.remote_printing == 1) {
                Popup($('#order_tbl').html());
            } else if (Settings.remote_printing == 2) {
                if (socket.readyState == 1) {
                    if (order_printers == '') {

                        var socket_data = {
                            'printer': false, 'order': true,
                            'logo': 'https://spos.tecdiary.com/uploads/logo.png',
                            'text': order
                        };
                        socket.send(JSON.stringify({ type: 'print-receipt', data: socket_data }));

                    } else {

                        $.each(order_printers, function () {
                            var socket_data = { 'printer': this, 'logo': 'https://spos.tecdiary.com/uploads/logo.png', 'text': order };
                            socket.send(JSON.stringify({ type: 'print-receipt', data: socket_data }));
                        });

                    }
                    return false;
                } else {
                    bootbox.alert('Unable to connect to socket, please make sure that server is up and running fine.');
                    return false;
                }
            }
        }
    </script>


    <script src="css/libraries.min.js" type="text/javascript"></script>
    <script src="css/scripts.min.js" type="text/javascript"></script>
    <script src="css/pos.min.js" type="text/javascript"></script>
    <!--<script src="https://spos.tecdiary.com/themes/default/assets/dist/js/libraries.min.js" type="text/javascript"></script>
                    <script src="https://spos.tecdiary.com/themes/default/assets/dist/js/scripts.min.js" type="text/javascript"></script>
    
                    <script src="https://spos.tecdiary.com/themes/default/assets/dist/js/pos.min.js" type="text/javascript"></script>-->
    <ul class="ui-autocomplete ui-front ui-menu ui-widget ui-widget-content" id="ui-id-1"
        tabindex="0" style="display: none;">
    </ul>
    <span role="status" aria-live="assertive" aria-relevant="additions" class="ui-helper-hidden-accessible">
    </span>
    <span id="spnbtnval"></span>
</body>
</html>
