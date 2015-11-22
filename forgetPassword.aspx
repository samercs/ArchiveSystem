<%@ Page ValidateRequest="false" Language="C#" AutoEventWireup="true" CodeFile="forgetPassword.aspx.cs" Inherits="login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>الدليل لاألكتروني لأرشفة الملفات والقرارات الحكومية</title>
    <meta charset="UTF-8" />
    
    
    
    <script src="/js/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="js/bootstrap-datepicker.min.js"></script>
    <script src="js/tooltip.js"></script>
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="background_img"></div>
        <div class="container">
            <div class="sub-container">
                <div class="logo_container">
                    <img class="logo_img img-responsive" src="img/logo.png"/>
                    <img src="img/logo_arrow.png" class="arrow_logo img-responsive"/>
                </div>
                <div class="arrow_login_form"></div>  
                <div class="login_form_container">
                    <form class="login_form">
                        <table dir="rtl" class="form_table">
                            <tr><td colspan="2" class="center"><h4  dir="rtl">نسيت كلمة السر ؟</h4></td></tr>
                            <tr class="form_table_tr ">
                                <td class="hme"><div  class="arrow_box" ><label class="text_color_white_smoke ">البريد الالكتروني</label></div> </td><td class=""><div class="input_box"><asp:TextBox CssClass="input_txt" ID="txtUserName" placeholder="البريد الالكتروني" runat="server"></asp:TextBox></div></td>
                            </tr >
                            <tr class="form_table_tr_extra"><td><asp:Button OnClick="btnLogin_OnClick" ID="btnLogin" CssClass="submit_btn_login_form" runat="server" Text="ارسال كلمة السر" /></td><td class="hme"><a href="login.aspx"  class="hyperlink_login_form">تسجيل الدخول</a></td></tr>
                            <tr><td class="moblie_hide align_center"><a href="#" class="hyperlink_login_form" id='hyperlink_login_form'>هل نسيت كلمة المرور ؟</a></td></tr>
                            <tr>
                                <td colspan="2" class="text-center">
                                    <asp:Panel CssClass="alert alert-danger error" ID="ErrorDiv" Visible="False" runat="server">
                                        <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
