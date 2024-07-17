<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="vocherform.aspx.cs" Inherits="vocherform" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style type="text/css">
        .ui-autocomplete
        {
            max-height: 100px;
            overflow-y: auto; /* prevent horizontal scrollbar */
            overflow-x: hidden; /* add padding to account for vertical scrollbar */
            z-index: 1000 !important;
        }
        .custom-combobox
        {
            position: relative;
            display: inline-block;
        }
        .custom-combobox-toggle
        {
            position: absolute;
            top: 0;
            bottom: 0;
            margin-left: -1px;
            padding: 0;
        }
        .custom-combobox-input
        {
            margin: 0;
            height: 35px;
            width: 250px;
        }
        .removeclass
        {
            background: #fd2053 !important;
            border-radius: 100% !important;
            padding: 0px !important;
            height: 30px !important;
            width: 30px !important;
            color: #ffffff !important;
            border-color: #fd2053 !important;
        }
        .prntcls
        {
            background: #00c0ef !important;
            border-radius: 100% !important;
            padding: 0px !important;
            height: 30px !important;
            width: 30px !important;
            color: #ffffff !important;
            border-color: #00c0ef !important;
        }
        .editcls
        {
            background: #00a65a !important;
            border-radius: 100% !important;
            padding: 0px !important;
            height: 30px !important;
            width: 30px !important;
            color: #ffffff !important;
            border-color: #00a65a !important;
        }
    </style>
<script type="text/javascript">
    function divRaiseVoucherClick() {
        $('#divRaiseVoucher').css('display', 'block');
        $('#divViewVoucher').css('display', 'none');
        $('#divVocherPayable').css('display', 'none');
        $('#div_raisevoucher').css('display', 'none');
    }
    function BtnclearClick() {
        $('#divRaiseVoucher').css('display', 'none');
        $('#divViewVoucher').css('display', 'block');
        $('#divVocherPayable').css('display', 'none');
        $('#div_raisevoucher').css('display', 'block');
        $('#divMainAddNewRows').css('display', 'none');
        var LevelType = '<%=Session["LevelType"] %>';
        if (LevelType == "AccountsOfficer" || LevelType == "Director") {
            $('#divSOffice').css('display', 'block');
            Fillso();
            $('#div_vivegeneratedet').css('display', 'block');
            $('#divViewVoucher').css('display', 'block');
        }
        else {
            $('#divSOffice').css('display', 'none');
            $('#div_vivegeneratedet').css('display', 'none');
            divViewVoucherClick();
            BtnGenerateClick();
            $('#divViewVoucher').css('display', 'block');
        }
        document.getElementById("ddlVoucherType").selectedIndex = 0;
        document.getElementById("btnSave").value = "Raise";
        document.getElementById("spnVoucherID").innerHTML = "";
        document.getElementById("txtdesc").value = "";
        document.getElementById("txtRemarks").value = "";
        document.getElementById("ddlEmpApprove").selectedIndex = 0;
        document.getElementById("txtAMount").innerHTML = "";
        document.getElementById("txtCashAmount").value = "";

        Cashform = [];


        $("#divHeadAcount").html("");
        document.getElementById("combobox").value = "";
        //            $('#combobox').focus().val('');
        //$('#combobox').autocomplete('');

    }
    function BtnPayVoucher_close() {
        $('#divRaiseVoucher').css('display', 'none');
        $('#divViewVoucher').css('display', 'block');
        $('#divVocherPayable').css('display', 'none');
        $('#div_raisevoucher').css('display', 'block');
        $('#divMainAddNewRows').css('display', 'none');
        var LevelType = '<%=Session["LevelType"] %>';
        if (LevelType == "AccountsOfficer" || LevelType == "Director") {
            $('#divSOffice').css('display', 'block');
            Fillso();
            $('#div_vivegeneratedet').css('display', 'block');
            $('#divViewVoucher').css('display', 'block');
        }
        else {
            $('#divSOffice').css('display', 'none');
            $('#div_vivegeneratedet').css('display', 'none');
            divViewVoucherClick();
            BtnGenerateClick();
            $('#divViewVoucher').css('display', 'block');
        }
    }
    function divViewVoucherClick() {
        $('#divRaiseVoucher').css('display', 'none');
        $('#divViewVoucher').css('display', 'block');
        $('#divVoucherGrid').css('display', 'block');
        $('#divVocherPayable').css('display', 'none');
        $('#divVarifyVoucher').css('display', 'none');
        $('#printvoucher').css('display', 'none');
        $('#divMainAddNewRows').css('display', 'none');
        var LevelType = '<%=Session["LevelType"] %>';
        if (LevelType == "AccountsOfficer" || LevelType == "Director") {
            $('#divSOffice').css('display', 'block');
            Fillso();
        }
        else {
            $('#divSOffice').css('display', 'none');
        }
    }
    function ddlVoucherTypeChange() {
        var VoucherType = document.getElementById("ddlVoucherType").value;
        var LevelType = '<%=Session["LevelType"] %>';
        if (VoucherType == "Debit") {
            if (LevelType == "AccountsOfficer" || LevelType == "Director") {
            }
            else {
                $('.divAprovalEmp').css('display', 'table-row');
            }
            $('.divType').css('display', 'none');
            $('#spnsalary').css('display', 'none');
            $('.divdType').css('display', 'block');
        }
        if (VoucherType == "Credit") {
            $('.divAprovalEmp').css('display', 'none');
            $('.divType').css('display', 'table-row');
            $('#spnsalary').css('display', 'none');
            $('.divdType').css('display', 'none');
        }
        if (VoucherType == "Due") {
            if (LevelType == "AccountsOfficer" || LevelType == "Director") {
            }
            else {
                $('.divAprovalEmp').css('display', 'table-row');
            }
            $('.divType').css('display', 'table-row');
            $('#spnsalary').css('display', 'none');
            $('.divdType').css('display', 'none');
        }
        if (VoucherType == "SalaryAdvance" || VoucherType == "SalaryPayble") {
            $('.transactionclass').css('display', 'table-row');
            $('.divdType').css('display', 'none');
        }
        else {
            $('.transactionclass').css('display', 'none');

        }
        $('#spnsalary').css('display', 'block');
    }
