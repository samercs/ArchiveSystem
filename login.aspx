<%@ Page ValidateRequest="false" Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>الدليل الاإلكتروني لإرشفة القرارات و التعاميم الحكومية</title>
    <meta charset="UTF-8" />
    

    <style>
        .fl {
            float: left;
        }

        .fr {
            float: right;
        }
    </style>

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
                    <img class="logo_img img-responsive" src="img/logo.png" />
                    <img src="img/logo_arrow.png" class="arrow_logo img-responsive" />
                </div>
                <div class="arrow_login_form"></div>
                <div class="login_form_container">

                    <table dir="rtl" class="form_table">
                        <tr>
                            <td colspan="2" class="center">
                                <h4 dir="rtl">الدخول</h4>
                            </td>
                        </tr>
                        <tr class="form_table_tr ">
                            <td class="hme">
                                <div class="arrow_box">
                                    <label class="text_color_white_smoke ">إسم المستخدم</label></div>
                            </td>
                            <td class="">
                                <div class="input_box">
                                    <asp:TextBox CssClass="input_txt" ID="txtUserName" placeholder="إسم المستخدم" runat="server"></asp:TextBox></div>
                            </td>
                        </tr>
                        <tr>
                            <td class="hme">
                                <div class="arrow_box ">
                                    <label class="text_color_white_smoke ">كلمة السر</label></div>
                            </td>
                            <td class="">
                                <div class="input_box">
                                    <asp:TextBox CssClass="input_txt" placeholder="كلمة السر" TextMode="Password" ID="txtPassword" runat="server"></asp:TextBox></div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="text-right">
                                <asp:CheckBox ID="cbRememberMe" CssClass="Mobile_width fr" runat="server" />
                                <label class="text_color_white_smoke">تذكرني</label>
                            </td>
                        </tr>
                        <tr class="text-right">
                            <td colspan="2">
                                <asp:CheckBox ID="cbKeepMeLogin" CssClass="Mobile_width fr" runat="server" />
                                <label class="text_color_white_smoke">البقاء متصلا</label>
                            </td>
                        </tr>
                        <tr class="form_table_tr_extra">
                            <td>
                                <asp:Button OnClick="btnLogin_OnClick" ID="btnLogin" CssClass="submit_btn_login_form" runat="server" Text="دخول" /></td>
                            <td class="hme">
                                <a href="forgetPassword.aspx" class="hyperlink_login_form">هل نسيت كلمة المرور ؟</a>
                                <br/>
                                <a class="hyperlink_login_form" data-toggle="modal" data-target="#myModal2">مراسلة مدير الموقع بخصوصة كلمة السر</a>
                            </td>
                        </tr>
                        <tr>
                            <td class="moblie_hide align_center">

                                <a href="forgetPassword.aspx" class="hyperlink_login_form" id='hyperlink_login_form'>هل نسيت كلمة المرور ؟</a>
                                <br/>
                                <a class="hyperlink_login_form" data-toggle="modal" data-target="#myModal2">مراسلة مدير الموقع بخصوصة كلمة السر</a>
                            </td>

                        </tr>
                        <tr>
                            <td colspan="2" class="text-center">
                                <asp:Panel CssClass="alert alert-danger error" ID="ErrorDiv" Visible="False" runat="server">
                                    <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>

                </div>
            </div>
        </div>
        
        
        <div class="modal fade" id="myModal2" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">


                        <h4 class="modal-title">مراسة مدير الموقع</h4>
                        <img src="img/model_arrow.png" class="img-responsive arrow_model MobileHide" />
                    </div>
                    <div class="arrow_model_form"></div>
                    <div class="modal-body">
                        <table dir="rtl" class="form_table">
                            <tr class="form_table_tr ">
                                <td class="hme">
                                    <img class="img-responsive label_img_model MobileHide" src="img/arro.png" /><div class="arrow_boxs">
                                        <label class="text_color_white_smoke ">عنوان الرسالة</label>
                                    </div>
                                </td>
                                <td class="">
                                    <div class="input_box">
                                        <img src="img/input.png" class="input_img img-responsive" /><asp:TextBox CssClass="report_input_txt" ID="txtTitle" placeholder="العنوان" runat="server"></asp:TextBox>
                                    </div>
                                </td>
                            </tr>
                            <tr class="form_table_tr ">
                                <td class="hme">
                                    <img class="img-responsive label_img_model MobileHide" src="img/arro.png" /><div class="arrow_boxs">
                                        <label class="text_color_white_smoke ">ارسال كلمة السر الى</label>
                                    </div>
                                </td>
                                <td class="">
                                    <div class="input_box">
                                        <img src="img/input.png" class="input_img img-responsive" /><asp:TextBox CssClass="report_input_txt" ID="txtEmail" placeholder="البريد الالكتروني" runat="server"></asp:TextBox>
                                    </div>
                                </td>
                            </tr>
                            <tr class="form_table_tr ">
                                <td class="hme top_align">
                                    <img class="img-responsive label_img_model_admin_chat" src="img/arro.png" /><div class="arrow_boxs ">
                                        <label class="text_color_white_smoke ">الرسالة</label>
                                    </div>
                                </td>
                                <td colspan="6">
                                    <div class="input_box">
                                        <img src="img/textarea.png" class="input_img_text_area_admin_chat img-responsive MobileHide" /><asp:TextBox ID="txtMsg" CssClass="input_txtarea" TextMode="MultiLine" Height="150" placeholder="الرسالة" runat="server"></asp:TextBox>
                                    </div>
                                </td>
                            </tr>
                            <tr class="form_table_tr_extra ">
                                <td colspan="2">
                                    <asp:Button OnClientClick="return  validateMsg();" OnClick="btnSendMsg_OnClick" ID="btnSendMsg" CssClass="submit_btn_report_form float_left txt_white" runat="server" Text="إرسال" />

                                </td>
                            </tr>
                        </table>

                    </div>

                </div>

            </div>
        </div>
        
        
        

    </form>
    
    
    
    <script type="text/javascript">
        function validateMsg() {
            var title = $("#<%=txtTitle.ClientID%>").val();
            var msg = $("#<%=txtMsg.ClientID%>").val();
            var email = $("#<%=txtEmail.ClientID%>").val();
            if (title == "") {
                alert("الرجاء ادخال عنوان الرسالة");
                return false;

            }
            if (msg == "") {
                alert("الرجاء ادخال  الرسالة");
                return false;

            }
            if (email == "") {
                alert("الرجاء ادخال  البريد الالكتروني");
                return false;

            }

            if (!validateEmail(email)) {
                alert("الرجاء التأكد من  البريد الالكتروني");
                return false;
            }

            return true;
        }

        function validateEmail(email) {
            var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return re.test(email);
        }


        
    </script>
    

</body>
</html>
