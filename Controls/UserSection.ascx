<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UserSection.ascx.cs" Inherits="UserSection" %>
<aside class="user_information">
    <div class="user_pic">
        <asp:Image ID="ImgUser" runat="server" />
    </div>
    <p class="mian_user_info">
        <span class="name">
            <asp:Label ID="lblName" runat="server" Text=""></asp:Label>
        </span>
        <br>
        <span class="jobtitle">
            <asp:Label ID="lblJobTitle" runat="server" Text=""></asp:Label>
        </span>
        <br>
        <i class="fa fa-user"></i><span class="tiwtter">‫‪
            <asp:Label ID="lblUserName" runat="server" Text=""></asp:Label>
        </span>
        <br>
    </p>
    <div class="last_files">
        <div class="file_header">
            <h4>‫آخر‬ ‫الملفات‬ المفضلة</h4>
        </div>
        <img src="img/grayshadow.png" class="gray_shadow img-responsive" />
        <ul class="files">
            <li class="filer">
                <div class="one_file_container">
                    <h5 dir="ltr">اسم الملف </h5>
                    <span class="datename">تاريخ الاصدار : </span><span class="datedes">16/9/2015</span>
                </div>
            </li>
            <img src="img/grayspliter.png" class="split img-responsive">
            <li class="filer">
                <div class="one_file_container">
                    <h5 dir="ltr">اسم الملف </h5>
                    <span class="datename">تاريخ الاصدار : </span><span class="datedes">16/9/2015</span>
                </div>

            </li>
            <img src="img/grayspliter.png" class="split img-responsive">
            <li class="filer">
                <div class="one_file_container">
                    <h5 dir="ltr">اسم الملف </h5>
                    <span class="datename">تاريخ الاصدار : </span><span class="datedes">16/9/2015</span>
                </div>

            </li>
            <img src="img/grayspliter.png" class="split img-responsive">
            <li class="filer">
                <div class="one_file_container">
                    <h5 dir="ltr">اسم الملف </h5>
                    <span class="datename">تاريخ الاصدار : </span><span class="datedes">16/9/2015</span>
                </div>

            </li>
            <img src="img/grayspliter.png" class="split img-responsive">
            <li class="filer">
                <div class="one_file_container">
                    <h5 dir="ltr">اسم الملف </h5>
                    <span class="datename">تاريخ الاصدار : </span><span class="datedes">16/9/2015</span>
                </div>

            </li>
            <img src="img/grayspliter.png" class="split img-responsive">
        </ul>
    </div>
    <div class="load_more">
        تصفح جميع  الملفات<br>
    </div>
</aside>
