<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Dailyreport.aspx.cs" Inherits="Dailyreport" %>
   <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<script type="text/javascript">
    function CallPrint(strid) {
        var divToPrint = document.getElementById(strid);
        var newWin = window.open('', 'Print-Window', 'width=400,height=400,top=100,left=100');
        newWin.document.open();
        newWin.document.write('<html><body   onload="window.print()">' + divToPrint.innerHTML + '</body></html>');
        newWin.document.close();
    }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">
                        Daily Report</h3>
                </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-12 col-sm-12">
                            <div class="well well-sm col-sm-12">
                            <table style="width:100%;">
                            <tr>
                            <td>
                             <label for="cash_in_hand">
                                    Date</label>
                                <asp:TextBox ID="dtp_FromDate" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:CalendarExtender ID="stcalender" runat="server" Enabled="True"
                                    TargetControlID="dtp_FromDate" Format="dd-MM-yyyy HH:mm">
                                </asp:CalendarExtender>
                            </td>
                            <td style="width:2%;"></td>
                            <td>
                            <asp:Button ID="Button2" runat="server" Text="GENERATE" CssClass="btn btn-success"
                                    OnClick="btn_Generate_Click" />
                            </td>
                            <td>
                             <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/exporttoxl.aspx">Export to xl</asp:HyperLink>
                            </td>
                            <td>
                            
                            </td>
                            <td>
                            <button type="button" class="btn btn-success"  onclick ="javascript:CallPrint('divPrint');"><i class="fa fa-print"></i> Print</button>
                            </td>

                            </tr>
                            </table>
                               
                                  
                            </div>
                           
                        </div>
                    </div>
                    <div style="padding-left:40%;">
                        <table >
                            <tr>
                                <td><asp:Label ID="Label2" runat="server" Font-Bold="true">Cash:</asp:Label></td>
                                <td><asp:Label ID="lblCash" runat="server" Font-Bold="true"  ForeColor="Green" Font-Size="20px"></asp:Label></td>
                                <td style="width:5px;"></td>
                                <td><asp:Label ID="Label1" runat="server" Font-Bold="true" >Phone Pay:</asp:Label></td>
                                <td><asp:Label ID="lblPhonePay" runat="server" Font-Bold="true" ForeColor="Green" Font-Size="20px"></asp:Label></td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-xs-12">
                        <div class="box box-primary" id="divPrint">
                            <asp:GridView ID="grdreport" runat="server" ForeColor="White" Width="100%" CssClass="gridcls"
                                GridLines="Both" Font-Bold="true" OnRowDataBound="grdsiloopening_RowDataBound">
                                <EditRowStyle BackColor="#999999" />
                                <FooterStyle BackColor="Gray" Font-Bold="False" ForeColor="White" />
                                <HeaderStyle BackColor="#f4f4f4" Font-Bold="False" ForeColor="Black" Font-Italic="False"
                                    Font-Names="Raavi" Font-Size="Small" />
                                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#ffffff" ForeColor="#333333" HorizontalAlign="Center" />
                                <AlternatingRowStyle HorizontalAlign="Center" />
                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
