using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserOutbox : UICaltureBase
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
        DataTable dt = db.ExecuteDataTable("select  msg.*,Users.name as username from (Msg inner join users on (users.id=msg.[toId]) ) where msg.[From]=@to order by msg.Id desc");
        ListView1.DataSource = dt;
        ListView1.DataBind();
    }

    

    protected void ListView1_OnPagePropertiesChanged(object sender, EventArgs e)
    {
        LoadMsg();
    }
}