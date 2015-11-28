using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpCookie keepmeusername = new HttpCookie("keepmeusername", "");
        HttpCookie keepmepassword = new HttpCookie("keepmepassword", "");
        keepmepassword.Expires = DateTime.Now.AddDays(-1);
        keepmeusername.Expires = DateTime.Now.AddDays(-1);
        Response.Cookies.Add(keepmepassword);
        Response.Cookies.Add(keepmeusername);
        Session.Clear();
        Session.Abandon();
        Response.Redirect("~/login.aspx");
    }
}