<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true" CodeFile="favorite.aspx.cs" Inherits="favorite" %>
<%@ Register TagPrefix="uc1" TagName="hijriCalender" Src="~/Controls/hijriCalender.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">    <style>
        select{
            direction:rtl;
        }
        label{
            width:75px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="space"></div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="full_width_white">
        <div class="container">

            <h4 class="align_right margin_12em font_14_em">المفضله</h4>
<table class="search_result margin_12e_bottom">
                <tr>
                    <td rowspan="2">
                        <asp:Button ID="btnSearch" OnClick="btnSearch_OnClick" CssClass="search_submit_page float_left" runat="server" Text="بحث" />
                    </td>

                   
                    <td>
                        <label>الرقم</label>
                        <asp:TextBox ID="txtNo1" CssClass="search_input_page search_input_page_width" OnTextChanged="txtNo1_TextChanged" AutoPostBack="true" runat="server"></asp:TextBox></td>
                    <td>
                        <label>عنوان الملف‬</label><asp:TextBox ID="txtTitle" CssClass="search_input_page search_input_page_width" runat="server"></asp:TextBox></td>
 <td>
                  <label>ترتيب النتائج</label>
     <asp:DropDownList CssClass="search_input_page search_input_page_width" OnSelectedIndexChanged="ddlSort_SelectedIndexChanged" AutoPostBack="true" ID="ddlSort" runat="server">
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
                        <asp:DropDownList CssClass="search_input_page search_input_page_width" OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged" AutoPostBack="true" ID="ddlCountry" runat="server"></asp:DropDownList>

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
         

            <table  class="table table-striped">
                <thead>
                    <tr id="green_background_color">
                        <td id="width_10">الرقم </td>
                        <td id="width_20">عنوان الملف</td>
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
                                <td ><%#Tools.RecierveNo(Eval("no").ToString()) %></td>
                                <td >
                                    <p id="sub_cont"><%#Eval("Title") %></p>
                                </td>
                                <td   class="Mobilehead"  style="width: 150px;"><%#(new Dates()).GregToHijri(Eval("FileDate","{0:dd/MM/yyyy}"),"dd/MMM/yyyy") %></td>
                                <td   class="Mobilehead"  >
                                    <p id="sub_cont"><%#Eval("TargetName") %></p>
                                </td>
                                <td   class="Mobilehead"  >
                                    <p id="sub_cont">
                                        <%#Eval("desc") %>
                                    </p>
                                </td>
                                <td  class="green_background_color">
                                    <a href="/SystemFiles/Files/<%#Eval("fileUrl") %>" target="_blank" class="sub_link"><i class="fa fa-file"></i> تصفح  </a><br />
                                    <a href="/SystemFiles/Files/<%#Eval("fileUrl") %>" class="sub_link" download="<%#Eval("fileUrl") %>"> <i class="fa fa-download"></i> تحميل </a><br />
                                    <asp:LinkButton CssClass="sub_link" OnClientClick="return confirm('هل انت متأكد من إزالة الملف من الملفات المفضلة ؟');" ID="btnDelete" CommandArgument='<%#Eval("id") %>' OnCommand="btnDelete_OnCommand" runat="server"><i class="fa fa-trash"></i> إزالة</asp:LinkButton>
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
        </ContentTemplate>
    </asp:UpdatePanel>
    
    <script type="text/javascript">
        $(function () {

            $(".calendars-trigger").hide();

        });

        function RefreshUpdatePanel() {
            __doPostBack('<%= UpdatePanel1.ClientID %>', ''); document.getElementById('<%= txtTitle.ClientID %>').focus();
        }

        var prm = Sys.WebForms.PageRequestManager.getInstance();
        if (prm != null) {
            prm.add_endRequest(function (sender, e) {
                if (sender._postBackSettings.panelsToUpdate != null) {


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

