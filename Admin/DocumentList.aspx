﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="DocumentList.aspx.cs" Inherits="Admin_DocumentList" %>

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
            <asp:HyperLink ID="HyperLink3" NavigateUrl="" CssClass="tdn fr" runat="server"><h5><i class="fa fa-plus-square-o"></i> اضافة معاملة </h5></asp:HyperLink>
            <asp:LinkButton ID="btnContactDelete" OnClick="btnContactDelete_Click" runat="server" CssClass="tdn fr mr10px btnDelete"><h5><i class="fa fa-times"></i> حذف المعاملات المختارة</h5></asp:LinkButton>
            <div class="clear"></div>
            <table class="SearchTable">
                <tr>
                    <td>
                        عنوان المعاملة
                    </td>
                    <td>
                        <asp:TextBox ID="txtFileName"  CssClass="txt1" Width="200" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        رقم المعاملة
                    </td>
                    <td>
                        <asp:TextBox ID="txtFileNo1" ValidationGroup="Option3" CssClass="txt1" Width="100" runat="server"></asp:TextBox> /
                        <asp:TextBox ID="txtFileNo2" ValidationGroup="Option3" CssClass="txt1" Width="100" runat="server"></asp:TextBox> 
                    </td>
                    <td>
                        فئة المعاملة
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlField" CssClass="ddl1" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Button OnClick="btnSearch_OnClick" CssClass="btnLogin" ID="btnSearch" runat="server" Text="بحث" />
                    </td>
                </tr>
            </table>
            
            

            <table cellspacing='0' class="LoginTbl tblList">
                <!-- cellspacing='0' is important, must stay -->
                <tr>
                    <th>
                        <asp:CheckBox ID="CheckBox10" OnCheckedChanged="CheckBox10_CheckedChanged" AutoPostBack="true" runat="server" /></th>
                    
                    <th>موضوع المعاملة</th>
                    <th>رقم القيد</th>
                    <th>فئة المعاملة</th>
                    <th>سرية المعاملة</th>
                    <th>الوضع القانوني</th>
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
                                <asp:CheckBox ID="CheckBox1" runat="server" /></td>
                            
                            <td>
                                <%#Eval("title") %> 
                            </td>
                            <td>
                                <%#Tools.RecierveNo(Eval("No").ToString()) %>
                            </td>
                            <td>
                                <%#Eval("CatName") %>
                            </td>
                            <td>
                                <%#Eval("SecName") %>
                            </td>
                            <td>
                                <%#Eval("LegalName") %>
                            </td>
                            
                            <td style="width: 150px;">
                                <asp:LinkButton CssClass="btnDelete" ID="btnDelete" OnCommand="btnDelete_Command" CommandName='' CommandArgument='<%#Eval("id") %>' runat="server"><i class="fa fa-trash fs20px"></i> حذف</asp:LinkButton>
                                <asp:LinkButton ID="btnEdit" OnCommand="btnEdit_Command" CommandArgument='<%#Eval("id") %>' runat="server"><i class="fa fa-pencil-square-o fs20px"></i> تعديل</asp:LinkButton>
                                
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



