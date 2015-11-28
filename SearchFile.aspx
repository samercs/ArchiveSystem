<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true" CodeFile="SearchFile.aspx.cs" Inherits="SearchFile" %>
<%@ Register TagPrefix="uc1" TagName="hijriCalender" Src="~/Controls/hijriCalender.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="space"></div>
    <div id="full_width_white">
        <div class="container">

            <h4 class="align_right margin_12em font_14_em">نتائج البحث عن ملف</h4>
            <table class="search_result margin_12e_bottom">
                <tr dir="rtl">
                    <th dir="rtl" colspan="2">
                        <asp:Button ID="btnSearch" OnClick="btnSearch_OnClick" CssClass="search_submit_page float_left" runat="server" Text="بحث" />
                    </th>
                    <th dir="rtl">
                        <label>‫تاريخ الملف‬</label>
                        <uc1:hijriCalender  Class=" search_input_page search_input_page_width"  runat="server" ID="txtFileDate" />
                    </th>
                    <th dir="rtl">
                        <label>‫المجال‬</label>
                        <asp:DropDownList CssClass="search_input_page search_input_page_width" ID="ddlField" runat="server"></asp:DropDownList>

                    </th>
                    <th dir="rtl">
                        <label>الرقم</label> <asp:TextBox ID="txtNo1" CssClass="search_input_page" size="4" MaxLength="4" runat="server"></asp:TextBox>/<asp:TextBox ID="txtNo2" CssClass="search_input_page" size="4" MaxLength="4" runat="server"></asp:TextBox></th>
                    <th dir="rtl">
                        <label>‫اسم البحث‬</label><asp:TextBox ID="txtTitle" CssClass="search_input_page search_input_page_width" runat="server"></asp:TextBox></th>
                </tr>
            </table>

            <table class=" moble_search_box_page margin_12e_bottom">
                <tr dir="rtl">
                    <td dir="rtl" class="padding_5em_bottom">
                        <label>‫البحث‬ ‫إسم‬</label><input type="text" placeholder="إسم البحث" class="full_width" name="filename"></td>
                    <td dir="rtl" class="align_center padding_5em_bottom">
                        <label>الرقم</label><input type="text" name="filename" class="half_width txt_right " size="4" placeholder="الرقم " maxlength="4">/<input type="text" class="half_width txt_left" placeholder="الرقم " size="4" name="filename" maxlength="4"></td>
                    <td dir="rtl" class="padding_5em_bottom">
                        <label>‫المجال‬</label><input type="text" class="full_width" placeholder="‫المجال‬" name="filename"></td>
                    <td dir="rtl" class="padding_5em_bottom">
                        <label>‫الاضافة‬ ‫تاريخ‬</label>
                        <input type="text" class="full_width picker" placeholder="‫الاضافة‬ ‫تاريخ‬" name="search_date"></td>
                    <td dir="rtl" colspan="2" class="padding_5em_bottom">
                        <input type="submit" class="full_width search_sub_btn" name="search" value="بحث" /></td>

                </tr>
            </table>

            <div class="space"></div>
            <table class="table table-striped">
                <thead>
                    <tr id="green_background_color">
                        <td id="width_10">الرقم </td>
                        <td id="width_20">اسم الملف</td>
                        <td id="width_10">التاريخ</td>
                        <td id="width_20">المجال</td>
                        <td id="width_30">الوصف</td>
                        <td id="width_10">العمليات</td>
                    </tr>
                </thead>
                <tbody>
                    <asp:ListView OnPagePropertiesChanged="Repeater1_OnPagePropertiesChanged" ID="Repeater1" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td id="width_10"><%#Tools.RecierveNo(Eval("no").ToString()) %></td>
                                <td id="width_20">
                                    <p class="fontsize" id="sub_cont"><%#Eval("Title") %></p>
                                </td>
                                <td id="width_10"><%# (new Dates()).GregToHijri(Eval("FileDate","{0:dd/MM/yyyy}"),"dd/MMM/yyyy") %></td>
                                <td id="width_20">
                                    <p  class="fontsize"  id="sub_cont"><%#Eval("fieldname") %></p>
                                </td>
                                <td id="width_30">
                                    <p  class="fontsize"  id="sub_cont">
                                        <%#Eval("desc") %>
                                    </p>
                                </td>
                                <td id="width_10" class="green_background_color">
                                    <a href="#" class="sub_link" data-toggle="modal" data-target="#myModal">تصفح  </a>&nbsp;&nbsp;
                                    <a href="#" class="sub_link"> تحميل  </a>
                                </td>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:ListView>

                </tbody>
            </table>
            <div class="modal fade" id="myModal" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header" id="modal-header">

                            <h4 class="modal-title">تصفح الملف</h4>
                            <img src="img/model_arrow.png" class="img-responsive arrow_model" />
                        </div>
                        <div id="arrow_model_form">
                            <img src="img/model2.png" class="img-responsive hme">
                        </div>
                        <div class="modal-body" id="modal-dialog">
                            <div class="article">
                                <table dir="rtl">
                                    <tr>
                                        <td colspan="5">
                                            <h4 class="header_h4">عنوان الملف</h4>
                                        </td>
                                    </tr>
                                    <tr class="space txt_gray">
                                        <td><i class="fa fa-microphone"></i>‫الصدور‬ ‫جهة‬</td>
                                        <td><i class="fa fa-list-alt"></i>‫الصدور‬ ‫رقم‬</td>
                                        <td><i class="fa fa-file-o"></i>‫النوع‬</td>
                                        <td><i class="fa fa-bullseye"></i>‫المعنية‬ ‫الفئة‬</td>
                                        <td><i class="fa fa-calendar"></i>‫الصدور‬ ‫تاريخ‬</td>
                                    </tr>
                                    <tr class="space txt_gray">
                                        <td colspan="5">
                                            <p class="p">
                                                ‫تأتي‬ ‫الملف‬ ‫عن‬ ‫بسيطة‬ ‫نبذة‬ ‫هنا‬ ‫تأتي‬ ‫الملف‬ ‫عن‬ ‫بسيطة‬ ‫نبذة‬ ‫هنا‬ ‫تأتي‬ ‫الملف‬ ‫عن‬ ‫بسيطة‬ ‫نبذة‬
                                                ‫الملف‬ ‫عن‬ ‫بسيطة‬ ‫نبذة‬ ‫هنا‬ ‫تأتي‬ ‫الملف‬ ‫عن‬ ‫بسيطة‬ ‫نبذة‬ ‫هنا‬ ‫تأتي‬ ‫الملف‬ ‫عن‬ ‫بسيطة‬ ‫نبذة‬ ‫هنا‬
                                                ‫عن‬ ‫بسيطة‬ ‫نبذة‬ ‫هنا‬ ‫تأتي‬ ‫الملف‬ ‫عن‬ ‫بسيطة‬ ‫نبذة‬ ‫هنا‬ ‫تأتي‬ ‫الملف‬ ‫عن‬ ‫بسيطة‬ ‫نبذة‬ ‫هنا‬ ‫تأتي‬
                                                ‫بسيطة‬ ‫نبذة‬ ‫هنا‬ ‫تأتي‬ ‫الملف‬ ‫عن‬ ‫بسيطة‬ ‫نبذة‬ ‫هنا‬ ‫تأتي‬ ‫الملف‬ ‫عن‬ ‫بسيطة‬ ‫نبذة‬ ‫هنا‬ ‫تأتي‬ ‫الملف‬
                                                .‬‬
                                            </p>
                                        </td>
                                    </tr>
                                    <tr class="space txt_green align_right">
                                        <td><i class="fa fa-mouse-pointer "></i>‫تصفح‬</td>
                                        <td><i class="fa fa-download"></i>‫تحميل‬</td>
                                        <td><i class="fa fa-archive"></i>‫أرشفة‬</td>
                                        <td><i class="fa fa-star "></i>‫للمفضلة‬ ‫إضافة‬</td>
                                        <td><a class="txt_green vis" href="#" data-toggle="modal" data-target="#myModal"><i class="fa fa-file-text-o"></i>‫إبلاغ‬</a></td>
                                    </tr>
                                </table>
                                <div class="space"></div>

                                <img src="img/grayspliter.png" class="split img-responsive">
                                <div class="space"></div>

                                <div class="comment_box">
                                    <table dir="rtl">
                                        <tr>
                                            <td class="width_50_px" rowspan="4">
                                                <img src="img/user_pic.png" class=" small_user_pic" /></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <h4 class="txt_green font_small space align_right">د.ماجد عبدالله القصبي</h4>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="space align_right">
                                                <p>‫عن‬ ‫بسيطة‬ ‫نبذة‬ ‫هنا‬ ‫تأتي‬ ‫الملف‬ ‫عن‬ ‫بسيطة‬ ‫نبذة‬ ‫هنا‬ ‫تأتي‬ ‫الملف‬ ‫عن‬ ‫بسيطة‬ ‫نبذة‬</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class=" ">
                                                <input type="submit" class="comment_sub background_gray txt_left" name="comment_sub" value="كتابة رد" /><img src="img/goback_green.png" class="img-responsive txt_left" /></td>
                                        </tr>
                                    </table>
                                </div>

                                <div class="commenter" id="demo" class="collapse">
                                    <div class="space"></div>
                                    <form>
                                        <div class="comment_box">
                                            <table dir="rtl">
                                                <tr>
                                                    <td rowspan="4">
                                                        <img src="img/user_pic.png" class=" small_user_pic" /></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <h4 class="txt_green font_small space align_right">د.ماجد عبدالله القصبي</h4>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="space align_right">
                                                        <textarea class="comment_input" placeholder="كتابة رد... " multiple name="comment_txt"></textarea></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" class=" ">
                                                        <input type="submit" class="comment_sub background_gray txt_left" name="comment_sub" value="كتابة رد" /><img src="img/goback_green.png" class="img-responsive txt_left" /></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </form>
                                </div>
                                <button class="link btn-link font_small">إظهار جميع التعليقات </button>
                                <div class="space"></div>
                                <div class="space"></div>
                                <div class="collapse">
                                    <img src="img/arrow_attched.png" class="img-responsive attached_img " />
                                    <div class="arrow_attached comment_input ">
                                        <table>
                                            <tr>
                                                <td colspan="3" class="align_right">
                                                    <h4>المرفقات</h4>
                                                </td>
                                            </tr>
                                            <tr class="align_center">
                                                <td>
                                                    <img src="img/flag.png" class="img-responsive" /><br>
                                                    <span class="align_center">اسم المرفق</span></td>
                                                <td>
                                                    <img src="img/tawoer.png" class="img-responsive" /><br>
                                                    <span class="align_center">اسم المرفق</span></td>
                                                <td>
                                                    <img src="img/city.png" class="img-responsive" /><br>
                                                    <span class="align_center">اسم المرفق</span></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                <div class="space"></div>
                                <div data-toggle="tooltip" title="عرض الملف " class="show_thefile">
                                    <img src="img/uparrow.png" class="img-responsive up" />
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <div class="text-center">
            <asp:DataPager class="btn-group btn-group-sm" ID="DataPager1" PagedControlID="Repeater1" PageSize="10" runat="server">
                <Fields>
                    <asp:NumericPagerField ButtonType="Link" CurrentPageLabelCssClass="btn btn-primary disabled" RenderNonBreakingSpacesBetweenControls="false"
                    NumericButtonCssClass="btn btn-default" ButtonCount="10" NextPageText="..." NextPreviousButtonCssClass="btn btn-default" />
                </Fields>
            </asp:DataPager>
            </div>
            
            <div class="space"></div>
        </div>
    </div>
    
    <script type="text/javascript">
        $(function () {
            
            $(".calendars-trigger").hide();

        });
    </script>

</asp:Content>

