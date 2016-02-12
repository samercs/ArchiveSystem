using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class login : UICaltureBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.Cookies["remembermeusername"] != null && Request.Cookies["remembermepassword"] != null)
            {
                txtUserName.Text = Request.Cookies["remembermeusername"].Value;
                txtPassword.Attributes.Add("value", Request.Cookies["remembermepassword"].Value);
                cbRememberMe.Checked = true;
            }
            else
            {
                cbRememberMe.Checked = false;

            }

            
        }
    }

    protected void btnLogin_OnClick(object sender, EventArgs e)
    {
        DataRow row = null;
        if (Request.Cookies["keepmeusername"] != null && Request.Cookies["keepmepassword"] != null)
        {
            row = CheckLogin(Request.Cookies["keepmeusername"].Value, Request.Cookies["keepmepassword"].Value);
        }
        else
        {
            row = CheckLogin(txtUserName.Text, txtPassword.Text);
        }



        if (row != null)
        {
            Users u = new Users();
            u.Id = row["Id"].ToString();
            u.Name = row["name"].ToString();
            u.UserName = row["username"].ToString();
            u.Password = row["password"].ToString();
            u.Image = row["Img"].ToString();
            u.Phone = row["Phone"].ToString();
            u.JobTitle = row["JobTitle"].ToString();
            u.RequeriedChangePassword = bool.Parse(row["RequerChange"].ToString());
            Session["User"] = u;

            if (cbKeepMeLogin.Checked)
            {
                HttpCookie keepmeusername = new HttpCookie("keepmeusername", txtUserName.Text);
                HttpCookie keepmepassword = new HttpCookie("keepmepassword", txtPassword.Text);
                keepmepassword.Expires = DateTime.Now.AddDays(30);
                keepmeusername.Expires = DateTime.Now.AddDays(30);
                Response.Cookies.Add(keepmepassword);
                Response.Cookies.Add(keepmeusername);

            }
            else
            {
                HttpCookie keepmeusername = new HttpCookie("keepmeusername", txtUserName.Text);
                HttpCookie keepmepassword = new HttpCookie("keepmepassword", txtPassword.Text);
                keepmepassword.Expires = DateTime.Now.AddDays(-1);
                keepmeusername.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(keepmepassword);
                Response.Cookies.Add(keepmeusername);
            }

            if (cbRememberMe.Checked)
            {
                HttpCookie remembermeusername = new HttpCookie("remembermeusername", txtUserName.Text);
                HttpCookie remembermepassword = new HttpCookie("remembermepassword", txtPassword.Text);
                remembermeusername.Expires = DateTime.Now.AddDays(30);
                remembermepassword.Expires = DateTime.Now.AddDays(30);
                Response.Cookies.Add(remembermeusername);
                Response.Cookies.Add(remembermepassword);
            }
            else
            {
                HttpCookie remembermeusername = new HttpCookie("remembermeusername", txtUserName.Text);
                HttpCookie remembermepassword = new HttpCookie("remembermepassword", txtPassword.Text);
                remembermeusername.Expires = DateTime.Now.AddDays(-1);
                remembermepassword.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(remembermeusername);
                Response.Cookies.Add(remembermepassword);
            }

            if (Request.QueryString["url"] != null)
            {
                Response.Redirect(Request.QueryString["url"]);
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
        }




    }



    private DataRow CheckLogin(string username, string password)
    {
        string sql = "select * from users where username=@username";
        Database db = new Database();
        db.AddParameter("@username", txtUserName.Text);

        DataTable dt = db.ExecuteDataTable(sql);
        if (dt.Rows.Count == 0)
        {
            ErrorDiv.Visible = true;
            lblError.Text = "الرجاء التأكد من بيانات الدخول";
            return null;
        }

        if (!dt.Rows[0]["password"].ToString().Equals(txtPassword.Text))
        {
            ErrorDiv.Visible = true;
            lblError.Text = "الرجاء التأكد من كلمة السر";
            return null;
        }


        DateTime tmp;
        if (!string.IsNullOrWhiteSpace(dt.Rows[0]["LockedTo"].ToString()))
        {
            tmp = DateTime.Parse(dt.Rows[0]["LockedTo"].ToString());
            if (tmp.CompareTo(DateTime.Now) <= 0)
            {
                Dates dates = new Dates();
                ErrorDiv.Visible = true;
                lblError.Text = String.Format("هذا الحساب منتهي الصلاحية الرجاء مراسلة إدارة الموقع", dates.GregToHijri(tmp.ToString("dd/MM/yyyy"), "dd/MMM/yyyy hh:mm"));
                return null;
            }
        }


        if (!dt.Rows[0]["IsActive"].ToString().Equals("True"))
        {
            ErrorDiv.Visible = true;
            lblError.Text = "تم ايقاف الحساب من قبل مدير الموقع";
            return null;
        }

        return dt.Rows[0];
    }


   
}