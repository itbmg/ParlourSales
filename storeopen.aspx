<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="storeopen.aspx.cs" Inherits="storeopen" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(function () {
           // get_denamination_details();
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
            var results = '<div  class="box-body"><table class="table table-bordered dataTable no-footer" role="grid" aria-="" describedby="example2_info" id="tbldino">';
            results += '<thead><tr><th scope="col">Sno</th><th scope="col">Denamination Type</th><th scope="col">Count</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                var k = i + 1;
                results += '<tr>';
                results += '<td scope="row" class="1" >' + k + '</td>';
                results += '<td scope="row" class="2" style="text-align: center; font-weight: bold;" ><span id="spn_dinamination">' + msg[i].dinaminationtype + '</span></td>';
                results += '<td><input id="txt_quantity" type="text" class="form-control" value="" name="quantity"/></td>';
                results += '<td style="display:none" class="7"><input id="hdnsno" type="hidden" value="' + msg[i].sno + '"></td></tr>';
            }
            results += '</table></div>';
            $("#divdinaminationdata").html(results);
        }
        function btnopenregisterclick() {
            var cashinhand = document.getElementById('txtcashinhand').value;
            if (cashinhand == "") {
                alert("Enter cashinhand");
                document.getElementById('txtcashinhand').focus();
                return false;
            }
            var btnval = document.getElementById('btnopen').value;
            var data = { 'op': 'save_openregisterDetails', 'cashinhand': cashinhand, 'btnval': btnval };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        cmpforclearall();
                        window.open("vpos.aspx", "_self");
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
            document.getElementById('txtcashinhand').value = "";
        }
    </script>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">
                        Please fill in the information below</h3>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4 col-sm-4">
                            <div class="well well-sm col-sm-12">
                                <label for="cash_in_hand">
                                    Cash in hand</label>
                                <input type="text" name="cash_in_hand" value="" id="txtcashinhand" class="form-control">
                            </div>
                        </div>
                        <div class="col-md-4 col-sm-4">
                            <div class="well well-sm col-sm-12">
                                <div id="divdinaminationdata">
                                </div>
                                 <input type="button" value="Open Register" class="btn btn-primary" id="btnopen" onclick="btnopenregisterclick();">
                            </div>
                        </div>
                       
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:content>
