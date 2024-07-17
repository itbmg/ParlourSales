<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="suppliermaster.aspx.cs" Inherits="suppliermaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(function () {
            fillcustmoerdetails();
            get_supplierdetails();
            get_state_details();
            get_gstregtype_details();
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
            $("#divsupplier").hide();
            scrollTo(0, 0);
        }
        function showPFMaster() {
            $("#div_pf").show();
            $("#div_Bankdetails").hide();
            $("#divsupplier").hide();
            scrollTo(0, 0);

        }
        function showsupMaster() {
            $("#div_pf").hide();
            $("#div_Bankdetails").hide();
            $("#divsupplier").show();
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
        // txtcnmae, txtcemail, txtcphno, slctcstatus, btncustomersave
        function btncustomersave() {
            var name = document.getElementById('txtcnmae').value;
            if (name == "") {
                alert("Enter name");
                document.getElementById('txtcnmae').focus();
                return false;
            }
            var email = document.getElementById('txtcemail').value;
            var phno = document.getElementById('txtcphno').value;
            if (phno == "") {
                alert("Enter email");
                document.getElementById('txtcphno').focus();
                return false;
            }
            var f1 = "";
            var f2 = "";
            var status = document.getElementById('slctcstatus').value;
            var btnSave = "Save";
            var data = { 'op': 'save_customer_details', 'cname': name, 'email': email, 'phno': phno, 'f1': f1, 'f2': f2, 'btnSave': btnSave };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        fillcustmoerdetails();
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

        function fillcustmoerdetails() {
            var data = { 'op': 'get_customer_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillcstmer(msg);
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
        function fillcstmer(msg) {
            var results = '<div class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbl_Stores_value">';
            results += '<thead><tr role="row"><th>Sno</th><th scope="col">Custemer Nam</th><th scope="col">Status</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr>';
                results += '<td scope="row" class="1" >' + k + '</td>';
                results += '<td scope="row" class="2" style="text-align: center; font-weight: bold;" >' + msg[i].sectionname + '</td>';
                results += '<td scope="row" class="3" style="text-align: center; font-weight: bold;">Active</td>';
                results += '<td style="display:none" class="5">' + msg[i].sno + '</td></tr>';
            }
            results += '</table></div>';
            $("#divcdata").html(results);
        }


        function bankforclearall() {
            scrollTo(0, 0);
            document.getElementById('txtBcode').value = "";
            document.getElementById('txtBName').value = "";
            document.getElementById('lbl_sno').value = "";
            document.getElementById('ddlstatus').selectedIndex = 0;
            document.getElementById('btn_save').innerHTML = "save";
            $("#lbl_code_error_msg").hide();
            $("#lbl_name_error_msg").hide();
            get_bank_details();
            $('#div_BankData').show();
            $('#Bankfillform').show();
        }



        //txtsupaddress, slctstatus, txtgstno, txtsupphno, txtsupemail, txtsupname
        function btnsuppliersave() {
            var supname = document.getElementById('txtsupname').value;
            if (supname == "") {
                alert("Enter suppplier name");
                document.getElementById('txtsupname').focus();
                return false;
            }
            var email = document.getElementById('txtsupemail').value;
            var phoneno = document.getElementById('txtsupphno').value;
            var gstno = document.getElementById('txtgstno').value;
            if (gstno == "") {
                alert("Enter gstno");
                document.getElementById('txtsupname').focus();
                return false;
            }
            var status = document.getElementById('slctstatus').value;
            var state = document.getElementById('slctstate').value;
            var gstregtype = document.getElementById('slctregtype').value;
            var address = document.getElementById('txtsupaddress').value;
            var sno = document.getElementById('lbl_sno').value;
            var btnval = document.getElementById('btnsupplier').value;
            var data = { 'op': 'save_supplierdetails', 'supname': supname, 'email': email, 'phoneno': phoneno, 'gstno': gstno, 'address': address, 'state': state, 'gstregtype': gstregtype, 'Status': status, 'btnVal': btnval, 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        supplierclearall();
                        get_supplierdetails();
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
        function supplierclearall() {
            scrollTo(0, 0);
            document.getElementById('txtsupname').value = "";
            document.getElementById('txtsupemail').value = "";
            document.getElementById('txtsupphno').value = "";
            document.getElementById('txtgstno').value = "";
            document.getElementById('txtsupaddress').value = "";
            document.getElementById('slctstatus').selectedIndex = 0;
            document.getElementById('slctregtype').selectedIndex = 0;
            document.getElementById('lbl_sno').innerHTML = "";
            document.getElementById('btnsupplier').value = "save";
            $("#lbl_code_error_msg").hide();
            $("#lbl_name_error_msg").hide();
            $("#div_PandF").show();
            $('#div_pf').show();
        }
        function get_supplierdetails() {
            var data = { 'op': 'get_supplierdetails' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillsupplierdetails(msg);
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
        function fillsupplierdetails(msg) {
            var results = '<div  style="overflow:auto;"><table class="table table-bordered table-hover dataTable" role="grid">';
            results += '<thead><tr role="row" class="trbgclrcls"><th scope="col">Supplier Name</th><th scope="col">Email</th><th scope="col">Mobileno</th><th scope="col">GST NO</th><th scope="col">Registration Type</th><th scope="col" style="font-weight: bold;">Status</th><th scope="col" style="font-weight: bold;"></th></tr></thead></tbody>';
            var k = 1;
            var l = 0;
            var COLOR = ["#f3f5f7", "#cfe2e0", "", "#cfe2e0"];
            for (var i = 0; i < msg.length; i++) {
                results += '<tr>'; //<td><input id="btn_poplate" type="button"  onclick="pfgetme(this)" name="submit" class="btn btn-primary" value="Edit" /></td>
                results += '<th scope="row" class="1" >' + msg[i].supname + '</th>';
                results += '<th scope="row" class="1" >' + msg[i].email + '</th>';
                results += '<th scope="row" class="1" >' + msg[i].phoneno + '</th>';
                results += '<th scope="row" class="1" >' + msg[i].gstno + '</th>';
                results += '<th scope="row" class="1" >' + msg[i].gstregtype + '</th>';
                results += '<th scope="row" class="1" >' + msg[i].status + '</th>';
                //                results += '<td data-title="brandstatus"><button type="button" title="Click Here To Edit!" class="btn btn-info btn-outline btn-circle btn-lg m-r-5 editcls" onclick="pfgetme(this)"><span class="glyphicon glyphicon-edit" style="top: 0px !important;"></span></button></td>';
                results += '<td style="display:none" class="3">' + msg[i].sno + '</td></tr>';
            }
            results += '</table></div>';
            $("#divsupplierdetails").html(results);
        }
        function pfgetme(thisid) {
            scrollTo(0, 0);
            var pandf = $(thisid).parent().parent().children('.1').html();
            var statuscode = $(thisid).parent().parent().children('.2').html();
            var sno = $(thisid).parent().parent().children('.3').html();
            if (statuscode == "Enabled") {

                status = "0";
            }
            else {
                status = "1";
            }

            document.getElementById('ddlstatuspf').value = status;
            document.getElementById('txtPandF').value = pandf;
            document.getElementById('lbl_sno').value = sno;
            document.getElementById('btn_savepf').innerHTML = "Modify";
            $("#div_PandF").show();
            $('#div_pf').show();

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
    <section class="content">
                <div class="box box-info">
                    <div class="box-header with-border">
                    </div>
                    <div class="box-body">
                        <div>
                            <ul class="nav nav-tabs">
                                <li id="id_tab_documents" class=""><a data-toggle="tab" href="#" onclick="showPFMaster()" aria-expanded="false">
                                    <i class="fa fa-truck" aria-hidden="true"></i>&nbsp;&nbsp;Customer Master</a></li>
                                <li id="Li1" class=""><a data-toggle="tab" href="#" onclick="showsupMaster()" aria-expanded="false">
                                    <i class="fa fa-truck" aria-hidden="true"></i>&nbsp;&nbsp;Supplyer Master</a></li>
                            </ul>
                        </div>
                        
                        <div id="div_pf">
                            <div class="box-header with-border">
                                <h3 class="box-title">
                                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Customer Master
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
                                                <label for="focus_add_item">Name</label>
                                                <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtcnmae">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">Email</label> 
                                               <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtcemail">
                                            </div>
                                        </div>
                                         <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">Phone No</label> 
                                               <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtcphno">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="print_bill">Status</label> 
                                                <select name="language" class="form-control tip select2 select2-hidden-accessible" id="slctcstatus" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
                                                    <option value="0">Select Status</option>
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
                             <input type="button" name="update" value="Save" class="btn btn-primary" id="btncsave" onclick="btncustomersave();"></div>

                             
                        </div>
                        <div class="row" id="div1">
        <div class="col-xs-12">
            <div class="box box-primary">
                         
                            <div id="divcdata"></div>
                      
        </div>

                
            </div>
        </div>
                      </div>



                      <div id="divsupplier" style="display: none;">
                            <div class="box-header with-border">
                                <h3 class="box-title">
                                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Supplier Master
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
                                                <label for="focus_add_item">Supplier Name</label>
                                                <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtsupname">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">Email</label> 
                                               <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtsupemail">
                                            </div>
                                        </div>
                                         <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">Phone No</label> 
                                               <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtsupphno">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">GSTNO</label> 
                                               <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtgstno">
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
                                                <label for="close_register">Reg Type</label>
                                                 <select name="language" class="form-control" id="slctregtype" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
                                                 </select>
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="print_bill">Status</label> 
                                                <select name="language" class="form-control tip select2 select2-hidden-accessible" id="slctstatus" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
                                                    <option value="1">Active</option>
                                                    <option value="2">InActive</option>
                                                 </select>
                                            </div>
                                        </div>
                                         <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">Address</label> 
                                               <textarea id="txtsupaddress" class="form-control" ></textarea>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
                                        </div>
                                  </div>
                            </div>
                            <div class="clearfix"></div>
                             <input type="button" name="update" value="Save" class="btn btn-primary" id="btnsupplier" onclick="btnsuppliersave();"></div>
                        </div>
                        <div class="row" id="div3">
        <div class="col-xs-12">
            <div class="box box-primary">
                         <div id="divsupplierdetails">
                         </div>
        </div>

                
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
