<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="UserOutbox.aspx.cs" Inherits="UserOutbox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 class="text-right" style="padding-right:10px;">
        الرسائل المرسلة
    </h1>
    <table class="tbl table table-responsive ">
        <thead>
            <tr>
                <th>العنوان 
                </th>
                <th>الى
                </th>
                <th>التاريخ
                </th>
                <th></th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <asp:ListView OnPagePropertiesChanged="ListView1_OnPagePropertiesChanged" ID="ListView1" runat="server">
                <ItemTemplate>

                    <tr>
                        <td>
                           <a data-to="<%#Eval("username") %>" data-text="<%#Eval("msg") %>" data-id="<%#Eval("id") %>" data-title="<%#Eval("title") %>" class="btnReadMsg" data-toggle="modal" data-target="#myModalInbox" href="#">  <%#Eval("Title") %>
                               </a>
                        </td>
                        <td>
                            <%#Eval("toId").ToString().Equals("-1") ? "مدير الموقع" :   Eval("UserName") %>
                        </td>
                        <td>
                            <%#(new Dates()).GregToHijri(Eval("AddDate","{0:dd/MM/yyyy}"),"dd/MM/yyyy") %>
                        </td>
                        <td>
                            <a data-to="<%#Eval("username") %>" data-text="<%#Eval("msg") %>" data-id="<%#Eval("id") %>" data-title="<%#Eval("title") %>" class="btnReadMsg" data-toggle="modal" data-target="#myModalInbox" href="#">
                                <i class="fa fa-eye"></i>قراءة
                            </a>
                        </td>
                        <td>
                            <asp:LinkButton OnClientClick="return confirm('هل متأكد من حذف هذة الرسالة');" OnCommand="btnDelete_OnCommand" ID="btnDelete" CommandArgument='<%#Eval("id") %>' runat="server"><i class="fa fa-trash"></i> حذف</asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
                <EmptyDataTemplate>
                    <tr>
                        <td colspan="4">
                            <div class="alert alert-warning text-center">
                                لا يوجد رسائل مرسلة
                            </div>
                        </td>
                    </tr>
                </EmptyDataTemplate>
            </asp:ListView>
        </tbody>
    </table>
    
    <div class="pager text-center">
        <asp:DataPager class="btn-group btn-group-sm" ID="DataPager1" PagedControlID="ListView1" PageSize="6" runat="server">
                <Fields>
                    <asp:NumericPagerField ButtonType="Link" CurrentPageLabelCssClass="btn btn-primary disabled" RenderNonBreakingSpacesBetweenControls="false"
                    NumericButtonCssClass="btn btn-default" ButtonCount="10" NextPageText="..." NextPreviousButtonCssClass="btn btn-default" />
                </Fields>
            </asp:DataPager>
    </div>
    
    
    <div style="padding: 10px 20px;">
        <a href="UserSendMsg.aspx" class="btn btn-block btn-primary">
            رسالة جديدة
        </a>
    </div>
    <div style="padding: 10px 20px;">
        <a href="UserInbox.aspx" class="btn btn-block btn-success">
            الرسائل المستلمة
        </a>
    </div>
    

    <div class="modal fade" id="myModalInbox" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">


                    <h4 class="modal-title">قراءة الرسالة</h4>
                    <img src="img/model_arrow.png" class="img-responsive arrow_model" />
                </div>
                <div class="arrow_model_form"></div>
                <div class="modal-body">
                    <table dir="rtl" class="form_table">
                        <tr class="form_table_tr ">
                            <td>المستلم
                            </td>
                            <td>
                                <asp:Label ID="lblReciver" runat="server" CssClass=" text-success" Text="sdfsdf"></asp:Label>
                            </td>
                        </tr>
                        <tr class="form_table_tr ">
                            <td>عنوان الرسالة
                            </td>
                            <td>
                                <asp:Label ID="lblTitle" runat="server" CssClass=" text-success" Text="sdfsdf"></asp:Label>
                            </td>
                        </tr>
                        <tr class="form_table_tr ">
                            <td>الرسالة
                            </td>
                            <td>
                                <asp:Label ID="lblMsg" runat="server" CssClass=" text-success" Text="sdfsdf"></asp:Label>
                            </td>
                        </tr>
                        <tr  class="form_table_tr ">
                            <td colspan="2">  
                            </td>
                        </tr>

                    </table>
                    
                </div>

            </div>

        </div>
    </div>

    <script type="text/javascript">
        $(function () {


            $(".btnReadMsg").click(function () {

                var $this = $(this);
                $("#<%=lblTitle.ClientID%>").text($this.data("title"));
                $("#<%=lblMsg.ClientID%>").text($this.data("text"));
                $("#<%=lblReciver.ClientID%>").text($this.data("to"));
                

            });

        });

        


        function isNullOrWhitespace(input) {

            if (typeof input === 'undefined' || input == null) return true;

            return input.replace(/\s/g, '').length < 1;
        }
    </script>

</asp:Content>

