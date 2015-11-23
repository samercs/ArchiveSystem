using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class favorite : UICaltureBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            Database db = new Database();
            db.LoadDDL("category", "title", ref ddlField, "المجال", "catId=5");
            LoadData();
        }
    }

    private void LoadData(string title="",string no="",string target="",string date="")
    {
        
        Dates dates=new Dates();
        Database db=new Database();
        Users u = Session["User"] as Users;
        db.AddParameter("@id", u.Id);
        string sql = "select *,category.title as FieldName from (UserFav inner join files on (files.id=Userfav.FileId)) left join category on files.Field=category.id where UserFav.UserId=@id";
        if(!string.IsNullOrWhiteSpace(title))
        {
            sql += " and files.title like '%' + @title + '%'";
            db.AddParameter("@title", title);
        }
        if (!string.IsNullOrWhiteSpace(no))
        {
            sql += " and files.no like '%' + @no + '%'";
            db.AddParameter("@no", no);
        }
        if (!string.IsNullOrWhiteSpace(target) && !target.Equals("-1"))
        {
            sql += " and files.Field=@Field ";
            db.AddParameter("@Field", target);
        }
        DateTime tmp;
        if (DateTime.TryParseExact(dates.HijriToGreg(txtFileDate.Text, "d/M/yyyy"), "d/M/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tmp))
        {
            sql += " and (day(files.fileDate)=@day and month(files.fileDate)=@month and year(files.fileDate)=@year)";
            db.AddParameter("@day", tmp.Day);
            db.AddParameter("@month", tmp.Month);
            db.AddParameter("@year", tmp.Year);
            
        }

        
        DataTable dt = db.ExecuteDataTable(sql);
        Repeater1.DataSource = dt;
        Repeater1.DataBind();
    }


    protected void Repeater1_OnPagePropertiesChanged(object sender, EventArgs e)
    {
        string no = String.Empty;
        if (!string.IsNullOrWhiteSpace(txtNo1.Text) || !string.IsNullOrWhiteSpace(txtNo2.Text))
        {
            no = txtNo1.Text + "/" + txtNo2.Text;
        }
        LoadData(txtTitle.Text, no , ddlField.SelectedValue, txtFileDate.Text);
    }

    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        string no=String.Empty;
        if(!string.IsNullOrWhiteSpace(txtNo1.Text) || !string.IsNullOrWhiteSpace(txtNo2.Text))
        {
            no = txtNo1.Text+"/"+txtNo2.Text;
        }
        LoadData(txtTitle.Text,no,ddlField.SelectedValue,txtFileDate.Text);
    }

    protected void btnDelete_OnCommand(object sender, CommandEventArgs e)
    {
        Database db=new Database();
        db.AddParameter("@id", e.CommandArgument.ToString());
        db.ExecuteNonQuery("delete from UserFav where id=@id");
        LoadData();
        ShowAlert("تم حذف الملف من قائمة الملفات المفضلة",MsgType.Success);
    }
}