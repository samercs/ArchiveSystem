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
            Database db=new Database();
            db.LoadDDL("category","title","id",ref ddlType,"اختر سبب الابلاغ","CatId=4");
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
            DataTable dt = db.ExecuteDataTable("select FileComment.Text, users.* from FileComment inner join Users on (FileComment.UserId=Users.id) where FileComment.fileId=@id and FileComment.Status=1");
            r.DataSource = dt;
            r.DataBind();

            if (dt.Rows.Count == 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(),DateTime.Now.Ticks.ToString(),"hiddenShowAllComment("+id.Value+");",true);
            }

            

            if (dt.Rows.Count > 0)
            {
                
            }

            ListView ls = e.Item.FindControl("RepeaterAttached") as ListView;
            db.AddParameter("@id", id.Value);
            dt = db.ExecuteDataTable("select * from FilesAttach where fileID=@id");
            ls.DataSource = dt;
            ls.DataBind();

            Label lblUser=e.Item.FindControl("lblUserName") as Label;
            Users user=Session["User"] as Users;
            lblUser.Text = user.Name;
            Image imgUser = e.Item.FindControl("imgUser") as Image;
            imgUser.ImageUrl = "~/SystemFiles/Users/" + user.Image;
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

    

    private bool ValidateComment()
    {
        return true;
    }

    protected void btnSendComent_OnCommand(object sender, CommandEventArgs e)
    {
        if (ValidateComment())
        {
            Database db = new Database();
            Users user = Session["User"] as Users;
            int itemId = int.Parse(e.CommandArgument.ToString());
            TextBox txtComment= ListView1.Items[itemId].FindControl("txtComment") as TextBox;
            HiddenField id= ListView1.Items[itemId].FindControl("id") as HiddenField;
            db.AddParameter("@FileId", id.Value);
            db.AddParameter("@UserId", user.Id);
            db.AddParameter("@Text", txtComment.Text);
            db.AddParameter("@Status", "0");
            db.ExecuteNonQuery("insert into fileComment(FileId,UserId,Text,Status) values(@FileId,@UserId,@Text,@Status)");
            ShowAlert("تم اضافة التعليق. سوف يتم مراجعة التعليق من قبل مدير الموقع و نشرة في حالة مطابقة الشروط",MsgType.Success);
        }
    }

    protected void btnAddToFav_OnCommand(object sender, CommandEventArgs e)
    {
        Database db = new Database();
        Users user = Session["User"] as Users;
        db.AddParameter("@userId", user.Id);
        db.AddParameter("@FileId", e.CommandArgument.ToString());
        DataTable dt = db.ExecuteDataTable("select * from UserFav where UserId=@UserId and FileId=@FileId");
        if (dt.Rows.Count == 0)
        {
            db.AddParameter("@userId", user.Id);
            db.AddParameter("@FileId", e.CommandArgument.ToString());
            db.ExecuteNonQuery("insert into UserFav(UserId,FileId) values(@UserId,@FileId)");
            
        }
        ShowAlert("تم اضافة الملف الى المفضلة", MsgType.Success);
    }

    protected void btnSendError_OnClick(object sender, EventArgs e)
    {
        Database db = new Database();
        Users user = Session["User"] as Users;
        db.AddParameter("@UserId", user.Id);
        db.AddParameter("@Rason", ddlType.SelectedValue);
        db.AddParameter("@Note", txtNote.Text);
        db.AddParameter("@FileId", fileId.Value);
        db.ExecuteNonQuery("insert into FileNotice(UserId,Rason,Note,FileId) values (@UserId,@Rason,@Note,@FileId)");
        ShowAlert("تم ارسال البلاغ بنجاح",MsgType.Success);
    }
}