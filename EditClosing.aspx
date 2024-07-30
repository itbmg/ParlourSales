<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="EditClosing.aspx.cs" Inherits="EditClosing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(function () {
            get_parlor_details();
            get_category_details();
            var date = new Date();
            var day = date.getDate();
            var month = date.getMonth() + 1;
            var year = date.getFullYear();
            if (month < 10) month = "0" + month;
            if (day < 10) day = "0" + day;
            today = year + "-" + month + "-" + day;
            $('#txtFrom_date').val(today);
            $('#txtTo_date').val(today);
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
            var subcatid = document.getElementById('slctcategory').value;

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
        var productdetails = [];
        function ddlsubcategorycange() {
            var subcatid = document.getElementById('slctsubcategory').value;
            var data = {
                'op': 'get_product_details', 'subcatid': subcatid
            };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        filldata(msg);
                        //productdetails = msg;
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
        function filldata(msg) {
            var data = document.getElementById('slctProductName');
            var length = data.options.length;
            document.getElementById('slctProductName').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select ProductName";
            opt.value = "Select ProductName";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            data.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].productname != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].productname;
                    option.value = msg[i].productid;
                    data.appendChild(option);
                }
            }
        }
        


        function btn_Get_Bal_Details() {
            var Branchid = document.getElementById('ddlBranchName').value;
            var category = document.getElementById('slctcategory').value;
            var subcategory = document.getElementById('slctsubcategory').value;
            var itemname = document.getElementById('slctProductName').value;
            var todate = document.getElementById('txtTo_date').value;
            var fromdate = document.getElementById('txtFrom_date').value;
            if (fromdate == "") {
                alert("Please select from date");
                return false;
            }
            if (todate == "") {
                alert("Please select from date");
                return false;
            }
            var data = { 'op': 'get_Bal_Trans', 'branchid': Branchid, 'category': category, 'subcategory': subcategory, 'itemname': itemname, 'fromdate': fromdate, 'todate': todate };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fill_details(msg);
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


        function fill_details(msg) {
            var results = '<div  style="overflow:auto;"><table id="myTable" class="table table-bordered table-hover dataTable no-footer">';
            results += '<thead><tr><th scope="col" >Sno</th><th scope="col">Date</th><th scope="col">AgentName</th><th scope="col">Opening</th><th scope="col">InwardQty</th><th scope="col">SaleQty</th><th scope="col">Closing</th><th></th></tr></thead></tbody>';
            var k = 1;
            for (var i = 0; i < msg.length; i++) {
                results += '<tr>';
                //k++;
                results += '<td scope="row"  style="text-align:center;">' + k + '</td>';
                results += '<th scope="row" id="spnProductid" class="clsProductid" style="width:65px;display:none;">' + msg[i].productid + '</th>';
                results += '<td id="spnDate" class="clsDate">' + msg[i].salesdate + '</td>';
                results += '<td id="spnProductName" class="clsProductName">' + msg[i].productname + '</td>';
                results += '<td class="4"><span id="spn_OpBal" class="clsOp">' + msg[i].opp_balance + '</span></td>';
                results += '<td id="spn_PrevOpBal" class="clsPrevOp" style="width:65px;display:none;">' + msg[i].opp_balance + '</td>';
                //results += '<td><input id="txt_OpBal" data-title="Code" style="width:65px;" onkeyup="CLChange(this);" class="4"  value="' + msg[i].opp_balance + '"/></td>';
                results += '<td><input  id="txt_Inwardqty" class="clsInwardqty" style="width:65px;" value="' + msg[i].inwardqty + '"/></td>';
                results += '<td id="txt_PrevInwardqty" class="clsPrevInwardqty" style="width:65px;display:none;">' + msg[i].inwardqty + '</td>';
                results += '<td><input id="txt_Saleqty" class="clsSaleqty" style="width:65px;" value="' + msg[i].saleqty + '"/></td>';
                results += '<td id="txt_PrevSaleqty" class="clsPrevSaleqty" style="width:65px;display:none;">' + msg[i].saleqty + '</td>';
                results += '<td id="txt_PrevCloBal" class="clsPrevCloBal" style="width:65px;display:none;">' + msg[i].clo_balance + '</td>';
                results += '<td><input  id="txt_CloBal" class="clsCloBal" style="width:65px;" value="' + msg[i].clo_balance + '"/></td>';
                results += '<td><input  id="txt_Sno" class="8" style="width:65px;display:none;"  value="' + msg[i].sno + '"/></td></tr >';
                k++;
            }
            results += '</table></div>';
            $("#div_BrandData").html(results);
        }



        var salevalue = 0; var paidamount = 0; var closingamt = 0;
        $(document).click(function () {
            increment = 0;
            $('#myTable').on('change', '.clsInwardqty', calTotal_gst)
                .on('change', '.clsSaleqty', calTotal_gst)
                .on('change', '.clsCloBal', calClosing);

        });




        var DataTable;
        var presentClosing = 0;
        function insertrow() {
            DataTable = [];
            var DataTable1 = [];
            var Productname = 0;
            var Productid = 0;
            var Op_Bal = 0;
            var PrevOp_Bal = 0;
            var Inwardqty = 0;
            var Saleqty = 0;
            var Clo_Bal = 0;
            var PrevClo_Bal = 0;
            var sno = 0;
            var IndDate = 0;
            var rows = $("#myTable tr:gt(0)");
            var rowsno = 1;
            var count = 0;
            $(rows).each(function (i, obj) {
                Productid = $(this).find('#spnProductid').text();
                Productname = $(this).find('#spnProductName').text();
                IndDate = $(this).find('#spnDate').text();

                PrevOp_Bal = parseFloat($(this).find('#spn_PrevOpBal').text());
                Inwardqty = parseFloat($(this).find('#txt_Inwardqty').val());
                PrevInwardqty = parseFloat($(this).find('#txt_PrevInwardqty').text());
                Saleqty = parseFloat($(this).find('#txt_Saleqty').val());
                PrevSaleqty = parseFloat($(this).find('#txt_PrevSaleqty').text());
                if (count == 0) {
                    Clo_Bal = parseFloat($(this).find('#txt_CloBal').val());
                    Op_Bal = parseFloat($(this).find('#spn_OpBal').text());
                }
                else {
                    Clo_Bal = presentClosing;
                    Op_Bal = PresentOpening;
                }
                PrevClo_Bal = parseFloat($(this).find('#txt_PrevCloBal').text());
                sno = parseFloat($(this).find('#txt_Sno').val());

                if (Inwardqty != PrevInwardqty || Saleqty != PrevSaleqty) {

                    if (PrevClo_Bal != Clo_Bal) {
                        if (count == 0) {
                            Op_Bal = PrevOp_Bal;
                            Clo_Bal = PrevOp_Bal + Inwardqty - Saleqty;
                        }
                        else {
                            Clo_Bal = Op_Bal + Inwardqty - Saleqty;
                        }

                        presentClosing = Clo_Bal;
                        PresentOpening = Clo_Bal;
                        count++;
                    }
                    else {
                        Clo_Bal = Op_Bal + Inwardqty - Saleqty;
                        //Op_Bal = Clo_Bal;
                    }
                }
                else {

                    if (PrevClo_Bal != Clo_Bal) {
                        if (count == 0) {
                            Op_Bal = PrevOp_Bal;
                            Clo_Bal = Clo_Bal;
                        }
                        else {
                            Clo_Bal = Op_Bal + Inwardqty - Saleqty;
                        }

                        presentClosing = Clo_Bal;
                        PresentOpening = Clo_Bal;
                        count++;
                    }
                    else {
                        Clo_Bal = Clo_Bal;
                        //Op_Bal = Clo_Bal;
                    }
                }
                sno = $(this).find('#txt_Sno').val();
                DataTable1.push({ 'Op_Bal': Op_Bal, 'productname': Productname, 'productid': Productid, 'inwardqty': Inwardqty, 'saleqty': Saleqty, 'Clo_Bal': Clo_Bal, 'sno': sno, 'IndDate': IndDate });//, freigtamt: freigtamt
                rowsno++;
            });
            var results = '<div  style="overflow:auto;"><table id="myTable" class="table table-bordered table-hover dataTable no-footer">';
            results += '<thead><tr><th scope="col" >Sno</th><th scope="col">Date</th><th scope="col">ProductName</th><th scope="col">Opening</th><th scope="col">InwardQty</th><th scope="col">SaleQty</th><th scope="col">Closing</th><th scope="col"></th></tr></thead></tbody>';
            for (var i = 0; i < DataTable1.length; i++) {
                results += '<tr><td scope="row" class="1" style="text-align:center;" id="txtsno">' + i + '</td>';
                results += '<th scope="row" id="spnProductid" class="clsProductid" style="width:65px;display:none;">' + DataTable1[i].productid + '</th>';
                results += '<td id="spnDate" class="clsDate">' + DataTable1[i].IndDate + '</td>';
                results += '<td id="spnProductName" class="clsProductName">' + DataTable1[i].productname + '</td>';
                results += '<td class="4"><span id="spn_OpBal" class="clsOp">' + parseFloat(DataTable1[i].Op_Bal).toFixed(2) + '</span></td>';
                results += '<td id="spn_PrevOpBal" class="clsPrevOp" style="width:65px;display:none;">' + parseFloat(DataTable1[i].Op_Bal).toFixed(2) + '</td>';
                results += '<td><input  id="txt_Inwardqty" class="clsInwardqty" style="width:65px;" value="' + parseFloat(DataTable1[i].inwardqty).toFixed(2) + '"/></td>';
                results += '<td id="txt_PrevInwardqty" class="clsPrevInwardqty" style="width:65px;display:none;">' + parseFloat(DataTable1[i].inwardqty).toFixed(2) + '</td>';
                results += '<td><input id="txt_Saleqty" class="clsSaleqty" style="width:65px;" value="' + parseFloat(DataTable1[i].saleqty).toFixed(2) + '"/></td>';
                results += '<td id="txt_PrevSaleqty" class="clsPrevSaleqty" style="width:65px;display:none;">' + parseFloat(DataTable1[i].saleqty).toFixed(2) + '</td>';
                results += '<td><input  id="txt_CloBal" class="clsCloBal" style="width:65px;" value="' + parseFloat(DataTable1[i].Clo_Bal).toFixed(2) + '"/></td>';
                results += '<td id="txt_PrevCloBal" class="clsPrevCloBal" style="width:65px;display:none;">' + parseFloat(DataTable1[i].Clo_Bal).toFixed(2) + '</td>';
                results += '<td><input  id="txt_Sno" class="8" style="width:65px;display:none;"  value="' + DataTable1[i].sno + '"/></td>';
                results += '<td style="display:none" class="4">' + i + '</td></tr>';
            }
            results += '</table></div>';
            $("#div_BrandData").html(results);
        }

        var inwardqty = 0; var saleqty = 0; var closingamt = 0;
        let increment = 0; var op = 0;
        function calTotal_gst() {

            var $row = $(this).closest('tr'),
                inwardqty = parseFloat($row.find('.clsInwardqty').val(),) || 0
            op = parseFloat($row.find('.clsOp').text(),) || 0
            Prevamt = parseFloat($row.find('.clsPrevCloBal').val(),) || 0
            Presentamt = parseFloat($row.find('.clsCloBal').val(),) || 0

            saleqty = parseFloat($row.find('.clsSaleqty').val(),) || 0

            closingamt = op + inwardqty - saleqty;
            $row.find('.clsCloBal').val(parseFloat(closingamt).toFixed(2));
            //if (Presentamt != Prevamt) {
            //    closingamt = Presentamt;
            insertrow();
            //}
        }
        var inwardqty1 = 0; var op = 0; var saleqty1 = 0; var closingamt1 = 0;
        function calClosing() {

            var $row = $(this).closest('tr'),
                inwardqty1 = parseFloat($row.find('.clsSaleValue').val(),) || 0
            op1 = parseFloat($row.find('.clsOp').text(),) || 0
            saleqty1 = parseFloat($row.find('.clsSaleqty').val(),) || 0
            var ClosingAmount = parseFloat($row.find('.clsCloBal').val(),) || 0

            closingamt1 = ClosingAmount;
            $row.find('.clsCloBal').val(parseFloat(closingamt1).toFixed(2));
            //if (Presentamt != Prevamt) {
            //    closingamt = Presentamt;
            insertrow();
            //}
        }

        //var filldetails = [];
        //function btnUpdate_Click() {
        //    $('#myTable> tbody > tr').each(function () {
        //        var Op_Bal = $(this).find('#spn_OpBal').text();
        //        var Inwardqty = $(this).find('#txt_Inwardqty').val();
        //        var Saleqty = $(this).find('#txt_Saleqty').val();
        //        var Clo_Bal = $(this).find('#txt_CloBal').val();
        //        var sno = $(this).find('#txt_Sno').val();
        //        var Date = $(this).find('#spnDate').text();
        //        var productid = $(this).find('#spnProductid').text();
        //        filldetails.push({ 'opp_balance': Op_Bal, 'inwardqty': Inwardqty, 'saleqty': Saleqty, 'clo_balance': Clo_Bal, 'sno': sno, 'doe': Date, 'productid': productid });//, 'freigtamt': freigtamt
        //    });
        //    var Data = { 'op': 'Edit_Item_Bal_Trans', 'filldetails': filldetails };
        //    var s = function (msg) {
        //        if (msg) {
        //            filldetails = [];
        //            alert(msg);
        //            btn_Get_Bal_Details();
        //            if (msg == "Session Expired") {
        //                window.location = "Login.aspx";
        //            }
        //        }
        //        else {
        //        }
        //    };
        //    var e = function (x, h, e) {
        //    };
        //    CallHandlerUsingJson(Data, s, e);
        //}


        var filldetails = [];
        function btnUpdate_Click() {
            $('#myTable> tbody > tr').each(function () {
                var Op_Bal = $(this).find('#spn_OpBal').text();
                var Inwardqty = $(this).find('#txt_Inwardqty').val();
                var Saleqty = $(this).find('#txt_Saleqty').val();
                var Clo_Bal = $(this).find('#txt_CloBal').val();
                var sno = $(this).find('#txt_Sno').val();
                var Date = $(this).find('#spnDate').text();
                var productid = $(this).find('#spnProductid').text();
                filldetails.push({ 'opp_balance': Op_Bal, 'inwardqty': Inwardqty, 'saleqty': Saleqty, 'clo_balance': Clo_Bal, 'sno': sno, 'doe': Date, 'productid': productid });//, 'freigtamt': freigtamt
            });
            var Data = { 'op': 'Edit_Item_Bal_Trans', 'filldetails': filldetails };
            var s = function (msg) {
                if (msg) {
                    filldetails = [];
                    alert(msg);
                    btn_Get_Bal_Details();
                    if (msg == "Session Expired") {
                        window.location = "Login.aspx";
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            CallHandlerUsingJson(Data, s, e);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <section class="content-header">
        <h1>Edit Indent<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Operations</a></li>
            <li><a href="#">Edit Indent</a></li>
        </ol>
    </section>
   <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="fa fa-cog"></i>AgentEditBalance
                </h3>
            </div>
            <div class="box-body">
                <table>
                    <tr>
                        <td>
                            <select id="ddlBranchName" class="form-control">
                                </select>
                        </td>

                        <td style="width: 5px;"></td>
                        <td>
                            <select id="slctcategory" class="form-control" onchange="ddlcategorycange()">
                            </select>
                        </td>
                        <td style="width: 5px;"></td>
                        <td>
                            <select id="slctsubcategory" class="form-control" onchange="ddlsubcategorycange()">
                            </select>
                        </td>
                        
                        <td style="width: 5px;"></td>
                        <td>
                             <select id="slctProductName" class="form-control">
                            </select>
                        </td>
                        <td style="width: 5px;"></td>
                        <td>
                            <input type="date" id="txtFrom_date" class="form-control" />
                        </td>
                        <td style="width: 5px;"></td>
                        <td>
                            <input type="date" id="txtTo_date" class="form-control" />
                        </td>
                        <td style="width: 5px;"></td>
                        <td>
                            <button type="button" class="btn btn-primary" style="margin-right: 5px;" onclick="btn_Get_Bal_Details()">
                                <i class="fa fa-refresh"></i>Get Details
                            </button>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <br />
                <div id="div_BrandData">
                </div>
                <div style="text-align:center">
                <button type="button" class="btn btn-primary" style="margin-right: 5px;" onclick="btnUpdate_Click()">
                    <i class="fa fa-refresh"></i>Save
                </button>
                    </div>
            </div>
        </div>
    </section>
</asp:Content>

