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
            LoadData();
        }
    }

    private void LoadData(string title="",string no="",string target="",string date="")
    {
        Database db=new Database();
        Users u = Session["User"] as Users;
        db.AddParameter("@id", u.Id);
        string sql = "select * from UserFav inner join files on (files.id=Userfav.FileId) where UserFav.UserId=@id";
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
        if (!string.IsNullOrWhiteSpace(target))
        {
            sql += " and files.target like '%' + @target + '%'";
            db.AddParameter("@target", target);
        }
        DateTime tmp;
        if (DateTime.TryParseExact(date,"d/M/yyyy",CultureInfo.InvariantCulture, DateTimeStyles.None, out tmp))
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
        LoadData(txtTitle.Text, txtNo1.Text + "/" + txtNo2.Text, txtTarget.Text, txtFileDate.Text);
    }

    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        string no=String.Empty;
        if(!string.IsNullOrWhiteSpace(txtNo1.Text) || !string.IsNullOrWhiteSpace(txtNo2.Text))
        {
            no = txtNo1.Text + "/" + txtNo2.Text;
        }
        LoadData(txtTitle.Text,no,txtTarget.Text,txtFileDate.Text);
    }
}