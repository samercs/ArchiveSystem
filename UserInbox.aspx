<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="UserInbox.aspx.cs" Inherits="UserInbox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 class="text-right">
        الرسائل المستلمة
    </h1>
    <table class="tbl table table-responsive ">
        <thead>
            <tr>
                <th>العنوان 
                </th>
                <th>المرسل
                </th>
                <th>التاريخ
                </th>
                <th>
                    
                </th>
                <th>
                    
                </th>
            </tr>
        </thead>
        <tbody>
            <asp:ListView OnPagePropertiesChanged="ListView1_OnPagePropertiesChanged" ID="ListView1" runat="server">
                <ItemTemplate>

                    <tr>
                        <td>
                            <%#Eval("Title") %>
                        </td>
                        <td>
                            <%#(string.IsNullOrWhiteSpace(Eval("from").ToString()) || Eval("from").ToString().Equals("-1")) ? "مدير الموقع" :  Eval("UserName") %>
                        </td>
                        <td>
                            <%#(new Dates()).GregToHijri(Eval("AddDate","{0:dd/MM/yyyy}"),"dd/MM/yyyy") %>
                        </td>
                        <td>
                            <a data-from="<%#Eval("from") %>" data-text="<%#Eval("msg") %>" data-id="<%#Eval("id") %>" data-title="<%#Eval("title") %>" class="btnReadMsg" data-toggle="modal" data-target="#myModalInbox" href="#">
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
                                لا يوجد رسائل مستلمة
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
        <a href="UserOutbox.aspx" class="btn btn-block btn-primary">
            الرسائل المرسلة
        </a>
    </div>
    <div style="padding: 10px 20px;">
        <a href="UserSendMsg.aspx" class="btn btn-block btn-success">
            رسالة جديدة
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
                    <asp:HiddenField ID="userId" runat="server" />
                                    <div class="comment_box" style="width:100%;">
                                        <table dir="rtl">
                                         <!--   <tr>
                                                <td rowspan="4">
                                                    <asp:Image CssClass="small_user_pic" ID="imgUser" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <h4 class="txt_green font_small space align_right">
                                                        <asp:Label ID="lblUserName" runat="server" Text=""></asp:Label>
                                                    </h4>
                                                </td>
                                            </tr>-->
                                            <tr>
                                                <td class="space align_right">
                                                    <asp:TextBox ID="txtComment" placeholder="كتابة رد... " CssClass="comment_input" TextMode="MultiLine" runat="server"></asp:TextBox>
                                                     <asp:LinkButton OnClientClick="return validateSendMsg();" OnClick="btnSendComent_OnClick" CssClass="comment_sub commenter_btn  txt_left" ID="btnSendComent" runat="server">كتابة رد</asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
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
                $("#<%=userId.ClientID%>").val($this.data("from"));

            });

        });

        function validateSendMsg() {
            
            var msg = $("#<%=txtComment.ClientID%>").val();
            if (isNullOrWhitespace(msg)) {
                alert("الرجاء ادخال الرد");
                return false;
            }

            return true;

        }


        function isNullOrWhitespace(input) {

            if (typeof input === 'undefined' || input == null) return true;

            return input.replace(/\s/g, '').length < 1;
        }
    </script>

</asp:Content>

