
<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" ValidateRequest="false" AutoEventWireup="true" CodeFile="MsgOp.aspx.cs" Inherits="Admin_MsgOp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 class="Title BorderBottom"><%=name %></h1>
    
    <asp:HyperLink ID="HyperLink2" CssClass="tdn fl" NavigateUrl="#" runat="server"><h5><i class="fa fa-backward"></i> رجوع</h5></asp:HyperLink>
    <div class="clear PT20"></div>
    <section>
        <asp:Panel ID="Panel1"  runat="server">
            <table class="tblConListOpt">
                
                
                <tr>
                    <td>
                        <asp:Label ID="Label9" runat="server" Text="المرسل" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblName" CssClass="Bold" runat="server" Text=""></asp:Label>
                    </td>
                    <td></td>
                </tr>
                
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="تاريخ الارسال" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblAddDate" CssClass="Bold" runat="server" Text=""></asp:Label>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label5" runat="server" Text="عنوان الرسالة" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblSubject" CssClass="Bold" runat="server" Text=""></asp:Label>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label6" runat="server" Text="نص الرسالة" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblTxt" CssClass="Bold" runat="server" Text=""></asp:Label>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <a href="MsgList.aspx" class="btnLogin2 fr">رجوع</a>
                        <asp:LinkButton OnClick="btnSendMsg_OnClick" ID="btnSendMsg" CssClass="btnLogin fr" runat="server">ارسال رد</asp:LinkButton>
                        
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </section>
    <script>
        $(function() {
            
            

        });
    </script>
</asp:Content>




