<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="RatesManage.aspx.cs" Inherits="RatesManage" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdateProgress ID="updateProgress1" runat="server">
        <ProgressTemplate>
            <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0;
                right: 0; left: 0; z-index: 9999999; background-color: #FFFFFF; opacity: 0.7;">
                <br />
                <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="thumbnails/loading.gif"
                    AlternateText="Loading ..." ToolTip="Loading ..." Style="padding: 10px; position: absolute;
                    top: 35%; left: 40%;" />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div>
        <section class="content-header">
            <h1>
                Import Report<small>Preview</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i>Reports</a></li>
                <li><a href="#">Import Report</a></li>
            </ol>
            <div class="box box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">
                        <i style="padding-right: 5px;" class="fa fa-cog"></i>Import Details
                    </h3>
                </div>
                <div class="box-body" style="overflow:scroll;">
                    <table style="width:100%;">
                        <tr>
                            <td style="float: left;">
                                          
                                 <asp:Button ID="Button1" runat="server" Text="Generate" class="btn btn-primary"
     OnClick="btnGenerate_Click" />
                                        </td>
                             <td style="width:5px;">
</td>
                             <td style="float: left;">
                           <%-- <asp:Button ID="Button3" Text="Export To Excel" runat="server" CssClass="btn btn-primary"
                                OnClick="btn_Export_Click" />--%>
  <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/exporttoxl.aspx">Export to xl</asp:HyperLink>
                        </td>
                         <td style="width:5px;">
                        </td>
                           
                                        <td style="width: 25%;">
                                            <asp:FileUpload ID="FileUploadToServer" runat="server" Style="height: 25px; font-size: 16px;" />&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <asp:Button ID="Button2" Text="Import" runat="server" CssClass="btn btn-primary"
                                                OnClick="btn_Import_Click" />
                                        </td>
                            
                        </tr>
                    </table>
                    
                    <br />
                    <asp:Label ID="lblMessage" runat="server" Visible="False" Font-Bold="True" ForeColor="#009933"></asp:Label><br />
                    <asp:UpdatePanel ID="updPanel" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="grvExcelData" runat="server">
                                <HeaderStyle BackColor="#df5015" Font-Bold="true" ForeColor="White" />
                            </asp:GridView>
                            </dr>
                            <asp:Label ID="lblmsg" Text="" runat="server" ForeColor="Red"></asp:Label>
                            <asp:Button ID="btnsave" runat="server" Visible="false" Text="save" class="btn btn-primary"
                                OnClick="btnSave_Click" />
                        </ContentTemplate>
                    </asp:UpdatePanel>

                     <asp:GridView ID="grdmiss" runat="server">
                                <HeaderStyle BackColor="#df5015" Font-Bold="true" ForeColor="White" />
                            </asp:GridView>
                   
                </div>
            </div>
        </section>
    </div>
</asp:Content>
