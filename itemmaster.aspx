<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="itemmaster.aspx.cs" Inherits="itemmaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<script type="text/javascript">
    $(function () {
        $("#btnaddclick").click(function () {
            $('#divitem').css('display', 'block');
            $('#divbind').css('display', 'none');
        })
        $("#btnclose").click(function () {
            $('#divitem').css('display', 'none');
            $('#divbind').css('display', 'block');
            forclearall();
        })
        get_category_details();
        get_subcategory_details();
        get_UOM_details();
        get_item_details();
    });
    function igstchange() {
        var igst = document.getElementById('slctigst').value;
        var cgst = igst / 2;
        document.getElementById('txtcgst').value = cgst;
        document.getElementById('txtsgst').value = cgst;
    }
    function get_category_details() {
        var data = { 'op': 'get_category_details' };
        var s = function (msg) {
            if (msg) {
                if (msg.length > 0) {
                    fillcatdetails(msg);
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
    function fillcatdetails(msg) {
        var data = document.getElementById('slctcategory');
        var length = data.options.length;
        document.getElementById('slctcategory').options.length = null;
        var opt = document.createElement('option');
        opt.innerHTML = "Select Category";
        opt.value = "Select Category";
        opt.setAttribute("selected", "selected");
        opt.setAttribute("disabled", "disabled");
        opt.setAttribute("class", "dispalynone");
        data.appendChild(opt);
        for (var i = 0; i < msg.length; i++) {
            if (msg[i].category != null) {
                var option = document.createElement('option');
                option.innerHTML = msg[i].category;
                option.value = msg[i].sno;
                data.appendChild(option);
            }
        }
    }

    function ddlcategorycange() {
        get_subcategory_details();
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
        var data = document.getElementById('slctsubcategory'); 
        var length = data.options.length;
        document.getElementById('slctsubcategory').options.length = null;
        var opt = document.createElement('option');
        opt.innerHTML = "Select Sub Category";
        opt.value = "Select Sub Category";
        opt.setAttribute("selected", "selected");
        opt.setAttribute("disabled", "disabled");
        opt.setAttribute("class", "dispalynone");
        data.appendChild(opt);
        var category = document.getElementById('slctcategory').value;
        if (category != "") {
            for (var i = 0; i < msg.length; i++) {
                if (category == msg[i].catid) {
                    if (msg[i].subcategory != null) {
                        var option = document.createElement('option');
                        option.innerHTML = msg[i].subcategory;
                        option.value = msg[i].sno;
                        data.appendChild(option);
                    }
                }
            }
        }
        else {
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].subcategory != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].subcategory;
                    option.value = msg[i].sno;
                    data.appendChild(option);
                }
            }
        }
    }
    function get_UOM_details() {
        var data = { 'op': 'get_UOM_details' };
        var s = function (msg) {
            if (msg) {
                if (msg.length > 0) {
                    filluomdetails(msg);
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
    function filluomdetails(msg) {
        var data = document.getElementById('slctuom'); 
        var length = data.options.length;
        document.getElementById('slctuom').options.length = null;
        var opt = document.createElement('option');
        opt.innerHTML = "Select UOM";
        opt.value = "Select UOM";
        opt.setAttribute("selected", "selected");
        opt.setAttribute("disabled", "disabled");
        opt.setAttribute("class", "dispalynone");
        data.appendChild(opt);
        for (var i = 0; i < msg.length; i++) {
            if (msg[i].UOM != null) {
                var option = document.createElement('option');
                option.innerHTML = msg[i].UOM;
                option.value = msg[i].sno;
                data.appendChild(option);
            }
        }
    }

    function saveitemdetails() {
        var category = document.getElementById('slctcategory').value;
        var subcategory = document.getElementById('slctsubcategory').value;
        var uom = document.getElementById('slctuom').value;
        var itemname = document.getElementById('txtitemname').value;
        var sku = document.getElementById('txtsku').value;
        var billingprice = document.getElementById('txtbillingprice').value;
        var mrp = document.getElementById('txtmrp').value;
        var hsncode = document.getElementById('txthsncode').value;
        var igst = document.getElementById('slctigst').value;
        var cgst = document.getElementById('txtcgst').value;
        var sgst = document.getElementById('txtsgst').value;
        var discription = document.getElementById('txtarea').value;
        var gsttaxtype = document.getElementById('slctgsttax').value;
        var status = document.getElementById('slctstatus').value;
        var btnval = document.getElementById('btnsave').value;
        var sno = document.getElementById('lbl_sno').innerHTML;
        var data = { 'op': 'saveitemdetails', 'category': category, 'subcategory': subcategory, 'uom': uom, 'itemname': itemname, 'sku': sku, 'billingprice': billingprice, 'mrp': mrp,
            'hsncode': hsncode, 'igst': igst, 'cgst': cgst, 'sgst': sgst, 'discription': discription, 'gsttaxtype': gsttaxtype, 'Status': status, 'btnVal': btnval, 'sno': sno
        };
        var s = function (msg) {
            if (msg) {
                if (msg.length > 0) {
                    alert(msg);
                    get_item_details();
                    $('#div_BankData').show();
                    $('#Bankfillform').show();
                    forclearall();
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
    function forclearall() {
        document.getElementById('slctcategory').value = "Select Category";
        document.getElementById('slctsubcategory').value = "Select Sub Category";
        document.getElementById('slctuom').value = "Select UOM";
        document.getElementById('txtitemname').value = "";
        document.getElementById('txtsku').value = "";
        document.getElementById('txtbillingprice').value = "";
        document.getElementById('txtmrp').value = "";
        document.getElementById('txthsncode').value = "";
        document.getElementById('slctigst').value = "";
        document.getElementById('txtcgst').value = "";
        document.getElementById('txtsgst').value = "";
        document.getElementById('txtarea').value = "";
        document.getElementById('slctgsttax').value = "";
        document.getElementById('slctstatus').value = 0;
        document.getElementById('btnsave').value = "Save";
        document.getElementById('lbl_sno').innerHTML = "";
    }
    function get_item_details() {
        var subcatid = "0";
        var data = { 'op': 'get_product_details', 'subcatid': subcatid };
        var s = function (msg) {
            if (msg) {
                if (msg.length > 0) {
                    fillitemdetails(msg);
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
    function fillitemdetails(msg) {
        var results = '<div class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbl_Stores_value">';
        results += '<thead><tr role="row"><th>Sno</th><th scope="col">Category</th><th scope="col">SubCategory</th><th scope="col">ItemName</th><th scope="col">UOM</th><th scope="col">Billing Prrice</th><th scope="col">MRP</th><th scope="col">GSTRegType</th><th scope="col">IGST</th><th scope="col">Status</th><th scope="col" style="font-weight: bold;">Actions</th></tr></thead></tbody>';
        for (var i = 0; i < msg.length; i++) {
            var k = i + 1;
            results += '<tr>';
            results += '<td scope="row" class="1" >' + k + '</td>';
            results += '<td scope="row" class="2" style="text-align: center; font-weight: bold;" >' + msg[i].category + '</td>';
            results += '<td scope="row" class="3" style="text-align: center; font-weight: bold;" >' + msg[i].subcategoryname + '</td>';
            results += '<td scope="row" class="4" style="text-align: center; font-weight: bold;" >' + msg[i].productname + '</td>';
            results += '<td scope="row" class="5" style="text-align: center; font-weight: bold;" >' + msg[i].uim + '</td>';
            results += '<td scope="row" class="6" style="text-align: center; font-weight: bold;" >' + msg[i].billingprice + '</td>';
            results += '<td scope="row" class="7" style="text-align: center; font-weight: bold;" >' + msg[i].price + '</td>';
            results += '<td scope="row" class="8" style="text-align: center; font-weight: bold;" >' + msg[i].GSTTaxCategory + '</td>';
            results += '<td scope="row" class="9" style="text-align: center; font-weight: bold;" >' + msg[i].igst + '</td>';
            results += '<td data-title="status" class="10" style="text-align: center; font-weight: bold;">' + msg[i].status + '</td>';
            results += '<td scope="row" class="11" style="text-align: center; font-weight: bold; display:none" >' + msg[i].hsncode + '</td>';
            results += '<td scope="row" class="12" style="text-align: center; font-weight: bold; display:none">' + msg[i].cgst + '</td>';
            results += '<td data-title="status" class="13" style="text-align: center; font-weight: bold; display:none">' + msg[i].sgst + '</td>';

            results += '<td data-title="status" class="14" style="text-align: center; font-weight: bold; display:none">' + msg[i].categoryid + '</td>';
            results += '<td data-title="status" class="15" style="text-align: center; font-weight: bold; display:none">' + msg[i].subcategoryid + '</td>';
            results += '<td data-title="status" class="16" style="text-align: center; font-weight: bold; display:none">' + msg[i].puim + '</td>';
            results += '<td data-title="status" class="18" style="text-align: center; font-weight: bold; display:none">' + msg[i].sku + '</td>';
            results += '<td data-title="status" class="19" style="text-align: center; font-weight: bold; display:none">' + msg[i].description + '</td>';
            results += '<td style="text-align: center;"><a href="#" title="View" class="tip btn btn-primary btn-xs" data-toggle="ajax"><i class="fa fa-file-text-o"></i></a><a href="#" onclick="getedit(this);" title="Edit Item" class="tip btn btn-warning btn-xs"><i class="fa fa-edit"></i></a> <a href="#" onclick="getmebranchdelete(this);" title="Delete Company" class="tip btn btn-danger btn-xs"><i class="fa fa-trash-o"></i></a></td>';
            results += '<td style="display:none" class="17">' + msg[i].productid + '</td></tr>';
        }
        results += '</table></div>';
        $("#divitemdata").html(results);
    }
    function getedit(thisid) {
        scrollTo(0, 0);
        var categoryid = $(thisid).parent().parent().children('.14').html();
        var subcategoryid = $(thisid).parent().parent().children('.15').html();
        var puim = $(thisid).parent().parent().children('.16').html();
        var productname = $(thisid).parent().parent().children('.4').html();
        var sku = $(thisid).parent().parent().children('.18').html();
        var price = $(thisid).parent().parent().children('.7').html();
        var billingprice = $(thisid).parent().parent().children('.6').html();
        var gsttaxcategory = $(thisid).parent().parent().children('.8').html();
        var hsncode = $(thisid).parent().parent().children('.11').html();
        var igst = $(thisid).parent().parent().children('.9').html();
        var cgst = $(thisid).parent().parent().children('.12').html();
        var sgst = $(thisid).parent().parent().children('.13').html();
        var sno = $(thisid).parent().parent().children('.17').html();
        var discription = $(thisid).parent().parent().children('.19').html();


        document.getElementById('slctcategory').value = categoryid;
        document.getElementById('slctsubcategory').value = subcategoryid;
        document.getElementById('slctuom').value = puim;
        document.getElementById('txtitemname').value = productname;
        document.getElementById('txtsku').value = sku;
        document.getElementById('txtbillingprice').value = billingprice;
        document.getElementById('txtmrp').value = price;
        document.getElementById('txthsncode').value = hsncode;
        document.getElementById('slctigst').value = igst;
        document.getElementById('txtcgst').value = cgst;
        document.getElementById('txtsgst').value = sgst;
        document.getElementById('txtarea').value = discription;
        document.getElementById('slctgsttax').value = gsttaxcategory;
        document.getElementById('slctstatus').value = status;
        document.getElementById('btnsave').value = "Modify";
        document.getElementById('lbl_sno').innerHTML = sno;
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
</script>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <section class="content">
    <div class="row"  id="divitem" style="display:none;">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">Item Master</h3>
                </div>
                <div class="box-body">
                    <div class="col-lg-12">
                        <div class="clearfix"></div>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="well well-sm">
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="focus_add_item">Category</label>
                                                <select name="language" class="form-control" id="slctcategory" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true" onchange="ddlcategorycange();">
                                                   
                                                 </select>
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">Sub Category</label> 
                                                <select name="language" class="form-control" id="slctsubcategory" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
                                                   
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="toggle_category_slider">Item Name</label> 
                                                 <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtitemname">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="cancel_sale">SKU</label>  
                                                 <input type="text" name="cancel_sale" value="" class="form-control tip" id="txtsku"> 
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="suspend_sale">UOM</label> 
                                               <select name="language" class="form-control" id="slctuom" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
                                                   
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="print_order">Billing Prrice</label> 
                                                <input type="text" name="print_order" value="" class="form-control tip" id="txtbillingprice">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="print_order">MRP</label> 
                                                <input type="text" name="print_order" value="" class="form-control tip" id="txtmrp">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="print_bill">GST Tax Category</label> 
                                                <select name="language" class="form-control" id="slctgsttax" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
                                                    <option value="Regular">Regular</option>
                                                    <option value="Nil Rated">Nil Rated</option>
                                                    <option value="Exempt">Exempt</option>
                                                 </select>
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="finalize_sale">HSN Code</label> 
                                                <input type="text" name="finalize_sale" value="" class="form-control tip" id="txthsncode">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="today_sale">IGST</label>
                                                <select name="language" class="form-control" id="slctigst" required="required" style="width:100%;" onchange="igstchange();">
                                                    <option disabled="" value="">SELECT</option>
                                                    <option value="0">0</option>
                                                    <option value="5">5</option>
                                                    <option value="12">12</option>
                                                    <option value="18">18</option>
                                                    <option value="28">28</option>
                                                 </select>
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="open_hold_bills">CGST</label>
                                                <input type="text" name="open_hold_bills" readonly value="" class="form-control tip" id="txtcgst">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="close_register">SGST</label>
                                                <input type="text" name="close_register" readonly value="" class="form-control tip" id="txtsgst">
                                            </div>
                                        </div>
                                         <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="print_bill">Status</label> 
                                                <select name="language" class="form-control tip select2 select2-hidden-accessible" id="slctstatus" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
                                                    <option value="Active">Active</option>
                                                    <option value="InActive">InActive</option>
                                                 </select>
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="close_register">Description</label>
                                                <textarea id="txtarea" class="form-control"></textarea>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <input type="submit" name="update" value="Save" class="btn btn-primary" id="btnsave" onclick="saveitemdetails();"> <input type="button" name="update" value="Close" class="btn btn-primary" id="btnclose"></div>

                           
                    </div>
                </div>
            </div>
        </div>

        <div class="row" id="divbind">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">Item Master</h3>
                </div><div style="float: right; padding-right: 14px;padding-bottom: 5px;"><input type="button" name="AddIteam" value="Add Item" class="btn btn-primary" id="btnaddclick"></br></div>
                         <div id="divitemdata"></div>
        </div>

                
            </div>
        </div>

         <div hidden>
                                <label id="lbl_sno">
                                </label>
                        </div>
    </section>
</asp:content>
