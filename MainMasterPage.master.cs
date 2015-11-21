using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MainMasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            LoadMsg();
        }
    }

    private void LoadMsg()
    {
        Users u = Session["User"] as Users;
        Database db = new Database();
        db.AddParameter("@to", u.Id);
        DataTable dt = db.ExecuteDataTable("select top(5) msg.*,Users.name as username from (Msg inner join users on (users.id=msg.[from]) ) where msg.ToId=@to order by msg.Id desc");
        ListView1.DataSource = dt;
        ListView1.DataBind();
    }

    protected void btnSendMsg_OnClick(object sender, EventArgs e)
    {
        if(ValidateData())
        {
            Users u=Session["User"] as Users;
            Database db=new Database();
            db.AddParameter("@from", u.Id);
            db.AddParameter("@title", txtTitle.Text);
            db.AddParameter("@msg", txtMsg.Text);
            db.ExecuteNonQuery("insert into msg([from],title,msg) values(@from,@title,@msg)");
            msg.CssClass += " alert-success";
            msg.Visible = true;
            lblMsg.Text = "تم ارسال الرسالة بنجاح";

        }
    }

    private bool ValidateData()
    {
        return true;
    }

    protected void ListView1_OnPagePropertiesChanged(object sender, EventArgs e)
    {
        LoadMsg();
    }
}
