<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" ValidateRequest="false" AutoEventWireup="true" CodeFile="DocumentOp.aspx.cs" Inherits="Admin_DocumentOp" %>

<%@ Register Src="~/controls/hijriCalender.ascx" TagPrefix="uc1" TagName="hijriCalender" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 class="Title BorderBottom"><%=name %></h1>

    <asp:HyperLink ID="HyperLink2" CssClass="tdn fl" NavigateUrl="DocumentList.aspx" runat="server"><h5><i class="fa fa-backward"></i> رجوع</h5></asp:HyperLink>
    <div class="clear PT20"></div>
    <section>
        <asp:Panel ID="Panel1" DefaultButton="btnSave" runat="server">
            <table class="tblConListOpt">
                

                <tr>
                    <td>
                        <asp:Label ID="Label9" runat="server" Text="موضوع المعاملة" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtTitle" ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="رقم القيد" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtNo1" Width="150" ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox> / 
                        <asp:TextBox ID="txtNo2" Width="150" ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label7" runat="server" Text="فئة المعاملة" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="ddlCat" CssClass="ddl1" runat="server">
                            
                        </asp:DropDownList>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="سرية المعاملة" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="ddlSec" CssClass="ddl1" runat="server">
                            
                        </asp:DropDownList>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="الوضع القانوني" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="ddlLegal" CssClass="ddl1" runat="server">
                            
                        </asp:DropDownList>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        المعاملات المرتبطة
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    المعاملة رقم 1
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlRDoc1" CssClass="ddl1" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    المعاملة رقم 2
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlRDoc2" CssClass="ddl1" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    المعاملة رقم 3
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlRDoc3" CssClass="ddl1" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                
                <tr>
                    <td colspan="2">
                        <a href="DocumentList.aspx" class="btnLogin2 fr">الغاء</a>
                        <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" ValidationGroup="Option3" Text="حفظ" CssClass="btnLogin fr" />

                    </td>
                </tr>
            </table>
        </asp:Panel>
    </section>
    
</asp:Content>




