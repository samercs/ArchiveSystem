using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Kalboard360.ClassCode;

public partial class UserSendMsg : UsersPages
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            string json = "";
            Database db = new Database();
            DataTable dt = db.ExecuteDataTable("select * from users where isActive=1");
            json = "[";
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (i == 0)
                {
                    json += "{ id: " + dt.Rows[i]["id"].ToString() + ", name: \"" + dt.Rows[i]["name"].ToString() + "\" }";
                }
                else
                {
                    json += ",{ id: " + dt.Rows[i]["id"].ToString() + ", name: \"" + dt.Rows[i]["name"].ToString() + "\" }";
                }

            }
            json += "]";
            ViewState["json"] = json;
        }
    }


    protected void btnSendMsg_OnClick(object sender, EventArgs e)
    {
      
        DivError.Visible = false;
        if (string.IsNullOrWhiteSpace(txtTo.Text))
        {
            DivError.Visible = true;
            DivError.CssClass += "alert alert-danger text-center";
            lblError.Text = "الرجاء اختيار مستلم للرسالة واحد على الاقل";
            return;
        }
        if (string.IsNullOrWhiteSpace(txtSubject.Text))
        {
            DivError.Visible = true;
            DivError.CssClass += "alert alert-danger text-center";
            lblError.Text = "الرجاء ادخال عنوان الرسالة";
            return;
        }
        if (string.IsNullOrWhiteSpace(txtMsg.Text))
        {
            DivError.Visible = true;
            DivError.CssClass = "alert alert-danger text-center";
            lblError.Text = "الرجاء ادخال نص الرسالة";
            return;
        }
        if (txtMsg.Text.Length > 500)
        {
            DivError.Visible = true;
            DivError.CssClass = "alert alert-danger text-center";
            lblError.Text = "نص الرسالة يجب الا يتخطى الـ500 حرف.";
            return;
        }
        Database db=new Database();
        Users u = Session["User"] as Users;
        DataTable dtUsers = db.ExecuteDataTable("select * from users where isActive=1 and (id in (" + txtTo.Text + "))");
        foreach (DataRow user in dtUsers.Rows)
        {
            db.AddParameter("@from", u.Id);
            db.AddParameter("@toid", user["id"].ToString());
            db.AddParameter("@title",txtSubject.Text);
            db.AddParameter("@msg", txtMsg.Text);
            db.ExecuteNonQuery("insert into msg([from],ToId,Title,Msg) values(@from,@ToId,@Title,@Msg)");
           
            
        }
 txtMsg.Text = string.Empty;
        DivError.Visible = true;
        DivError.CssClass = "alert alert-success text-center";
        lblError.Text = "تم ارسال الرسالة";
    }
}