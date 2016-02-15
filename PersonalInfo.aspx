<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PersonalInfo.aspx.cs" Inherits="PersonalInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">




    <table class="tabler">
        <tr>
            <td class="input_td">
                <asp:TextBox placeholder="إدخل الاسم" CssClass="form_class_input" ID="txtName" runat="server"></asp:TextBox>
            </td>
            <td class="lable_td hme">
                <label>الاسم</label>
            </td>
        </tr>
        <tr>
            <td class="input_td">
                <asp:TextBox ReadOnly="True" Enabled="False" placeholder="المسمى الوظيفي" CssClass="form_class_input" ID="txtJobTitle" runat="server"></asp:TextBox>
            </td>
            <td class="lable_td hme">
                <label>المسمى الوظيفي</label></td>
        </tr>
        <tr>
            <td class="input_td">
                <asp:TextBox  placeholder="جهة العمل" CssClass="form_class_input" ID="txtOrganization" runat="server"></asp:TextBox>
            </td>
            <td class="lable_td hme">
                <label>جهة العمل</label></td>
        </tr>
        <tr>
            <td class="input_td">
                <asp:TextBox placeholder="رقم الهاتف" CssClass="form_class_input" ID="txtPhoneNumber" runat="server"></asp:TextBox>
            </td>
            <td class="lable_td hme">
                <label>رقم الهاتف</label>
            </td>
        </tr>
        <tr>
            <td class="input_td">
                <asp:TextBox placeholder="رقم الجوال" CssClass="form_class_input" ID="txtMobile" runat="server"></asp:TextBox>
            </td>
            <td class="lable_td hme">
                <label>رقم الجوال</label>
            </td>
        </tr>
        <tr>
            <td class="input_td">
                <asp:TextBox ReadOnly="True" Enabled="False" placeholder="البريد الإلكتروني" CssClass="form_class_input" ID="txtUserName" runat="server"></asp:TextBox>
            </td>
            <td class="lable_td hme">
                <label>البريد الإلكتروني </label>
            </td>
        </tr>
        <tr>
            <td class="input_td">
                <asp:TextBox Enabled="False" ReadOnly="True" TextMode="Password" placeholder="كلمة المرور" CssClass="form_class_input" ID="txtPassword" runat="server"></asp:TextBox>
            </td>
            <td class="lable_td hme hme">
                <label>كلمة المرور</label>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="text-left">
                <a href="ChangePassword.aspx" class="btn btn-default">تغير كلمة السر</a>
            </td>
        </tr>
        <tr>
            <td class="input_td">
                <asp:FileUpload ID="fileImg" runat="server" />
                <span class="help-block">146 * 146</span>
            </td>
            <td class="lable_td hme">
                <label>الصورة</label>
            </td>
        </tr>
        
        <tr>
            <td class="full_widther" colspan="2">
                <asp:Button ID="btnSubmit" OnClick="btnSubmit_OnClick" CssClass="btn yes" runat="server" Text="حفظ" />
                <a href="Default.aspx" class="btn no">إلغاء</a>
            </td>
        </tr>
    </table>




</asp:Content>

