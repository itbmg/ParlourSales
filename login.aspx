<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>Login | SimplePOS</title>
    <link rel="shortcut icon" href="">
    <%--<link href="https://spos.tecdiary.com/themes/default/assets/dist/css/styles.css"
        rel="stylesheet" type="text/css" />--%>
    <link href="css/styles.css" rel="stylesheet" type="text/css" />
    <script src="css/jQuery-2.1.4.min.js" type="text/javascript"></script>
    <script type='text/javascript'>
        function Validate() {
            var msg = document.getElementById('<%=lblMsg.ClientID %>');
            if (document.getElementById('<%=txtusername.ClientID %>').value.length == 0) {
                msg.innerHTML = "Please enter user name ";
                msg.style.color = "red";
                document.getElementById('<%=txtusername.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%=txtpassword.ClientID %>').value.length == 0) {
                msg.innerHTML = "Please enter password ";
                msg.style.color = "red";
                document.getElementById('<%=txtpassword.ClientID %>').focus();
                return false;
            }
            msg.innerHTML = "";
            return true;
        }
       // msg.innerHTML = "";
    </script>
    <script src="finger/jquery-1.8.2.js"></script>
    <script src="finger/mfs100-9.0.2.6.js"></script>
    <script language="javascript" type="text/javascript">
        var quality = 100; //(1 to 100) (recommanded minimum 55)
        var timeout = 10; // seconds (minimum=10(recommanded), maximum=60, unlimited=0 )
        function GetInfo() {
            document.getElementById('tdSerial').innerHTML = "";
            document.getElementById('tdCertification').innerHTML = "";
            document.getElementById('tdMake').innerHTML = "";
            document.getElementById('tdModel').innerHTML = "";
            document.getElementById('tdWidth').innerHTML = "";
            document.getElementById('tdHeight').innerHTML = "";
            document.getElementById('tdLocalMac').innerHTML = "";
            document.getElementById('tdLocalIP').innerHTML = "";
            document.getElementById('tdSystemID').innerHTML = "";
            document.getElementById('tdPublicIP').innerHTML = "";

            var key = document.getElementById('txtKey').value;

            var res;
            if (key.length == 0) {
                res = GetMFS100Info();
            }
            else {
                res = GetMFS100KeyInfo(key);
            }

            if (res.httpStaus) {

                document.getElementById('txtStatus').value = "ErrorCode: " + res.data.ErrorCode + " ErrorDescription: " + res.data.ErrorDescription;

                if (res.data.ErrorCode == "0") {
                    document.getElementById('tdSerial').innerHTML = res.data.DeviceInfo.SerialNo;
                    document.getElementById('tdCertification').innerHTML = res.data.DeviceInfo.Certificate;
                    document.getElementById('tdMake').innerHTML = res.data.DeviceInfo.Make;
                    document.getElementById('tdModel').innerHTML = res.data.DeviceInfo.Model;
                    document.getElementById('tdWidth').innerHTML = res.data.DeviceInfo.Width;
                    document.getElementById('tdHeight').innerHTML = res.data.DeviceInfo.Height;
                    document.getElementById('tdLocalMac').innerHTML = res.data.DeviceInfo.LocalMac;
                    document.getElementById('tdLocalIP').innerHTML = res.data.DeviceInfo.LocalIP;
                    document.getElementById('tdSystemID').innerHTML = res.data.DeviceInfo.SystemID;
                    document.getElementById('tdPublicIP').innerHTML = res.data.DeviceInfo.PublicIP;
                }
            }
            else {
                alert(res.err);
            }
            return false;
        }

        function Capture() {
            try {
                document.getElementById('txtStatus').value = "";
                document.getElementById('imgFinger').src = "data:image/bmp;base64,";
                document.getElementById('txtImageInfo').value = "";
                document.getElementById('txtIsoTemplate').value = "";
                document.getElementById('txtAnsiTemplate').value = "";
                document.getElementById('txtIsoImage').value = "";
                document.getElementById('txtRawData').value = "";
                document.getElementById('txtWsqData').value = "";

                var res = CaptureFinger(quality, timeout);
                if (res.httpStaus) {

                    document.getElementById('txtStatus').value = "ErrorCode: " + res.data.ErrorCode + " ErrorDescription: " + res.data.ErrorDescription;

                    if (res.data.ErrorCode == "0") {
                        document.getElementById('imgFinger').src = "data:image/bmp;base64," + res.data.BitmapData;
                        var imageinfo = "Quality: " + res.data.Quality + " Nfiq: " + res.data.Nfiq + " W(in): " + res.data.InWidth + " H(in): " + res.data.InHeight + " area(in): " + res.data.InArea + " Resolution: " + res.data.Resolution + " GrayScale: " + res.data.GrayScale + " Bpp: " + res.data.Bpp + " WSQCompressRatio: " + res.data.WSQCompressRatio + " WSQInfo: " + res.data.WSQInfo;
                        document.getElementById('txtImageInfo').value = imageinfo;
                        document.getElementById('txtIsoTemplate').value = res.data.IsoTemplate;
                        document.getElementById('txtAnsiTemplate').value = res.data.AnsiTemplate;
                        document.getElementById('txtIsoImage').value = res.data.IsoImage;
                        document.getElementById('txtRawData').value = res.data.RawData;
                        document.getElementById('txtWsqData').value = res.data.WsqImage;
                    }
                }
                else {
                    alert(res.err);
                }
            }
            catch (e) {
                alert(e);
            }
            return false;
        }
        function btnClearclick() {
            document.getElementById('imgFinger').src = "data:image/bmp;base64,";
            return false;
        }
        function Verify() {
            try {
                var isotemplate = document.getElementById('txtIsoTemplate').value;
                var res = VerifyFinger(isotemplate, isotemplate);

                if (res.httpStaus) {
                    if (res.data.Status) {
                        alert("Finger matched");
                    }
                    else {
                        if (res.data.ErrorCode != "0") {
                            alert(res.data.ErrorDescription);
                        }
                        else {
                            alert("Finger not matched");
                        }
                    }
                }
                else {
                    alert(res.err);
                }
            }
            catch (e) {
                alert(e);
            }
            return false;

        }

        function Match() {
            try {
                var isotemplate = document.getElementById('txtIsoTemplate').value;
                var res = MatchFinger(quality, timeout, isotemplate);

                if (res.httpStaus) {
                    if (res.data.Status) {
                        alert("Finger matched");
                    }
                    else {
                        if (res.data.ErrorCode != "0") {
                            alert(res.data.ErrorDescription);
                        }
                        else {
                            alert("Finger not matched");
                        }
                    }
                }
                else {
                    alert(res.err);
                }
            }
            catch (e) {
                alert(e);
            }
            return false;

        }

        function GetPid() {
            try {
                var isoTemplateFMR = document.getElementById('txtIsoTemplate').value;
                var isoImageFIR = document.getElementById('txtIsoImage').value;

                var Biometrics = Array(); // You can add here multiple FMR value
                Biometrics["0"] = new Biometric("FMR", isoTemplateFMR, "UNKNOWN", "", "");

                var res = GetPidData(Biometrics);
                if (res.httpStaus) {
                    if (res.data.ErrorCode != "0") {
                        alert(res.data.ErrorDescription);
                    }
                    else {
                        document.getElementById('txtPid').value = res.data.PidData.Pid
                        document.getElementById('txtSessionKey').value = res.data.PidData.Sessionkey
                        document.getElementById('txtHmac').value = res.data.PidData.Hmac
                        document.getElementById('txtCi').value = res.data.PidData.Ci
                        document.getElementById('txtPidTs').value = res.data.PidData.PidTs
                    }
                }
                else {
                    alert(res.err);
                }

            }
            catch (e) {
                alert(e);
            }
            return false;
        }
        function GetProtoPid() {
            try {
                var isoTemplateFMR = document.getElementById('txtIsoTemplate').value;
                var isoImageFIR = document.getElementById('txtIsoImage').value;

                var Biometrics = Array(); // You can add here multiple FMR value
                Biometrics["0"] = new Biometric("FMR", isoTemplateFMR, "UNKNOWN", "", "");

                var res = GetProtoPidData(Biometrics);
                if (res.httpStaus) {
                    if (res.data.ErrorCode != "0") {
                        alert(res.data.ErrorDescription);
                    }
                    else {
                        document.getElementById('txtPid').value = res.data.PidData.Pid
                        document.getElementById('txtSessionKey').value = res.data.PidData.Sessionkey
                        document.getElementById('txtHmac').value = res.data.PidData.Hmac
                        document.getElementById('txtCi').value = res.data.PidData.Ci
                        document.getElementById('txtPidTs').value = res.data.PidData.PidTs
                    }
                }
                else {
                    alert(res.err);
                }

            }
            catch (e) {
                alert(e);
            }
            return false;
        }
        function GetRbd() {
            try {
                var isoTemplateFMR = document.getElementById('txtIsoTemplate').value;
                var isoImageFIR = document.getElementById('txtIsoImage').value;

                var Biometrics = Array();
                Biometrics["0"] = new Biometric("FMR", isoTemplateFMR, "LEFT_INDEX", 2, 1);
                Biometrics["1"] = new Biometric("FMR", isoTemplateFMR, "LEFT_MIDDLE", 2, 1);
                // Here you can pass upto 10 different-different biometric object.


                var res = GetRbdData(Biometrics);
                if (res.httpStaus) {
                    if (res.data.ErrorCode != "0") {
                        alert(res.data.ErrorDescription);
                    }
                    else {
                        document.getElementById('txtPid').value = res.data.RbdData.Rbd
                        document.getElementById('txtSessionKey').value = res.data.RbdData.Sessionkey
                        document.getElementById('txtHmac').value = res.data.RbdData.Hmac
                        document.getElementById('txtCi').value = res.data.RbdData.Ci
                        document.getElementById('txtPidTs').value = res.data.RbdData.RbdTs
                    }
                }
                else {
                    alert(res.err);
                }

            }
            catch (e) {
                alert(e);
            }
            return false;
        }

        function GetProtoRbd() {
            try {
                var isoTemplateFMR = document.getElementById('txtIsoTemplate').value;
                var isoImageFIR = document.getElementById('txtIsoImage').value;

                var Biometrics = Array();
                Biometrics["0"] = new Biometric("FMR", isoTemplateFMR, "LEFT_INDEX", 2, 1);
                Biometrics["1"] = new Biometric("FMR", isoTemplateFMR, "LEFT_MIDDLE", 2, 1);
                // Here you can pass upto 10 different-different biometric object.


                var res = GetProtoRbdData(Biometrics);
                if (res.httpStaus) {
                    if (res.data.ErrorCode != "0") {
                        alert(res.data.ErrorDescription);
                    }
                    else {
                        document.getElementById('txtPid').value = res.data.RbdData.Rbd
                        document.getElementById('txtSessionKey').value = res.data.RbdData.Sessionkey
                        document.getElementById('txtHmac').value = res.data.RbdData.Hmac
                        document.getElementById('txtCi').value = res.data.RbdData.Ci
                        document.getElementById('txtPidTs').value = res.data.RbdData.RbdTs
                    }
                }
                else {
                    alert(res.err);
                }

            }
            catch (e) {
                alert(e);
            }
            return false;
        }
    </script>
