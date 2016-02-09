<%@ Page Title="" Theme="Ar" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Notifications.aspx.cs" Inherits="Notifications" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .notifications{
            padding-right:15px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="space"></div>
    <asp:ListView ID="ListView1" runat="server" OnItemDataBound="ListView1_ItemDataBound"  OnPagePropertiesChanged="ListView1_OnPagePropertiesChanged">
        <ItemTemplate>
            <asp:HiddenField ID="Datet" runat="server" Value='<%#Eval("AddDate") %>' />
    <div class="notifications" dir="rtl">
                لقد قمت بالتعليق على الملف <a href="<%# ResolveUrl("~/FileDetails.aspx?id="+Eval("id")) %>">(<%#Eval("Title") %>)</a> بتاريخ (<%# (new Dates()).GregToHijri(Eval("AddDate","{0:dd/MM/yyyy}"),"dd/MMM/yyyy") %>) ,<asp:Label ID="time" runat="server" Text="Label"></asp:Label>
        </div>
<div class="space"></div>
        </ItemTemplate>
    </asp:ListView>
        <div class="space"></div>
    <div class="text-center">
        <asp:DataPager ID="DataPager1" class="btn-group btn-group-sm" PagedControlID="ListView1" PageSize="15" runat="server">
            <Fields>
                <asp:NumericPagerField ButtonType="Link" CurrentPageLabelCssClass="btn btn-primary disabled" RenderNonBreakingSpacesBetweenControls="false"
                    NumericButtonCssClass="btn btn-default" ButtonCount="10" NextPageText="..." NextPreviousButtonCssClass="btn btn-default" />
            </Fields>
        </asp:DataPager>
    </div>
    <div class="space"></div>
</asp:Content>

