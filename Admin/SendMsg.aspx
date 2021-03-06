﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="SendMsg.aspx.cs" Inherits="Admin_SendMsg" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="/js/jquery.tokeninput.js"></script>
    <link href="/css/token-input.css" rel="stylesheet" />
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 class="Title BorderBottom"><%=name %></h1>

    <asp:HyperLink ID="HyperLink1" NavigateUrl="Default.aspx" CssClass="tdn fl" runat="server"><h5><i class="fa fa-backward"></i> رجوع</h5></asp:HyperLink>

    <div class="clear"></div>

    
        <table class="tblConListOpt">


            <tr>
                <td></td>
                <td>
                    <asp:CheckBox CssClass="label_xblack" AutoPostBack="True" OnCheckedChanged="CheckBox1_OnCheckedChanged" ID="CheckBox1" Text="مراسلة جميع المستخدمين" runat="server" />
                </td>
                <td></td>
            </tr>
            <tr id="rowData" runat="server">
                <td>
                    <asp:Label ID="Label9" runat="server" Text="المستخدمين" CssClass="label_xblack"></asp:Label></td>
                <td>
                    <asp:TextBox ID="txtResearchList" ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label5" runat="server" Text="عنوان الرسالة" CssClass="label_xblack"></asp:Label></td>
                <td>
                    <asp:TextBox ID="txtSubject" ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label6" runat="server" Text=" الرسالة" CssClass="label_xblack"></asp:Label></td>
                <td>
                    <asp:TextBox ID="txtTxt" ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox>
                </td>
                <td></td>
            </tr>
            
            <tr>
                <td colspan="2">
                    <a href="Default.aspx" class="btnLogin2 fr">الغاء</a>
                    <asp:Button ID="btnSave" runat="server" OnClick="btnSave_OnClick" ValidationGroup="Option3" Text="ارسال" CssClass="btnLogin fr" />

                </td>
            </tr>
        </table>


        <script>
            alertify.defaults.glossary.ok = 'موافق';
            alertify.defaults.glossary.cancel = 'إلغاء';


            function bindEvent() {
                $(".btnDelete").click(function (event) {
                    event.preventDefault();
                    var href = this.href;
                    alertify.confirm('تأكيد الحذف', 'هل متأكد من الحذف.', function () { window.location.href = href; }, null);

                });

                $("#<%=txtResearchList.ClientID%>").tokenInput(<%=ViewState["json"]%>, { prePopulate : <%=ViewState["toid"]%> });
        }

        $(function () {


            bindEvent();


            

        });
        </script>
</asp:Content>



