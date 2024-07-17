<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="cmpmasters.aspx.cs" Inherits="cmpmasters" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(function () {
            get_company_details();
            get_Branch_Details();
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
        function showbankmaster() {
            $("#div_Bankdetails").show();
            $("#div_pf").hide();
            $("#div_tax").hide();
            $("#div_UOM").hide();
            $("#div_Delveryterms").hide();
            $('#Div_Payment').hide();
            $('#div_BrandData').hide();
            $('#div_address').hide();
            $("#div_state").hide();
            scrollTo(0, 0);
        }
        function showPFMaster() {
            $("#div_pf").show();
            $("#div_tax").hide();
            $("#div_UOM").hide();
            $("#div_Delveryterms").hide();
            $("#div_Bankdetails").hide();
            $('#Div_Payment').hide();
            $('#div_BrandData').hide();
            $('#div_address').hide();
            $("#div_state").hide();
            scrollTo(0, 0);

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

        function btncmpsave() {
            var cmpname = document.getElementById('txtcmpname').value;
            if (cmpname == "") {
                alert("Enter name");
                document.getElementById('txtcmpname').focus();
                return false;
            }
            var cmpcode = document.getElementById('txtcmpcode').value;
            if (cmpcode == "") {
                alert("Enter Code");
                document.getElementById('txtcmpcode').focus();
                return false;
            }
            var status = document.getElementById('slctcmpstatus').value;
            var btnval = document.getElementById('btnsave').value;
            var sno = document.getElementById('lbl_sno').innerHTML;
            var data = { 'op': 'savecompanyDetails', 'cmpname': cmpname, 'cmpcode': cmpcode, 'Status': status, 'btnVal': btnval, 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        get_company_details();
                        $('#div_BankData').show();
                        $('#Bankfillform').show();
                        cmpforclearall();
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
        function cmpforclearall() {
            scrollTo(0, 0);
            document.getElementById('txtcmpname').value = "";
            document.getElementById('txtcmpcode').value = "";
            document.getElementById('lbl_sno').value = "";
            document.getElementById('slctcmpstatus').selectedIndex = 0;
            document.getElementById('btnsave').innerHTML = "save";
            $("#lbl_code_error_msg").hide();
            $("#lbl_name_error_msg").hide();
            get_company_details();
            $('#div_BankData').show();
            $('#Bankfillform').show();
        }

        function get_company_details() {
            var data = { 'op': 'get_company_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillcmpdetails(msg);
                        fillcmpdropdown(msg);
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

        function fillcmpdetails(msg) {
            var results = '<div  class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbl_Stores_value">';
            results += '<thead><tr role="row" class="trbgclrcls"><th scope="col" style="width: 10px">Sno</th><th scope="col">Company Name</th><th scope="col">Code</th><th scope="col">Status</th><th scope="col" style="font-weight: bold;">Actions</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr><td scope="row" style="text-align: center; font-weight: bold;">' + k + '</td>';
                results += '<td scope="row" class="1" style="text-align: center; font-weight: bold;" >' + msg[i].cmpname + '</td>';
                results += '<td data-title="code" class="2" style="text-align: center; font-weight: bold;">' + msg[i].cmpcode + '</th>';
                results += '<td data-title="status" class="3" style="text-align: center; font-weight: bold;">' + msg[i].status + '</td>';
                results += '<td style="text-align: center;"><a href="#" onclick="getmethisedit(this);" title="Edit Company" class="tip btn btn-warning btn-xs"><i class="fa fa-edit"></i></a> <a href="#" onclick="getmethisdelete(this);" title="Delete Company" class="tip btn btn-danger btn-xs"><i class="fa fa-trash-o"></i></a></td>';
                results += '<td style="display:none" class="4">' + msg[i].sno + '</td></tr>';
            }
            results += '</table></div>';
            $("#divcmpdata").html(results);
        }
        function getmethisdelete(thisid) {
            return confirm('You are going to delete Company, please Contact To Management.');
        }
        function getmethisedit(thisid) {
            scrollTo(0, 0);
            var cmpname = $(thisid).parent().parent().children('.1').html();
            var cmpcode = $(thisid).parent().parent().children('.2').html();
            var status = $(thisid).parent().parent().children('.3').html();
            var sno = $(thisid).parent().parent().children('.4').html();
            //            if (status == "0") {
            //                status = "0";
            //            }
            //            else {
            //                status = "1";
            //            }
            document.getElementById('txtcmpname').value = cmpname;
            document.getElementById('txtcmpcode').value = cmpcode;
            document.getElementById('btnsave').value = "Modify";
            document.getElementById('lbl_sno').innerHTML = sno;
            document.getElementById('slctcmpstatus').value = status;
            $("#div_BankData").show();
            $("#Bankfillform").show();
        }

        function fillcmpdropdown(msg) {
            var data = document.getElementById('slctcmpname');
            var length = data.options.length;
            document.getElementById('slctcmpname').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select Company";
            opt.value = "Select Company";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            data.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].cmpname != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].cmpname;
                    option.value = msg[i].sno;
                    data.appendChild(option);
                }
            }
        }

        function btnbranchsave() {
            var cmpid = document.getElementById('slctcmpname').value;
            if (cmpid == "") {
                alert("Select Company");
                document.getElementById('slctcmpname').focus();
                return false;
            }
            var branchname = document.getElementById('txtbranchname').value;
            if (branchname == "") {
                alert("Enter Branch Name");
                document.getElementById('txtbranchname').focus();
                return false;
            }
            var branchcode = document.getElementById('txtbranchcode').value;
            var address = document.getElementById('txtaddress').value;
            var sno = document.getElementById('lbl_sno').innerHTML;
            var status = document.getElementById('slctbranchstatus').value;
            if (status == "") {
                alert("select status");
                document.getElementById('slctbranchstatus').focus();
                return false;
            }
            var btnval = document.getElementById('btnbranch').value;
            var data = { 'op': 'Save_branchetails', 'cmpid': cmpid, 'branchname': branchname, 'branchcode': branchcode, 'address': address, 'status': status, 'btnVal': btnval, 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        branchclearall();
                        get_Branch_Details();
                        $('#div_PandF').show();
                        $('#div_pf').show();

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

        function get_Branch_Details() {
            var data = { 'op': 'get_Branch_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillbranchdetails(msg);
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
        function fillbranchdetails(msg) {
            var results = '<div class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tblbranchdata">';
            results += '<thead><tr role="row"><th style="width: 10px">Sno</th><th scope="col" style="font-weight: bold;">Company Name</th><th>Branch Name</th><th>Branch Code</th><th scope="col" style="font-weight: bold;">Status</th><th scope="col" style="font-weight: bold;">Actions</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr>';
                results += '<th scope="row">' + k + '</th>';
                results += '<td scope="row" class="1" style="text-align: center; font-weight: bold;" >' + msg[i].cmpname + '</td>';
                results += '<td data-title="code" class="2" style="text-align: center; font-weight: bold;">' + msg[i].Branchname + '</th>';
                results += '<td data-title="code" class="3" style="text-align: center; font-weight: bold;">' + msg[i].Branchcode + '</th>';
                results += '<td data-title="status" class="4" style="text-align: center; font-weight: bold;">' + msg[i].status + '</td>';
                results += '<td style="text-align: center;"><a href="#" onclick="getmebranchedit(this);" title="Edit Company" class="tip btn btn-warning btn-xs"><i class="fa fa-edit"></i></a> <a href="#" onclick="getmebranchdelete(this);" title="Delete Company" class="tip btn btn-danger btn-xs"><i class="fa fa-trash-o"></i></a></td>';
                results += '<td style="display:none" class="5">' + msg[i].cmpid + '</td>';
                results += '<td style="display:none" class="6">' + msg[i].sno + '</td></tr>';
            }
            results += '</table></div>';
            $("#divbranchdata").html(results);
        }
        function getmebranchdelete(thisid) {
            return confirm('You are going to delete Branch, please Contact To Management.');
        }
        function getmebranchedit(thisid) {
            scrollTo(0, 0);
            var Branchname = $(thisid).parent().parent().children('.2').html();
            var Branchcode = $(thisid).parent().parent().children('.3').html();
            var cmpid = $(thisid).parent().parent().children('.5').html();
            var statuscode = $(thisid).parent().parent().children('.4').html();
            var sno = $(thisid).parent().parent().children('.6').html();
            if (statuscode == "Enabled") {
                status = "0";
            }
            else {
                status = "1";
            }
            document.getElementById('slctcmpname').value = cmpid;
            document.getElementById('slctbranchstatus').value = status;
            document.getElementById('txtbranchname').value = Branchname;
            document.getElementById('txtbranchcode').value = Branchcode;
            document.getElementById('txtaddress').value = "";
            document.getElementById('lbl_sno').innerHTML = sno;
            document.getElementById('btnbranch').value = "Modify";
            $("#div_PandF").show();
            $('#div_pf').show();

        }
        
        function branchclearall() {
            scrollTo(0, 0);
            document.getElementById('txtbranchname').value = "";
            document.getElementById('txtbranchcode').value = "";
            document.getElementById('txtaddress').value = "";
            document.getElementById('slctbranchstatus').value = "";
            document.getElementById('slctcmpname').selectedIndex = 0;
            document.getElementById('lbl_sno').innerHTML = "";
            document.getElementById('btnbranch').value = "save";
            $("#lbl_code_error_msg").hide();
            $("#lbl_name_error_msg").hide();
            $("#div_PandF").show();
            $('#div_pf').show();
        }

   

    </script>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <section class="content">
                <div class="box box-info">
                    <div class="box-header with-border">
                    </div>
                    <div class="box-body">
                        <div>
                            <ul class="nav nav-tabs">
                                <li id="id_tab_Personal" class="active"><a data-toggle="tab" href="#" onclick="showbankmaster()" aria-expanded="true">
                                    <i class="fa fa-university" aria-hidden="true"></i>&nbsp;&nbsp;Company Master</a></li>
                                <li id="id_tab_documents" class=""><a data-toggle="tab" href="#" onclick="showPFMaster()" aria-expanded="false">
                                    <i class="fa fa-truck" aria-hidden="true"></i>&nbsp;&nbsp;Branch Master</a></li>
                            </ul>
                        </div>
                        <div id="div_Bankdetails" style="display: block;">
                            <div class="box-header with-border">
                                <h3 class="box-title">
                                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Company Master
                                </h3>
                            </div>
                            <div class="box-body">
                    <div class="col-lg-12">
                        <div class="clearfix"></div>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="well well-sm">
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="focus_add_item">Company Name</label>
                                                <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtcmpname">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">Company Code</label> 
                                               <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtcmpcode">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="print_bill">Status</label> 
                                                <select name="language" class="form-control tip select2 select2-hidden-accessible" id="slctcmpstatus" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
                                                    <option value="1">Active</option>
                                                    <option value="2">InActive</option>
                                                 </select>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                             <input type="button"  value="Save" class="btn btn-primary" id="btnsave" onclick="btncmpsave();"></div>
                           </div>

                           <div class="row" id="divbind">
        <div class="col-xs-12">
            <div class="box box-primary">
                         <div id="divcmpdata"></div>
        </div>

                
            </div>
        </div>
                        </div>
                        <div id="div_pf" style="display: none;">
                            <div class="box-header with-border">
                                <h3 class="box-title">
                                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Branch Master
                                </h3>
                            </div>
                             <div class="box-body">
                    <div class="col-lg-12">
                        <div class="clearfix"></div>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="well well-sm">
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="print_bill">Company Name</label> 
                                                <select name="language" class="form-control tip select2 select2-hidden-accessible" id="slctcmpname" required="required" style="width:100%;" tabindex="-1" aria-hidden="true">
                                                   
                                                 </select>
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="focus_add_item">Branch Name</label>
                                                <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtbranchname">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">Branch Code</label> 
                                               <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtbranchcode">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">Address</label> 
                                               <textarea id="txtaddress" class="form-control"></textarea>
                                            </div>
                                        </div>
                                       
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="print_bill">Status</label> 
                                                <select name="language" class="form-control tip select2 select2-hidden-accessible" id="slctbranchstatus" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
                                                    <option value="1">Active</option>
                                                    <option value="2">InActive</option>
                                                 </select>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
                                        </div>
                                  </div>
                            </div>
                            <div class="clearfix"></div>
                             <input type="button" name="update" value="Save" class="btn btn-primary" id="btnbranch" onclick="btnbranchsave();"></div>

                             
                        </div>
                        <div class="row" id="div1">
        <div class="col-xs-12">
            <div class="box box-primary">
                         <div id="divbranchdata"></div>
        </div>

                
            </div>
        </div>
                      </div>
                    <div hidden>
                                <label id="lbl_sno">
                                </label>
                        </div>
                    </div>
                
        </section>
</asp:content>
