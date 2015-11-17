<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Header.ascx.cs" Inherits="Admin_Controls_Header" %>
<header>

    <div id="Literal1" runat="server">
        <ul id="gn-menu" class="gn-menu-main">
            <li class="gn-trigger">
                <a class="gn-icon gn-icon-menu"><span>Menu</span></a>
                <nav class="gn-menu-wrapper">
                    <div class="gn-scroller">
                        <ul class="gn-menu">

                            <li>
                                <a class="gn-icon gn-icon-article" href="Default.aspx">الصفحة الرئيسية</a>
                            </li>
                            <li>
                                <a class="gn-icon gn-icon-download" href="AdminList.aspx">مدراء الموقع</a>
                            </li>
                            <li>
                                <a class="gn-icon gn-icon-archive" href="FileList.aspx">الملفات</a>
                            </li>
                            <li>
                                <a class="gn-icon gn-icon-archive" href="DocumentList.aspx">المعاملات</a>
                            </li>
                            <li>
                                <a class="gn-icon gn-icon-archive" href="MsgList.aspx">رسائل مدير الموقع</a>
                            </li>
                            <li>
                                <a class="gn-icon gn-icon-archive" href="CategoryList.aspx">التصنيفات</a>
                            </li>
                            <li><a class="gn-icon gn-icon-cog" href="UserDetail.aspx">حسابي</a>
                                <ul class="gn-submenu">

                                    <li><a class="gn-icon gn-icon-Empty" href="Logout.aspx">تسجيل الخروج <i class="fa fa-sign-out"></i></a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <!-- /gn-scroller -->
                </nav>
            </li>
            <li class="nhover"><a href="Default.aspx">
                <img alt="Logo" src="/img/logo.png" width="120" style="margin-top: 10px" /></a></li>

            <li>
                <asp:HyperLink CssClass="codrops-icon codrops-icon-prev" ID="HyperLink1" runat="server"></asp:HyperLink>
            </li>
            
            <li>
                <asp:HyperLink ID="HyperLink2" CssClass="codrops-icon codrops-icon-drop" NavigateUrl="../Logout.aspx" runat="server"><span><i class="fa fa-sign-out"></i> تسجيل الخروج</span></asp:HyperLink>
            </li>
        </ul>
    </div>
</header>
<div class="clear"></div>
