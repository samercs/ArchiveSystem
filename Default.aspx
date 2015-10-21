﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:ListView OnItemDataBound="ListView1_OnItemDataBound" OnPagePropertiesChanged="ListView1_OnPagePropertiesChanged" ID="ListView1" runat="server">
        <ItemTemplate>
            <asp:HiddenField ID="id" Value='<%#Eval("id") %>' runat="server" />
            <div class="article">
                <table dir="rtl">
                    <tr>
                        <td colspan="5">
                            <h4 class="header_h4"><%#Eval("title") %></h4>
                        </td>
                    </tr>
                    <tr class="space txt_gray">
                        <td><i class="fa fa-microphone"></i>‫<%#Eval("From") %>‬</td>
                        <td><i class="fa fa-list-alt"></i>‫<%#Eval("No") %>‬</td>
                        <td><i class="fa fa-file-o"></i>‫<%#Eval("Type").ToString().Equals("1") ? "ملف" : "تعميم" %>‬</td>
                        <td><i class="fa fa-bullseye"></i>‫<%#Eval("Target") %>‬</td>
                        <td><i class="fa fa-calendar"></i>‫<%#Eval("FileDate","{0:dd/MM/yyyy}") %>‬</td>
                    </tr>
                    <tr class="space txt_gray">
                        <td colspan="5">
                            <p class="p">
                                <%#Eval("desc") %>
                            </p>
                        </td>
                    </tr>
                    <tr class="space txt_green align_right">
                        <td><i class="fa fa-mouse-pointer "></i>‫تصفح‬</td>
                        <td><i class="fa fa-download"></i>‫تحميل‬</td>
                        <td><i class="fa fa-archive"></i>‫أرشفة‬</td>
                        <td><i class="fa fa-star "></i>‫ إضافة للمفضلة‬‫‬</td>
                        <td><a class="txt_green vis" href="#" data-toggle="modal" data-target="#myModal"><i class="fa fa-file-text-o"></i>‫إبلاغ‬</a></td>
                    </tr>
                </table>
                <div class="space"></div>


                <img src="img/grayspliter.png" class="split img-responsive">
                <div class="space"></div>

                <div class="comment_box">
                    <asp:Repeater ID="Repeater1" runat="server">
                        <ItemTemplate>
                            <table dir="rtl">
                                <tr>
                                    <td class="width_50_px" rowspan="4">
                                        <img src="/SystemFiles/Users/<%#Eval("img") %>" class="small_user_pic" /></td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4 class="txt_green font_small space align_right"><%#Eval("name") %></h4>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="space align_right">
                                        <p>‫
                                            <%#Eval("text") %>

                                        </p>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" class=" ">
                                        <input type="submit" class="comment_sub background_gray txt_left" name="comment_sub" value="كتابة رد" /><img src="img/goback_green.png" class="img-responsive txt_left" /></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:Repeater>


                </div>

                <div class="commenter" id="demo" class="collapse">
                    <div class="space"></div>

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
            <div class="space gray"></div>
            <div class="space gray"></div>
        </ItemTemplate>
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
        <div class="modal-dialog">

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
                                    <img src="img/input.png" class="input_img img-responsive" /><input type="text" class="input_txt" placeholder="إسم الملف" name="username" />
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
                                    <img src="img/input.png" class="input_img img-responsive" /><select class="input_txt txt_gray_light" name="report_cuz"><option class="txt_gray_light">إختار سبب الإبلاغ</option>
                                    </select>
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
                                    <img src="img/textarea.png" class="input_img_text_area img-responsive" /><textarea class="input_txtarea" placeholder="ملاحظات اخرى" name="report_cuz" height="150"></textarea>
                                </div>
                            </td>
                        </tr>
                        <tr class="form_table_tr_extra ">
                            <td colspan="2">
                                <input type="submit" class="submit_btn_report_form float_left txt_white" name="submet_login_form" value="إرسال" /></td>
                        </tr>
                    </table>

                </div>

            </div>

        </div>
    </div>








</asp:Content>

