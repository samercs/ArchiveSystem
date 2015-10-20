using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserSection : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Users u=Session["User"] as Users;
        ImgUser.ImageUrl = "~/SystemFiles/Users/" + u.Image;
        lblName.Text = u.Name;
        lblJobTitle.Text = u.JobTitle;
        lblUserName.Text = u.UserName;
    }
}