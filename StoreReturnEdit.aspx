<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="StoreReturnEdit.aspx.cs" Inherits="StoreReturnEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="bootstrap/js/JTemplate.js"></script>
    <style type="text/css">
        .ddlsize {
            width: 230px;
            height: 30px;
            font-size: 16px;
            border: 1px solid gray;
            border-radius: 7px 7px 7px 7px;
        }

        .datepicker {
            border: 1px solid gray;
            background: url("Images/CalBig.png") no-repeat scroll 99%;
            width: 70%;
            top: 0;
            left: 0;
            height: 20px;
            font-weight: 700;
            font-size: 12px;
            cursor: pointer;
            border: 1px solid gray;
            margin: .5em 0;
            padding: .6em 20px;
            border-radius: 10px 10px 10px 10px;
            filter: Alpha(Opacity=0);
            box-shadow: 3px 3px 3px #ccc;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            get_company_details();
            get_parlor_details();
        });
        function get_company_details() {
            var data = { 'op': 'get_company_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg == "Session Expired") {
                        alert(msg);
                        window.location = "Login.aspx";
                    }
                    BindComapany(msg)
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }

        function BindComapany(msg) {
            var ddlsalesOffice = document.getElementById('ddlCompanyName');
            var length = ddlsalesOffice.options.length;
            ddlsalesOffice.options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "select";
            ddlsalesOffice.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].cmpname != null) {
                    var opt = document.createElement('option');
                    opt.innerHTML = msg[i].cmpname;
                    opt.value = msg[i].sno;
                    ddlsalesOffice.appendChild(opt);
                }
            }
        }

        function get_parlor_details() {
            var data = { 'op': 'get_parlor_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg == "Session Expired") {
                        alert(msg);
                        window.location = "Login.aspx";
                    }
                    bindBranchName(msg);
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }

        function bindBranchName(msg) {
            var ddlRouteName = document.getElementById('ddlBranchName');
            var length = ddlRouteName.options.length;
            ddlRouteName.options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select Parloural Name";
            ddlRouteName.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].parlorname != null) {
                    var opt = document.createElement('option');
                    opt.innerHTML = msg[i].parlorname;
                    opt.value = msg[i].parlorid;
                    ddlRouteName.appendChild(opt);
                }
            }
        }





        function DeliversCloseClick() {
            $('#divDeliveryProducts').css('display', 'none');
        }


        function GetEditIndentValues() {
            var ddlCompanyName = document.getElementById('ddlCompanyName').value;
            if (ddlCompanyName == "Select Company" || ddlCompanyName == "") {
                alert("Please Select Company Name");
                return false;
            }
            var ddlBranchName = document.getElementById('ddlBranchName').value;
            if (ddlBranchName == "Select Parloural Name" || ddlBranchName == "") {
                alert("Please Select Parloural Name");
                return false;
            }
            var InvoiceNo = document.getElementById('txtInvoiceNo').value;
            if (InvoiceNo == "") {
                alert("Please Enter Invoice");
                return false;
            }
            var data = { 'op': 'get_storereturn_details', 'ddlCompanyName': ddlCompanyName, 'ddlBranchName': ddlBranchName, 'InvoicNo': InvoiceNo };
            var s = function (msg) {
                if (msg) {
                    //BindDeliverInventory();
                    //BindCollectionInventory();
                    $('#divFillScreen').removeTemplate();
                    $('#divFillScreen').setTemplateURL('ReturnEdit1.htm');
                    $('#divFillScreen').processTemplate(msg);
                    calcTot();
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }


        function btnEditIndentSaveClick(id) {
            var InvoiceNo = document.getElementById('txtInvoiceNo').value;
            var Paying = document.getElementById('txtPaying').value;
            var Payable = document.getElementById('txt_TotalAmount').innerHTML;
            var btnvalue = "Edit";
            var rows = $("#table_Indent_details tr:gt(0)");
            var fillitems = new Array();
            $(rows).each(function (i, obj) {
                if ($(this).find('#txtProductName').text() != "") {
                    //var TotalCost = document.getElementById('txt_TotalAmount').innerHTML;

                    fillitems.push({ hdnproductsno: $(this).find('#hdnProductSno').val(), productname: $(this).find('#txtProductName').text(), PerUnitRs: $(this).find('#txtLtr_rate').text(), Quantity: $(this).find('#txtPkts_Dqty').val(), pkt_qty: $(this).find('#hdnPkt_UnitQty').val(), PerUnitRs: $(this).find('#txtPkt_rate').text(), TotalCost: $(this).find('#txtTotal_Value').text(), ordertax: $(this).find('#hdnOrderTax').val()  });
                }
            });

            //end added by akbar 20-May-2022
            var ddlCompanyName = document.getElementById('ddlCompanyName').value;
            if (ddlCompanyName == "Select Company" || ddlCompanyName == "") {
                alert("Please Select Company Name");
                return false;
            }
            var ddlBranchName = document.getElementById('ddlBranchName').value;
            if (ddlBranchName == "Select Parloural Name" || ddlBranchName == "") {
                alert("Please Select Parloural Name");
                return false;
            }
            var data = { 'op': 'save_storereturn_details', 'fillitems': fillitems, 'ddlCompanyName': ddlCompanyName, 'Branchname': ddlBranchName, 'sno': InvoiceNo, 'totalpaying': Paying, 'totalpayable': Payable, 'totalvalue': Payable, 'btnvalue': btnvalue };
            var s = function (msg) {
                if (msg) {
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            CallHandlerUsingJson(data, s, e);
        }

        function OrderPktQtyChange(PktQty) {
            if (PktQty.value == "") {

            }
            else {
                var pktval = PktQty.value;

                $(PktQty).closest("tr").find("#txtLtrQty").text(parseFloat(pktval).toFixed(2))

                var rate = $(PktQty).closest('tr').find('#txtPkt_rate').text();
                var total = rate * pktval;
                $(PktQty).closest('tr').find('#txtTotal_Value').text(total);
                calcTot();
            }
        }

        var FinalAmount;
        function calcTot() {
            var qty = 0.0;
            var rate = 0;
            var total = 0;
            var totallpkts = 0;
            var totallAmount = 0;
            var totalltr = 0;
            var cnt = 0;
            $('.Unitqtyclass').each(function (i, obj) {
                //var qtyclass = $(this).next.next.next.text();
                var qtyclass = $(this).closest('tr').find('#txtPkts_Dqty').val();
                if (qtyclass == "" || qtyclass == "0") {
                }
                else {
                    totallpkts += parseFloat(qtyclass);
                    cnt++;
                }
            });


            $('.clsTotal').each(function (i, obj) {
                //var qtyclass = $(this).next.next.next.text();
                var totalclass = $(this).closest('tr').find('#txtTotal_Value').text();
                if (totalclass == "" || totalclass == "0") {
                }
                else {
                    totallAmount += parseFloat(totalclass);
                    cnt++;
                }
            });

            document.getElementById('txt_TotalAmount').innerHTML = parseFloat(totallAmount).toFixed(2);
            document.getElementById('txt_TotalPkts').innerHTML = parseFloat(totallpkts).toFixed(2);
            FinalAmount = total;
        }
        function numberOnlyExample() {
            if ((event.keyCode < 48) || (event.keyCode > 57))
                return false;
        }
        function OrdersCloseClick() {
            $('#divMainAddNewRow').css('display', 'none');
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content-header">
        <h1>Edit Return<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Operations</a></li>
            <li><a href="#">Edit Return</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Edit Return Details
                </h3>
            </div>
            <div class="box-body">

                <div id="tbldropdowns">
                    <table align="center">
                        <tr>
                            <td>
                                <label for="lblBranch">
                                    CompanyName
                                </label>
                            </td>
                            <td style="height: 40px;">
                                <select id="ddlCompanyName" class="form-control">
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="lblBranch">
                                    BranchName</label>
                            </td>
                            <td style="height: 40px;">
                                <select id="ddlBranchName" class="form-control">
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="lblBranch">
                                    InvoiceNo</label>
                            </td>
                            <td style="height: 40px;">
                                <input type="text" id="txtInvoiceNo" class="form-control" placeholder="Enter Invoice Number" class="form-control" />
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td style="height: 40px;">
                                <input type="button" id="Button1" value="GET Return" class="btn btn-primary" onclick="GetEditIndentValues();" />
                            </td>
                        </tr>
                    </table>
                    <div id="divFillScreen">
                    </div>
                    <div style="height: 5%;">
                        <table align="center">
                            <tr>
                                <td style="width: 35%;"></td>
                                <td style="width: 25%;">
                                    <input type="button" id="btnSave" value="Save" onclick="btnEditIndentSaveClick();" class="btn btn-primary" />
                                </td>
                                <td style="width: 5%;">
                                    <span style="font-weight: bold; font-size: 14px;display:none;">Paying</span>
                                </td>
                                <td style="width: 20%;">
                                    <input type="text" id="txtPaying" style="display:none;" class="form-control" />
                                </td>

                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

