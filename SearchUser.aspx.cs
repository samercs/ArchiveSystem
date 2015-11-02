﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SearchUser : UICaltureBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string name = Request.QueryString["name"];
            string jobTitle = Request.QueryString["jobTitle"];
            txtUserName.Text = name;
            txtJobTitle.Text = jobTitle;
            btnSearch_OnClick(this,null);
        }
        
    }

    private void LoadData(string name = "", string jobTitle = "")
    {
        Database db = new Database();
        
        
        string sql = "select * from users  where IsActive=1 ";
        if (!string.IsNullOrWhiteSpace(name))
        {
            sql += " and users.name like '%' + @name + '%'";
            db.AddParameter("@name", name);
        }
        if (!string.IsNullOrWhiteSpace(jobTitle))
        {
            sql += " and users.JobTitle like '%' + @JobTitle + '%'";
            db.AddParameter("@JobTitle", jobTitle);
        }

        DataTable dt = db.ExecuteDataTable(sql);
        ListView1.DataSource = dt;
        ListView1.DataBind();
    }

    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        LoadData(txtUserName.Text,txtJobTitle.Text);
    }

    protected void ListView1_OnPagePropertiesChanged(object sender, EventArgs e)
    {
        LoadData(txtUserName.Text, txtJobTitle.Text);
    }

    protected void btnSendMsg_OnClick(object sender, EventArgs e)
    {
        if (ValidateData())
        {
            Database db = new Database();
            Users u = Session["User"] as Users;
            db.AddParameter("@from", u.Id);
            db.AddParameter("@to", hiddenId.Value);
            db.AddParameter("@title", txtSubject.Text);
            db.AddParameter("@msg", txtMsg.Text);
            db.ExecuteNonQuery("insert into msg([from],toId,title,msg) values(@from,@to,@title,@msg)");
            ShowAlert("تم ارسال الرسالة بنجاح",MsgType.Success);
        }
    }


    private bool ValidateData()
    {
        if (string.IsNullOrWhiteSpace(hiddenId.Value))
        {
            ShowAlert("الرجاء تحديد المستخدم",MsgType.Error);
            return false;
        }
        return true;
    }
}