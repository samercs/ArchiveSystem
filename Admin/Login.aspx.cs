using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Login : AdminPages
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            HttpCookie UName = Request.Cookies["ASUserName"];
            HttpCookie UPassword = Request.Cookies["ASPassword"];
            if (UName != null)
            {
                txtUserName.Text = UName.Value;
                cbRememberMe.Checked = true;
            }
            
            if (UPassword != null)
            {
                txtPassword.Attributes.Add("value", UPassword.Value);
                cbRememberMe.Checked = true;
            }
            txtUserName.Attributes.Add("onkeydown", "if(event.which || event.keyCode){if ((event.which == 13) || (event.keyCode == 13)) {__doPostBack('" + btnLogin.UniqueID + "','');}} ");
            txtPassword.Attributes.Add("onkeydown", "if(event.which || event.keyCode){if ((event.which == 13) || (event.keyCode == 13)) {__doPostBack('" + btnLogin.UniqueID + "','');}} ");
            if (Request.Cookies["ASCMSKeepOnline"] != null)
            {
                int id;
                if (int.TryParse(Request.Cookies["ASCMSKeepOnline"].Value, out id))
                {
                    Database db = new Database();
                    db.AddParameter("@id", id);
                    System.Data.DataTable dt = db.ExecuteDataTable("select * from adminUsers where id=@id");
                    txtUserName.Text = dt.Rows[0]["username"].ToString();
                    txtPassword.Text = dt.Rows[0]["password"].ToString();
                    btnLogin_Click(null, null);
                }
            }

            if(Request.QueryString["msg"]!=null)
            {
                ErrorDiv.Visible = true;
                sp1.Visible = true;
                lblError.Text = "<i class=\"fa fa-exclamation-triangle fcRed\"></i>  " + Request.QueryString["msg"];
            }

        }

    }
    protected void btnGoForget_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        Database db = new Database();
        db.AddParameter("@uname", txtUserName.Text);
        db.AddParameter("@password", txtPassword.Text);
        System.Data.DataTable dt = db.ExecuteDataTable("Select * from AdminUsers where (username=@uname or email=@uname) and (password=@password)");
        if (dt.Rows.Count != 0)
        {

            if(cbRememberMe.Checked)
            {
                HttpCookie c=new HttpCookie("ASUserName", txtUserName.Text);
                c.Expires = DateTime.Now.AddYears(1);
                Response.Cookies.Add(c);
                c = new HttpCookie("ASPassword", txtPassword.Text);
                c.Expires = DateTime.Now.AddYears(1);
                Response.Cookies.Add(c);
            }
            else
            {
                HttpCookie c = new HttpCookie("ASUserName", "");
                c.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(c);
                c = new HttpCookie("ASPassword", "");
                c.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(c);
            }

            if(cbKeepMeLogin.Checked)
            {
                HttpCookie c = new HttpCookie("ASCMSKeepOnline", dt.Rows[0]["id"].ToString());
                c.Expires = DateTime.Now.AddDays(20);
                Response.Cookies.Add(c);
            }
            else
            {
                HttpCookie c = new HttpCookie("ASCMSKeepOnline", "");
                c.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(c);
            }

            AdminInfo admininfo = new AdminInfo(dt.Rows[0]["id"].ToString(), dt.Rows[0]["name"].ToString(), dt.Rows[0]["username"].ToString(), dt.Rows[0]["password"].ToString(), dt.Rows[0]["email"].ToString(), dt.Rows[0]["permition"].ToString());
            Session["AdminInfo"] = admininfo;
            
            if (Request.QueryString["url"] == null)
            {
                Response.Redirect("default.aspx");
            }
            else
            {
                Response.Redirect(Request.QueryString["url"]);
            }
        }
        else
        {
            ErrorDiv.Visible = true;
            sp1.Visible = true;
            lblError.Text = "<i class=\"fa fa-exclamation-triangle fcRed\"></i> خطا في بيانات الدخول الرجاء التاكد من اسم المستخدم و كلمة المرور ";
        }

    }
    protected void btnBackLogin_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
    }
    protected void btnForgetPass_Click(object sender, EventArgs e)
    {
        AppFunctions v = new AppFunctions();
        if (!v.IsEmailValid(txtEmail.Text))
        {
            ErrorDiv.Visible = true;
            sp1.Visible = true;
            lblError.Text = "<i class=\"fa fa-exclamation-triangle fcRed\"></i> الرجاء التأكد من البريد الالكتروني.";
            return;
        }

        Database db = new Database();
        db.AddParameter("@email", txtEmail.Text);
        System.Data.DataTable dt = db.ExecuteDataTable("Select * from AdminUsers where email=@email");
        if (dt.Rows.Count == 0)
        {
            ErrorDiv.Visible = true;
            sp1.Visible = true;
            lblError.Text = "<i class=\"fa fa-exclamation-triangle fcRed\"></i> هذا البريد الالكتروني غير مسجل في النظام";
            return;
        }

        string body = "<h2>";
        body += "هذة معلومات الدخول الى لوحة التحكم الخاصة بموقع الدليل الاإلكتروني لإرشفة القرارات و التعاميم الحكومية<br/>";
        body += "اسم المستخدم : " + dt.Rows[0]["username"].ToString() + "<br/>";
        body += "البريد الالكتروني : " + dt.Rows[0]["email"].ToString() + "<br/>";
        body += "كلمة السر : " + dt.Rows[0]["password"].ToString() + "<br/>";
        body += "</h2>";
        SendMail mail = new SendMail();
        mail.SendMsg(txtEmail.Text, "الدليل الاإلكتروني لإرشفة القرارات و التعاميم الحكومية", body);
        ScriptManager.RegisterClientScriptBlock(this,GetType(), "writeMsg", "alert('تم ارسال كلمة السر الي البريد الالكتروني " + txtEmail.Text + " ');", true);
        


    }
}