<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" ValidateRequest="false" AutoEventWireup="true" CodeFile="DocumentOp.aspx.cs" Inherits="Admin_DocumentOp" %>

<%@ Register Src="~/controls/hijriCalender.ascx" TagPrefix="uc1" TagName="hijriCalender" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 class="Title BorderBottom"><%=name %></h1>

    <asp:HyperLink ID="HyperLink2" CssClass="tdn fl" NavigateUrl="DocumentList.aspx" runat="server"><h5><i class="fa fa-backward"></i> رجوع</h5></asp:HyperLink>
    <div class="clear PT20"></div>
    <section>
        <asp:Panel ID="Panel1" DefaultButton="btnSave" runat="server">
            <table class="tblConListOpt">
                

                <tr>
                    <td>
                        <asp:Label ID="Label9" runat="server" Text="موضوع المعاملة" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtTitle" ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="رقم القيد" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtNo1" Width="150" ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox> / 
                        <asp:TextBox ID="txtNo2" Width="150" ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label7" runat="server" Text="فئة المعاملة" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="ddlCat" CssClass="ddl1" runat="server">
                            
                        </asp:DropDownList>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="سرية المعاملة" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="ddlSec" CssClass="ddl1" runat="server">
                            
                        </asp:DropDownList>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="الوضع القانوني" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="ddlLegal" CssClass="ddl1" runat="server">
                            
                        </asp:DropDownList>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        المعاملات المرتبطة
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    المعاملة رقم 1
                                </td>
                                <td>
                                    <asp:DropDownList  ID="ddlRDoc1" CssClass="ddl1  ddlExe ddlExe1" data-id="1" runat="server">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    
                                </td>
                            </tr>
                            <tr id="tr2">
                                <td>
                                    المعاملة رقم 2
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlRDoc2" CssClass="ddl1 ddlExe ddlExe2" data-id="2" runat="server">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <a href="#"><img data-id="2" class="btnRemove" src="Images/remove.png" /></a>
                                </td>
                            </tr>
                            <tr id="tr3">
                                <td>
                                    المعاملة رقم 3
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlRDoc3" CssClass="ddl1 ddlExe ddlExe3" data-id="3" runat="server">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <a href="#"><img data-id="3" class="btnRemove" src="Images/remove.png" /></a>
                                </td>
                            </tr>
                            <tr id="tr4">
                                <td>
                                    المعاملة رقم 4
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlRDoc4" CssClass="ddl1 ddlExe ddlExe4" data-id="4" runat="server">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <a href="#"><img data-id="4" class="btnRemove" src="Images/remove.png" /></a>
                                </td>
                            </tr>
                            <tr id="tr5">
                                <td>
                                    المعاملة رقم 5
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlRDoc5" CssClass="ddl1 ddlExe ddlExe5" data-id="5" runat="server">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <a href="#"><img data-id="5" class="btnRemove" src="Images/remove.png" /></a>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                
                <tr>
                    <td colspan="2">
                        <a href="DocumentList.aspx" class="btnLogin2 fr">الغاء</a>
                        <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" ValidationGroup="Option3" Text="حفظ" CssClass="btnLogin fr" />

                    </td>
                </tr>
            </table>
        </asp:Panel>
    </section>
    
    
    <script>
        
        $(function () {
            
            
            ini_page();


            $(".ddlExe").change(function () {
                var $val = $(this).val();
                if($val != "-1") {
                    $id = $(this).data("id");
                    $next = (parseInt($id) + 1);
                    $("#tr" + $next).show();
                } else {

                }
               
                  

            });

            $(".btnRemove").click(function (e) {
                e.preventDefault();
                $id = $(this).data("id");
                $("#tr" + $id).hide();
                $(".ddlExe" + $id).val("-1");

            });

        });


        function ini_page() {
            

            $("#tr2").hide();
            $("#tr3").hide();
            $("#tr4").hide();
            $("#tr5").hide();
            var $val2=$("#<%=ddlRDoc2.ClientID%>").val();
            var $val3=$("#<%=ddlRDoc3.ClientID%>").val();
            var $val4=$("#<%=ddlRDoc4.ClientID%>").val();
            var $val5=$("#<%=ddlRDoc5.ClientID%>").val();




            <%
            if(Request.QueryString["Op"].Equals("Edit"))
            {
                %>
                if($val2 != "-1" ) {
                    $("#tr2").show();
                }
                if ($val3 != "-1") {
                    $("#tr3").show();
                }
                if ($val4 != "-1") {
                    $("#tr4").show();
                }
                if ($val5 != "-1") {
                    $("#tr5").show();
                }
            
            
                <%
            }

            %>

        }

    </script>

</asp:Content>




