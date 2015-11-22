using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class login : UICaltureBase
{
    
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnLogin_OnClick(object sender, EventArgs e)
    {
        string loginUrl = Request.Url.AbsoluteUri.Replace("forgetPassword.aspx", "login.aspx");

        string sql = "select * from users where username=@username";
        Database db=new Database();
        db.AddParameter("@username", txtUserName.Text);
        
        DataTable dt = db.ExecuteDataTable(sql);
        if(dt.Rows.Count==0)
        {
            ErrorDiv.Visible = true;
            lblError.Text = "هذا البريد الالكتروني غير مسجل لدينا الرجاء مراجعة مدير النظام";
            return;
        }

        StringBuilder strBuild=new StringBuilder();
        strBuild.Append("<h1>المركز الوطني للبحوث و الدراسات الاجتماعية</h1>");
        strBuild.Append("<h2>استرجاع كلمة السر الخاص بنظام الارشفة</h2>");
        strBuild.Append("<h4>معلومات الدخول الخاص بك الى النظام</h4>");
        strBuild.Append(String.Format("<p>اسم المستخدم : <b>{0}</b></p>",dt.Rows[0]["username"].ToString()));
        strBuild.Append(String.Format("<p>كلمة السر : <b>{0}</b></p>",dt.Rows[0]["password"]));
        strBuild.Append(String.Format("<p>لتسجيل الدخول <a href'{0}'>من هنا</a></p>", loginUrl));
        SendMail mail=new SendMail();
        mail.SendMsg(dt.Rows[0]["username"].ToString(), "استعادة كلمة المرور", strBuild.ToString());
        ClientScript.RegisterClientScriptBlock(this.GetType(),"msgBox","alert('تم ارسال كلمة السر على بريدك الالكتروني');",true);

        


    }
}