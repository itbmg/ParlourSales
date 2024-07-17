<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="expences.aspx.cs" Inherits="expences" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(function () {
            GetFixedrows();
        });
        var today_date = "";
        function isFloat(evt) {
            var charCode = (event.which) ? event.which : event.keyCode;
            if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            else {
                var parts = evt.srcElement.value.split('.');
                if (parts.length > 1 && charCode == 46)
                    return false;
                return true;
            }
        }


        $(document).click(function () {
            $('#tabledetails_gst').on('change', '.price', calTotal)
                  .on('change', '.quantity', calTotal);
            function calTotal() {
                var $row = $(this).closest('tr');
                price = $row.find('.price').val();
                quantity = $row.find('.quantity').val();
                var prod_total = price * quantity;
                prod_total = prod_total.toFixed(2);
                var total = parseFloat(prod_total);
                $row.find('#txttotal').text(parseFloat(total).toFixed(2));
            }
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
        function btnsave_click() {
            var btnvalue = document.getElementById("btnsave").value;
            var fillitems = [];
            $('#tabledetails_gst> tbody > tr').each(function () {
                var productname = $(this).find('#txtproductname').val();
                var PerUnitRs = $(this).find('#txt_perunitrs').val();
                var Quantity = $(this).find('#txt_quantity').val();
                var TotalCost = $(this).find('#txttotal').text();
                if (productname == "" || productname == "0") {
                }
                else {
                    fillitems.push({ 'productname': productname, 'PerUnitRs': PerUnitRs, 'Quantity': Quantity, 'TotalCost': TotalCost });
                }
            });
            if (fillitems.length == 0) {
                alert("Please Select Items Names");
                return false;
            }
            var Data = { 'op': 'save_expencessdetails',  'btnvalue': btnvalue, 'fillitems': fillitems };
            var s = function (msg) {
                if (msg) {
                    alert(msg);
                    forclearall();
                }
            }
            var e = function (x, h, e) {
            };
            CallHandlerUsingJson(Data, s, e);
        }
        function GetFixedrows() {
            var results = '<div class="box-body"><table class="table table-striped table-condensed table-hover list-table" style="margin: 0px;" data-height="100" ID="tabledetails_gst">';
            results += '<thead><tr class="success"><th scope="col">Sno</th><th scope="col">Item Name</th><th scope="col">Price</th><th scope="col">Quantity</th><th scope="col">Value</th></tr></thead></tbody>';
            for (var i = 1; i < 11; i++) {
                results += '<tr><td scope="row" class="1" style="text-align:center;" id="txtsno">' + i + '</td>';
                results += '<td><input id="txtproductname" type="text"  class="productcls_gst" placeholder= "Enter Product" style="width: 100%;"/></td>';
                results += '<td><input id="txt_perunitrs" type="text" name="price" class="price price_gst" placeholder="Enter Price" style="width: 100%;" onkeypress="return isFloat(event)"/></td>';
                results += '<td><input id="txt_quantity" type="text" name="quantity" class="quantity quantity_gst" placeholder="Enter Qty" style="width: 100%;"  onkeypress="return isFloat(event)" style="width:90px;"/></td>';
                results += '<td ><span id="txttotal"  class="clstotal_gst"  onkeypress="return isFloat(event)"  style="width:90px;"></td>';
                results += '<td><span id="spn_taxable"></span><input id="txt_taxable" type="text" class="taxable" placeholder="Amount" onkeypress="return isFloat(event)" style="width:90px;display:none;"/></td>';
                results += '<td style="display:none"><input id="hdnproductsno" type="hidden"/></td>';
                results += '<td style="display:none"><input id="txt_stsno" type="hidden" /></td>';
                results += '<td style="display:none" class="4">' + i + '</td></tr>';
            }
            results += '</table></div>';
            $("#div_SectionData").html(results);
        }

    </script>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <div class="clearfix">
    </div>
    <div class="row" id="divbind">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">
                        Expences Master</h3>
                </div>
                <div id="div_SectionData">
                </div>
            </div>
        </div>
    </div>
    <div>
        <input type="submit" name="update" value="Save" class="btn btn-primary" id="btnsave"
            onclick="btnsave_click();">
        <input type="button" name="update" value="Close" class="btn btn-primary" id="btnclose"></div>
</asp:content>
