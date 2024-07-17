<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="distibutorindentapproval.aspx.cs" Inherits="distibutorindentapproval" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(function () {
            var date = new Date();
            var day = date.getDate() - 1;
            var month = date.getMonth() + 1;
            var year = date.getFullYear();
            if (month < 10) month = "0" + month;
            if (day < 10) day = "0" + day;
            today = year + "-" + month + "-" + day;
            $('#txtfromdate').val(today);
            document.getElementById("txtfromdate").setAttribute("min", today);
        });
        var avail_stores;
        var qty;
        $(document).click(function () {
            $('#tabledetails').on('change', '.price', calTotal)
                  .on('change', '.quantity', calTotal);
            function calTotal() {
                var $row = $(this).closest('tr'),
                price = $row.find('.price').val(),
                quantity = $row.find('.quantity').val(),
                qty = parseFloat(quantity);
                total = price * qty;
                $row.find('#spntotal').text(total);
                clstotalval();
            }
        });

        function clstotalval() {
            var totaamount = 0; //var totalpfamount = 0;
            $('.clstotal').each(function (i, obj) {
                var totlclass = $(this).html();
                if (totlclass == "" || totlclass == "0") {
                }
                else {
                    totaamount += parseFloat(totlclass);
                }
            });
            var totalamount1 = parseFloat(totaamount);
            var freight = 0;
            var grandtotal = parseFloat(totalamount1) + parseFloat(freight);
            var grandtotal1 = grandtotal.toFixed(2);
            var diff = 0;
            if (grandtotal > grandtotal1) {
                diff = grandtotal - grandtotal1;
            }
            else {
                diff = grandtotal1 - grandtotal;
            }
            document.getElementById('spn_st_amt').innerHTML = parseFloat(grandtotal).toFixed(2);
            document.getElementById('spn_roundoffamt').innerHTML = parseFloat(diff).toFixed(2);
            document.getElementById('spn_total_amount').innerHTML = parseFloat(grandtotal1).toFixed(2);
        }

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

        function get_agentindent_details() {
            var agentid = document.getElementById('slctdistname').value;
            var date = document.getElementById('txtfromdate').value;
            var data = { 'op': 'get_agentindent_details', 'agentid': agentid, 'date': date };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillindentdetails(msg);
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
        function fillindentdetails(msg) {
            var results = '<div class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tabledetails">';
            results += '<thead><tr role="row"><th>Sno</th><th scope="col">Item Name</th><th scope="col">Qty</th><th scope="col">Price</th><th scope="col">Total Value</th><th>UOM</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr>';
                results += '<td scope="row" class="1" >' + k + '</td>';
                results += '<td scope="row" class="2" style="text-align: center; font-weight: bold;" ><span class="sname" id="spn_Productname">' + msg[i].productname + '</span></td>';
                results += '<td style="text-align: center;"><input id="txt_quantity" type="text" class="quantity" value="' + msg[i].Unitsqty + '" name="quantity"/></td>';
                results += '<td style="text-align: center;"><input id="txt_perunitrs" type="text" class="price" value="' + msg[i].UnitCost + '" name="price" readonly/></td>';
                var price = parseFloat(msg[i].UnitCost);
                var qty = parseFloat(msg[i].Unitsqty);
                var value = price * qty;
                results += '<td style="text-align: center;"><span class="clstotal" id="spntotal">' + parseFloat(value).toFixed(2) + '</span></td>';
                results += '<td scope="row" class="6" style="text-align: center; font-weight: bold;" >' + msg[i].uim + '</td>';
                results += '<td style="display:none" scope="row" class="17" style="text-align: center; font-weight: bold;" ><span class="sindent" id="spn_indentno">' + msg[i].IndentNo + '</span></td>';
                results += '<td style="display:none" class="16"><input id="hdnsno" type="hidden" value="' + msg[i].Productsno + '"></td></tr>';
            }
            results += '</table></div>';
            $("#divparlordata").html(results);
            clstotalval();
        }
        function btnsave_click() {
            var BranchID = document.getElementById('slctdistname').value;
            var btnval = document.getElementById('btnsave').value;
            var rows = $("#tabledetails tr:gt(0)");
            var itemlist = [];
            var offerdata = [];
            var txtsno = 0;
            var rowsno = 1;
            var taxtype = 0;
            var perunittax = 0;
            var igst = 0;
            var dis = 0;
            var tax = 0;
            var edtax = 0;
            var ofd = 0;
            var totqaty = 0;
            var indentno;
            $(rows).each(function (i, obj) {
                if ($(this).find('#txt_quantity').val() != "") {
                    txtsno = rowsno;
                    productname = $(this).find('#spn_Productname').text();
                    indentno = $(this).find('#spn_indentno').text();
                    Quantity = $(this).find('#txt_quantity').val();
                    totqaty += parseFloat(Quantity);
                    price = $(this).find('#txt_perunitrs').val();
                    productid = $(this).find('#hdnsno').val();
                    itemlist.push({ Sno: txtsno, productname: productname, UnitCost: price, Unitsqty: Quantity, Productsno: productid, IndentNo: indentno });
                    rowsno++;
                }
            });
            var totalqty = totqaty;
            offerdata.push({ Unitsqty: ofd, Product: ofd });
            if (itemlist.length == 0) {
                alert("Please Select Items Names");
                return false;
            }
            var Data = { 'op': 'btnOrdereditClick', 'data': itemlist, 'offerdata': offerdata, 'btnval': btnval, 'BranchID': BranchID, 'totqty': totalqty };
            var s = function (msg) {
                if (msg) {
                    alert(msg);
                }
            }
            var e = function (x, h, e) {
            };
            CallHandlerUsingJson(Data, s, e);
        }
        function forclearall() {
            scrollTo(0, 0);
            document.getElementById('slctcmp').value = "";
            document.getElementById('slctbranch').value = "";
            document.getElementById('txtparlorname').value = "";
            document.getElementById('txtparlorcode').value = "";
            document.getElementById('slctparlortype').value = "";
            document.getElementById('txtpramotername').value = "";
            document.getElementById('slctstate').value = "";
            document.getElementById('txtmobileno').value = "";
            document.getElementById('txtemail').value = "";
            document.getElementById('txtpanno').value = "";
            document.getElementById('txttinno').value = "";
            document.getElementById('txtcstno').value = "";
            document.getElementById('txtgstin').value = "";
            document.getElementById('slctregtype').value = "";
            document.getElementById('txttallyledger').value = "";
            document.getElementById('txtsapledger').value = "";
            document.getElementById('txtsapledgercode').value = "";
            document.getElementById('txtaddress').value = "";
            document.getElementById('lbl_sno').innerHTML = "";
            document.getElementById('slctcstatus').selectedIndex = 0;
            document.getElementById('btnsave').value = "Save";
            $("#lbl_code_error_msg").hide();
            $("#lbl_name_error_msg").hide();
            get_parlor_details();
            $('#div_BankData').show();
            $('#Bankfillform').show();
        }


        function getedit(thisid) {
            scrollTo(0, 0);
            var parlorname = $(thisid).parent().parent().children('.2').html();
            var parlortype = $(thisid).parent().parent().children('.3').html();
            var phone = $(thisid).parent().parent().children('.4').html();
            var emailid = $(thisid).parent().parent().children('.5').html();
            var gstin = $(thisid).parent().parent().children('.6').html();
            var regtype = $(thisid).parent().parent().children('.7').html();
            var pramotername = $(thisid).parent().parent().children('.8').html();
            var status = $(thisid).parent().parent().children('.9').html();
            var address = $(thisid).parent().parent().children('.10').html();
            var tinno = $(thisid).parent().parent().children('.11').html();
            var cstno = $(thisid).parent().parent().children('.12').html();
            var stateid = $(thisid).parent().parent().children('.13').html();
            var parlorcode = $(thisid).parent().parent().children('.14').html();
            var panno = $(thisid).parent().parent().children('.15').html();
            var sno = $(thisid).parent().parent().children('.16').html();
            var cmpid = $(thisid).parent().parent().children('.17').html();
            var lid = $(thisid).parent().parent().children('.18').html();
            var tallyledger = $(thisid).parent().parent().children('.19').html();
            var sapledger = $(thisid).parent().parent().children('.20').html();
            var sapledgercode = $(thisid).parent().parent().children('.21').html();
            if (status == "Enabled") {
                status = "0";
            }
            else {
                status = "1";
            }
            document.getElementById('slctcmp').value = cmpid;
            document.getElementById('slctbranch').value = lid;
            document.getElementById('txtparlorname').value = parlorname;
            document.getElementById('txtparlorcode').value = parlorcode;
            document.getElementById('slctparlortype').value = parlortype;
            document.getElementById('txtpramotername').value = pramotername;
            document.getElementById('slctstate').value = stateid;
            document.getElementById('txtmobileno').value = phone;
            document.getElementById('txtemail').value = emailid;
            document.getElementById('txtpanno').value = panno;
            document.getElementById('txttinno').value = tinno;
            document.getElementById('txtcstno').value = cstno;
            document.getElementById('txtgstin').value = gstin;
            document.getElementById('slctregtype').value = regtype;
            document.getElementById('txttallyledger').value = tallyledger;
            document.getElementById('txtsapledger').value = sapledger;
            document.getElementById('txtsapledgercode').value = sapledgercode;
            document.getElementById('txtaddress').value = address;
            document.getElementById('btnsave').value = "Modify";
            document.getElementById('lbl_sno').innerHTML = sno;
            document.getElementById('slctcstatus').value = status;
            $('#divitem').css('display', 'block');
            $('#divbind').css('display', 'none');
        }

        function get_state_details() {
            var data = { 'op': 'get_state_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillstatedetails(msg);
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
        function fillstatedetails(msg) {
            var data = document.getElementById('slctstate');
            var length = data.options.length;
            document.getElementById('slctstate').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select State";
            opt.value = "Select State";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            data.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].statename != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].statename;
                    option.value = msg[i].sno;
                    data.appendChild(option);
                }
            }
        }
        function get_gstregtype_details() {
            var data = { 'op': 'get_gstregtype_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillregdetails(msg);
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
        function fillregdetails(msg) {
            var data = document.getElementById('slctregtype');
            var length = data.options.length;
            document.getElementById('slctregtype').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select RegType";
            opt.value = "Select State";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            data.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].gstregtype != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].gstregtype;
                    option.value = msg[i].sno;
                    data.appendChild(option);
                }
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        $('body').addClass('skin-green sidebar-collapse sidebar-mini pos');
    </script>
    <section class="content">
        <div class="row" id="divitem">
            <div class="col-xs-12">
                <div class="box box-primary">
                    <div class="box-header">
                        <h3 class="box-title">
                            Distibuter Indent Edit</h3>
                    </div>
                    <div class="box-body">
                        <div class="col-lg-12">
                            <div class="clearfix">
                            </div>
                            <div class="row">
                                <div class="col-md-10 col-sm-10">
                                    <div class="well well-sm col-sm-12">
                                        <table>
                                            <tbody>
                                                <tr>
                                                <td>
                                                        <label for="print_bill">
                                                           Distributor Name</label>
                                                        <select class="form-control" id="slctdistname" required="required" 
                                                            aria-hidden="true">
                                                            <option value="0">Select</option>
                                                            <option value="3897">Srinivasa MIlk Dist (Rotari Nagar)</option>
                                                            <option value="3898">Srinivasa MIlk Dist (Srinivasa Rao Ballepalli</option>
                                                            <option value="3899">Srinivasa MIlk Dist (vdos colony)</option>
                                                            <option value="3901">Srinivasa MIlk Dist (Indira Nagar)</option>
                                                            <option value="3902">Srinivasa MIlk Dist (mustafa nagar)</option>
                                                            <option value="3903">Srinivasa MIlk Dist (Gandhi Chowk_Johny)</option>
                                                            <option value="3905">Srinivasa MIlk Dist (kasba bazar)</option>
                                                            <option value="5355">Srinivasa MIlk Dist (Mustafanagar_murali)</option>
                                                            <option value="6043">Srinivasa MIlk Dist (AMMENA-KHANAPURAM)</option>
                                                            <option value="6100">Srinivasa MIlk Dist (Vazeer Maramma Temple)</option>
                                                            <option value="6125">Srinivasa MIlk Dist (SHAIK MOULALI )</option>
                                                            <option value="6484">Srinivasa MIlk Dist (SRI BALAJI DISTRIBUTER-B</option>
                                                            <option value="7462">Srinivasa Milk Distributors - Kmm</option>
                                                            <option value="8430">Srinivasa MIlk Dist (Lakshminarayana Milk Dis</option>
                                                        </select>
                                                    </td>
                                                    <td style="width: 10%;">
                                                    </td>
                                                    <td>
                                                        <label for="print_bill">
                                                           Date</label>
                                                            <input type="date" id="txtfromdate" class="form-control" />
                                                    </td>
                                                    <td style="width: 10%;">
                                                   
                                                    </td>
                                                    <td>
                                                        <br>
                                                        <input type="button" value="Get Details" class="btn btn-primary" id="btngenarate"
                                                            onclick="get_agentindent_details();">
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div id="divparlordata">
                                </div>


                                <div>
                            <table class="table table-bordered table-hover dataTable no-footer" style="width:100%;">
                                <tbody>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td colspan="2">
                                        <label style="font-size: 13px;">
                                             AMOUNT :</label>
                                    </td>
                                    <td>
                                        <span id="spn_st_amt" style="font-size: 12px;"></span>
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
                                        <span id="spn_roundoffamt" style="font-size: 12px;">0.00</span>
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
                                        <span id="spn_total_amount" class="tdheading"></span>
                                    </td>
                                </tr>
                            </tbody></table>
                        </div>
                                <div style="text-align: center;">
                                    <input type="submit" name="update" value="Save" class="btn btn-primary" id="btnsave"
                                        onclick="btnsave_click();">
                                    <input type="button" name="update" value="Close" class="btn btn-primary" id="btnclose"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="box-body">
            </div>
            <div hidden="">
                <label id="lbl_sno">
                </label>
            </div>
        </div>
    </section>
</asp:Content>