</script>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <section class="content">
    <div class="row"  id="divitem">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">Vocher Form</h3>
                </div>
                <div class="box box-info">
            <div class="box-body">
                <div style="width: 100%; background-color: #fff">
                    <%--<div style="width: 100%; float: left;">
                        <a id="ancRaise" onclick="divRaiseVoucherClick();" style="width: 20%; font-size: 24px;
                            text-decoration: underline;">Raise Voucher</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <a id="ancView" onclick="divViewVoucherClick();"
                                style="padding-left: 25%; font-size: 24px; text-decoration: underline;">View Vouchers</a>
                    </div>--%>
                  <div id="div_raisevoucher" style="text-align: -webkit-right;" >
                   <table>
                        <tr>
                            <td>
                            </td>
                            <td>
                            <div class="input-group" style="cursor: pointer;">
                                <div class="input-group-addon">
                                <span  class="glyphicon glyphicon-plus-sign" onclick="divRaiseVoucherClick()"></span> <span onclick="divRaiseVoucherClick()">Raise Voucher</span>
                          </div>
                          </div>
                            </td>
                     </tr>
                     </table>
                </div>
                  <br />
                    <div id="divRaiseVoucher" style="display: none;"> 
                        <table align="center">
                            <tr class="divsalesOffice" style="display: none">
                                <td>
                                    Sales Office
                                </td>
                                <td style="height: 40px;">
                                    <select id="ddlsalesOffice" class="form-control" onchange="ddlSalesOfficeChange(this);">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Voucher Type
                                </td>
                                <td style="height: 40px;">
                                    <select id="ddlVoucherType" class="form-control" onchange="ddlVoucherTypeChange();">
                                        <option>Select</option>
                                        <option>Debit</option>
                                        <option>Credit</option>
                                        <option>Due</option>
                                        <option>SalaryAdvance</option>
                                        <option>SalaryPayble</option>
                                    </select>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td class="divType" style="display: none; height: 40px;">
                                    <select id="ddlCashType" class="form-control" onchange="ddlCashTypeChange(this);">
                                        <option>Select</option>
                                        <option>Cash</option>
                                        <option>Bills</option>
                                        <option>Others</option>
                                    </select>
                                </td>

                                <td class="divdType" style="display: none; height: 40px;">
                                    <select id="slctdebittype" class="form-control">
                                        <option>Cash</option>
                                        <option>Branch</option>
                                        <option>Bank</option>
                                    </select>
                                </td>
                            </tr>
                            <tr class="transactionclass" style="display: none;">
                                <td>
                                    Type Of Transaction
                                </td>
                                <td style="height: 40px;">
                                    <select id="ddltransactiontype" class="form-control" onchange="ddltransactiontypechanged();">
                                        <option>Select</option>
                                        <option>Employee</option>
                                        <option>Others</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Pay To
                                </td>
                                <td style="height: 40px;">
                                    <input type="text" id="txtdesc" class="form-control"    maxlength="45" placeholder="Enter PayTo" />
                                </td>
                                <td style="height: 40px;">
                              <input id="txtHiddenEName" type="hidden" class="form-control" name="HiddenName" />
                               <input id="txtHiddenOName" type="hidden" class="form-control" name="HiddenName" />
                              <input id="txthiddenempid" type="hidden" class="form-control" name="Hiddenempid" />
                               </td>

                               <td id="tdhidesalary" style="height: 40px;display:none;">
                                    <span id="spnsalary" class="form-control">
                                    </span>
                                </td>

                            </tr>
                           
                            <tr>
                                <td>
                                    Head Of Account
                                </td>
                               
                                   
                                    <td style="height: 40px;">
                                    <input type="text" id="combobox" class="form-control"    maxlength="45" placeholder="Select Head Of Account" />
                                </td>
                                    <%--<select id="combobox" class="form-control">
                                    </select>--%>
                                    <td>
                                 <input id="hidden_headid" type="hidden" class="form-control" name="hiddenheadid" />
                               </td>
                                <td style="width:6px;">
                                </td>
                                <td>
                                    <input type="number" id="txtCashAmount" class="form-control" placeholder="Enter Amount" onkeyup="cashamountchange(this);"/>
                                </td>
                                <td>
                                    <%--<input type="button" id="Button3" value="Add" onclick="BtnCashToAddClick();" class="btn btn-primary" />--%>
                                    <button type="button" title="Click Here To Add!" class="btn btn-info btn-outline btn-circle btn-lg m-r-5 prntcls"   onclick="BtnCashToAddClick();">
                                    <span class="glyphicon glyphicon-plus" style="top: 0px !important;"></span></button>
                                </td>
                            </tr>
                            <tr>
                                <td rowspan="1" colspan="2">
                                    <div id="divHeadAcount">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Amount
                                </td>
                                <td style="height: 40px;">
                                    <span id="txtAMount" class="form-control"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Remarks
                                </td>
                                <td style="height: 40px;">
                                    <textarea rows="5" cols="45" id="txtRemarks" class="form-control" maxlength="2000"
                                        placeholder="Enter Remarks"></textarea>
                                </td>
                            </tr>
                            <tr class="divAprovalEmp" style="display: none">
                                <td>
                                    Requested For Aproval
                                </td>
                                <td style="height: 40px;">
                                    <select id="ddlEmpApprove" class="form-control">
                                    </select>
                                </td>
                            </tr>
                            
                            <tr style="display: none">
                                <td>
                                    Voucher ID
                                </td>
                                <td>
                                    <span id="spnVoucherID" class="Spancontrol"></span>
                                </td>
                            </tr>
                        </table>
                        <table align="center">
                            <tr>
                                <td style="display: block;">
                                </td>
                                <td style="height: 40px;">
                                    <input type="button" id="btnSave" value="Raise" onclick="BtnRaiseVoucherClick();"
                                        class="btn btn-primary" />
                                </td>
                                <td style="width:3%;">
                                </td>
                                <td style="height: 40px;">
                                    <input type="button" id="btnClear" value="Close" onclick="BtnclearClick();"
                                        class="btn btn-danger" />
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div id="divViewVoucher" style="display:block;">
                         <div id="divVoucherGrid">
                         <table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="example2_info"><tbody>
                         <tr style="background-color:#7ac8f5;font-size: 14px;" class="trbgclrcls">
                                     <th scope="col" style="text-align:center;font-weight: 600;width: 51px;">
                                        Voucher ID
                                    </th>
                                    <th scope="col" style="text-align:center;font-weight: 600;width: 60px;">
                                        Voucher Type
                                    </th>
                                    <th scope="col" style="text-align:center;font-weight: 600;width: 150px;">
                                        Cash To
                                    </th>
                                    <th scope="col" style="text-align:center;font-weight: 600;width: 50px;">
                                         Amount
                                    </th>
                                    <th scope="col" style="text-align:center;font-weight: 600;width: 69px;">
                                        Approve By
                                    </th>
                                    <th scope="col" style="text-align:center;font-weight: 600;width: 54px;">
                                        Status
                                    </th>
                                    <th scope="col" style="text-align:center;font-weight: 600;width: 673px;">
                                        Approval Remarks
                                    </th>
                                </tr>
                         <tr><td scope="row" class="50" style="text-align:center; display:none;">3648</td><td scope="row" class="1" style="text-align:center;font-size: 13px;width: 51px;">196977</td><td scope="row" class="2" style="text-align:center;font-size: 13px;width: 60px;">Debit</td><td scope="row" class="8" style="display:none;">172</td><td data-title="brandstatus" style="text-align:center;font-size: 13px;width: 150px;" class="9">Purchase of Store Materials.Nil Tax</td><td data-title="brandstatus" style="text-align:center;font-size: 13px;width: 50px;" class="3">4700</td><td data-title="brandstatus" style="text-align:center;font-size: 13px;width: 69px;" class="4"> Apurva Chavda</td><td data-title="brandstatus" style="display:none;" class="5"></td><td data-title="brandstatus" style="text-align:center;font-size: 13px;width: 54px;" class="6">Raised</td><td data-title="brandstatus" style="display:none;" class="10">192</td><td data-title="brandstatus" style="display:none;" class="11"></td><td data-title="brandstatus" style="text-align:center;font-size: 13px;" class="12">Being the cash paid to Mr P.Ramanaiah(pbk).  Purpose of purchase of Fire Wood 1880kg's -4700/-vied mrn no;516/09-07-19 for Boiler section purpose    Date : 24-07-2019  Total Amount 4700.00 i/b sameer sir</td><td data-title="brandstatus" style="display:none;" class="13">Mr P.Ramanaiah(pbk)</td><td data-title="brandstatus" style="display:none;" class="7"></td><td data-title="brandstatus"><button type="button" title="Click Here To Edit!" class="btn btn-info btn-outline btn-circle btn-lg m-r-5 prntcls" onclick="geteditdetails(this)"><span class="glyphicon glyphicon-edit" style="top: 0px !important;"></span></button></td><td data-title="brandstatus"><button type="button" title="Click Here To Print!" class="btn btn-info btn-outline btn-circle btn-lg m-r-5 prntcls" onclick="printvoucher(this)"><span class="glyphicon glyphicon-print" style="top: 0px !important;"></span></button></td><td data-title="brandstatus"><button type="button" title="Click Here To Pay!" class="btn btn-info btn-outline btn-circle btn-lg m-r-5 prntcls" style="background-color: #f39c12!important;border-color: #f39c12!important;" onclick="payvoucher(this)"><span class="glyphicon glyphicon-usd" style="top: 0px !important;"></span></button></td><td data-title="brandstatus"><button type="button" title="Click Here To Cancel!" class="btn btn-info btn-outline btn-circle btn-lg m-r-5 removeclass" onclick="cancelvoucher(this)"><span class="glyphicon glyphicon-remove-circle" style="top: 0px !important;"></span></button></td></tr><tr><td scope="row" class="50" style="text-align:center; display:none;">3649</td><td scope="row" class="1" style="text-align:center;font-size: 13px;width: 51px;">196984</td><td scope="row" class="2" style="text-align:center;font-size: 13px;width: 60px;">Debit</td><td scope="row" class="8" style="display:none;">172</td><td data-title="brandstatus" style="text-align:center;font-size: 13px;width: 150px;" class="9">Sales Maintenance -(Tirupathi)</td><td data-title="brandstatus" style="text-align:center;font-size: 13px;width: 50px;" class="3">125</td><td data-title="brandstatus" style="text-align:center;font-size: 13px;width: 69px;" class="4"> Apurva Chavda</td><td data-title="brandstatus" style="display:none;" class="5"></td><td data-title="brandstatus" style="text-align:center;font-size: 13px;width: 54px;" class="6">Raised</td><td data-title="brandstatus" style="display:none;" class="10">192</td><td data-title="brandstatus" style="display:none;" class="11"></td><td data-title="brandstatus" style="text-align:center;font-size: 13px;" class="12">Being the cash paid to Mr T Bhaskaraiah-Driver.  Purpose of   SVDS PUF-AP26TC5949 vehicle toll gate charges 125/-for pbk to Kadapa to pbk trip purpose    Date : 24-07-2019  Total Amount 125.00 i/b sameer sir</td><td data-title="brandstatus" style="display:none;" class="13">Mr T Bhaskaraiah-Driver</td><td data-title="brandstatus" style="display:none;" class="7"></td><td data-title="brandstatus"><button type="button" title="Click Here To Edit!" class="btn btn-info btn-outline btn-circle btn-lg m-r-5 editcls" onclick="geteditdetails(this)"><span class="glyphicon glyphicon-edit" style="top: 0px !important;"></span></button></td><td data-title="brandstatus"><button type="button" title="Click Here To Print!" class="btn btn-info btn-outline btn-circle btn-lg m-r-5 prntcls" onclick="printvoucher(this)"><span class="glyphicon glyphicon-print" style="top: 0px !important;"></span></button></td><td data-title="brandstatus"><button type="button" title="Click Here To Pay!" class="btn btn-info btn-outline btn-circle btn-lg m-r-5 prntcls" style="background-color: #f39c12!important;border-color: #f39c12!important;" onclick="payvoucher(this)"><span class="glyphicon glyphicon-usd" style="top: 0px !important;"></span></button></td><td data-title="brandstatus"><button type="button" title="Click Here To Cancel!" class="btn btn-info btn-outline btn-circle btn-lg m-r-5 removeclass" onclick="cancelvoucher(this)"><span class="glyphicon glyphicon-remove-circle" style="top: 0px !important;"></span></button></td></tr><tr><td scope="row" class="50" style="text-align:center; display:none;">3650</td><td scope="row" class="1" style="text-align:center;font-size: 13px;width: 51px;">197014</td><td scope="row" class="2" style="text-align:center;font-size: 13px;width: 60px;">Debit</td><td scope="row" class="8" style="display:none;">172</td><td data-title="brandstatus" style="text-align:center;font-size: 13px;width: 150px;" class="9">SVDS Tanker-AP29T9468</td><td data-title="brandstatus" style="text-align:center;font-size: 13px;width: 50px;" class="3">150</td><td data-title="brandstatus" style="text-align:center;font-size: 13px;width: 69px;" class="4"> Apurva Chavda</td><td data-title="brandstatus" style="display:none;" class="5"></td><td data-title="brandstatus" style="text-align:center;font-size: 13px;width: 54px;" class="6">Raised</td><td data-title="brandstatus" style="display:none;" class="10">192</td><td data-title="brandstatus" style="display:none;" class="11"></td><td data-title="brandstatus" style="text-align:center;font-size: 13px;" class="12">Being the cash paid to Mr K.Ramesh Reddy (Driver).  Purpose of  SVDS Tanker-AP29T9468 vehicle Air Checkup charges 150/-for pbk to Karimangalam to pbk trip purpose  Date : 24-07-2019  Total Amount 150.00 i/b sameer sir</td><td data-title="brandstatus" style="display:none;" class="13">Mr K.Ramesh Reddy (Driver)</td><td data-title="brandstatus" style="display:none;" class="7"></td><td data-title="brandstatus"><button type="button" title="Click Here To Edit!" class="btn btn-info btn-outline btn-circle btn-lg m-r-5 editcls" onclick="geteditdetails(this)"><span class="glyphicon glyphicon-edit" style="top: 0px !important;"></span></button></td><td data-title="brandstatus"><button type="button" title="Click Here To Print!" class="btn btn-info btn-outline btn-circle btn-lg m-r-5 prntcls" onclick="printvoucher(this)"><span class="glyphicon glyphicon-print" style="top: 0px !important;"></span></button></td><td data-title="brandstatus"><button type="button" title="Click Here To Pay!" class="btn btn-info btn-outline btn-circle btn-lg m-r-5 prntcls" style="background-color: #f39c12!important;border-color: #f39c12!important;" onclick="payvoucher(this)"><span class="glyphicon glyphicon-usd" style="top: 0px !important;"></span></button></td><td data-title="brandstatus"><button type="button" title="Click Here To Cancel!" class="btn btn-info btn-outline btn-circle btn-lg m-r-5 removeclass" onclick="cancelvoucher(this)"><span class="glyphicon glyphicon-remove-circle" style="top: 0px !important;"></span></button></td></tr><tr><td scope="row" class="50" style="text-align:center; display:none;">3651</td><td scope="row" class="1" style="text-align:center;font-size: 13px;width: 51px;">197021</td><td scope="row" class="2" style="text-align:center;font-size: 13px;width: 60px;">Debit</td><td scope="row" class="8" style="display:none;">172</td><td data-title="brandstatus" style="text-align:center;font-size: 13px;width: 150px;" class="9">Weighing Charges Tankers-Pbk</td><td data-title="brandstatus" style="text-align:center;font-size: 13px;width: 50px;" class="3">460</td><td data-title="brandstatus" style="text-align:center;font-size: 13px;width: 69px;" class="4"> Apurva Chavda</td><td data-title="brandstatus" style="display:none;" class="5"></td><td data-title="brandstatus" style="text-align:center;font-size: 13px;width: 54px;" class="6">Raised</td><td data-title="brandstatus" style="display:none;" class="10">192</td><td data-title="brandstatus" style="display:none;" class="11"></td><td data-title="brandstatus" style="text-align:center;font-size: 13px;" class="12">Being the cash paid to Mr K.Ramesh Reddy (Driver).  Purpose of   SVDS Tanker-AP09Y8199 vehicle weighing charges 160/-,air checkup 100/-,RTO Mamool 200/-for pbk to Karimangalam to pbk trip purpose Date : 24-07-2019  Total Amount 460.00 i/b sameer sir</td><td data-title="brandstatus" style="display:none;" class="13">Mr K.Ramesh Reddy (Driver)</td><td data-title="brandstatus" style="display:none;" class="7"></td><td data-title="brandstatus"><button type="button" title="Click Here To Edit!" class="btn btn-info btn-outline btn-circle btn-lg m-r-5 editcls" onclick="geteditdetails(this)"><span class="glyphicon glyphicon-edit" style="top: 0px !important;"></span></button></td><td data-title="brandstatus"><button type="button" title="Click Here To Print!" class="btn btn-info btn-outline btn-circle btn-lg m-r-5 prntcls" onclick="printvoucher(this)"><span class="glyphicon glyphicon-print" style="top: 0px !important;"></span></button></td><td data-title="brandstatus"><button type="button" title="Click Here To Pay!" class="btn btn-info btn-outline btn-circle btn-lg m-r-5 prntcls" style="background-color: #f39c12!important;border-color: #f39c12!important;" onclick="payvoucher(this)"><span class="glyphicon glyphicon-usd" style="top: 0px !important;"></span></button></td><td data-title="brandstatus"><button type="button" title="Click Here To Cancel!" class="btn btn-info btn-outline btn-circle btn-lg m-r-5 removeclass" onclick="cancelvoucher(this)"><span class="glyphicon glyphicon-remove-circle" style="top: 0px !important;"></span></button></td></tr></tbody></table>
                           
                        </div>
                        
                        
                        
                        
                        <table>
                            <tr>
                                <td>
                                    <div id="printvoucher" style="display: none;">
                                        <div id="divPrint">
                                            <div>
                                                <table style="width: 100%;">
                                                    <tr>
                                                        <td rowspan="2">
                                                            <img src="Images/Vyshnavilogo.png" alt="Vyshnavi" width="55px" height="25px" />
                                                        </td>
                                                        <td colspan="4">
                                                            <h4>
                                                                <span id="lblTitle"></span>
                                                            </h4>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="font-size: 10px; padding-left: 24%; text-decoration: underline;">
                                                            <span id="lblVoucherType"></span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <span style="font-size: 12px; float: right;">Voucher No:</span>
                                                        </td>
                                                        <td>
                                                            <b><span id="lblVoucherno"></span></b>
                                                        </td>
                                                        <td>
                                                            <span style="font-size: 12px; float: right;">Date:</span>
                                                        </td>
                                                        <td>
                                                            <b><span id="lblDate"></span></b>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <div>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <b>Pay To </b>
                                                            </td>
                                                            <td style="float: left;">
                                                                <b><span id="lblPayCash"></span></b>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: #f4f4f4;">
                                                            <td colspan="2" rowspan="1" style="width: 100%;">
                                                                <div id="divHead">
                                                                </div>
                                                            </td>
                                                            <td>
                                                            </td>
                                                        </tr>
                                                           <tr>
                                                            <td>
                                                                <b><span class="mylbl">Remarks:</span> </b>
                                                            </td>
                                                            <td style="float: left;">
                                                                <b><span id="lblRemarks"></span></b>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <b><span class="mylbl">Received Rs:</span> </b>
                                                            </td>
                                                            <td style="float: left;">
                                                                <b><span id="lblReceived"></span></b>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <br />
                                                <div>
                                                    <table style="width: 100%;">
                                                        <tr>
                                                            <td style="width: 20%;">
                                                                <span style="font-size: 12px;">Cashier</span>
                                                            </td>
                                                            <td style="width: 20%;">
                                                                <span style="font-size: 12px;">Verified By</span>
                                                            </td>
                                                            <td style="width: 20%;">
                                                                <span style="font-size: 12px;">Accounts officer</span>
                                                            </td>
                                                            <td style="width: 20%;">
                                                              <span style="font-size: 12px;" ID="lblApprove"></span>
                                                            </td>
                                                            <td style="width: 20%;">
                                                                <span style="font-size: 12px;">Receiver's Signature</span>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                        <br />
                                        <div>
                                        <table>
                                        <tr>
                                        <td>
                                        <button type="button" class="btn btn-primary" style="margin-right: 5px;" onclick="javascript:CallPrint('divPrint');">
                                            <i class="fa fa-print"></i>Print
                                        </button>
                                        </td>
                                        <td style="width:3%;">
                                        </td>
                                        <td>
                                         <input type="button" id="Button7" value="Close" onclick="BtnclearClick_pr();"
                                             class="btn btn-danger" />
                                             </td>
                                        </tr></table></div>
                                        <br />
                                        <asp:Label ID="lblmsg" runat="server" Font-Size="20px" ForeColor="Red" Text=""></asp:Label>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                  
                </div>
                <div id="divMainAddNewRow" class="pickupclass" style="text-align: center; height: 100%;
                    width: 100%; position: absolute; display: none; left: 0%; top: 0%; z-index: 99999;
                    background: rgba(192, 192, 192, 0.7);">
                    <div id="divAddNewRow" style="border: 5px solid #A0A0A0; position: absolute; top: 30%;
                        background-color: White; left: 10%; right: 10%; width: 80%; height: 50%; -webkit-box-shadow: 1px 1px 10px rgba(50, 50, 50, 0.65);
                        -moz-box-shadow: 1px 1px 10px rgba(50, 50, 50, 0.65); box-shadow: 1px 1px 10px rgba(50, 50, 50, 0.65);
                        border-radius: 10px 10px 10px 10px;">
                        <table align="left" cellpadding="0" cellspacing="0" style="float: left; width: 100%;"
                            id="tableCollectionDetails" class="mainText2" border="1">
                            <tr>
                                <td>
                                    <label>
                                        Head Of Account</label>
                                </td>
                                <td>
                                    <select id="ddlBillHead" class="form-control">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <input type="button" value="ADD Voucher" id="btnAdd" onclick="btnVoucherAddClick();"
                                        class="btn btn-primary" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divclose" style="width: 35px; top: 24.5%; right: 9.5%; position: absolute;
                        z-index: 99999; cursor: pointer;">
                        <img src="Images/Odclose.png" alt="close" onclick="OrdersCloseClick();" />
                    </div>
                </div>
            </div>
            <div id="divMainAddNewRows" class="pickupclass" style="text-align: center; height: 100%;
                    width: 100%; position: absolute; display: none; left: 0%; top: 0%; z-index: 99999;
                    background: rgba(192, 192, 192, 0.7);">
                    <div id="div2" style="border: 2px solid #A0A0A0; position: absolute; top: 8%;
                    background-color: White; right: 25%; width: 50%;  -webkit-box-shadow: 1px 1px 10px rgba(50, 50, 50, 0.65);
                    -moz-box-shadow: 1px 1px 10px rgba(50, 50, 50, 0.65); box-shadow: 1px 1px 10px rgba(50, 50, 50, 0.65);
                    border-radius: 10px 10px 10px 10px; padding:2%">
                        <table align="left" cellpadding="0" cellspacing="0" style="float: left; width: 100%;"
                            id="tableCollectionDetailss" class="mainText2" border="1">
                            <tr>
                                <td>
                                  <label>  Name</label>
                                </td>
                                <td style="height:40px;">
                                    <span id="spnNames" style="font-size:20px;font-weight:900;color:#00a65a;"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>  Voucher ID</label>
                                </td>
                                <td style="height:40px;">
                                    <span id="spnVoucherIDs" class="form-control"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                   <label>    VoucherType</label>
                                </td>
                                <td style="height:40px;">
                                    <span id="spnVoucherTypes" style="font-size:20px;font-weight:900;color:#00a65a;"></span>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div id="divHeads">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>   Amount</label>
                                </td>
                                <td style="height:40px;">
                                    <span id="spnAmounts" style="font-size:20px;font-weight:900;color:#3c8dbc;"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                   <label>    Approval By</label>
                                </td>
                                <td style="height:40px;">
                                    <span id="spnApprovalEmps" style="font-size:20px;font-weight:900;color:#00a65a;"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                   <label>    Remarks</label>
                                </td>
                                <td style="height:40px;">
                                    <textarea rows="3" cols="45" id="txtCashierRemarkss" class="form-control" placeholder="Enter Remarks"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>   Approval Amount </label>
                                </td>
                                <td style="height:40px;">
                                    <input type="number" id="txtApprovalamts" class="form-control" value="" onkeypress="return numberOnlyExample();"
                                        placeholder="Enter Approval Amount" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>   Approval Remarks</label>
                                </td>
                                <td style="height:40px;">
                                    <input type="text" id="txtRemarkss" class="form-control" value="" onkeypress="return numberOnlyExample();"
                                        placeholder="Enter Remarks" />
                                </td>
                            </tr>
                        </table>
                        <table align="center" style="height: 40px;">
                            <tr>
                                <td style="height:40px;">
                                    <input type="button" value="Update" id="Button2" onclick="btnVoucherUpdateClicks();"
                                         class="btn btn-primary" />
                                </td>
                                <td style="width:3%;">
                                </td>
                                <td style="height:40px;">
                                    <input type="button" id="Button5" value="Approve" onclick="btnApproveVoucherclicks();"
                                         class="btn btn-success" />
                                </td>
                                <td style="width:3%;">
                                </td>
                                <td style="height:40px;">
                                    <input type="button" id="Button6" value="Reject" onclick="btnRejectVoucherclicks();"
                                         class="btn btn-danger" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="div4" style="width: 35px; top: 7.5%; right: 24%; position: absolute;
                    z-index: 99999; cursor: pointer;">
                        <img src="Images/close1.png" alt="close" onclick="OrdersCloseClicks();" style="width: 30px;height: 25px;"/>
                    </div>
                </div>
        </div>
                </div>
            </div>
        </div>
    </section>
</asp:content>
