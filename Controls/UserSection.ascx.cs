﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class UserSection : System.Web.UI.UserControl
{
    private readonly Tools t;

    public UserSection()
    {
        t = new Tools();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (t.IsUserLogin(Session))
        {
            Users u = Session["User"] as Users;
            ImgUser.ImageUrl = "~/SystemFiles/Users/" + u.Image;
            lblName.Text = u.Name;
            lblJobTitle.Text = u.JobTitle;
            lblUserName.Text = u.UserName;
            LoadFavFiles(u.Id);
        }
        else
        {
            UserSectionCon.Visible = false;
            
        }

        
    }

    private void LoadFavFiles(string userId)
    {
        Database db=new Database();
        db.AddParameter("@id", userId);
        DataTable dt = db.ExecuteDataTable("select files.* from UserFav inner join files on (Files.Id=UserFav.FileId) where UserFav.UserId=@id");
        Repeater1.DataSource = dt;
        Repeater1.DataBind();
    }
}