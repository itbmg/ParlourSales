<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="stockclosing.aspx.cs" Inherits="stockclosing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(function () {
            get_stock_details();
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
        function get_stock_details() {
            var data = { 'op': 'get_stock_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillstockdetails(msg);
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
        function fillstockdetails(msg) {
            var results = '<div class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbl_Stores_value">';
            results += '<thead><tr role="row"><th>Sno</th><th scope="col">Item Name</th><th scope="col">Quantity</th><th scope="col">Price</th><th scope="col">Value</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr>';
                results += '<td scope="row" class="1" >' + k + '</td>';
                results += '<td scope="row" class="2" style="font-weight: bold;" >' + msg[i].itemname + '</td>';
                results += '<td scope="row" class="3" style="font-weight: bold;" >' + msg[i].quantity + '</td>';
                results += '<td scope="row" class="4" style="font-weight: bold;" >' + msg[i].sellingprice + '</td>';
                var qty = parseFloat(msg[i].quantity);
                var price = parseFloat(msg[i].sellingprice);
                var value = qty * price;
                var rvalue = parseFloat(value).toFixed(2);
                results += '<td scope="row" class="6" style="font-weight: bold;" >' + rvalue + '</td>';
                results += '<td style="display:none" class="5">' + msg[i].sno + '</td></tr>';
            }
            results += '</table></div>';
            $("#divstockdata").html(results);
        }
       
        function btnsave_click() {
            
            var btnval = document.getElementById('btnsave').value;
            var sno = document.getElementById('lbl_sno').innerHTML;
            var data = { 'op': 'btn_save_parlor', 'parlorname': parlorname, 'parlorcode': parlorcode, 'parlortype': parlortype, 'pramotername': pramotername,
                'state': state, 'mobileno': mobileno, 'email': email, 'panno': panno, 'tinno': tinno, 'cstno': cstno, 'gstin': gstin, 'regtype': regtype, 'tallyledger': tallyledger, 'sapledger': sapledger, 'sapledgercode': sapledgercode, 'Status': status, 'btnval': btnval, 'sno': sno, 'cmpid': cmpid, 'branchid': branchid, 'address': address
            };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        get_parlor_details();
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
    </script>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
   
    <section class="content">
    <div class="row"  id="divitem">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">Stock Closing Details</h3>
                </div>
                <div class="box-body">
                    <div class="col-lg-12">
                        <div class="clearfix"></div>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div id="divstockdata"></div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <input type="submit" name="update" value="Save" class="btn btn-primary" id="btnsave" onclick="btnsave_click();"></div>
                    </div>
                </div>
            </div>
        </div>

        <div hidden>
                                <label id="lbl_sno">
                                </label>
                        </div>
    </section>
</asp:content>
