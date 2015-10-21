<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">




    <table class="tabler">
        <tr>
            <td class="input_td">
                <asp:TextBox placeholder="كلمة السر الحالة" CssClass="form_class_input" ID="txtPassword1" runat="server"></asp:TextBox>
            </td>
            <td class="lable_td hme">
                <label>كلمة السر الحالة</label>
            </td>
        </tr>
        <tr>
            <td class="input_td">
                <asp:TextBox  placeholder="كلمة السر الجديدة" CssClass="form_class_input" ID="txtPassword2" runat="server"></asp:TextBox>
            </td>
            <td class="lable_td hme">
                <label>كلمة السر الجديدة</label></td>
        </tr>
        <tr>
            <td class="input_td">
                <asp:TextBox  placeholder="تأكيد كلمة السر" CssClass="form_class_input" ID="txtPassword3" runat="server"></asp:TextBox>
            </td>
            <td class="lable_td hme">
                <label>تأكيد كلمة السر</label></td>
        </tr>
        
        <tr>
            <td class="full_widther" colspan="2">
                <asp:Button ID="btnSubmit" OnClick="btnSubmit_OnClick" CssClass="btn yes" runat="server" Text="حفظ" />
                <a href="PersonalInfo.aspx" class="btn no">إلغاء</a>
            </td>
        </tr>
    </table>




</asp:Content>

