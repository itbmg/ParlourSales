<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="empmaster.aspx.cs" Inherits="empmaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(function () {
            get_Department_details();
            get_designation_details();
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

        function btndeptclick() {
            var Department = document.getElementById('txtdept').value;
            if (Department == "") {
                alert("Enter Department");
                document.getElementById('txtdept').focus();
                return false;
            }
            var deptcode = document.getElementById('txtdeptcode').value;
            if (deptcode == "") {
                alert("Enter Code");
                document.getElementById('txtdeptcode').focus();
                return false;
            }
            var status = document.getElementById('slctstatus').value;
            var btnval = document.getElementById('btncsave').value;
            var sno = document.getElementById('lbl_sno').innerHTML;
            var data = { 'op': 'btnsave_Departmentclick', 'Department': Department, 'deptcode': deptcode, 'Status': status, 'btnval': btnval, 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        get_Department_details();
                        $('#div_BankData').show();
                        $('#Bankfillform').show();
                        deptforclearall();
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
        function deptforclearall() {
            scrollTo(0, 0);
            document.getElementById('txtdept').value = "";
            document.getElementById('txtdeptcode').value = "";
            document.getElementById('lbl_sno').innerHTML = "";
            document.getElementById('slctstatus').selectedIndex = 0;
            document.getElementById('btncsave').value = "Save";
            $("#lbl_code_error_msg").hide();
            $("#lbl_name_error_msg").hide();
            get_Department_details();
            $('#div_BankData').show();
            $('#Bankfillform').show();
        }
        function get_Department_details() {
            var data = { 'op': 'get_Department_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillDepartmentdetails(msg);
                        filldeptddl(msg);
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
        function fillDepartmentdetails(msg) {
            var results = '<div class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbl_Stores_value">';
            results += '<thead><tr role="row"><th>Sno</th><th scope="col">Department</th><th scope="col">Dept Code</th><th scope="col">Status</th><th scope="col" style="font-weight: bold;">Actions</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr>';
                results += '<td scope="row" class="1" >' + k + '</td>';
                results += '<td scope="row" class="2" style="text-align: center; font-weight: bold;" >' + msg[i].department + '</td>';
                results += '<td scope="row" class="3" style="text-align: center; font-weight: bold;">' + msg[i].deptcode + '</td>';
                results += '<td data-title="status" class="4" style="text-align: center; font-weight: bold;">' + msg[i].status + '</td>';
                results += '<td style="text-align: center;"><a href="#" onclick="getcatedit(this);" title="Edit Company" class="tip btn btn-warning btn-xs"><i class="fa fa-edit"></i></a> <a href="#" onclick="getmebranchdelete(this);" title="Delete Company" class="tip btn btn-danger btn-xs"><i class="fa fa-trash-o"></i></a></td>';
                results += '<td style="display:none" class="5">' + msg[i].sno + '</td></tr>';
            }
            results += '</table></div>';
            $("#divdeptdata").html(results);
        }
        function getcatedit(thisid) {
            scrollTo(0, 0);
            var name = $(thisid).parent().parent().children('.2').html();
            var Code = $(thisid).parent().parent().children('.3').html();
            var statuscode = $(thisid).parent().parent().children('.4').html();
            var sno = $(thisid).parent().parent().children('.5').html();
            if (statuscode == "Enabled") {
                status = "0";
            }
            else {
                status = "1";
            }
            document.getElementById('txtdept').value = name;
            document.getElementById('txtdeptcode').value = Code;
            document.getElementById('btncsave').value = "Modify";
            document.getElementById('lbl_sno').innerHTML = sno;
            document.getElementById('slctstatus').value = status;
            $("#div_BankData").show();
            $("#Bankfillform").show();
        }

        function filldeptddl(msg) {
            var data = document.getElementById('slctdept');
            var length = data.options.length;
            document.getElementById('slctdept').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select Department";
            opt.value = "Select Department";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            data.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].department != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].department;
                    option.value = msg[i].sno;
                    data.appendChild(option);
                }
            }
        }

        function btndesignaionsave() {
            var designation = document.getElementById('txtdesignation').value;
            if (designation == "") {
                alert("enter designation");
                document.getElementById('txtdesignation').focus();
                return false;
            }
            var designationcode = document.getElementById('txtdesignationcode').value;
            var sno = document.getElementById('lbl_sno').innerHTML;
            var status = document.getElementById('slctdstatus').value;
            if (status == "") {
                alert("select status");
                document.getElementById('slctdstatus').focus();
                return false;
            }
            var btnval = document.getElementById('btnsubcat').value;
            var data = { 'op': 'btnsave_designation', 'designation': designation, 'designationcode': designationcode, 'status': status, 'btnval': btnval, 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        clearall();
                        get_designation_details();
                        $('#div_PandF').show();
                        $('#div_subcategory').show();

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
        function clearall() {
            scrollTo(0, 0);
            document.getElementById('txtdesignation').value = "";
            document.getElementById('txtdesignationcode').value = "";
            document.getElementById('lbl_sno').innerHTML = "";
            document.getElementById('btnsubcat').value = "Save";
            $("#lbl_code_error_msg").hide();
            $("#lbl_name_error_msg").hide();
            $("#div_PandF").show();
            $('#div_subcategory').show();
        }
        function get_designation_details() {
            var data = { 'op': 'get_designation_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillsubcatdetails(msg);
                        filldesgddl(msg)
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
            var results = '<div  class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="Table1">';
            results += '<thead><tr role="row"><th scope="col">Sno</th><th scope="col">Designation</th><th scope="col"">Designation Code</th><th scope="col">Status</th><th scope="col">Actions</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr>';
                results += '<td scope="row" class="1" >' + k + '</td>';
                results += '<td scope="row" class="2" style="text-align: center; font-weight: bold;" >' + msg[i].designation + '</td>';
                results += '<td scope="row" class="3" style="text-align: center; font-weight: bold;">' + msg[i].desgcode + '</td>';
                results += '<td data-title="status" class="5" style="text-align: center; font-weight: bold;">' + msg[i].status + '</td>';
                results += '<td style="text-align: center;"><a href="#" onclick="getsubcatedit(this);" title="Edit Company" class="tip btn btn-warning btn-xs"><i class="fa fa-edit"></i></a> <a href="#" onclick="getmebranchdelete(this);" title="Delete Company" class="tip btn btn-danger btn-xs"><i class="fa fa-trash-o"></i></a></td>';
                results += '<td style="display:none" class="7">' + msg[i].sno + '</td></tr>';
            }
            results += '</table></div>';
            $("#divsubcatdata").html(results);
        }
        function getsubcatedit(thisid) {
            scrollTo(0, 0);
            var designation = $(thisid).parent().parent().children('.2').html();
            var desgcode = $(thisid).parent().parent().children('.3').html();
            var status = $(thisid).parent().parent().children('.5').html();
            var sno = $(thisid).parent().parent().children('.7').html();
            if (status == "Enabled") {
                status = "0";
            }
            else {
                status = "1";
            }
            document.getElementById('txtdesignation').value = designation;
            document.getElementById('txtdesignationcode').value = desgcode;
            document.getElementById('slctdstatus').value = status;
            document.getElementById('lbl_sno').innerHTML = sno;
            document.getElementById('btnsubcat').value = "Modify";
            $("#div_PandF").show();
            $('#div_subcategory').show();
        }
        function filldesgddl(msg) {
            var data = document.getElementById('slctdesg');
            var length = data.options.length;
            document.getElementById('slctdesg').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select Designation";
            opt.value = "Select Designation";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            data.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].designation != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].designation;
                    option.value = msg[i].sno;
                    data.appendChild(option);
                }
            }
        }
        //
        function showdeptmaster() {
            $("#div_category").show();
            $("#div_subcategory").hide();
            $("#divregtype").hide();
            $("#divuom").hide();
            $("#divstate").hide();
            scrollTo(0, 0);
        }
        function showPFMaster() {
            $("#div_subcategory").show();
            $("#div_category").hide();
            $("#divregtype").hide();
            $("#divuom").hide();
            $("#divstate").hide();
            scrollTo(0, 0);
        }
        function showuomMaster() {
            $("#div_subcategory").hide();
            $("#div_category").hide();
            $("#divregtype").hide();
            $("#divuom").show();
            $("#divstate").hide();
            scrollTo(0, 0);
        }

        function showstateMaster() {
            $("#div_subcategory").hide();
            $("#div_category").hide();
            $("#divregtype").hide();
            $("#divuom").hide();
            $("#divstate").show();
            scrollTo(0, 0);
        }

        function showtaxregtypeMaster() {
            $("#div_subcategory").hide();
            $("#div_category").hide();
            $("#divregtype").show();
            $("#divuom").hide();
            $("#divstate").hide();
            scrollTo(0, 0);
        }
        function btnempsave() {
            var dept = document.getElementById('slctdept').value;
            var designation = document.getElementById('slctdesg').value;
            var lveltype = $("#slctdesg option:selected").html();
            var empname = document.getElementById('txtempname').value;
            var username = document.getElementById('txtusername').value;
            
            var password = document.getElementById('txtpassword').value;
            var mobileno = document.getElementById('txtmobileno').value;
            var emailid = document.getElementById('txtemailid').value;
            var adharno = document.getElementById('txtadharno').value;
            var empaddress = document.getElementById('txtempaddress').value;
            var status = document.getElementById('slctempstatus').value;
            var btnval = document.getElementById('btnemp').value;
            var sno = document.getElementById('lbl_sno').innerHTML;
            var data = { 'op': 'btnsave_employedetails', 'dept': dept, 'lveltype':lveltype, 'username': username, 'designation': designation, 'empname': empname, 'password': password, 'mobileno': mobileno, 'emailid': emailid, 'adharno': adharno, 'empaddress': empaddress, 'status': status, 'btnval': btnval, 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        empclearall();
                       // get_emp_details(msg);
//                        $('#div_PandF').show();
//                        $('#div_subcategory').show();

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
        function get_emp_details(msg) {

        }
        //slctcstatus, txtcategory, txtcategorycode
        function empclearall() {
            document.getElementById('slctdept').value = "";
            document.getElementById('slctdesg').value = "";
            document.getElementById('txtempname').value = "";
            document.getElementById('txtpassword').value = "";
            document.getElementById('txtmobileno').value = "";
            document.getElementById('txtemailid').value = "";
            document.getElementById('txtadharno').value = "";
            document.getElementById('txtempaddress').value = "";
            document.getElementById('slctempstatus').value = "";
            document.getElementById('btnemp').value = "Save";
            document.getElementById('lbl_sno').innerHTML = "";
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
                                <li id="id_tab_Personal" class="active"><a data-toggle="tab" href="#" onclick="showdeptmaster()" aria-expanded="true">
                                    <i class="fa fa-university" aria-hidden="true"></i>&nbsp;&nbsp;Department Master</a></li>
                                <li id="id_tab_documents" class=""><a data-toggle="tab" href="#" onclick="showPFMaster()" aria-expanded="false">
                                    <i class="fa fa-university" aria-hidden="true"></i>&nbsp;&nbsp;Designation Master</a></li>
                                <li id="Li2" class=""><a data-toggle="tab" href="#" onclick="showuomMaster()" aria-expanded="false">
                                    <i class="fa fa-university" aria-hidden="true"></i>&nbsp;&nbsp;Employee Master</a></li>
                            </ul>
                        </div>
                        <div id="div_category" style="display: block;">
                            <div class="box-header with-border">
                                <h3 class="box-title">
                                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Department Master
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
                                                <label for="focus_add_item">Department</label>
                                                <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtdept">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">Department Code</label> 
                                               <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtdeptcode">
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
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                             <input type="button" name="update" value="Save" class="btn btn-primary" id="btncsave" onclick="btndeptclick();"></div>
                    </div>

                           <div class="row" id="divbind">
        <div class="col-xs-12">
            <div class="box box-primary">
                         <div id="divdeptdata"></div>
        </div>

                
            </div>
        </div>
                        </div>

                        <div id="div_subcategory" style="display: none;">
                            <div class="box-header with-border">
                                <h3 class="box-title">
                                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Designation Master
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
                                                <label for="focus_add_item">Designation</label>
                                                <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtdesignation">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">Designation Code</label> 
                                               <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtdesignationcode">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="print_bill">Status</label> 
                                                <select name="language" class="form-control tip select2 select2-hidden-accessible" id="slctdstatus" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
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
                             <input type="button" name="update" value="Save" class="btn btn-primary" id="btnsubcat" onclick="btndesignaionsave();"></div>
                        </div>
                        <div class="row" id="div1">
        <div class="col-xs-12">
            <div class="box box-primary">
                         <div id="divsubcatdata"></div>
        </div>

                
            </div>
        </div>
                      </div>


                      <div id="divuom" style="display: none;">
                            <div class="box-header with-border">
                                <h3 class="box-title">
                                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Employe Master
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
                                                <label for="print_bill">Department</label> 
                                                <select name="language" class="form-control" id="slctdept" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
                                                   
                                                 </select>
                                            </div>
                                        </div>

                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="print_bill">Designation</label> 
                                                <select name="language" class="form-control" id="slctdesg" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
                                                   
                                                 </select>
                                            </div>
                                        </div>

                                        
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="focus_add_item">Employe Name</label>
                                                <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtempname">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">User Name</label> 
                                               <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtusername">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">Passward</label> 
                                               <input type="password" name="toggle_category_slider" value="" class="form-control tip" id="txtpassword">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">Mobile No</label> 
                                               <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtmobileno">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">EmailId</label> 
                                               <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtemailid">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">Adhar No</label> 
                                               <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtadharno">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">Address</label> 
                                               <textarea id="txtempaddress" class="form-control"></textarea>
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="print_bill">Status</label> 
                                                <select name="language" class="form-control tip select2 select2-hidden-accessible" id="slctempstatus" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
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
                             <input type="button" name="update" value="Save" class="btn btn-primary" id="btnemp" onclick="btnempsave();"></div>
                        </div>
                        <div class="row" id="divuombind">
        <div class="col-xs-12">
            <div class="box box-primary">
                         <div id="divUOMdata"></div>
        </div>

                
            </div>
        </div>
                      </div>

                      <div id="divstate" style="display: none;">
                            <div class="box-header with-border">
                                <h3 class="box-title">
                                    <i style="padding-right: 5px;" class="fa fa-cog"></i>State Master
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
                                                <label for="focus_add_item">State</label>
                                                <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtstatename">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">State Code</label> 
                                               <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtstatecode">
                                            </div>
                                        </div>

                                         <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">Gst State Code</label> 
                                               <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtgststatecode">
                                            </div>
                                        </div>

                                        
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="print_bill">Status</label> 
                                                <select name="language" class="form-control tip select2 select2-hidden-accessible" id="slctstatestatus" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
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
                             <input type="button" name="update" value="Save" class="btn btn-primary" id="btnstate" onclick="btnstatesave();"></div>
                        </div>
                        <div class="row" id="div4">
        <div class="col-xs-12">
            <div class="box box-primary">
                         <div id="divstatedata"></div>
        </div>

                
            </div>
        </div>
                      </div>

                      <div id="divregtype" style="display: none;">
                            <div class="box-header with-border">
                                <h3 class="box-title">
                                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Tax Regtype Master
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
                                                <label for="focus_add_item">RegType</label>
                                                <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtregtype">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="print_bill">Status</label> 
                                                <select name="language" class="form-control tip select2 select2-hidden-accessible" id="slctregstatus" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
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
                             <input type="button" name="update" value="Save" class="btn btn-primary" id="btnregtype" onclick="btnregtypesave();"></div>
                        </div>
                        <div class="row" id="div5">
        <div class="col-xs-12">
            <div class="box box-primary">
                         <div id="divregdata"></div>
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
