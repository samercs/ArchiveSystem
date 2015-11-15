<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 class="Title BorderBottom">الصفحة الرئيسية</h1>
    <div class="PagesItems">
        <a href="AdminList.aspx">
            <div class="item">
                <div class="clear sp20"></div>
                <i class="fa fa-lock fa-4x"></i>
                <br />
                <p>
                    مدير الموقع
                </p>

            </div>
        </a>
        <a href="FileList.aspx">
            <div class="item">
                <div class="clear sp20" "></div>
                <i class="fa fa-file-text-o fa-4x"></i>
                <br />
                <p>
                    الملفات
                </p>

            </div>
        </a>
        <a href="FileNoticeList.aspx">
            <div class="item">
                <div class="clear sp20"></div>
                <i class="fa fa-bell fa-4x"></i>
                <br />
                <p class="posr">
                   الابلاغات عن الملفات 
                    <span id="lblFileNoticeCount" runat="server" class="badge">
                    </span>
                </p>

            </div>
        </a>
        <a href="FileCommentList.aspx">
            <div class="item">
                <div class="clear sp20"></div>
                <i class="fa fa-comment fa-4x"></i>
                <br />
                <p class="posr">
                   التعليقات 
                    <span id="lblFileCommentCount" runat="server" class="badge">
                    </span>
                </p>

            </div>
        </a>
     </div>
</asp:Content>
