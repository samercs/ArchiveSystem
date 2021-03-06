﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" ValidateRequest="false" AutoEventWireup="true" CodeFile="FileOp.aspx.cs" Inherits="Admin_FileOp" %>

<%@ Register Src="~/controls/hijriCalender.ascx" TagPrefix="uc1" TagName="hijriCalender" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="Scripts/tinymce/js/tinymce/tinymce.min.js"></script>

    <script type="text/javascript">
        tinymce.init({
            selector: "textarea",
            plugins: [
                "advlist autolink autosave link image lists charmap print preview hr anchor pagebreak spellchecker",
                "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
                "table contextmenu directionality emoticons template textcolor paste textcolor colorpicker textpattern"
            ],

            toolbar1: "bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | styleselect formatselect fontselect fontsizeselect",
            toolbar2: "cut copy paste | searchreplace | bullist numlist | outdent indent blockquote | undo redo | link unlink anchor image media code | insertdatetime preview | forecolor backcolor",
            toolbar3: "table | hr removeformat | subscript superscript | charmap emoticons | print fullscreen | ltr rtl | spellchecker | visualchars visualblocks nonbreaking template pagebreak restoredraft",

            menubar: false,
            toolbar_items_size: 'small',

            style_formats: [
                { title: 'Bold text', inline: 'b' },
                { title: 'Red text', inline: 'span', styles: { color: '#ff0000' } },
                { title: 'Red header', block: 'h1', styles: { color: '#ff0000' } },
                { title: 'Example 1', inline: 'span', classes: 'example1' },
                { title: 'Example 2', inline: 'span', classes: 'example2' },
                { title: 'Table styles' },
                { title: 'Table row 1', selector: 'tr', classes: 'tablerow1' }
            ],
        });

        function Validate(event) {
            var regex = new RegExp("^[0-9?]+$");
            var key = String.fromCharCode(event.charCode ? event.which : event.charCode);
            if (!regex.test(key)) {
                event.preventDefault();
                return false;
            }
        }
    </script>


    <script type="text/javascript" src="/js/calender/jquery.calendars.js"></script>
    <script type="text/javascript" src="/js/calender/jquery.calendars.plus.js"></script>
    <link rel="stylesheet" type="text/css" href="/js/calender/jquery.calendars.picker.css" />
    <script type="text/javascript" src="/js/calender/jquery.plugin.js"></script>
    <script type="text/javascript" src="/js/calender/jquery.calendars.picker.js"></script>
    <script type="text/javascript" src="/js/calender/jquery.calendars.picker-ar.js"></script>
    <script type="text/javascript" src="/js/calender/jquery.calendars.islamic.js"></script>
    <script type="text/javascript" src="/js/calender/jquery.calendars.islamic-ar.js"></script>
    <script type="text/javascript" src="/js/calender/jquery.calendars.islamic-ar.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 class="Title BorderBottom"><%=name %></h1>

    <asp:HyperLink ID="HyperLink2" CssClass="tdn fl" NavigateUrl="FileList.aspx" runat="server"><h5><i class="fa fa-backward"></i> رجوع</h5></asp:HyperLink>
    <div class="clear PT20"></div>
    <section>
        <asp:Panel ID="Panel1" DefaultButton="btnSave" runat="server">
            <table class="tblConListOpt">
                <tr>
                    <td>
                        <asp:Label ID="Label10" runat="server" Text="الملف" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:FileUpload ID="fileFile" CssClass="txt1" ValidationGroup="Option3" runat="server" />
                    </td>
                    <td></td>
                </tr>

                <tr>
                    <td>
                        <asp:Label ID="Label9" runat="server" Text="العنوان" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtTitle" ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="الرقم" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:TextBox Width="100" ID="txtNo1" ValidationGroup="Option3" onkeypress="return Validate(event);" CssClass="txt1" runat="server"></asp:TextBox> / 
                        <asp:TextBox Width="100" ID="txtNo2" ValidationGroup="Option3" onkeypress="return Validate(event);" CssClass="txt1" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>

                <tr>
                    <td>
                        <asp:Label ID="Label14" runat="server" Text="جهة الاصدار " CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtFrom" ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="جهة الاستقبال " CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtTo" ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                
                <tr>
                    <td>
                        <asp:Label ID="Label12" runat="server" Text="الفئات المستهدفة " CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="ddlTarget" CssClass="ddl1" runat="server">
                            
                        </asp:DropDownList>
                    </td>
                    <td>
                        
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="النوع " CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="ddlType" CssClass="ddl1" runat="server">
                            
                        </asp:DropDownList>
                    </td>
                    <td>
                        
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label8" runat="server" Text="السرية" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="ddlSecurity" CssClass="ddl1" runat="server">
                            
                        </asp:DropDownList>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label7" runat="server" Text="الحالة" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="ddlStatus" CssClass="ddl1" runat="server">
                            
                        </asp:DropDownList>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label16" runat="server" Text="المعنين" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="ddlField" CssClass="ddl1" runat="server">
                            
                        </asp:DropDownList>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label13" runat="server" Text="الدولة" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="ddlCountry" CssClass="ddl1" runat="server">
                            
                        </asp:DropDownList>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="تاريخ الملف" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <uc1:hijriCalender  Class="txtCal" ValidationGroup="Option3" runat="server" ID="txtFileDate" />
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label5" runat="server" Text="تاريخ الاضافة" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <uc1:hijriCalender  Class="txtCal" ValidationGroup="Option3" runat="server" ID="txtAddedDate" />
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label6" runat="server" Text="الوصف " CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtDesc"  TextMode="MultiLine" ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label15" runat="server" Text="كلمات مفتاحية " CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtFileKey"  TextMode="MultiLine" ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        
                    </td>
                </tr>
                <tr id="rowAttache" runat="server">
                    <td>
                        <asp:Label ID="Label11" runat="server" Text="الملفات المرفقه" CssClass="label_xblack"></asp:Label></td>
                    <td>
                        <table>
                            <tr>
                                <td>عنوان المرفق</td>
                                <td>الملف المرفق</td>
                            </tr>
                            <tr>
                                
                                <td>
                                    <asp:TextBox ID="txtAttachedTitle1"   ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:FileUpload ID="attachedFile1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                
                                <td>
                                    <asp:TextBox ID="txtAttachedTitle2"   ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:FileUpload ID="attachedFile2" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                
                                <td>
                                    <asp:TextBox ID="txtAttachedTitle3"   ValidationGroup="Option3" CssClass="txt1" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:FileUpload ID="attachedFile3" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <a href="Default.aspx" class="btnLogin2 fr">الغاء</a>
                        <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" ValidationGroup="Option3" Text="حفظ" CssClass="btnLogin fr" />

                    </td>
                </tr>
            </table>
        </asp:Panel>
    </section>
    
</asp:Content>




