using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SearchFile : UICaltureBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            Database db = new Database();
            db.LoadDDL("category", "title", ref ddlField, "المجال", "catId=5");
            string title = Request.QueryString["name"];
            string date = Request.QueryString["date"];
            string target = Request.QueryString["category"];
            string no = Request.QueryString["no"];
            txtTitle.Text = title;
            ddlField.SelectedValue = target;
            txtFileDate.Text = date;
            string[] noArray = no.Split('/');
            txtNo1.Text = noArray[0];
            txtNo2.Text = noArray[1];
            LoadData(txtTitle.Text,no,ddlField.SelectedValue,txtFileDate.Text);
        }
    }

    private void LoadData(string title="",string no="",string target="",string date="")
    {
        Dates dates =new Dates();
        Database db = new Database();
        Users u = Session["User"] as Users;
        db.AddParameter("@id", u.Id);
        string sql = "select files.*,category.title as fieldName from  files left join category on files.Field=category.id where 1=1";
        if (!string.IsNullOrWhiteSpace(title))
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
            sql += " and files.[Field] = @Field";
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
        LoadData(txtTitle.Text, txtNo1.Text + "/" + txtNo2.Text, ddlField.SelectedValue, txtFileDate.Text);
    }

    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        LoadData(txtTitle.Text, txtNo1.Text + "/" + txtNo2.Text, ddlField.SelectedValue, txtFileDate.Text);
    }
}