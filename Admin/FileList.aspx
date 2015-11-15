<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="FileList.aspx.cs" Inherits="Admin_FilesList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 class="Title BorderBottom"><%=name %></h1>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdateProgress runat="server" ID="PageUpdateProgress" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="0">
        <ProgressTemplate>
            <div class="LoadingCenter">
                <img src="Images/small_loader.gif" />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HyperLink ID="HyperLink1" NavigateUrl="Default.aspx" CssClass="tdn fl" runat="server"><h5><i class="fa fa-backward"></i> رجوع</h5></asp:HyperLink>
            <asp:HyperLink ID="HyperLink3" NavigateUrl="" CssClass="tdn fr" runat="server"><h5><i class="fa fa-plus-square-o"></i> اضافة ملف </h5></asp:HyperLink>
            <asp:LinkButton ID="btnContactDelete" OnClick="btnContactDelete_Click" runat="server" CssClass="tdn fr mr10px btnDelete"><h5><i class="fa fa-times"></i> حذف الملفات المختارة</h5></asp:LinkButton>
            <div class="clear"></div>
            <table cellspacing='0' class="LoginTbl tblList">
                <!-- cellspacing='0' is important, must stay -->
                <tr>
                    <th>
                        <asp:CheckBox ID="CheckBox10" OnCheckedChanged="CheckBox10_CheckedChanged" AutoPostBack="true" runat="server" /></th>
                    
                    <th>العنوان</th>
                    <th>الرقم</th>
                    <th>جهة الاصدار</th>
                    <th>جهة الاستقبال</th>
                     <th>الجهات المستهدفه</th>
                    <th>النوع</th>
                    <th>الحالة</th>
                    <th>تاريخ الاضافة</th>
                    <th>تاريخ الملف</th>
                    <th></th>
                </tr>
                <asp:ListView ID="RepeaterLists" OnPagePropertiesChanged="ListView1_PagePropertiesChanged" ItemPlaceholderID="iph" runat="server">
                    <LayoutTemplate>
                        <asp:PlaceHolder ID="iph" runat="server"></asp:PlaceHolder>
                        <tr>
                            <td colspan="10">
                                <div class="Pager AC">
                                    <asp:DataPager ID="DataPager2" PagedControlID="RepeaterLists" PageSize="10" runat="server">
                                        <Fields>
                                            <asp:NumericPagerField CurrentPageLabelCssClass="CurrentPageNumber" ButtonCount="10" />
                                        </Fields>
                                    </asp:DataPager>
                                </div>
                            </td>
                        </tr>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:HiddenField ID="id" runat="server" Value='<%# Eval("Id") %>' />
                                <asp:HiddenField ID="file" runat="server" Value='<%# Eval("fileUrl") %>' />
                                <asp:CheckBox ID="CheckBox1" runat="server" /></td>
                            
                            <td>
                                <%#Eval("title") %> 
                            </td>
                            <td>
                                <%#Eval("No") %>
                            </td>
                            <td>
                                <%#Eval("From") %>
                            </td>
                            <td>
                                <%#Eval("To") %>
                            </td>
                            <td>
                                <%#Eval("Target") %>
                            </td>
                            <td>
                                <%#Eval("Type").ToString().Equals("1") ? "ملف" : "تعميم" %>
                            </td>
                            <td>
                                <%#Eval("Status").ToString().Equals("1") ? "منشور" : "موقوف" %>
                                - <asp:LinkButton OnCommand="btnEditStatus_OnCommand" CommandArgument='<%#Eval("id") %>' ID="btnEditStatus" runat="server">
                                    <%#Eval("Status").ToString().Equals("1") ? "ايقاف" : "تفعيل" %>
                                </asp:LinkButton> 
                            </td>
                            <td>
                                <%#new Dates().GregToHijri(Eval("AddedDate","{0:dd/MM/yyyy}"),"dd/MMM/yyyy") %>
                            </td>
                            <td>
                                <%#new Dates().GregToHijri(Eval("FileDate","{0:dd/MM/yyyy}"),"dd/MMM/yyyy") %>
                            </td>
                            <td style="width: 150px;">
                                <asp:LinkButton CssClass="btnDelete" ID="btnDelete" OnCommand="btnDelete_Command" CommandName='<%#Eval("FileUrl") %>' CommandArgument='<%#Eval("id") %>' runat="server"><i class="fa fa-trash fs20px"></i> حذف</asp:LinkButton>
                                <asp:LinkButton ID="btnEdit" OnCommand="btnEdit_Command" CommandArgument='<%#Eval("id") %>' runat="server"><i class="fa fa-pencil-square-o fs20px"></i> تعديل</asp:LinkButton>
                                <div style="padding-top: 10px;">
                                    <a href="ConectedDocList.aspx?id=<%#Eval("id") %>"><i class="fa fa-link"></i> الملفات المرتبطة </a>
                                </div>
                                <div style="padding-top: 10px;">
                                    <a href="FilesAttachList.aspx?id=<%#Eval("id") %>"><i class="fa fa-paperclip"></i> الملفات المرفقه </a>
                                </div>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
            </table>
            </section>
        </ContentTemplate>
    </asp:UpdatePanel>
    
    <script>
        alertify.defaults.glossary.ok = 'موافق';
        alertify.defaults.glossary.cancel = 'إلغاء';
        

        function bindEvent() {
            $(".btnDelete").click(function (event) {
                event.preventDefault();
                var href = this.href;
                alertify.confirm('تأكيد الحذف','هل متأكد من الحذف.', function () { window.location.href = href; },null);

            });
        }

        $(function() {


            bindEvent();
            

            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (evt, args) {
                bindEvent();
            });

        });
    </script>
</asp:Content>



