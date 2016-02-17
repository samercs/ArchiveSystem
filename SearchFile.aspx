<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true" CodeFile="SearchFile.aspx.cs" Inherits="SearchFile" %>

<%@ Register TagPrefix="uc1" TagName="hijriCalender" Src="~/Controls/hijriCalender.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        select {
            direction: rtl;
        }

        label {
            width: 75px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="space"></div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="full_width_white">
                <div class="container">

                    <h4 class="align_right margin_12em font_14_em">نتائج البحث عن ملف</h4>
                    <table class="search_result margin_12e_bottom">
                        <tr>
                            <td rowspan="2">
                                <asp:Button ID="btnSearch" OnClick="btnSearch_OnClick" CssClass="search_submit_page float_left" runat="server" Text="بحث" />
                            </td>


                            <td>
                                <label>الرقم</label>
                                <asp:TextBox ID="txtNo1" CssClass="search_input_page search_input_page_width" onkeypress="return Validate(event);" OnTextChanged="txtNo1_TextChanged" AutoPostBack="true" runat="server"></asp:TextBox></td>
                            <td>
                                <label>عنوان الملف‬</label>
                                <asp:TextBox ID="txtTitle" CssClass="search_input_page search_input_page_width" runat="server"></asp:TextBox></td>
                            <td>
                                <%-- onfocus="this.value=this.value;" onkeyup="RefreshUpdatePanel();" OnTextChanged="txtTitle_TextChanged"--%>
                                <label>ترتيب النتائج</label>
                                <asp:DropDownList OnSelectedIndexChanged="ddlSort_SelectedIndexChanged" AutoPostBack="true" CssClass="search_input_page search_input_page_width" ID="ddlSort" runat="server">
                                    <asp:ListItem Text="الترتيب" Value="-1"></asp:ListItem>
                                    <asp:ListItem Text="من الأحدث للأقدم" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="من الأقدم للأحدث" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="ترتيب أبجدي" Value="3"></asp:ListItem>
                                </asp:DropDownList>
                            </td>

                        </tr>
                        <tr>
                            <td runat="server" visible="false">
                                <label>‫النوع‬</label>
                                <asp:DropDownList CssClass="search_input_page search_input_page_width" ID="ddlType" runat="server"></asp:DropDownList>

                            </td>
                            <td>
                                <label>‫الدولة‬</label>
                                <asp:DropDownList OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged" AutoPostBack="true" CssClass="search_input_page search_input_page_width" ID="ddlCountry" runat="server"></asp:DropDownList>

                            </td>
                            <td>
                                <label>‫تاريخ الملف‬</label>
                                <asp:TextBox ID="txtFileDate" CssClass="search_input_page search_input_page_width" AutoPostBack="true" OnTextChanged="txtFileDate_TextChanged" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <label>‫المجال‬</label>
                                <asp:DropDownList CssClass="search_input_page search_input_page_width" OnSelectedIndexChanged="ddlField_SelectedIndexChanged" AutoPostBack="true" ID="ddlField" runat="server"></asp:DropDownList>

                            </td>
                        </tr>
                    </table>



                    <div class="space"></div>

                    <asp:ListView ItemPlaceholderID="iph" OnPagePropertiesChanged="Repeater1_OnPagePropertiesChanged" ID="Repeater1" runat="server">
                        <LayoutTemplate>
                            <table class="table table-striped">
                                <thead>
                                    <tr id="green_background_color">
                                        <td>التسلسل </td>
                                        <td id="width_10">الرقم </td>
                                        <td id="width_20">عنوان الملف</td>
                                        <td id="width_10">التاريخ</td>
                                        <td id="width_10">المجال</td>
                                        <td id="width_10">النوع</td>
                                        <td id="width_30">الوصف</td>
                                        <td id="width_10">العمليات</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:PlaceHolder ID="iph" runat="server"></asp:PlaceHolder>
                                </tbody>
                            </table>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr>
                                <td class="text-center"><%#Eval("Id")%></td>
                                <td id="width_10"><%#Tools.RecierveNo(Eval("no").ToString()) %></td>
                                <td id="width_20">
                                    <p class="fontsize" id="sub_cont"><%#Eval("Title") %></p>
                                </td>
                                <td class="Mobilehead" id="width_10"><%# (new Dates()).GregToHijri(Eval("FileDate","{0:dd/MM/yyyy}"),"dd/MMM/yyyy") %></td>
                                <td class="Mobilehead" id="width_10">
                                    <p class="fontsize" id="sub_cont"><%#Eval("targetName") %></p>
                                </td>
                                <td class="Mobilehead" id="width_10">
                                    <p class="fontsize" id="sub_cont"><%#Eval("TypeName") %></p>
                                </td>
                                <td class="Mobilehead" id="width_30">
                                    <p class="fontsize" id="sub_cont">
                                        <%#Eval("desc") %>
                                    </p>
                                </td>
                                <td id="width_10" class="green_background_color">
                                    <a href="/SystemFiles/Files/<%#Eval("fileUrl") %>" target="_blank" class="sub_link">تصفح  </a>
                                    <br />
                                    <br />
                                    <a href="/SystemFiles/Files/<%#Eval("fileUrl") %>" class="sub_link" download="<%#Eval("fileUrl") %>">تحميل  </a>
                                </td>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <div class="text-center alert alert-warning">
                                الملف الذي تبحث عنة غير موجود الرجاء تعديل صيغة البحث
                            </div>
                        </EmptyDataTemplate>
                    </asp:ListView>


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
        </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript">
        $(function () {

            $(".calendars-trigger").hide();

        });
        function Validate(event) {
            var regex = new RegExp("^[0-9?=./]+$");
            var key = String.fromCharCode(event.charCode ? event.which : event.charCode);
            if (!regex.test(key)) {
                event.preventDefault();
                return false;
            }
        }
        function RefreshUpdatePanel() {
            __doPostBack('<%= UpdatePanel1.ClientID %>', ''); document.getElementById('<%= txtTitle.ClientID %>').focus();
        }

        var prm = Sys.WebForms.PageRequestManager.getInstance();
        if (prm != null) {
            prm.add_endRequest(function (sender, e) {
                if (sender._postBackSettings.panelsToUpdate != null) {
                    function Validate(event) {
                        var regex = new RegExp("^[0-9?=./]+$");
                        var key = String.fromCharCode(event.charCode ? event.which : event.charCode);
                        if (!regex.test(key)) {
                            event.preventDefault();
                            return false;
                        }
                    }

                    $(function () {

                        $(".calendars-trigger").hide();

                    });
                }
            });
        };
        $(function () {


            $("#<%=txtFileDate.ClientID%>").calendarsPicker($.extend(
            {
                calendar: $.calendars.instance('islamic', 'ar'), dateFormat: "dd/mm/yyyy", showTrigger: '<button type="button" class="trigger"><i class="fa fa-calendar"></i></button>',
                onSelect: function () {
                    __doPostBack('<%= UpdatePanel1.ClientID %>', '');
        },
    },
    $.calendarsPicker.regionalOptions['ar']));

            });
var prm = Sys.WebForms.PageRequestManager.getInstance();

prm.add_endRequest(function () {
    $(function () {


        $("#<%=txtFileDate.ClientID%>").calendarsPicker($.extend(
 {
     calendar: $.calendars.instance('islamic', 'ar'), dateFormat: "dd/mm/yyyy", showTrigger: '<button type="button" class="trigger"><i class="fa fa-calendar"></i></button>',
     onSelect: function () {
         __doPostBack('<%= UpdatePanel1.ClientID %>', '');
        },
    },
    $.calendarsPicker.regionalOptions['ar']));

 });
    }
    );
    </script>

</asp:Content>

