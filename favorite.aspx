<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true" CodeFile="favorite.aspx.cs" Inherits="favorite" %>
<%@ Register TagPrefix="uc1" TagName="hijriCalender" Src="~/Controls/hijriCalender.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="space"></div>
    <div id="full_width_white">
        <div class="container">

            <h4 class="align_right margin_12em font_14_em">المفضله</h4>
            <table class="search_result margin_12e_bottom">
                <tr dir="rtl">
                    <th dir="rtl" colspan="2">
                        <asp:Button ID="btnSearch" OnClick="btnSearch_OnClick" CssClass="search_submit_page float_left" runat="server" Text="بحث" />
                    </th>
                    <th dir="rtl">
                        <label>‫تاريخ الملف‬</label>
                        <uc1:hijriCalender  Class="txtCal search_input_page search_input_page_width datepicker"  runat="server" ID="txtFileDate" />

                    </th>

                    <th dir="rtl">
                        <label>‫المجال‬</label><asp:DropDownList CssClass="search_input_page search_input_page_width" ID="ddlField" runat="server"></asp:DropDownList></th>
                    <th dir="rtl">
                        <label>الرقم</label> <asp:TextBox ID="txtNo1" CssClass="search_input_page" size="4" MaxLength="4" runat="server"></asp:TextBox>/<asp:TextBox ID="txtNo2" CssClass="search_input_page" size="4" MaxLength="4" runat="server"></asp:TextBox></th>
                    <th dir="rtl">
                        <label>‫اسم الملف‬</label><asp:TextBox ID="txtTitle" CssClass="search_input_page search_input_page_width" runat="server"></asp:TextBox></th>
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


            <table  class="table table-bordered table-hover">
                <thead>
                    <tr id="green_background_color">
                        <td style="width: 10%;">الرقم </td>
                        <td style="width: 10%;">اسم الملف</td>
                        <td style="width: 13%;">التاريخ</td>
                        <td style="width: 20%;">المجال</td>
                        <td style="width: 30%;">الوصف</td>
                        <td style="width: 17%;">العملايات</td>
                    </tr>
                </thead>
                <tbody>
                    <asp:ListView OnPagePropertiesChanged="Repeater1_OnPagePropertiesChanged" ID="Repeater1" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td ><%#Eval("no") %></td>
                                <td >
                                    <p id="sub_cont"><%#Eval("Title") %></p>
                                </td>
                                <td style="width: 150px;"><%#(new Dates()).GregToHijri(Eval("FileDate","{0:dd/MM/yyyy}"),"dd/MMM/yyyy") %></td>
                                <td >
                                    <p id="sub_cont"><%#Eval("FieldName") %></p>
                                </td>
                                <td >
                                    <p id="sub_cont">
                                        <%#Eval("desc") %>
                                    </p>
                                </td>
                                <td  class="green_background_color">
                                    <a href="/SystemFiles/Files/<%#Eval("fileUrl") %>" target="_blank" class="sub_link"><i class="fa fa-file"></i> تصفح &nbsp;&nbsp;&nbsp;&nbsp; </a>
                                    <a href="/SystemFiles/Files/<%#Eval("fileUrl") %>" class="sub_link" download="<%#Eval("fileUrl") %>"> <i class="fa fa-download"></i> تحميل &nbsp;&nbsp;&nbsp;&nbsp;</a>
                                    <asp:LinkButton CssClass="sub_link" OnClientClick="return confirm('هل متأكد من حذف ه1ا الملف من الملفات المضلة ؟');" ID="btnDelete" CommandArgument='<%#Eval("id") %>' OnCommand="btnDelete_OnCommand" runat="server"><i class="fa fa-trash"></i> &nbsp;&nbsp;حذف</asp:LinkButton>
                                </td>
                                
                            </tr>
                        </ItemTemplate>
                    </asp:ListView>

                </tbody>
            </table>
            
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

