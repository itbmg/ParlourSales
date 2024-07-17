<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="itemmonitor.aspx.cs" Inherits="itemmonitor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(function () {
             get_subcategory_details();
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
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].subcategory != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].subcategory;
                    option.value = msg[i].sno;
                    data.appendChild(option);
                }
            }
        }

        function get_itemmonitor_details() {
            var subcatid = document.getElementById('slctsubcategory').value;
            var data = { 'op': 'get_itemmonitor_details', 'subcatid': subcatid };
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
            var results = '<div  class="box-body"><table class="table table-bordered dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tblitemsdata">';
            results += '<thead><tr><th scope="col">Sno</th><th scope="col">Item Name</th><th scope="col">Quantity</th><th scope="col">Selling Price</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr>';
                results += '<td scope="row" class="1" >' + k + '</td>';
                results += '<td scope="row" class="2" style="text-align: center; font-weight: bold;" ><span id="spn_Productname">' + msg[i].itemname + '</span></td>';
                results += '<td><input id="txt_quantity" type="text" class="form-control" value="' + msg[i].quantity + '" name="quantity"/></td>';
                results += '<td><input id="txt_price" type="text" class="form-control" value="' + msg[i].sellingprice + '" name="price"/></td>';
                results += '<td style="display:none" class="7"><input id="hdnsno" type="hidden" value="' + msg[i].sno + '"></td></tr>';
            }
            results += '</table></div>';
            $("#divitemsdata").html(results);
        }
        function btngenarateclick() {
            get_itemmonitor_details();
        }
        function btnsave_itemmonitordetails() {
            var rows = $("#tblitemsdata tr:gt(0)");
            var txtsno = 0;
            var rowsno = 1;
            var taxtype = 0;
            var perunittax = 0;
            var igst = 0;
            var dis = 0;
            var tax = 0;
            var edtax = 0;
            var itemlist = [];
            $(rows).each(function (i, obj) {
                if ($(this).find('#spn_Productname').text() != "") {
                    txtsno = rowsno;
                    productname = $(this).find('#spn_Productname').text();
                    Quantity = $(this).find('#txt_quantity').val();
                    price = $(this).find('#txt_price').val();
                    productid = $(this).find('#hdnsno').val();
                    itemlist.push({ Sno: txtsno, productname: productname, price: price, Quantity: Quantity, productid: productid });
                    rowsno++;
                }
            });
            if (itemlist.length == 0) {
                alert("Please Select Items Names");
                return false;
            }
            var Data = { 'op': 'update_itemstockdetails', 'itemlist': itemlist};
            var s = function (msg) {
                if (msg) {
                    alert(msg);
                    get_itemmonitor_details();
                }
            }
            var e = function (x, h, e) {
            };
            CallHandlerUsingJson(Data, s, e);
        }
        function cmpforclearall() {
            scrollTo(0, 0);
            document.getElementById('txtcashinhand').value = "";
        }
    </script>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">
                        Item Stock Monitor</h3>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4 col-sm-4">
                            <div class="well well-sm col-sm-12">
                                <label for="print_bill">
                                    Category</label>
                                <select class="form-control" id="slctsubcategory" required="required" style="width: 100%;"
                                    tabindex="-1" aria-hidden="true">
                                </select>
                            </div>
                        </div>
                        <div class="col-md-4 col-sm-4">
                            <div class="well well-sm col-sm-12">
                                <div id="divdinaminationdata">
                                </div>
                                <input type="button" value="Get Details" class="btn btn-primary" id="btngenarate" onclick="btngenarateclick();">
                            </div>
                        </div>
                        <div id="divitemsdata">
                        </div>
                        <div>
                         <input type="button" value="Save" class="btn btn-primary" id="Button1" onclick="btnsave_itemmonitordetails();">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:content>
