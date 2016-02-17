<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true" CodeFile="SearchUser.aspx.cs" Inherits="SearchUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="space"></div>

    <section class="main">
        <div class="">
        <div class="space"></div>
        
            <div class="container">
                <h4 class="align_right margin_12em font_14_em mobile_center space">نتائج البحث</h4>
        <table class="search_result margin_12e_bottom">
            <tr dir="rtl">
                <td  colspan="2">
                    <asp:Button OnClick="btnSearch_OnClick" ID="Button2" CssClass="search_submit_page float_left" runat="server" Text="بحث" /></td>
          

                <td dir="rtl" class="th">
                    <label>المسمى الوظيفي</label>
                    <asp:TextBox ID="txtJobTitle" palceholder="المسمى الوظيفي" CssClass="search_input_page" runat="server"></asp:TextBox>
                </td>
                <td dir="rtl" class="th">
                    <label>جهة العمل</label>
                    <asp:TextBox ID="txtOrganization" palceholder=" جهة العمل" CssClass="search_input_page" runat="server"></asp:TextBox>
                </td>

                <td dir="rtl" class="th">
                    <label> ‫إسم الشخص‬</label>
                    <asp:TextBox ID="txtUserName" palceholder="اسم الشخص" CssClass="search_input_page" runat="server"></asp:TextBox>

                </td>
              
            </tr>
        </table>
                </div>
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
                                    <h5><%#Eval("Organization") %></h5>
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
        <div class="modal-dialog" >

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
                                    <img src="img/input.png" class="input_img img-responsive" /><asp:TextBox ID="txtSubject" placeholder="عنوان الرسالة" CssClass="report_input_txt" runat="server"></asp:TextBox>
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
                                    <img src="img/textarea.png" class="input_img_text_area img-responsive" /><asp:TextBox ID="txtMsg" MaxLength="500" placeholder="الرسالة" TextMode="MultiLine" CssClass="input_txtarea" runat="server"></asp:TextBox>
                                 <div id="txtaddress" dir="rtl" style="font-size: 12px;text-align: center;display: block;margin: 0 auto;
    width: 150px;"></div>
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
             $(document).ready(function () {

            var text_max = 500;

            $('#txtaddress').html(text_max + ' حرف متبقي');

            $("#<%=txtMsg.ClientID%>").keyup(function () {

                var text_length = $("#<%=txtMsg.ClientID%>").val().length;
                var text_remaining = text_max - text_length;

                $('#txtaddress').html(text_remaining + ' حرف متبقي');


            });

                });

        function validateMsg2() {
            var title = $("#<%=txtSubject.ClientID%>").val();
            var txtMsg = $("#<%=txtMsg.ClientID%>").val();
            var msg = $("#<%=txtMsg.ClientID%>").val();
            if (title == "") {
                alert("الرجاء ادخال عنوان الرسالة");
                return false;

            }
            if (txtMsg.length>500) {
                alert("نص الرسالة يجب الا يتخطى الـ500 حرف.");
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

