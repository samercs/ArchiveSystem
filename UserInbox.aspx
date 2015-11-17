﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="UserInbox.aspx.cs" Inherits="UserInbox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <table class="tbl table table-responsive ">
        <thead>
            <tr>
                <th>العنوان 
                </th>
                <th>المرسل
                </th>
                <th>التاريخ
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
                            <%#string.IsNullOrWhiteSpace(Eval("UserName").ToString()) ? "مدير الموقع" : Eval("UserName").ToString() %>
                        </td>
                        <td>
                            <%#Eval("AddDate","{0:dd/MM/yyyy}") %>
                        </td>
                        <td>
                            <a data-from="<%#Eval("from") %>" data-text="<%#Eval("msg") %>" data-id="<%#Eval("id") %>" data-title="<%#Eval("title") %>" class="btnReadMsg" data-toggle="modal" data-target="#myModalInbox" href="#">
                                <i class="fa fa-eye"></i>قراءة
                            </a>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
        </tbody>
    </table>
    
    <div class="pager text-center">
        <asp:DataPager class="btn-group btn-group-sm" ID="DataPager1" PagedControlID="ListView1" PageSize="10" runat="server">
                <Fields>
                    <asp:NumericPagerField ButtonType="Link" CurrentPageLabelCssClass="btn btn-primary disabled" RenderNonBreakingSpacesBetweenControls="false"
                    NumericButtonCssClass="btn btn-default" ButtonCount="10" NextPageText="..." NextPreviousButtonCssClass="btn btn-default" />
                </Fields>
            </asp:DataPager>
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
                               
                                <asp:HiddenField ID="userId" runat="server" />
                                    <div class="comment_box">
                                        <table dir="rtl">
                                            <tr>
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
                                            </tr>
                                            <tr>
                                                <td class="space align_right">
                                                    <asp:TextBox ID="txtComment" placeholder="كتابة رد... " CssClass="comment_input" TextMode="MultiLine" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class=" ">
                                                    <asp:LinkButton OnClientClick="return validateSendMsg();" OnClick="btnSendComent_OnClick" CssClass="comment_sub background_gray txt_left" ID="btnSendComent" runat="server">كتابة رد
                                                        <img src="img/goback_green.png" class="img-responsive txt_left" /></asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                               
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

