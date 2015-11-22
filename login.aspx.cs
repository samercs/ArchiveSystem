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

    }

    protected void btnLogin_OnClick(object sender, EventArgs e)
    {
        string sql = "select * from users where username=@username";
        Database db=new Database();
        db.AddParameter("@username", txtUserName.Text);
        
        DataTable dt = db.ExecuteDataTable(sql);
        if(dt.Rows.Count==0)
        {
            ErrorDiv.Visible = true;
            lblError.Text = "الرجاء التأكد من بيانات الدخول";
            return;
        }

        if(!dt.Rows[0]["password"].ToString().Equals(txtPassword.Text))
        {
            ErrorDiv.Visible = true;
            lblError.Text = "الرجاء التأكد من كلمة السر";
            return;
        }


        DateTime tmp;
        if(!string.IsNullOrWhiteSpace(dt.Rows[0]["LockedTo"].ToString()))
        {
            tmp=DateTime.Parse(dt.Rows[0]["LockedTo"].ToString());
            if(tmp.CompareTo(DateTime.Now)>=0)
            {
                Dates dates=new Dates();
                ErrorDiv.Visible = true;
                lblError.Text = String.Format("الرجاء الانتظار حتى {0} كي تتمكن من تسجيل الدخول", dates.GregToHijri(tmp.ToString("dd/MM/yyyy"),"dd/MMM/yyyy hh:mm"));
                return;
            }
        }

        
        if (!dt.Rows[0]["IsActive"].ToString().Equals("True"))
        {
            ErrorDiv.Visible = true;
            lblError.Text = "تم ايقاف الحساب من قبل مدير الموقع";
            return;
        }

        Users u=new Users();
        u.Id = dt.Rows[0]["Id"].ToString();
        u.Name = dt.Rows[0]["name"].ToString();
        u.UserName = dt.Rows[0]["username"].ToString();
        u.Password = dt.Rows[0]["password"].ToString();
        u.Image = dt.Rows[0]["Img"].ToString();
        u.Phone = dt.Rows[0]["Phone"].ToString();
        u.JobTitle = dt.Rows[0]["JobTitle"].ToString();
        u.RequeriedChangePassword = bool.Parse(dt.Rows[0]["RequerChange"].ToString());
        Session["User"] = u;
        if(Request.QueryString["url"]!=null)
        {
            Response.Redirect(Request.QueryString["url"]);
        }
        else
        {
            Response.Redirect("Default.aspx");
        }


    }
}