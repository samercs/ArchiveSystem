﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Kalboard360.ClassCode;

public partial class UserInbox : UsersPages
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            
            LoadMsg();
            txtComment.Attributes.Add("onkeydown", "if(event.which || event.keyCode){if ((event.which == 13) || (event.keyCode == 13)) { if(validateSendMsg())  __doPostBack('" + btnSendComent.UniqueID + "','');}} ");
        }
    }

    private void LoadMsg()
    {
        
        Users u = Session["User"] as Users;
        Database db = new Database();
        db.AddParameter("@to", u.Id);
        DataTable dt = db.ExecuteDataTable("select  msg.*,Users.name as username from (Msg left join users on (users.id=msg.[from]) ) where msg.ToId=@to order by msg.Id desc");
        ListView1.DataSource = dt;
        ListView1.DataBind();
    }

    protected void btnSendComent_OnClick(object sender, EventArgs e)
    {
        if (txtComment.Text.Length > 500)
        {
           
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('نص الرسالة يجب الا يتخطى الـ500 حرف.')", true);

            return;
        }
        Database db=new Database();
        Users u = Session["User"] as Users;
        db.AddParameter("@from", u.Id);
        db.AddParameter("@toId", userId.Value);
        db.AddParameter("@Title",  txtTitle.Text);
        db.AddParameter("@Msg",txtComment.Text );
        db.ExecuteNonQuery("insert into msg([from],toId,Title,Msg) values (@from,@toId,@Title,@Msg)");
        txtComment.Text = "";
        userId.Value = "";
         ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('تم ارسال الرسالة بنجاح.')", true);
    }

    protected void ListView1_OnPagePropertiesChanged(object sender, EventArgs e)
    {
        LoadMsg();
    }

    protected void btnDelete_OnCommand(object sender, CommandEventArgs e)
    {
        Database db=new Database();
        db.AddParameter("@id", e.CommandArgument.ToString());
        db.ExecuteNonQuery("delete from msg where id=@id");
        LoadMsg();
        ShowAlert("تم حذف الرسالة",MsgType.Success);
    }
}