</head>
<body class="login-page login-page-green rtl rtl-inv">
    
    <div class="login-box">
        <div class="login-logo">
            <a href="#">Vyshnavi<b>POS</b></a>
        </div>
        <div class="login-box-body">
            <p class="login-box-msg">
                Please login to your account.</p>
            <form id="FORM1" runat="server">
            <div class="form-group has-feedback">
                <asp:textbox id="txtusername" runat="server" placeholder="Username" type="name" cssclass="form-control">
                </asp:textbox>
                <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <asp:textbox id="txtpassword" runat="server" placeholder="Password" type="password"
                    cssclass="form-control">
                </asp:textbox>
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>
            <div class="checkbox pull-left" style="margin-top: 0;">
                <div class="custom-checkbox">
                    <div class="icheckbox_square-blue checked" aria-checked="false" aria-disabled="false"
                        style="position: relative; background: url(~/blue.png) no-repeat;">
                        <input type="checkbox" name="remember" value="1" checked="checked" id="remember"
                            style="position: absolute; top: -20%; left: -20%; display: block; width: 140%;
                            height: 140%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px;
                            opacity: 0;">
                        <ins class="iCheck-helper" style="position: absolute; top: -20%; left: -20%; display: block;
                            width: 140%; height: 140%; margin: 0px; padding: 0px; background: rgb(255, 255, 255);
                            border: 0px; opacity: 0;"></ins>
                    </div>
                    <label for="remember" style="padding-left: 5px;">
                        Remember me</label>
                </div>
            </div>
            <asp:button id="login_btn" text="Login" runat="server" onclientclick="return Validate();"
                onclick="login_click" class="btn btn-primary btn-block btn-flat" />
            </form>
            <div class="">
                <asp:label id="lblMsg" runat="server" forecolor="Red" font-size="15px" font-bold="true">
                </asp:label>
                <p>
                    &nbsp;</p>
                <p>
                    <span class="text-danger">Forgot your password?</span><br>
                    Don't worry! <a href="#" class="text-danger" data-toggle="modal" data-target="#myModal">
                        click here</a> To Reset
                </p>
                <p>
                    <span class="text-danger">New User?</span><br>
                    Don't worry! <a href="#" class="text-danger" data-toggle="modal" data-target="#mymodelreg">
                        click here</a> To Register
                </p>
            </div>
            <div>
                <p>
                    <span class="text-danger">Download Offline Application</span><br>
                    Don't worry! <a href="download.html" class="text-danger">click here</a>
                </p>
            </div>
        </div>
    </div>
    <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1"
        id="myModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="forgot_password" method="post" accept-charset="utf-8">
                <input type="hidden" name="spos_token" value="43d93d3a8eb973b4b8cb1d6e020da298">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        ×</button>
                    <h4 class="modal-title">
                        Forgot Password?</h4>
                </div>
                <div class="modal-body">
                    <p>
                        Enter your e-mail address below to reset your password.</p>
                    <input type="email" name="forgot_email" placeholder="Email" autocomplete="off" class="form-control placeholder-no-fix">
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default pull-left" type="button">
                        Close</button>
                    <button class="btn btn-primary" type="submit">
                        Submit</button>
                </div>
                </form>
            </div>
        </div>
    </div>
    <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1"
        id="mymodelreg" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="forgot_password" method="post" accept-charset="utf-8">
                <input type="hidden" name="spos_token" value="43d93d3a8eb973b4b8cb1d6e020da298">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        ×</button>
                    <h4 class="modal-title">
                        User Register</h4>
                </div>
                <div class="modal-body">
                    <div class="col-lg-12">
                        <div class="clearfix">
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="well well-sm">
                                    <div class="col-md-4 col-sm-4">
                                        <div class="form-group">
                                            <label for="focus_add_item">
                                                Employe Name</label>
                                            <input type="text" name="toggle_category_slider" value="" class="form-control tip"
                                                id="txtempname">
                                        </div>
                                    </div>
                                    <div class="col-md-4 col-sm-4">
                                        <div class="form-group">
                                            <label for="add_customer">
                                                User Name</label>
                                            <input type="text" name="toggle_category_slider" value="" class="form-control tip"
                                                id="Text1">
                                        </div>
                                    </div>
                                    <div class="col-md-4 col-sm-4">
                                        <div class="form-group">
                                            <label for="add_customer">
                                                Passward</label>
                                            <input type="password" name="toggle_category_slider" value="" class="form-control tip"
                                                id="Password1">
                                        </div>
                                    </div>
                                    <div class="col-md-4 col-sm-4">
                                        <div class="form-group">
                                            <label for="add_customer">
                                                Mobile No</label>
                                            <input type="text" name="toggle_category_slider" value="" class="form-control tip"
                                                id="txtmobileno">
                                        </div>
                                    </div>
                                    <div class="col-md-4 col-sm-4">
                                        <div class="form-group">
                                            <label for="add_customer">
                                                EmailId</label>
                                            <input type="text" name="toggle_category_slider" value="" class="form-control tip"
                                                id="txtemailid">
                                        </div>
                                    </div>
                                    <div class="col-md-4 col-sm-4">
                                        <div class="form-group">
                                            <label for="add_customer">
                                                Adhar No</label>
                                            <input type="text" name="toggle_category_slider" value="" class="form-control tip"
                                                id="txtadharno">
                                        </div>
                                    </div>
                                    <div class="col-md-12 col-sm-12">
                                        <div class="form-group">
                                            <label for="add_customer">
                                                Address</label>
                                            <textarea id="txtempaddress" class="form-control"></textarea>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <table width="100%" style="padding-top: 0px;">
                                <tr>
                                    <td width="200px;">
                                        <table align="left" border="0" width="100%">
                                            <tr >
                                                <td style="display:none;">
                                                    <input type="submit" id="btnInfo" value="Get Info" class="btn btn-primary btn-100"
                                                        onclick="return GetInfo()" />
                                                </td>
                                                <td>
                                                    <input type="submit" id="btnCapture" value="Capture" class="btn btn-primary btn-100"
                                                        onclick="return Capture()" />
                                                </td>
                                                 <td>
                                                    <input type="submit" id="Clear" value="Clear" class="btn btn-primary btn-100"
                                                        onclick="return btnClearclick()" />
                                                </td>
                                            </tr>
                                            <tr style="display:none;">
                                                <td colspan="2">
                                                    <input type="submit" id="btnCaptureAndMatch" value="Capture and Match" class="btn btn-primary btn-200"
                                                        onclick="return Match()" />
                                                </td>
                                            </tr>
                                            <tr style="display:none;">
                                                <td colspan="2">
                                                    <input type="submit" id="btnMatch" value="Match" class="btn btn-primary btn-200"
                                                        onclick="return Verify()" />
                                                </td>
                                            </tr>
                                            <tr style="display:none;">
                                                <td>
                                                    <input type="submit" id="btnGetPid" value="Get PID (X)" class="btn btn-primary btn-100"
                                                        onclick="return GetPid()" />
                                                </td>
                                                <td>
                                                    <input type="submit" id="btnProtoGetPid" value="Get PID (P)" class="btn btn-primary btn-100"
                                                        onclick="return GetProtoPid()" />
                                                </td>
                                            </tr>
                                            <tr style="display:none;">
                                                <td>
                                                    <input type="submit" id="btnGetRbd" value="Get RBD (X)" class="btn btn-primary btn-100"
                                                        onclick="return GetRbd()" />
                                                </td>
                                                <td>
                                                    <input type="submit" id="btnProtoGetRbd" value="Get RBD (P)" class="btn btn-primary btn-100"
                                                        onclick="return GetProtoRbd()" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td width="150px" height="190px" align="center" class="img">
                                        <img id="imgFinger" width="145px" height="188px" alt="Finger Image" />
                                    </td>
                                    <td style="display:none;">
                                        <table align="left" border="0" style="width: 100%; padding-right: 20px;">
                                            <tr style="display:none;">
                                                <td style="width: 100px;">
                                                    Key:
                                                </td>
                                                <td colspan="3">
                                                    <input type="text" value="" id="txtKey" class="form-control" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" style="width: 100px;">
                                                    Serial No:
                                                </td>
                                                <td align="left" style="width: 150px;" id="tdSerial">
                                                </td>
                                                <td align="left" style="width: 100px;">
                                                    Certification:
                                                </td>
                                                <td align="left" id="tdCertification">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    Make:
                                                </td>
                                                <td align="left" id="tdMake">
                                                </td>
                                                <td align="left">
                                                    Model:
                                                </td>
                                                <td align="left" id="tdModel">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    Width:
                                                </td>
                                                <td align="left" id="tdWidth">
                                                </td>
                                                <td align="left">
                                                    Height:
                                                </td>
                                                <td align="left" id="tdHeight">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    Local IP
                                                </td>
                                                <td align="left" id="tdLocalIP">
                                                </td>
                                                <td align="left">
                                                    Local MAC:
                                                </td>
                                                <td align="left" id="tdLocalMac">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    Public IP
                                                </td>
                                                <td align="left" id="tdPublicIP">
                                                </td>
                                                <td align="left">
                                                    System ID
                                                </td>
                                                <td align="left" id="tdSystemID">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <div class="panel" style="display: none;">
                                <table width="100%">
                                    <tr>
                                        <td width="220px">
                                            Status:
                                        </td>
                                        <td>
                                            <input type="text" value="" id="txtStatus" class="form-control" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Quality:
                                        </td>
                                        <td>
                                            <input type="text" value="" id="txtImageInfo" class="form-control" />
                                        </td>
                                    </tr>
                                    <!--<tr>
                <td>
                    NFIQ:
                </td>
                <td>
                    <input type="text" value="" id="txtNFIQ" class="form-control" />
                </td>
            </tr>-->
                                    <tr>
                                        <td>
                                            Base64Encoded ISO Template
                                        </td>
                                        <td>
                                            <textarea id="txtIsoTemplate" style="width: 100%; height: 50px;" class="form-control"> </textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Base64Encoded ANSI Template
                                        </td>
                                        <td>
                                            <textarea id="txtAnsiTemplate" style="width: 100%; height: 50px;" class="form-control"> </textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Base64Encoded ISO Image
                                        </td>
                                        <td>
                                            <textarea id="txtIsoImage" style="width: 100%; height: 50px;" class="form-control"> </textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Base64Encoded Raw Data
                                        </td>
                                        <td>
                                            <textarea id="txtRawData" style="width: 100%; height: 50px;" class="form-control"> </textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Base64Encoded Wsq Image Data
                                        </td>
                                        <td>
                                            <textarea id="txtWsqData" style="width: 100%; height: 50px;" class="form-control"> </textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Encrypted Base64Encoded Pid/Rbd
                                        </td>
                                        <td>
                                            <textarea id="txtPid" style="width: 100%; height: 50px;" class="form-control"> </textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Encrypted Base64Encoded Session Key
                                        </td>
                                        <td>
                                            <textarea id="txtSessionKey" style="width: 100%; height: 50px;" class="form-control"> </textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Encrypted Base64Encoded Hmac
                                        </td>
                                        <td>
                                            <input type="text" value="" id="txtHmac" class="form-control" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Ci
                                        </td>
                                        <td>
                                            <input type="text" value="" id="txtCi" class="form-control" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Pid/Rbd Ts
                                        </td>
                                        <td>
                                            <input type="text" value="" id="txtPidTs" class="form-control" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button data-dismiss="modal" class="btn btn-default pull-left" type="button">
                            Close</button>
                        <button class="btn btn-primary" type="submit">
                            Submit</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="css/jQuery-2.1.4.min.js" type="text/javascript"></script>
    <script src="https://spos.tecdiary.com/themes/default/assets/bootstrap/js/bootstrap.min.js"
        type="text/javascript"></script>
    <script src="https://spos.tecdiary.com/themes/default/assets/plugins/iCheck/icheck.min.js"
        type="text/javascript"></script>
    <script>
        $(function () {
            if ($('#identity').val())
                $('#password').focus();
            else
                $('#identity').focus();
            $('input').iCheck({
                checkboxClass: 'icheckbox_square-blue',
                radioClass: 'iradio_square-blue',
                increaseArea: '20%'
            });
        });
    </script>
</body>
</html>
