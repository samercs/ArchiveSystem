﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_Default" %>

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
                    ادارة الموقع
                </p>

            </div>
        </a>
        <a href="UsersList.aspx">
            <div class="item">
                <div class="clear sp20"></div>
                <i class="fa fa-user fa-4x"></i>
                <br />
                <p class="posr">
                    المستخدمين
                    <span id="lblUsersCount" runat="server" class="badge"></span>
                </p>

            </div>
        </a>
        <a href="FileList.aspx">
            <div class="item">
                <div class="clear sp20"></div>
                <i class="fa fa-file-text-o fa-4x"></i>
                <br />
                <p>
                    الملفات
                </p>

            </div>
        </a>
        <a href="DocumentList.aspx">
            <div class="item">
                <div class="clear sp20"></div>
                <i class="fa fa-book fa-4x"></i>
                <br />
                <p>
                    المعاملات
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
                    <span id="lblFileNoticeCount" runat="server" class="badge"></span>
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
                    <span id="lblFileCommentCount" runat="server" class="badge"></span>
                </p>

            </div>
        </a>
        <a href="MsgList.aspx">
            <div class="item">
                <div class="clear sp20"></div>
                <i class="fa fa-inbox fa-4x"></i>
                <br />
                <p class="posr">
                    رسائل مدير الموقع 
                    <span id="lblMsgCount" runat="server" class="badge"></span>
                </p>

            </div>
        </a>
        <a href="CategoryList.aspx">
            <div class="item">
                <div class="clear sp20"></div>
                <i class="fa fa-list fa-4x"></i>
                <br />
                <p class="posr">
                    التصنيفات 
                    <span id="Span1" runat="server" class="badge"></span>
                </p>

            </div>
        </a>
          <a href="PagesList.aspx">
            <div class="item">
                <div class="clear sp20"></div>
                <i class="fa fa-newspaper-o fa-4x"></i>
                <br />
                <p class="posr">
                  معلومات الاتصال
                    <span id="Span2" runat="server" class="badge"></span>
                </p>

            </div>
        </a>
          <a href="SocialList.aspx">
            <div class="item">
                <div class="clear sp20"></div>
                <i class="fa fa-facebook fa-4x"></i>
                <br />
                <p class="posr">
                روابط التواصل الاجتماعي
                    <span id="Span3" runat="server" class="badge"></span>
                </p>

            </div>
        </a>
        <div class="clear"></div>
        <h1 class="Title BorderBottom">خصائص الملفات</h1>
        <a href="FileSecurityList.aspx" runat="server" visible="false">
            <div class="item">
                <div class="clear sp20"></div>
                <i class="fa fa-user-secret fa-4x"></i>
                <br />
                <p class="posr">
                    السرية
                </p>

            </div>
        </a>
        <a href="FileTypeList.aspx">
            <div class="item">
                <div class="clear sp20"></div>
                <i class="fa fa-file-o fa-4x"></i>
                <br />
                <p class="posr">
                    النوع
                </p>

            </div>
        </a>
        <a href="FileFieldList.aspx">
            <div class="item">
                <div class="clear sp20"></div>
                <i class="fa fa-users fa-4x"></i>
                <br />
                <p class="posr">
                    المعنين
                </p>

            </div>
        </a>
        <a href="FileTargetList.aspx">
            <div class="item">
                <div class="clear sp20"></div>
                <i class="fa fa-check-circle-o  fa-4x"></i>
                <br />
                <p class="posr">
                    المجال
                </p>

            </div>
        </a>
        <a href="FileStatusList.aspx"  runat="server" visible="false">
            <div class="item">
                <div class="clear sp20"></div>
                <i class="fa fa-list-alt   fa-4x"></i>
                <br />
                <p class="posr">
                    حالة الملف
                </p>

            </div>
        </a>
    </div>
</asp:Content>
