﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true" CodeFile="SearchUser.aspx.cs" Inherits="SearchUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="space"></div>

    <section class="main">
        <div class="space"></div>
        <h4 class="align_right margin_12em font_14_em mobile_center space">نتائج البحث</h4>
        <table class="chating_result margin_12e_bottom">
            <tr dir="rtl">
                <th dir="rtl" colspan="2" class=" hme">
                    <asp:Button OnClick="btnSearch_OnClick" ID="Button2" CssClass="chating_submit_page float_left" runat="server" Text="بحث" /></th>

                <th dir="rtl" class="th">
                    <label>المسمى الوظيفي</label>
                    <asp:TextBox ID="txtJobTitle" palceholder="المسمى الوظيفي" CssClass="chating_input_page chating_input_page_width" runat="server"></asp:TextBox>
                </th>

                <th dir="rtl" class="th">
                    <label>الشخص ‫إسم‬</label>
                    <asp:TextBox ID="txtUserName" palceholder="اسم الشخص" CssClass="chating_input_page chating_input_page_width" runat="server"></asp:TextBox>

                </th>
                <th dir="rtl" colspan="2" class="moblie_hide th">
                    <asp:Button OnClick="btnSearch_OnClick" ID="btnSearch" CssClass="chating_submit_page float_left" runat="server" Text="بحث" />
                    
                </th>
            </tr>
        </table>
        <div class="container">


            <asp:ListView OnPagePropertiesChanged="ListView1_OnPagePropertiesChanged" ID="ListView1" runat="server">
                <ItemTemplate>
                    <div class="person">
                        <table>
                            <tr>
                                <td>
                                    <img src="SystemFiles/Users/<%#Eval("img") %>"></td>
                            </tr>
                            <tr>
                                <td>‫<h4><%#Eval("name") %></h4>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <h5><%#Eval("JobTitle") %></h5>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <h5><%#Eval("UserName") %></h5>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <h5>‫<%#Eval("Phone") %></h5>
                                </td>
                            </tr>

                        </table>
                        <div class="person_fotter">
                            <a class="linkBtn" href="#" data-id="<%#Eval("id") %>" data-toggle="modal" data-target="#myModal">
                                <h4>مراسلة</h4>
                            </a>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:ListView>
            <div class="clearfix"></div>
            <div class="space"></div>
            <div class="space"></div>
            <div class="space"></div>
            

            <div class="text-center">
            <asp:DataPager class="btn-group btn-group-sm" ID="DataPager1" PagedControlID="ListView1" PageSize="8" runat="server">
                <Fields>
                    <asp:NumericPagerField ButtonType="Link" CurrentPageLabelCssClass="btn btn-primary disabled" RenderNonBreakingSpacesBetweenControls="false"
                    NumericButtonCssClass="btn btn-default" ButtonCount="10" NextPageText="..." NextPreviousButtonCssClass="btn btn-default" />
                </Fields>
            </asp:DataPager>
            </div>



        </div>

        <div class="space"></div>
        <div class="space"></div>
        <div class="space"></div>
        <div class="space"></div>
    </section>

    <!-- Modal -->
    <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">


                    <h4 class="modal-title">نموذج المراسلة</h4>
                    <img src="img/model_arrow.png" class="img-responsive arrow_model" />
                </div>
                <div class="arrow_model_form"></div>
                <div class="modal-body">
                    <table dir="rtl" class="form_table">
                        <tr class="form_table_tr ">
                            <td class="hme">
                                <img class="img-responsive label_img_model" src="img/arro.png" /><div class="arrow_boxs">
                                    <label class="text_color_white_smoke ">عنوان الرسالة</label>
                                </div>
                            </td>
                            <td class="">
                                <div class="input_box">
                                    <img src="img/input.png" class="input_img img-responsive" /><asp:TextBox ID="txtSubject" CssClass="input_txt" runat="server"></asp:TextBox>
                                </div>
                            </td>
                        </tr>
                        <tr class="form_table_tr ">
                            <td class="hme top_align">
                                <img class="img-responsive label_img_model" src="img/arro.png" /><div class="arrow_boxs ">
                                    <label class="text_color_white_smoke ">الرسالة</label>
                                </div>
                            </td>
                            <td colspan="6">
                                <div class="input_box">
                                    <img src="img/textarea.png" class="input_img_text_area img-responsive" /><asp:TextBox ID="txtMsg" TextMode="MultiLine" CssClass="input_txtarea" runat="server"></asp:TextBox>
                                </div>
                            </td>
                        </tr>
                        <tr class="form_table_tr_extra ">
                            <td colspan="2">
                                <asp:Button OnClientClick="return validateMsg2()" OnClick="btnSendMsg_OnClick" ID="btnSendMsg" CssClass="submit_btn_report_form float_left txt_white" runat="server" Text="إرسال" />
                            </td>
                        </tr>
                    </table>

                </div>

            </div>

        </div>
    </div>

    <div class="space"></div>
    <div class="space"></div>
    <div class="space"></div>
    <div class="space"></div>
    <asp:HiddenField ID="hiddenId" runat="server" />
    <script type="text/javascript">
        $(function() {

            $(".linkBtn").click(function() {

                $("#<%=hiddenId.ClientID%>").val($(this).data("id"));
                
            });


            

        });


        function validateMsg2() {
            var title = $("#<%=txtSubject.ClientID%>").val();
            var msg = $("#<%=txtMsg.ClientID%>").val();
            if (title == "") {
                alert("الرجاء ادخال عنوان الرسالة");
                return false;

            }
            if (msg == "") {
                alert("الرجاء ادخال  الرسالة");
                return false;

            }
            return true;
        }
        

    </script>

</asp:Content>

