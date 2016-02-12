<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="UserInbox.aspx.cs" Inherits="UserInbox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 class="text-right">الرسائل المستلمة
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
                <th></th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <asp:ListView OnPagePropertiesChanged="ListView1_OnPagePropertiesChanged" ID="ListView1" runat="server">
                <ItemTemplate>

                    <tr>
                        <td>
                            <a data-id="<%#Eval("id") %>" data-from="<%#Eval("from") %>" data-text="<%#Eval("msg") %>" data-id="<%#Eval("id") %>" data-title="<%#Eval("title") %>" class="btnReadMsg" data-toggle="modal" data-target="#myModalInbox" href="#"><%#Eval("Title") %></a>
                        </td>
                        <td>
                            <%#(string.IsNullOrWhiteSpace(Eval("from").ToString()) || Eval("from").ToString().Equals("-1")) ? "مدير الموقع" :  Eval("UserName") %>
                        </td>
                        <td>
                            <%#(new Dates()).GregToHijri(Eval("AddDate","{0:dd/MM/yyyy}"),"dd/MM/yyyy") %>
                        </td>
                        <td>
                            <a data-id="<%#Eval("id") %>" data-from="<%#Eval("from") %>" data-text="<%#Eval("msg") %>" data-id="<%#Eval("id") %>" data-title="<%#Eval("title") %>" class="btnReadMsg" data-toggle="modal" data-target="#myModalInbox" href="#">
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
        <a href="UserOutbox.aspx" class="btn btn-block btn-primary">الرسائل المرسلة
        </a>
    </div>
    <div style="padding: 10px 20px;">
        <a href="UserSendMsg.aspx" class="btn btn-block btn-success">رسالة جديدة
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
                                <asp:Label ID="lblTitle" runat="server" CssClass=" text-success" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr class="form_table_tr ">
                            <td>الرسالة
                            </td>
                            <td>
                                <div style="overflow-x: scroll; width: 300px;">
                                    <asp:Label ID="lblMsg" runat="server" CssClass=" text-success" Text=""></asp:Label>
                                </div>
                            </td>
                        </tr>
                        <tr class="form_table_tr ">
                            <td colspan="2"></td>
                        </tr>

                    </table>
                    <asp:HiddenField ID="userId" runat="server" />

                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <table dir="rtl" class="table table-responsive">
                                <tr>
                                    <td class="space align_right">
                                        <asp:TextBox ID="txtTitle" placeholder="عنوان الرسالة" CssClass="form-control" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="space align_right">
                                        <asp:TextBox ID="txtComment" MaxLength="500" placeholder="كتابة رد... " CssClass="form-control" TextMode="MultiLine" runat="server"></asp:TextBox>
                                        <div id="txtaddress" dir="rtl" style="font-size: 12px; text-align: center;"></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton OnClientClick="return validateSendMsg();" OnClick="btnSendComent_OnClick" CssClass="comment_sub commenter_btn  txt_left" ID="btnSendComent" runat="server">ارسال الرد</asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>

            </div>

        </div>
    </div>

    <script type="text/javascript">
        $(function () {


            $(".btnReadMsg").click(function () {

                var $this = $(this);
                $("#<%=lblTitle.ClientID%>").text($this.data("title"));
                $("#<%=txtTitle.ClientID%>").val('رد : ' + $this.data("title"));
                $("#<%=lblMsg.ClientID%>").text($this.data("text"));
                $("#<%=userId.ClientID%>").val($this.data("from"));
                $.ajax({
                    url: "ajax/updateMsg.ashx?id=" + $this.data("id"), success: function (result) {

                    }
                });

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
        $(document).ready(function () {

            var text_max = 500;

            $('#txtaddress').html(text_max + ' حرف متبقي');

            $("#<%=txtComment.ClientID%>").keyup(function () {

                var text_length = $("#<%=txtComment.ClientID%>").val().length;
                var text_remaining = text_max - text_length;

                $('#txtaddress').html(text_remaining + ' حرف متبقي');


            });

                });

        var prm = Sys.WebForms.PageRequestManager.getInstance();

        prm.add_endRequest(function () {
            $(function () {


                $(".btnReadMsg").click(function () {

                    var $this = $(this);
                    $("#<%=lblTitle.ClientID%>").text($this.data("title"));
                $("#<%=txtTitle.ClientID%>").val('رد : ' + $this.data("title"));
                $("#<%=lblMsg.ClientID%>").text($this.data("text"));
                $("#<%=userId.ClientID%>").val($this.data("from"));
                $.ajax({
                    url: "ajax/updateMsg.ashx?id=" + $this.data("id"), success: function (result) {

                    }
                });

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
            $(document).ready(function () {

                var text_max = 500;

                $('#txtaddress').html(text_max + ' حرف متبقي');

                $("#<%=txtComment.ClientID%>").keyup(function () {

                var text_length = $("#<%=txtComment.ClientID%>").val().length;
                var text_remaining = text_max - text_length;

                $('#txtaddress').html(text_remaining + ' حرف متبقي');


            });

                });
        });
    </script>

</asp:Content>

