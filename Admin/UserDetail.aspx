﻿
<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" ValidateRequest="false" AutoEventWireup="true" CodeFile="UserDetail.aspx.cs" Inherits="Admin_UserDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="Scripts/tinymce/js/tinymce/tinymce.min.js"></script>
    
    <script type="text/javascript">
        tinymce.init({
            selector: "textarea",
            plugins: [
                "advlist autolink autosave link image lists charmap print preview hr anchor pagebreak spellchecker",
                "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
                "table contextmenu directionality emoticons template textcolor paste textcolor colorpicker textpattern"
            ],

            toolbar1: "bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | styleselect formatselect fontselect fontsizeselect",
            toolbar2: "cut copy paste | searchreplace | bullist numlist | outdent indent blockquote | undo redo | link unlink anchor image media code | insertdatetime preview | forecolor backcolor",
            toolbar3: "table | hr removeformat | subscript superscript | charmap emoticons | print fullscreen | ltr rtl | spellchecker | visualchars visualblocks nonbreaking template pagebreak restoredraft",

            menubar: false,
            toolbar_items_size: 'small',

            style_formats: [
                { title: 'Bold text', inline: 'b' },
                { title: 'Red text', inline: 'span', styles: { color: '#ff0000' } },
                { title: 'Red header', block: 'h1', styles: { color: '#ff0000' } },
                { title: 'Example 1', inline: 'span', classes: 'example1' },
                { title: 'Example 2', inline: 'span', classes: 'example2' },
                { title: 'Table styles' },
                { title: 'Table row 1', selector: 'tr', classes: 'tablerow1' }
            ],
        });</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 class="Title BorderBottom"><%=name %></h1>
    
    <asp:HyperLink ID="HyperLink2" CssClass="tdn fl" NavigateUrl="#" runat="server"><h5><i class="fa fa-backward"></i> رجوع</h5></asp:HyperLink>
    <div class="clear PT20"></div>
    <section>
        <asp:Panel ID="Panel1"  runat="server">
            <table class="tblConListOpt">
                
                
                <tr>
                    <td>
                        <asp:Label ID="Label9" runat="server" Text="الاسم" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblName" CssClass="Bold" runat="server" Text=""></asp:Label>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="البريد الالكتروني" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblEmail" CssClass="Bold" runat="server" Text=""></asp:Label>
                    </td>
                    <td></td>
                </tr>
                 <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="اسم المستخدم" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblUserName" CssClass="Bold" runat="server" Text=""></asp:Label>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="كلمة السر" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblPassword" CssClass="Bold" runat="server" Text=""></asp:Label>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="2">
                        
                        <a href="Default.aspx" class="btnLogin2 fr">رجوع</a>
                        <asp:LinkButton OnClick="LinkButton1_OnClick" CssClass="btnLogin fr" ID="LinkButton1" runat="server">تعديل</asp:LinkButton>
                     </td>
                </tr>
            </table>
        </asp:Panel>
    </section>
    <script>
        $(function() {
            
            

        });
    </script>
</asp:Content>




