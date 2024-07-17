<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Branchmaster.aspx.cs" Inherits="Branchmaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(function () {
            get_state_details();
            get_gstregtype_details();
            get_company_details();
            get_Branch_Details();
            get_parlor_details();
            $("#btnaddclick").click(function () {
                $('#divitem').css('display', 'block');
                $('#divbind').css('display', 'none');
            })
            $("#btnclose").click(function () {
                $('#divitem').css('display', 'none');
                $('#divbind').css('display', 'block');
            })
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
        function get_company_details() {
            var data = { 'op': 'get_company_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
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
        function fillcmpdropdown(msg) {
            var data = document.getElementById('slctcmp');
            var length = data.options.length;
            document.getElementById('slctcmp').options.length = null;
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
            var cmpid = document.getElementById('slctcmp').value;
            var data = document.getElementById('slctbranch');
            var length = data.options.length;
            document.getElementById('slctbranch').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select Company";
            opt.value = "Select Company";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            data.appendChild(opt);
            if (cmpid != "") {
                for (var i = 0; i < msg.length; i++) {
                    if (msg[i].cmpid == cmpid) {
                        var option = document.createElement('option');
                        option.innerHTML = msg[i].Branchname;
                        option.value = msg[i].sno;
                        data.appendChild(option);
                    }
                }
            }
            else {
                for (var i = 0; i < msg.length; i++) {
                    if (msg[i].Branchname != null) {
                        var option = document.createElement('option');
                        option.innerHTML = msg[i].Branchname;
                        option.value = msg[i].sno;
                        data.appendChild(option);
                    }
                }
            }
        }

        function slctcmp_change() {
            get_Branch_Details();
        }

        function btnsave_click() {
            var cmpid = document.getElementById('slctcmp').value;
            var branchid = document.getElementById('slctbranch').value;
            var parlorname = document.getElementById('txtparlorname').value;
            if (parlorname == "") {
                alert("Enter parlorname");
                document.getElementById('txtparlorname').focus();
                return false;
            }
            var parlorcode = document.getElementById('txtparlorcode').value;
            var parlortype = document.getElementById('slctparlortype').value;
            var pramotername = document.getElementById('txtpramotername').value;
            var state = document.getElementById('slctstate').value;
            if (state == "") {
                alert("Select State");
                document.getElementById('slctstate').focus();
                return false;
            }
            var mobileno = document.getElementById('txtmobileno').value;
            var email = document.getElementById('txtemail').value;
            var panno = document.getElementById('txtpanno').value;
            var tinno = document.getElementById('txttinno').value;
            var cstno = document.getElementById('txtcstno').value;
            var gstin = document.getElementById('txtgstin').value;
            var regtype = document.getElementById('slctregtype').value;
            var tallyledger = document.getElementById('txttallyledger').value;
            var sapledger = document.getElementById('txtsapledger').value;
            var sapledgercode = document.getElementById('txtsapledgercode').value;
            var address = document.getElementById('txtaddress').value;
            if (regtype == "") {
                alert("Enter regtype");
                document.getElementById('slctregtype').focus();
                return false;
            }
            var status = document.getElementById('slctcstatus').value;
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
                        $('#divitem').css('display', 'none');
                        $('#divbind').css('display', 'block');
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
        function get_parlor_details() {
            var data = { 'op': 'get_parlor_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillparlordetails(msg);
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
        function fillparlordetails(msg) {
            var results = '<div class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbl_Stores_value">';
            results += '<thead><tr role="row"><th>Sno</th><th scope="col">Parlor Name</th><th scope="col">Parlor Type</th><th scope="col">Phone No</th><th scope="col">Email</th><th scope="col">GST No</th><th scope="col">Reg Type</th><th scope="col">Pramoter Name</th><th scope="col">Status</th><th scope="col" style="font-weight: bold;">Actions</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr>';
                results += '<td scope="row" class="1" >' + k + '</td>';
                results += '<td scope="row" class="2" style="text-align: center; font-weight: bold;" >' + msg[i].parlorname + '</td>';
                results += '<td scope="row" class="3" style="text-align: center; font-weight: bold;" >' + msg[i].parlortype + '</td>';
                results += '<td scope="row" class="4" style="text-align: center; font-weight: bold;" >' + msg[i].phone + '</td>';
                results += '<td scope="row" class="5" style="text-align: center; font-weight: bold;" >' + msg[i].emailid + '</td>';
                results += '<td scope="row" class="6" style="text-align: center; font-weight: bold;" >' + msg[i].gstin + '</td>';
                results += '<td scope="row" class="7" style="text-align: center; font-weight: bold;" >' + msg[i].regtype + '</td>';
                results += '<td scope="row" class="8" style="text-align: center; font-weight: bold;" >' + msg[i].pramotername + '</td>';
                results += '<td data-title="status" class="9" style="text-align: center; font-weight: bold;">' + msg[i].status + '</td>';
                results += '<td scope="row" class="10" style="text-align: center; font-weight: bold; display:none" >' + msg[i].address + '</td>';
                results += '<td scope="row" class="11" style="text-align: center; font-weight: bold; display:none">' + msg[i].tinno + '</td>';
                results += '<td data-title="status" class="12" style="text-align: center; font-weight: bold; display:none">' + msg[i].cstno + '</td>';
                results += '<td data-title="status" class="13" style="text-align: center; font-weight: bold; display:none">' + msg[i].stateid + '</td>';
                results += '<td data-title="status" class="14" style="text-align: center; font-weight: bold; display:none">' + msg[i].parlorcode + '</td>';
                results += '<td data-title="status" class="15" style="text-align: center; font-weight: bold; display:none">' + msg[i].panno + '</td>';
                results += '<td data-title="status" class="17" style="text-align: center; font-weight: bold; display:none">' + msg[i].cmpid + '</td>';
                results += '<td data-title="status" class="18" style="text-align: center; font-weight: bold; display:none">' + msg[i].locationid + '</td>';
                results += '<td data-title="status" class="19" style="text-align: center; font-weight: bold; display:none">' + msg[i].tallyledger + '</td>';
                results += '<td data-title="status" class="20" style="text-align: center; font-weight: bold; display:none">' + msg[i].sapledger + '</td>';
                results += '<td data-title="status" class="21" style="text-align: center; font-weight: bold; display:none">' + msg[i].sapledgercode + '</td>';
                results += '<td style="text-align: center;"><a href="#" title="View" class="tip btn btn-primary btn-xs" data-toggle="ajax"><i class="fa fa-file-text-o"></i></a><a href="#" onclick="getedit(this);" title="Edit ParlorInfo" class="tip btn btn-warning btn-xs"><i class="fa fa-edit"></i></a> <a href="#" onclick="getmebranchdelete(this);" title="Delete Company" class="tip btn btn-danger btn-xs"><i class="fa fa-trash-o"></i></a></td>';
                results += '<td style="display:none" class="16">' + msg[i].sno + '</td></tr>';
            }
            results += '</table></div>';
            $("#divparlordata").html(results);
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
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
 <script type="text/javascript">
     $('body').addClass('skin-green sidebar-collapse sidebar-mini pos');
    </script>
    <section class="content">
    <div class="row"  id="divitem" style="display:none;">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">Parlor Master</h3>
                </div>
                <div class="box-body">
                    <div class="col-lg-12">
                        <div class="clearfix"></div>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="well well-sm">
                                     <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="cancel_sale">Company</label>
                                                 <select class="form-control" id="slctcmp" required="required" style="width:100%;" onchange="slctcmp_change();">
                                                   
                                                 </select>
                                            </div>
                                        </div>

                                         <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="cancel_sale">Branch</label>
                                                 <select class="form-control" id="slctbranch" required="required" style="width:100%;" tabindex="-1" aria-hidden="true">
                                                   
                                                 </select>
                                            </div>
                                        </div>


                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="focus_add_item">Parlor Name</label> 
                                                <input type="text" name="focus_add_item" value="" class="form-control tip" id="txtparlorname">
                                            </div>
                                        </div>

                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">Parlor Code</label> 
                                                <input type="text" name="add_customer" value="" class="form-control tip" id="txtparlorcode">
                                            </div>
                                        </div>
                                       <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="close_register">Parlor Type</label>
                                                  <select name="language" class="form-control tip select2 select2-hidden-accessible" id="slctparlortype" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
                                                    <option value="Own" selected="selected">Own</option>
                                                    <option value="Hiring">Hiring</option>
                                                 </select>
                                            </div>
                                        </div> 
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="toggle_category_slider">Pramoter Name</label> <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtpramotername">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="cancel_sale">State</label>
                                                 <select class="form-control" id="slctstate" required="required" style="width:100%;" tabindex="-1" aria-hidden="true">
                                                   
                                                 </select>
                                            </div>
                                        </div>
                                     
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="print_order">Mobile Number</label> 
                                                <input type="text" name="print_order" value="" class="form-control tip" id="txtmobileno">
                                            </div>
                                        </div>

                                         <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="open_hold_bills">Email Address</label> 
                                                <input type="text" name="open_hold_bills" value="" class="form-control tip" id="txtemail">
                                            </div>
                                        </div>

                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="print_bill">Pan No</label> 
                                                <input type="text" name="print_bill" value="" class="form-control tip" id="txtpanno">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="finalize_sale">Tin Number</label> 
                                                <input type="text" name="finalize_sale" value="" class="form-control tip" id="txttinno">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="today_sale">Cst Number</label>
                                                <input type="text" name="today_sale" value="" class="form-control tip" id="txtcstno">
                                            </div>
                                        </div>
                                       
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="close_register">GSTIN</label>
                                                 <input type="text" name="close_register" value="" class="form-control tip" id="txtgstin">
                                            </div>
                                        </div>

                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="close_register">Reg Type</label>
                                                 <select name="language" class="form-control" id="slctregtype" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
                                                 </select>
                                            </div>
                                        </div>

                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="close_register">Status</label>
                                                  <select name="language" class="form-control tip select2 select2-hidden-accessible" id="slctcstatus" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
                                                    <option value="Active" selected="selected">Active</option>
                                                    <option value="InActive">InActive</option>
                                                 </select>
                                            </div>
                                        </div>
                                     
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="close_register">Tally Ledger</label>
                                                 <input type="text" name="close_register" value="" class="form-control tip" id="txttallyledger">
                                            </div>
                                        </div>
                                        
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="close_register">SapLedger</label>
                                                 <input type="text" name="close_register" value="" class="form-control tip" id="txtsapledger">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="close_register">SapLedger Code</label>
                                                 <input type="text" name="close_register" value="" class="form-control tip" id="txtsapledgercode">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="close_register">Address</label>
                                                 <textarea id="txtaddress" class="form-control"></textarea>
                                            </div>
                                        </div>

                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <input type="submit" name="update" value="Save" class="btn btn-primary" id="btnsave" onclick="btnsave_click();"> <input type="button" name="update" value="Close" class="btn btn-primary" id="btnclose"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" id="divbind">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">Parlor Master</h3>
                </div><div style="float: right; padding-right: 14px;padding-bottom: 5px;"><input type="button" name="AddIteam" value="Add Branch" class="btn btn-primary" id="btnaddclick"></br></div>
                         

                        <div id="divparlordata"></div>
        </div>

                
            </div>
        </div>
        <div hidden>
                                <label id="lbl_sno">
                                </label>
                        </div>
    </section>
</asp:content>
