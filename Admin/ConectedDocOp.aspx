<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" ValidateRequest="false" AutoEventWireup="true" CodeFile="ConectedDocOp.aspx.cs" Inherits="Admin_ConectedDocOp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 class="Title BorderBottom"><%=name %></h1>
    
    <asp:HyperLink ID="HyperLink2" CssClass="tdn fl" NavigateUrl="" runat="server"><h5><i class="fa fa-backward"></i> رجوع</h5></asp:HyperLink>
    <div class="clear PT20"></div>
    <section>
        <asp:Panel ID="Panel1" DefaultButton="btnSave" runat="server">
            <table class="tblConListOpt">
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="الملف الرئيسي" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:Label ID="lblFilename" runat="server" Text="" CssClass="label_xblack"></asp:Label></td>
                    </td>
                    
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label9" runat="server" Text="اختر الملف المرتبط" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="ddlFile" CssClass="ddl1" runat="server">
                            
                        </asp:DropDownList>
                    </td>
                    
                </tr>
                
                

                <tr>
                    <td colspan="2">
                        <a href="ConectedDocList.aspx?id=<%=Request.QueryString["pid"] %>" class="btnLogin2 fr">الغاء</a>
                        <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" ValidationGroup="Option3" Text="حفظ" CssClass="btnLogin fr" />
                        
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




