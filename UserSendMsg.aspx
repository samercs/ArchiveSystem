﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="UserSendMsg.aspx.cs" Inherits="UserSendMsg" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="js/jquery.tokeninput.js"></script>
    <link href="css/token-input.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 class="text-right">رسالة جديدة
    </h1>
    <div class="form-group">
        <label>المستلم</label>
        <asp:TextBox ID="txtTo"   CssClass="form-control" runat="server"></asp:TextBox>
    </div>
    <div class="form-group">
        <label>العنوان</label>
        <asp:TextBox ID="txtSubject" CssClass="form-control" runat="server"></asp:TextBox>
    </div>
    <div class="form-group">
        <label>الرسالة</label>
        <asp:TextBox ID="txtMsg" Height="120" MaxLength="500" TextMode="MultiLine"  CssClass="form-control" runat="server"></asp:TextBox>
        <div id="txtaddress" dir="rtl" style="font-size:12px;text-align:center;"></div>
    </div>
    <div class="form-group">
        <asp:Button OnClick="btnSendMsg_OnClick" CssClass="btn btn-block btn-success" ID="btnSendMsg" runat="server" Text="ارسال الرسالة" />
    </div>
    <div class="form-group">
        <a href="UserInbox.aspx" class="btn btn-block btn-warning">
            رجوع
        </a>
    </div>
    <div class="form-group">
        <asp:Panel CssClass="" ID="DivError" runat="server" Visible="False">
            <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
        </asp:Panel>
    </div>

    <script type="text/javascript">
        $(function () {

            $("#<%=txtTo.ClientID%>").tokenInput(<%=ViewState["json"]%>, {  });
            

        });
        $(document).ready(function() {

            var text_max = 500;

            $('#txtaddress').html(text_max+' حرف متبقي');

            $("#<%=txtMsg.ClientID%>").keyup(function() {

                var text_length =   $("#<%=txtMsg.ClientID%>").val().length;
                var text_remaining = text_max - text_length;

                $('#txtaddress').html(text_remaining+' حرف متبقي');
         

            });

        });
        
    </script>

</asp:Content>

