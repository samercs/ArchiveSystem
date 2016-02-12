<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:ListView OnItemDataBound="ListView1_OnItemDataBound" OnPagePropertiesChanged="ListView1_OnPagePropertiesChanged" ID="ListView1" runat="server">
        <ItemTemplate>
            <asp:HiddenField ID="id" Value='<%#Eval("id") %>' runat="server" />
            <div class="article">
                <div class="number">
                    <%#Eval("id") %>
                </div>
                <table class="table table-responsive noborder">
                    <tr>
                        <td class="MobileDesign" colspan="5">
                            <h4 class="header_h4"><%#Eval("title") %></h4>
                        </td>
                    </tr>
                    <tr class="space txt_gray">
                        <td class="MobileWidth"><i class="fa fa-microphone"></i>‫<%#Eval("From") %>‬</td>
                        <td class="MobileWidth"><i class="fa fa-list-alt"></i>‫<%# Tools.RecierveNo( Eval("No").ToString()) %>‬</td>
                        <td class="MobileWidth"><i class="fa fa-file-o"></i>‫<%#Eval("TypeName") %>‬</td>
                        <td class="MobileWidth"><i class="fa fa-bullseye"></i>‫<%#Eval("TargetName") %>‬</td>
                        <td class="MobileWidth"><i class="fa fa-calendar"></i>‫<%#(new Dates()).GregToHijri(Eval("FileDate","{0:dd/MM/yyyy}"),"dd/MMM/yyyy") %>‬</td>
                    </tr>
                    <tr class="space txt_gray">
                        <td colspan="5">
                            <hr class="hr1" />
                        </td>
                    </tr>
                    <tr class="space txt_gray">
                        <td colspan="5">
                            <p class="p">
                                <%#Eval("desc").ToString() %>
                            </p>
                        </td>
                    </tr>
                    <tr class="space txt_green align_right ">
                        <td colspan="5" class="links-list">
                            <div class="row">

                                <div class="col-md-6">
                                    <asp:HiddenField ID="Security" Value='<%#Eval("Security") %>' runat="server" />
                                    <asp:Panel ID="ShareCon" Visible="False" runat="server">
                                        <!-- AddToAny BEGIN -->
                                        <a class="a2a_dd" href="https://www.addtoany.com/share">
                                        <img src="//static.addtoany.com/buttons/share_save_171_16.png" width="171" height="16" border="0" alt="Share" /></a>
                                        <script type="text/javascript" src="//static.addtoany.com/menu/page.js"></script>
                                        <!-- AddToAny END -->
                                    </asp:Panel>
                                </div>
                                <div class="col-md-6 text-right">
                                    <a href="/SystemFiles/Files/<%#Eval("FileUrl") %>" target="_blank"><i class="fa fa-mouse-pointer txt_green"></i>‫تصفح</a>‬
                                    <a class="txt_green" href="/SystemFiles/Files/<%#Eval("FileUrl") %>" download><i class="fa fa-download"></i>‫تحميل</a>‬
                                    <asp:LinkButton CssClass="txt_green" OnCommand="btnAddToFav_OnCommand" CommandArgument='<%#Eval("id") %>' ID="btnAddToFav" runat="server">
                                        <i class="fa fa-star txt_green"></i>‫ مفضلة
                                    </asp:LinkButton>
                                    <a data-id="<%#Eval("id") %>" data-name="<%#Eval("title") %>" class="txt_green vis btnSendError" href="#" data-toggle="modal" data-target="#myModal"><i class="fa fa-file-text-o"></i>‫إبلاغ‬</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
                <div class="space"></div>


                <img src="img/grayspliter.png" class="split img-responsive">
                <div class="space"></div>

                <asp:Panel ID="CommentCon" Visible="False" runat="server">
                    <div class="comment_box" id="comment_box_<%#Container.DataItemIndex +1 %>">
                        <table dir="rtl">
                            <tr>
                                <td colspan="2">
                                    <a runat="server" id="btnShowCommenter1" class="comment_sub background_gray txt_left">&nbsp;&nbsp;&nbsp;تعليق&nbsp;&nbsp;&nbsp;<img src="img/goback_green.png" class="img-responsive txt_left" /></a></td>
                            </tr>
                            <asp:ListView ID="Repeater1" runat="server">
                                <ItemTemplate>

                                    <tr style="vertical-align: top;">
                                        <td style="vertical-align: top;" class="width_50_px" rowspan="3">
                                            <img src="/SystemFiles/Users/<%#Eval("img") %>" class="small_user_pic" /></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <h4 style="padding: 0; margin: 0;" class="txt_green font_small space align_right"><%#Eval("name") %></h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border: none;" class="space align_right">
                                            <p>
                                                ‫
                                            <%#Eval("text") %>
                                            </p>
                                        </td>
                                    </tr>



                                </ItemTemplate>
                                <EmptyDataTemplate>

                                    <tr>
                                        <td colspan="2" class=" ">
                                            <div class="text-center alert alert-warning">
                                                لا يوجد تعليقات
                                            </div>
                                        </td>
                                    </tr>

                                    <tr style="visibility: hidden;">
                                        <td colspan="2" class=" ">
                                            <a runat="server" id="btnShowCommenter2" class="comment_sub background_gray txt_left">&nbsp;&nbsp;&nbsp;تعليق&nbsp;&nbsp;&nbsp;<img src="img/goback_green.png" class="img-responsive txt_left" /></a></td>
                                    </tr>
                                </EmptyDataTemplate>
                            </asp:ListView>

                        </table>

                    </div>



                    <div class="commenter" id="commenter_<%#Container.DataItemIndex+1 %>">
                        <div class="space"></div>

                        <div class="addcomment_box">
                            <table style="width: 100%;" dir="rtl">
                                <tr>
                                    <td style="vertical-align: top;" rowspan="4">
                                        <asp:Image CssClass="small_user_pic" BorderStyle="Solid" BorderWidth="2" BorderColor="#88c16c" ID="imgUser" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4 style="padding: 0; margin: 0;" class="txt_green font_small space align_right">
                                            <asp:Label ID="lblUserName" runat="server" Text=""></asp:Label>
                                        </h4>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 84%;" class="space align_right">
                                        <asp:TextBox ID="txtComment" placeholder="تعليق... " CssClass="comment_input" TextMode="MultiLine" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" class=" ">
                                        <asp:LinkButton CommandArgument='<%#Container.DataItemIndex %>' OnCommand="btnSendComent_OnCommand" CssClass="comment_sub commenter_btn  txt_left" ID="btnSendComent" runat="server">تعليق</asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </div>

                    </div>
                    <a id="btnShowAllComment<%#Eval("id") %>" class="link btn-link font_small btn-show-all-comment" data-text="اخفاء التعليقات" data-id="comment_box_<%#Container.DataItemIndex+1 %>">إظهار جميع التعليقات </a>
                    <div class="space"></div>
                </asp:Panel>

                <div class="collapse" id="attached-<%#Container.DataItemIndex + 1 %>">
                    <img src="img/arrow_attched.png" class="img-responsive attached_img " />
                    <div class="arrow_attached comment_input ">
                        <table>
                            <tr>
                                <td colspan="3" class="align_right">
                                    <h4>المرفقات</h4>
                                </td>
                            </tr>
                            <tr class="align_center">
                                <asp:ListView ID="RepeaterAttached" runat="server">
                                    <ItemTemplate>
                                        <td>
                                            <a href="/SystemFiles/FilesAttach/<%#Eval("fileUrl") %>" download>
                                                <%# GetFileIcon(Eval("fileUrl")) %><br>
                                                <span class="align_center"><%#Eval("title") %></span>
                                            </a>
                                        </td>
                                    </ItemTemplate>

                                    <EmptyDataTemplate>
                                        <td colspan="3">
                                            <div class="alert alert-warning">
                                                لا يوجد مرفقات
                                            </div>
                                        </td>
                                    </EmptyDataTemplate>
                                </asp:ListView>


                            </tr>
                        </table>
                    </div>
                </div>

                <div data-toggle="tooltip" title="عرض المرفقات" class="show_thefile">
                    <img src="img/uparrow.png" class="img-responsive up" data-id="attached-<%#Container.DataItemIndex + 1 %>" />
                </div>
            </div>
            <div class="space gray"></div>
            <div class="space gray"></div>
        </ItemTemplate>
        <EmptyDataTemplate>
            <br />
            <br />
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <div class="alert alert-warning text-center">
                        لا يوجد ملفات مضافة
                    </div>
                </div>
            </div>

        </EmptyDataTemplate>
    </asp:ListView>

    <div class="space"></div>
    <div class="text-center">
        <asp:DataPager ID="DataPager1" class="btn-group btn-group-sm" PagedControlID="ListView1" PageSize="2" runat="server">
            <Fields>
                <asp:NumericPagerField ButtonType="Link" CurrentPageLabelCssClass="btn btn-primary disabled" RenderNonBreakingSpacesBetweenControls="false"
                    NumericButtonCssClass="btn btn-default" ButtonCount="10" NextPageText="..." NextPreviousButtonCssClass="btn btn-default" />
            </Fields>
        </asp:DataPager>
    </div>
    <div class="space"></div>

    <!-- Modal -->
    <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog" style="margin: 7em auto;">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">


                    <h4 class="modal-title">نموذج الإبلاغ عن ملف</h4>
                    <img src="img/model_arrow.png" class="img-responsive arrow_model" />
                </div>
                <div class="arrow_model_form"></div>
                <div class="modal-body">
                    <table dir="rtl" class="form_table">
                        <tr class="form_table_tr ">
                            <td class="hme">
                                <img class="img-responsive label_img_model" src="img/arro.png" /><div class="arrow_boxs">
                                    <label class="text_color_white_smoke ">إسم الملف</label>
                                </div>
                            </td>
                            <td class="">
                                <div class="input_box">
                                    <img src="img/input.png" class="input_img img-responsive" />
                                    <asp:TextBox ReadOnly="True" Enabled="False" ID="txtFileName" CssClass="report_input_txt" runat="server"></asp:TextBox>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="hme">
                                <img class="img-responsive label_img_model" src="img/arro.png" /><div class="arrow_boxs ">
                                    <label class="text_color_white_smoke ">سبب الإبلاغ</label>
                                </div>
                            </td>
                            <td class="">
                                <div class="input_box">
                                    <img src="img/input.png" class="input_img img-responsive" />
                                    <asp:DropDownList CssClass="report_input_txt txt_gray_light" ID="ddlType" runat="server"></asp:DropDownList>


                                </div>
                            </td>
                        </tr>
                        <tr class="form_table_tr ">
                            <td class="hme top_align">
                                <img class="img-responsive label_img_model" src="img/arro.png" /><div class="arrow_boxs ">
                                    <label class="text_color_white_smoke ">ملاحظات اخرى</label>
                                </div>
                            </td>
                            <td colspan="6">
                                <div class="input_box">
                                    <img src="img/textarea.png" class="input_img_text_area img-responsive" />
                                    <asp:TextBox ID="txtNote" CssClass="input_txtarea" runat="server" TextMode="MultiLine"></asp:TextBox>

                                </div>
                            </td>
                        </tr>
                        <tr class="form_table_tr_extra ">
                            <td colspan="2">
                                <asp:Button OnClick="btnSendError_OnClick" OnClientClick="return validateSendError()" ID="btnSendError" CssClass="submit_btn_report_form float_left txt_white" runat="server" Text="إرسال" />
                                <asp:HiddenField ID="fileId" runat="server" />
                            </td>
                        </tr>
                    </table>

                </div>

            </div>

        </div>
    </div>



    <script type="text/javascript">
        $(function () {

            $(".up").click(function () {

                var attached_id = $(this).attr("data-id");
                $("#" + attached_id).slideToggle("slow");

            });

            $(".btn-show-all-comment").click(function () {

                var commentId = $(this).attr("data-id");
                $("#" + commentId).toggleClass("full-hieght");
                if ($(this).attr("data-text") == "اخفاء التعليقات") {
                    $(this).text($(this).attr("data-text"));
                    $(this).attr("data-text", "اظهار التعليقات");
                } else {
                    $(this).text($(this).attr("data-text"));
                    $(this).attr("data-text", "اخفاء التعليقات");
                }

            });

            $(".comment_sub").click(function () {
                $(this).parent().parent().parent().parent().parent().next().toggle(300);

            });

            $(".btnSendError").click(function () {


                var $this = $(this);
                var id = $this.data("id");
                var name = $this.data("name");
                $("#<%=txtFileName.ClientID%>").val(name);
                $("#<%=fileId.ClientID%>").val(id);

            });





        });


        function validateSendError() {


            var why = $("#<%=ddlType.ClientID%>").val();
            if (why == "-1") {
                alert("الرجاء اختيار سبب البلاغ");
                return false;
            }
            return true;

        }


        function hiddenShowAllComment(id) {
            $("#btnShowAllComment" + id).hide();
        }
    </script>




</asp:Content>

