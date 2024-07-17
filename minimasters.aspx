<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="minimasters.aspx.cs" Inherits="minimasters" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(function () {
            get_category_details();
            get_subcategory_details();
            get_UOM_details();
            get_state_details();
            get_gstregtype_details();
            get_denamination_details();
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

        function btncategoryclick() {
            var categoryname = document.getElementById('txtcategory').value;
            if (categoryname == "") {
                alert("Enter category");
                document.getElementById('txtcategory').focus();
                return false;
            }
            var categorycode = document.getElementById('txtcategorycode').value;
            if (categorycode == "") {
                alert("Enter Code");
                document.getElementById('txtcategorycode').focus();
                return false;
            }
            var status = document.getElementById('slctcstatus').value;
            var btnval = document.getElementById('btncsave').value;
            var sno = document.getElementById('lbl_sno').innerHTML;
            var data = { 'op': 'btnsave_categoryclick', 'categoryname': categoryname, 'categorycode': categorycode, 'Status': status, 'btnval': btnval, 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        get_category_details();
                        $('#div_BankData').show();
                        $('#Bankfillform').show();
                        bankforclearall();
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
        function bankforclearall() {
            scrollTo(0, 0);
            document.getElementById('txtcategory').value = "";
            document.getElementById('txtcategorycode').value = "";
            document.getElementById('lbl_sno').value = "";
            document.getElementById('slctcstatus').selectedIndex = 0;
            document.getElementById('btncsave').innerHTML = "Save";
            $("#lbl_code_error_msg").hide();
            $("#lbl_name_error_msg").hide();
            get_category_details();
            $('#div_BankData').show();
            $('#Bankfillform').show();
        }
        function get_category_details() {
            var data = { 'op': 'get_category_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillcategorydetails(msg);
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
        function fillcategorydetails(msg) {
            var results = '<div class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbl_Stores_value">';
            results += '<thead><tr role="row"><th>Sno</th><th scope="col">Category</th><th scope="col">Category Code</th><th scope="col">Status</th><th scope="col" style="font-weight: bold;">Actions</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr>';
                results += '<td scope="row" class="1" >' + k + '</td>';
                results += '<td scope="row" class="2" style="text-align: center; font-weight: bold;" >' + msg[i].category + '</td>';
                results += '<td scope="row" class="3" style="text-align: center; font-weight: bold;">' + msg[i].cat_code + '</td>';
                results += '<td data-title="status" class="4" style="text-align: center; font-weight: bold;">' + msg[i].status + '</td>';
                results += '<td style="text-align: center;"><a href="#" onclick="getcatedit(this);" title="Edit Company" class="tip btn btn-warning btn-xs"><i class="fa fa-edit"></i></a> <a href="#" onclick="getmebranchdelete(this);" title="Delete Company" class="tip btn btn-danger btn-xs"><i class="fa fa-trash-o"></i></a></td>';
                results += '<td style="display:none" class="5">' + msg[i].sno + '</td></tr>';
            }
            results += '</table></div>';
            $("#divcatdata").html(results);
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
            document.getElementById('txtcategory').value = name;
            document.getElementById('txtcategorycode').value = Code;
            document.getElementById('btncsave').value = "Modify";
            document.getElementById('lbl_sno').innerHTML = sno;
            document.getElementById('slctcstatus').value = status;
            $("#div_BankData").show();
            $("#Bankfillform").show();
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
        //, , , slctcategory
        function btnsubcategorysave() {
            var catid = document.getElementById('slctcategory').value;
            if (catid == "") {
                alert("Please Select Category Id");
                document.getElementById('slctcategory').focus();
                return false;
            }
            var subcategory = document.getElementById('txtsubcategory').value;
            var subcategorycode = document.getElementById('txtsubcatcode').value;
            if (subcategory == "") {
                alert("Enter subcategory");
                document.getElementById('txtsubcategory').focus();
                return false;
            }
            var sno = document.getElementById('lbl_sno').innerHTML;
            var status = document.getElementById('slctsubcatstatus').value;
            if (status == "") {
                alert("select status");
                document.getElementById('slctsubcatstatus').focus();
                return false;
            }
            var btnval = document.getElementById('btnsubcat').value;
            var data = { 'op': 'btnsave_subcategory', 'catid': catid, 'subcategory': subcategory, 'subcategorycode': subcategorycode, 'status': status, 'btnval': btnval, 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        subcatclearall();
                        get_subcategory_details();
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
        function subcatclearall() {
            scrollTo(0, 0);
            document.getElementById('txtsubcategory').value = "";
            document.getElementById('txtsubcatcode').value = "";
            document.getElementById('slctcategory').selectedIndex = 0;
            document.getElementById('lbl_sno').innerHTML = "";
            document.getElementById('btnsubcat').value = "Save";
            $("#lbl_code_error_msg").hide();
            $("#lbl_name_error_msg").hide();
            $("#div_PandF").show();
            $('#div_subcategory').show();
        }
        function get_subcategory_details() {
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
            var results = '<div  class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="Table1">';
            results += '<thead><tr role="row"><th scope="col">Sno</th><th scope="col">Category</th><th scope="col"">Sub Category</th><th scope="col">Code</th><th scope="col">Status</th><th scope="col">Actions</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr>';
                results += '<td scope="row" class="1" >' + k + '</td>';
                results += '<td scope="row" class="2" style="text-align: center; font-weight: bold;" >' + msg[i].category + '</td>';
                results += '<td scope="row" class="3" style="text-align: center; font-weight: bold;">' + msg[i].subcategory + '</td>';
                results += '<td scope="row" class="4" style="text-align: center; font-weight: bold;">' + msg[i].subcat_code + '</td>';
                results += '<td data-title="status" class="5" style="text-align: center; font-weight: bold;">' + msg[i].status + '</td>';
                results += '<td style="text-align: center;"><a href="#" onclick="getsubcatedit(this);" title="Edit Company" class="tip btn btn-warning btn-xs"><i class="fa fa-edit"></i></a> <a href="#" onclick="getmebranchdelete(this);" title="Delete Company" class="tip btn btn-danger btn-xs"><i class="fa fa-trash-o"></i></a></td>';
                results += '<td style="display:none" class="6">' + msg[i].catid + '</td>';
                results += '<td style="display:none" class="7">' + msg[i].sno + '</td></tr>';
            }
            results += '</table></div>';
            $("#divsubcatdata").html(results);
        }
        function getsubcatedit(thisid) {
            scrollTo(0, 0);
            var catid = $(thisid).parent().parent().children('.6').html();
            var subcategory = $(thisid).parent().parent().children('.3').html();
            var subcat_code = $(thisid).parent().parent().children('.4').html();
            var status = $(thisid).parent().parent().children('.5').html();
            var sno = $(thisid).parent().parent().children('.7').html();
            if (status == "Enabled") {
                status = "0";
            }
            else {
                status = "1";
            }
            document.getElementById('slctcategory').value = catid;
            document.getElementById('txtsubcategory').value = subcategory;
            document.getElementById('txtsubcatcode').value = subcat_code;
            document.getElementById('slctsubcatstatus').value = status;
            document.getElementById('lbl_sno').innerHTML = sno;
            document.getElementById('btnsubcat').value = "Modify";
            $("#div_PandF").show();
            $('#div_subcategory').show();
        }


        function btnuomsave() {
            var uom = document.getElementById('txtuom').value;
            if (uom == "") {
                alert("Enter UOM");
                document.getElementById('txtuom').focus();
                return false;
            }
            var sno = document.getElementById('lbl_sno').innerHTML;
            var status = document.getElementById('slctuom').value;
            if (status == "") {
                alert("select status");
                document.getElementById('slctuom').focus();
                return false;
            }
            var btnval = document.getElementById('btnuom').value;
            var data = { 'op': 'btnsave_UOM', 'uom': uom, 'status': status, 'btnval': btnval, 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        uomclearall();
                        get_UOM_details();
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


        function uomclearall() {
            scrollTo(0, 0);
            document.getElementById('txtuom').value = "";
            document.getElementById('lbl_sno').innerHTML = "";
            document.getElementById('btnuom').value = "Save";
            $("#lbl_code_error_msg").hide();
            $("#lbl_name_error_msg").hide();
        }
        function get_UOM_details() {
            var data = { 'op': 'get_UOM_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        filluomdetails(msg);
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
        function filluomdetails(msg) {
            var results = '<div  class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="Table1">';
            results += '<thead><tr role="row"><th scope="col">Sno</th><th scope="col">UOM</th><th scope="col">Status</th><th scope="col">Actions</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr>';
                results += '<td scope="row" class="1" >' + k + '</td>';
                results += '<td scope="row" class="2" style="text-align: center; font-weight: bold;" >' + msg[i].UOM + '</td>';
                results += '<td data-title="status" class="5" style="text-align: center; font-weight: bold;">' + msg[i].status + '</td>';
                results += '<td style="text-align: center;"><a href="#" onclick="getUOMedit(this);" title="Edit Company" class="tip btn btn-warning btn-xs"><i class="fa fa-edit"></i></a> <a href="#" onclick="getmebranchdelete(this);" title="Delete Company" class="tip btn btn-danger btn-xs"><i class="fa fa-trash-o"></i></a></td>';
                results += '<td style="display:none" class="7">' + msg[i].sno + '</td></tr>';
            }
            results += '</table></div>';
            $("#divUOMdata").html(results);
        }
        function getUOMedit(thisid) {
            scrollTo(0, 0);
            var catid = $(thisid).parent().parent().children('.2').html();
            var status = $(thisid).parent().parent().children('.5').html();
            var sno = $(thisid).parent().parent().children('.7').html();
            if (status == "Enabled") {
                status = "0";
            }
            else {
                status = "1";
            }
            document.getElementById('txtuom').value = catid;
            document.getElementById('lbl_sno').innerHTML = sno;
            document.getElementById('btnuom').value = "Modify";

        }

        function btnstatesave() {
            var statename = document.getElementById('txtstatename').value;
            if (statename == "") {
                alert("Enter statename");
                document.getElementById('txtstatename').focus();
                return false;
            }
            var statecode = document.getElementById('txtstatecode').value;
            if (statecode == "") {
                alert("Enter statecode");
                document.getElementById('txtstatecode').focus();
                return false;
            }

            var gststatecode = document.getElementById('txtgststatecode').value;
            if (gststatecode == "") {
                alert("Enter gststatecode");
                document.getElementById('txtgststatecode').focus();
                return false;
            }

            var sno = document.getElementById('lbl_sno').innerHTML;
            var status = document.getElementById('slctstatestatus').value;
            if (status == "") {
                alert("select status");
                document.getElementById('slctstatestatus').focus();
                return false;
            }
            var btnval = document.getElementById('btnstate').value;
            var data = { 'op': 'btnsave_state', 'statename': statename, 'statecode': statecode, 'gststatecode': gststatecode, 'status': status, 'btnval': btnval, 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        stateclearall();
                        get_state_details();
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


        function stateclearall() {
            scrollTo(0, 0);
            document.getElementById('txtstatename').value = "";
            document.getElementById('txtstatecode').value = "";
            document.getElementById('txtgststatecode').value = "";
            document.getElementById('lbl_sno').innerHTML = "";
            document.getElementById('btnstate').value = "Save";
            $("#lbl_code_error_msg").hide();
            $("#lbl_name_error_msg").hide();
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
            var results = '<div  class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="Table1">';
            results += '<thead><tr role="row"><th scope="col">Sno</th><th scope="col">State Name</th><th scope="col">State Code</th><th scope="col">Gst State Code</th><th scope="col">Status</th><th scope="col">Actions</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr>';
                results += '<td scope="row" class="1" >' + k + '</td>';
                results += '<td scope="row" class="2" style="text-align: center; font-weight: bold;" >' + msg[i].statename + '</td>';
                results += '<td scope="row" class="3" style="text-align: center; font-weight: bold;" >' + msg[i].statecode + '</td>';
                results += '<td scope="row" class="4" style="text-align: center; font-weight: bold;" >' + msg[i].gststatecode + '</td>';
                results += '<td data-title="status" class="5" style="text-align: center; font-weight: bold;">' + msg[i].status + '</td>';
                results += '<td style="text-align: center;"><a href="#" onclick="getstateedit(this);" title="Edit State" class="tip btn btn-warning btn-xs"><i class="fa fa-edit"></i></a> <a href="#" onclick="getmebranchdelete(this);" title="Delete State" class="tip btn btn-danger btn-xs"><i class="fa fa-trash-o"></i></a></td>';
                results += '<td style="display:none" class="7">' + msg[i].sno + '</td></tr>';
            }
            results += '</table></div>';
            $("#divstatedata").html(results);
        }
        function getstateedit(thisid) {
            scrollTo(0, 0);
            var statename = $(thisid).parent().parent().children('.2').html();
            var statecode = $(thisid).parent().parent().children('.3').html();
            var gststatecode = $(thisid).parent().parent().children('.4').html();
            var status = $(thisid).parent().parent().children('.5').html();
            var sno = $(thisid).parent().parent().children('.7').html();
            if (status == "Enabled") {
                status = "0";
            }
            else {
                status = "1";
            }
            document.getElementById('txtstatename').value = statename;
            document.getElementById('txtstatecode').value = statecode;
            document.getElementById('txtgststatecode').value = gststatecode;
            document.getElementById('lbl_sno').innerHTML = sno;
            document.getElementById('btnstate').value = "Modify";

        }


        function btnregtypesave() {
            var regtype = document.getElementById('txtregtype').value;
            if (regtype == "") {
                alert("Enter Regtype");
                document.getElementById('txtregtype').focus();
                return false;
            }
            var sno = document.getElementById('lbl_sno').innerHTML;
            var status = document.getElementById('slctregstatus').value;
            if (status == "") {
                alert("select status");
                document.getElementById('slctregstatus').focus();
                return false;
            }
            var btnval = document.getElementById('btnregtype').value;
            var data = { 'op': 'btnsave_gstregtype', 'regtype': regtype, 'status': status, 'btnval': btnval, 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        regclearall();
                        get_gstregtype_details();
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
        function regclearall() {
            scrollTo(0, 0);
            document.getElementById('txtregtype').value = "";
            document.getElementById('lbl_sno').innerHTML = "";
            document.getElementById('btnregtype').value = "Save";
            $("#lbl_code_error_msg").hide();
            $("#lbl_name_error_msg").hide();
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
            var results = '<div  class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="Table1">';
            results += '<thead><tr role="row"><th scope="col">Sno</th><th scope="col">GST Reg Type</th><th scope="col">Status</th><th scope="col">Actions</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr>';
                results += '<td scope="row" class="1" >' + k + '</td>';
                results += '<td scope="row" class="2" style="text-align: center; font-weight: bold;" >' + msg[i].gstregtype + '</td>';
                results += '<td data-title="status" class="5" style="text-align: center; font-weight: bold;">' + msg[i].status + '</td>';
                results += '<td style="text-align: center;"><a href="#" onclick="getREGedit(this);" title="Edit GstRegType" class="tip btn btn-warning btn-xs"><i class="fa fa-edit"></i></a> <a href="#" onclick="getmebranchdelete(this);" title="Delete State" class="tip btn btn-danger btn-xs"><i class="fa fa-trash-o"></i></a></td>';
                results += '<td style="display:none" class="7">' + msg[i].sno + '</td></tr>';
            }
            results += '</table></div>';
            $("#divregdata").html(results);
        }
        function getREGedit(thisid) {
            scrollTo(0, 0);
            var gstregtype = $(thisid).parent().parent().children('.2').html();
            var status = $(thisid).parent().parent().children('.5').html();
            var sno = $(thisid).parent().parent().children('.7').html();
            if (status == "Enabled") {
                status = "0";
            }
            else {
                status = "1";
            }
            document.getElementById('txtregtype').value = gstregtype;
            document.getElementById('lbl_sno').innerHTML = sno;
            document.getElementById('btnregtype').value = "Modify";

        }
        //
        function showbankmaster() {
            $("#div_category").show();
            $("#div_subcategory").hide();
            $("#divregtype").hide();
            $("#divuom").hide();
            $("#divstate").hide();
            $("#divdinaminations").hide();
            scrollTo(0, 0);
        }
        function showPFMaster() {
            $("#div_subcategory").show();
            $("#div_category").hide();
            $("#divregtype").hide();
            $("#divuom").hide();
            $("#divstate").hide();
            $("#divdinaminations").hide();
            scrollTo(0, 0);
        }
        function showuomMaster() {
            $("#div_subcategory").hide();
            $("#div_category").hide();
            $("#divregtype").hide();
            $("#divuom").show();
            $("#divstate").hide();
            $("#divdinaminations").hide();
            scrollTo(0, 0);
        }

        function showstateMaster() {
            $("#div_subcategory").hide();
            $("#div_category").hide();
            $("#divregtype").hide();
            $("#divuom").hide();
            $("#divstate").show();
            $("#divdinaminations").hide();
            scrollTo(0, 0);
        }

        function showtaxregtypeMaster() {
            $("#div_subcategory").hide();
            $("#div_category").hide();
            $("#divregtype").show();
            $("#divuom").hide();
            $("#divstate").hide();
            $("#divdinaminations").hide();
            scrollTo(0, 0);
        }

        function showdinaminationMaster() {
            $("#div_subcategory").hide();
            $("#div_category").hide();
            $("#divregtype").show();
            $("#divuom").hide();
            $("#divstate").hide();
            $("#divdinaminations").show();
            scrollTo(0, 0);
        }
        function get_denamination_details() {
            var data = { 'op': 'get_denamination_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        filldenaminationdetails(msg);
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
        function filldenaminationdetails(msg) {
            var results = '<div  class="box-body"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="Table1">';
            results += '<thead><tr role="row"><th scope="col">Sno</th><th scope="col">Denamination Type</th><th scope="col">Status</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr>';
                results += '<td scope="row" class="1" >' + k + '</td>';
                results += '<td scope="row" class="2" style="text-align: center; font-weight: bold;" >' + msg[i].gstregtype + '</td>';
                results += '<td data-title="status" class="5" style="text-align: center; font-weight: bold;">' + msg[i].status + '</td>';
                results += '<td style="display:none" class="7">' + msg[i].sno + '</td></tr>';
            }
            results += '</table></div>';
            $("#divdinaminationdata").html(results);
        }
        function btndinaminationsave() {
            var dinamination = document.getElementById('txtdinamination').value;
            if (dinamination == "") {
                alert("Enter dinamination");
                document.getElementById('txtdinamination').focus();
                return false;
            }
            var sno = document.getElementById('lbl_sno').innerHTML;
            var status = document.getElementById('slctdinamination').value;
            if (status == "") {
                alert("select status");
                document.getElementById('slctdinamination').focus();
                return false;
            }
            var btnval = document.getElementById('btndinamination').value;
            var data = { 'op': 'btnsave_dinaminations', 'dinamination': dinamination, 'status': status, 'btnval': btnval, 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        dinaminationclearall();
                        get_denamination_details();
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
        function dinaminationclearall() {
            scrollTo(0, 0);
            document.getElementById('txtdinamination').value = "";
            document.getElementById('lbl_sno').innerHTML = "";
            document.getElementById('btndinamination').value = "Save";
            $("#lbl_code_error_msg").hide();
            $("#lbl_name_error_msg").hide();
        }

       // , , , , 
        //slctcstatus, txtcategory, txtcategorycode

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
                                    <i class="fa fa-university" aria-hidden="true"></i>&nbsp;&nbsp;Category Master</a></li>
                                <li id="id_tab_documents" class=""><a data-toggle="tab" href="#" onclick="showPFMaster()" aria-expanded="false">
                                    <i class="fa fa-university" aria-hidden="true"></i>&nbsp;&nbsp;Sub Category Master</a></li>

                                    <li id="Li2" class=""><a data-toggle="tab" href="#" onclick="showuomMaster()" aria-expanded="false">
                                    <i class="fa fa-university" aria-hidden="true"></i>&nbsp;&nbsp;UOM Master</a></li>

                                    <li id="Li1" class=""><a data-toggle="tab" href="#" onclick="showstateMaster()" aria-expanded="false">
                                    <i class="fa fa-university" aria-hidden="true"></i>&nbsp;&nbsp;State Master</a></li>

                                    <li id="Li3" class=""><a data-toggle="tab" href="#" onclick="showtaxregtypeMaster()" aria-expanded="false">
                                    <i class="fa fa-university" aria-hidden="true"></i>&nbsp;&nbsp;Regtype Master</a></li>

                                    <%--<li id="Li4" class=""><a data-toggle="tab" href="#" onclick="showdinaminationMaster()" aria-expanded="false">
                                    <i class="fa fa-university" aria-hidden="true"></i>&nbsp;&nbsp;Denomination Master</a></li>--%>
                            </ul>
                        </div>
                        <div id="div_category" style="display: block;">
                            <div class="box-header with-border">
                                <h3 class="box-title">
                                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Category Master
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
                                                <label for="focus_add_item">Category</label>
                                                <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtcategory">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">Category Code</label> 
                                               <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtcategorycode">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="print_bill">Status</label> 
                                                <select name="language" class="form-control tip select2 select2-hidden-accessible" id="slctcstatus" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
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
                             <input type="button" name="update" value="Save" class="btn btn-primary" id="btncsave" onclick="btncategoryclick();"></div>
                    </div>

                           <div class="row" id="divbind">
        <div class="col-xs-12">
            <div class="box box-primary">
                         <div id="divcatdata"></div>
        </div>

                
            </div>
        </div>
                        </div>

                        <div id="div_subcategory" style="display: none;">
                            <div class="box-header with-border">
                                <h3 class="box-title">
                                    <i style="padding-right: 5px;" class="fa fa-cog"></i>SubCategory Master
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
                                                <label for="print_bill">Category</label> 
                                                <select  class="form-control" id="slctcategory" required="required" style="width:100%;"  tabindex="-1" aria-hidden="true">
                                                    
                                                 </select>
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="focus_add_item">Sub Category</label>
                                                <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtsubcategory">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="add_customer">Sub Category Code</label> 
                                               <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtsubcatcode">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="print_bill">Status</label> 
                                                <select name="language" class="form-control tip select2 select2-hidden-accessible" id="slctsubcatstatus" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
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
                             <input type="button" name="update" value="Save" class="btn btn-primary" id="btnsubcat" onclick="btnsubcategorysave();"></div>

                             
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
                                    <i style="padding-right: 5px;" class="fa fa-cog"></i>UOM Master
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
                                                <label for="focus_add_item">UOM</label>
                                                <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtuom">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <label for="print_bill">Status</label> 
                                                <select name="language" class="form-control tip select2 select2-hidden-accessible" id="slctuom" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
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
                             <input type="button" name="update" value="Save" class="btn btn-primary" id="btnuom" onclick="btnuomsave();"></div>

                             
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


                      <div id="divdinaminations" style="display: none;"> 
                            <div class="box-header with-border">
                                <h3 class="box-title">
                                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Dinaminations Master
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
                                                <label for="focus_add_item">Dinaminations Type</label>
                                                <input type="text" name="toggle_category_slider" value="" class="form-control tip" id="txtdinamination">
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4"> 
                                            <div class="form-group">
                                                <label for="print_bill">Status</label> 
                                                <select name="language" class="form-control tip select2 select2-hidden-accessible" id="slctdinamination" required="required" style="width:100%;" data-fv-field="language" tabindex="-1" aria-hidden="true">
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
                             <input type="button" name="update" value="Save" class="btn btn-primary" id="btndinamination" onclick="btndinaminationsave();"></div>

                             
                        </div>
                        <div class="row" id="div3">
        <div class="col-xs-12">
            <div class="box box-primary">
                         <div id="divdinaminationdata"></div>
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
