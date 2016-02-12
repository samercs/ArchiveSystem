using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Kalboard360.ClassCode;

public partial class UserOutbox : UsersPages
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
        DataTable dt = db.ExecuteDataTable("select  msg.*,Users.name as username from (Msg left join users on (users.id=msg.[toId]) ) where msg.[From]=@to order by msg.Id desc");
        ListView1.DataSource = dt;
        ListView1.DataBind();
    }

    

    protected void ListView1_OnPagePropertiesChanged(object sender, EventArgs e)
    {
        LoadMsg();
    }

    protected void btnDelete_OnCommand(object sender, CommandEventArgs e)
    {
        Database db = new Database();
        db.AddParameter("@id", e.CommandArgument.ToString());
        db.ExecuteNonQuery("delete from msg where id=@id");
        LoadMsg();
        ShowAlert("تم حذف الرسالة", MsgType.Success);
    }
}