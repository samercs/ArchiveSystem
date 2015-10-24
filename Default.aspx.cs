using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
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
            ListView r = e.Item.FindControl("Repeater1") as ListView;
            HiddenField id=e.Item.FindControl("id") as HiddenField;
            Database db=new Database();
            db.AddParameter("@id", id.Value);
            DataTable dt = db.ExecuteDataTable("select FileComment.Text, users.* from FileComment inner join Users on (FileComment.UserId=Users.id) where FileComment.fileId=@id");
            r.DataSource = dt;
            r.DataBind();

            HtmlAnchor aLink;

            if (dt.Rows.Count > 0)
            {
                
            }

            ListView ls = e.Item.FindControl("RepeaterAttached") as ListView;
            db.AddParameter("@id", id.Value);
            dt = db.ExecuteDataTable("select * from FilesAttach where fileID=@id");
            ls.DataSource = dt;
            ls.DataBind();
        }
    }


    protected string GetFileIcon(object fileName)
    {
        if (fileName.ToString().ToLower().EndsWith(".pdf"))
        {
            return "<i style='font-size: 40px;color: #910505;' class='fa fa-file-pdf-o'></i>";
        }
        else if (fileName.ToString().ToLower().EndsWith(".doc") || fileName.ToString().ToLower().EndsWith(".docx"))
        {
            return "<i style='font-size: 40px;color:#2a56eb;' class='fa fa-file-word-o'></i>";
        }
        else
        {
            return "<i style='font-size: 40px;' class='fa fa-file-o'></i>";
        }
    }
}