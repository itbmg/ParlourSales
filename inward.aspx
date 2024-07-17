<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="inward.aspx.cs" Inherits="inward" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type='text/javascript'>
        $(function () {
            get_product_details();
            getinwarddetails();
            get_supplierdetails();
            $("#btnaddclick").click(function () {
                $('#divitem').css('display', 'block');
                $('#divbind').css('display', 'none');
            })
            $("#btnclose").click(function () {
                $('#divitem').css('display', 'none');
                $('#divbind').css('display', 'block');
            })
        });

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

        function get_supplierdetails() {
            var data = { 'op': 'get_supplierdetails' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillsupplierdetails(msg);
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

        function fillsupplierdetails(msg) {
            var data = document.getElementById('slctstate');
            var length = data.options.length;
            document.getElementById('slctstate').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select Supplier";
            opt.value = "Select Supplier";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            data.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].supname != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].supname;
                    option.value = msg[i].sno;
                    data.appendChild(option);
                }
            }
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
                    var hdnproductsno = $(this).find('#hdnproductsno').val();
                    itemlist.push({ productname: productname, price: PerUnitRs, Quantity: Quantity, TotalCost: TotalCost, productid: hdnproductsno });
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
                    var Totalax = itemlist[i].Totaltax;
                    var igst = itemlist[i].igst;
                    var productid = itemlist[i].productid;
                    var sumprice = parseFloat(PerUnitRs) + parseFloat(Totalax);
                    dummyitem.push({ productname: productname, price: PerUnitRs, Quantity: Quantity, TotalCost: TotalCost, productid: productid });
                    rdummyitem.push({ productname: productname, price: sumprice, Quantity: Quantity, TotalCost: TotalCost, productid: productid });
                    dupliitemlist.push(productid);
                }
            }
            if (dummyitem.length > 0) {
                itemlist = [];
                DataTable = rdummyitem;
                var itemresults = '<table id="posTable" class="table table-striped table-condensed table-hover list-table" style="margin: 0px;" data-height="100"><thead> <tr class="success"><th> Product</th> <th style="width: 15%; text-align: center;"> Price </th><th style="width: 15%; text-align: center;"> Qty</th><th style="width: 20%; text-align: center;">Subtotal </th> <th style="width: 20px;" class="satu"><i class="fa fa-trash-o"></i> </th></tr></thead> ';
                for (var i = 0; i < dummyitem.length; i++) {
                    itemresults += '<tr>';
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
                    itemresults += '<td class="text-center"><input id="hdnproductsno" type="hidden" value="' + dummyitem[i].productid + '"></td>';
                    itemresults += '</tr>';
                }
                itemresults += '</table>';
                $("#div_itemData").html(itemresults);
                clstotalval();
            }
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
            opt.value = "Walk-in Client";
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

        function btnsubmitinward_click() {
            var date = document.getElementById('txt_Date').value;
            var refno = document.getElementById('txtrefno').value;
            var supplier = document.getElementById('slctstate').value;
            var reciveornot = document.getElementById('slctcstatus').value;
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
            var Data = { 'op': 'save_inwarddetails', 'date': date, 'refnote': refno, 'supplier': supplier, 'reciveornot': reciveornot, 'description': description, 'btnvalue': btnvalue, 'totalvalue': totalvalue, 'sno':sno, 'fillitems': fillitems };
            var s = function (msg) {
                if (msg) {
                    alert(msg);
                    forclearall();
                    getinwarddetails();
                }
            }
            var e = function (x, h, e) {
            };
            CallHandlerUsingJson(Data, s, e);
        }
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
        function getinwarddetails() {
            var data = { 'op': 'get_inward_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillinwarddtls(msg);
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
      
        var inward_subdetails = [];
        function fillinwarddtls(msg) {
            scrollTo(0, 0);
            inward_subdetails = msg[0].SubInward;
            var itemresults = '<div class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbl_Stores_value">';
            itemresults += '<thead><tr role="row"><th>Sno</th><th scope="col">Date</th><th scope="col">Supplier Name</th><th scope="col">MRNNo</th><th scope="col">TotalValue</th><th scope="col">status</th><th scope="col" style="font-weight: bold;">Actions</th></tr></thead></tbody>';
            var inward = msg[0].InwardDetails;
            for (var i = 0; i < inward.length; i++) {
                var k = i + 1;
                itemresults += '<tr role="row" style="text-align: center;">';
                itemresults += '<td  class="1">' + k + '</td>';
                itemresults += '<td  class="2">' + inward[i].date + '</td>';
                itemresults += '<td  class="3">' + inward[i].supplier + '</td>';
                itemresults += '<td  class="4">' + inward[i].mrnno + '</td>';
                itemresults += '<td  class="5">' + inward[i].totalvalue + '</td>';
                itemresults += '<td  class="6">' + inward[i].status + '</td>';
                itemresults += '<td style="text-align: center;"><a href="#" onclick="update(this);" title="Edit Inward" class="tip btn btn-warning btn-xs"><i class="fa fa-edit"></i></a> <a href="#" onclick="getmebranchdelete(this);" title="Delete Inward" class="tip btn btn-danger btn-xs"><i class="fa fa-trash-o"></i></a></td>';
                itemresults += '<td  class="11"  style="display:none;">' + inward[i].refnote + '</td>';
                itemresults += '<td  class="10"  style="display:none;">' + inward[i].reciveornot + '</td>';
                itemresults += '<td  class="9"  style="display:none;">' + inward[i].description + '</td>';
                itemresults += '<td  class="7" style="display:none;">' + inward[i].supplierid + '</td>';
                itemresults += '<td class="8" style="display:none;">' + inward[i].sno + '</td>';
                itemresults += '</tr>';
            }
            itemresults += '</table>';
            $("#divinwarddata").html(itemresults);
            
        }
        var sno = 0;
        function update(thisid) {
            scrollTo(0, 0);
            var date = $(thisid).parent().parent().children('.2').html();
            var supplier = $(thisid).parent().parent().children('.3').html();
            var mrnno = $(thisid).parent().parent().children('.4').html();
            var totalvalue = $(thisid).parent().parent().children('.5').html();
            var status = $(thisid).parent().parent().children('.6').html();
            var supplierid = $(thisid).parent().parent().children('.7').html();
            var sno = $(thisid).parent().parent().children('.8').html();
            var description = $(thisid).parent().parent().children('.9').html();
            var reciveornot = $(thisid).parent().parent().children('.10').html();
            var refnote = $(thisid).parent().parent().children('.11').html();

            document.getElementById('txt_Date').value = date;
            document.getElementById('txtrefno').value = refnote;
            document.getElementById('slctstate').selectedIndex = supplierid;
            document.getElementById('slctcstatus').selectedIndex = reciveornot;
            document.getElementById('total').innerHTML = totalvalue;
            document.getElementById('txtaddress').value = description;
            document.getElementById('lbl_sno').innerHTML = sno;
            document.getElementById('btnsave').value = "Modify";
            var table = document.getElementById("posTable");
            var results = '<table id="posTable" class="table table-striped table-condensed table-hover list-table" style="margin: 0px;" data-height="100"><thead> <tr class="success"><th> Product</th> <th style="width: 15%; text-align: center;"> Price </th><th style="width: 15%; text-align: center;"> Qty</th><th style="width: 20%; text-align: center;">Subtotal </th> <th style="width: 20px;" class="satu"><i class="fa fa-trash-o"></i> </th></tr></thead> ';
            var k = 1;
            for (var i = 0; i < inward_subdetails.length; i++) {
                if (sno == inward_subdetails[i].inword_refno) {
                    results += '<tr>';
                    results += '<td  class="1" style="display:none;">' + inward_subdetails[i].productname + '</td>';
                    if (i % 2 == 0) {
                        results += '<td><span class="sname" id="spn_Productname">' + inward_subdetails[i].productname + '</span></td>';
                    }
                    else {
                        results += '<td><span class="sname" id="spn_Productname">' + inward_subdetails[i].productname + '</span></td>';
                    }
                    results += '<td   style="width:20%; text-align: center;"><input id="txt_perunitrs" name="prices" class="price" type="text" value="' + inward_subdetails[i].PerUnitRs + '"/></td>';
                    results += '<td style="width:20%; text-align: center;"><input id="txt_quantity" type="text" class="quantity form-control input-qty kb-pad text-center rquantity" style="width: 52% !important;float: right !important;" onkeyup="qtychage(this);"    value="' + inward_subdetails[i].Quantity + '" name="quantity"/></td>';
                    results += '<td  style="width:20%; text-align: center;"><span class="clstotal text-right ssubtotal" id="txtTotal">' + inward_subdetails[i].TotalCost + '</span></td>';
                    results += '<td class="text-center"><span onclick="removerow(this);"style="cursor: pointer;color: red;"><i class="fa fa-trash-o"></i></span></td>';
                    results += '<td class="text-center"><input id="hdnproductsno" type="hidden" value="' + inward_subdetails[i].hdnproductsno + '"></td>';
                    results += '</tr>';
                }
            }
            results += '</table>';
            $("#div_itemData").html(results);
            clstotalval();
            $('#divitem').css('display', 'block');
            $('#divbind').css('display', 'none');
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
    
    <section class="content">
    <div class="row"  id="divitem" style="display:none;">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">Inward</h3>
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
                                                <label for="cancel_sale">Supplier Name</label>
                                                 <select class="form-control" id="slctstate" required="required" style="width:100%;" tabindex="-1" aria-hidden="true">
                                                   
                                                 </select>
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="close_register">Reacived</label>
                                                  <select name="language" class="form-control tip select2 select2-hidden-accessible" id="slctcstatus" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
                                                    <option value="Received" selected="selected">Received</option>
                                                    <option value="NotReceived">Not received yet</option>
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
                            <input type="submit" name="update" value="Save" class="btn btn-primary" id="btnsave" onclick="btnsubmitinward_click();"> <input type="button" name="update" value="Close" class="btn btn-primary" id="btnclose"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" id="divbind">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">Inward Entry</h3>
                </div><div style="float: right; padding-right: 14px;padding-bottom: 5px;"><input type="button" name="AddIteam" value="Add Inward" class="btn btn-primary" id="btnaddclick"></br></div>
                        <div id="divinwarddata"></div>
        </div>

                
            </div>
        </div>
        <div hidden>
                                <label id="lbl_sno">
                                </label>
                        </div>
    </section>
</asp:content>
