using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : UICaltureBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadData();
        }
    }

    private void LoadData()
    {
        Database db = new Database();
        DataTable dt = db.ExecuteDataTable("select * from Files Order By FileDate Desc");
        ListView1.DataSource = dt;
        ListView1.DataBind();
    }

    protected void ListView1_OnPagePropertiesChanged(object sender, EventArgs e)
    {
        LoadData();
    }

    protected void ListView1_OnItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            Repeater r = e.Item.FindControl("Repeater1") as Repeater;
            HiddenField id=e.Item.FindControl("id") as HiddenField;
            Database db=new Database();
            db.AddParameter("@id", id.Value);
            DataTable dt = db.ExecuteDataTable("select FileComment.Text, users.* from FileComment inner join Users on (FileComment.UserId=Users.id) where FileComment.fileId=@id");
            r.DataSource = dt;
            r.DataBind();
        }
    }
}