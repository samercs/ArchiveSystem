<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" ValidateRequest="false" AutoEventWireup="true" CodeFile="UsersOp.aspx.cs" Inherits="Admin_UsersOp" %>

<%@ Register Src="~/controls/hijriCalender.ascx" TagPrefix="uc1" TagName="hijriCalender" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    

    <script type="text/javascript" src="/js/calender/jquery.calendars.js"></script>
    <script type="text/javascript" src="/js/calender/jquery.calendars.plus.js"></script>
    <link rel="stylesheet" type="text/css" href="/js/calender/jquery.calendars.picker.css" />
    <script type="text/javascript" src="/js/calender/jquery.plugin.js"></script>
    <script type="text/javascript" src="/js/calender/jquery.calendars.picker.js"></script>
    <script type="text/javascript" src="/js/calender/jquery.calendars.picker-ar.js"></script>
    <script type="text/javascript" src="/js/calender/jquery.calendars.islamic.js"></script>
    <script type="text/javascript" src="/js/calender/jquery.calendars.islamic-ar.js"></script>
    <script type="text/javascript" src="/js/calender/jquery.calendars.islamic-ar.js"></script>
    

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 class="Title BorderBottom"><%=name %></h1>

    <asp:HyperLink ID="HyperLink2" CssClass="tdn fl" NavigateUrl="UsersList.aspx" runat="server"><h5><i class="fa fa-backward"></i> رجوع</h5></asp:HyperLink>
    <div class="clear PT20"></div>
    <section>
        <asp:Panel ID="Panel1" DefaultButton="btnSave" runat="server">
            <table class="tblConListOpt">
                <tr>
                    <td>
                        <asp:Label ID="Label10" runat="server" Text="الصورة" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:FileUpload ID="fileFile" CssClass="txt1" ValidationGroup="Option3" runat="server" />
                    </td>
                    <td></td>
                </tr>

                <tr>
                    <td>
                        <asp:Label ID="Label9" runat="server" Text="الاسم" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtName" ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="البريد الالكتروني" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtUserName" ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>

                <tr>
                    <td>
                        <asp:Label ID="Label14" runat="server" Text="كلمة السر " CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtPassword" ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="الوظيفة " CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtJobTitle" ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label5" runat="server" Text="رقم الهاتف " CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtPhone" ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label6" runat="server" Text="محظور حتى تاريخ " CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <uc1:hijriCalender  Class="txtCal" ValidationGroup="Option3" runat="server" ID="txtLockedTo" />
                    </td>
                    <td>
                        في حالة حظر مستخدم ادخل تاريخ الحظر
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="بحاجة الى تغير كلمة السر ؟ " CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:RadioButtonList ID="RadioButtonList1" runat="server">
                            
                            <asp:ListItem Value="1">نعم</asp:ListItem>
                            <asp:ListItem Selected="True" Value="0">لا</asp:ListItem>
                            
                        </asp:RadioButtonList>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="الحالة " CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="ddlStatus" CssClass="ddl1" runat="server">
                            <asp:ListItem Text="فعال" Value="1"></asp:ListItem>
                            <asp:ListItem Text="موقوف" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td></td>
                </tr>
                
                <tr>
                    <td colspan="2">
                        <a href="UsersList.aspx" class="btnLogin2 fr">الغاء</a>
                        <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" ValidationGroup="Option3" Text="حفظ" CssClass="btnLogin fr" />

                    </td>
                </tr>
            </table>
        </asp:Panel>
    </section>
    
</asp:Content>




