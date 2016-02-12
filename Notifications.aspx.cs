using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Kalboard360.ClassCode;

public partial class Notifications : UsersPages
{Database db = new Database();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null) Response.Redirect("~/Login.aspx");
        LoadData();
    }

    protected void ListView1_OnPagePropertiesChanged(object sender, EventArgs e)
    {
        LoadData();
    }
    private void LoadData()
    {
        Users u = Session["User"] as Users;
        
        db.AddParameter("@uid", u.Id);
        DataTable dt = db.ExecuteDataTable("select f.id, fc.AddDate, f.Title from files f,filecomment fc where userid=@uid and f.id=fc.FileId order by fc.AddDate desc ");
        ListView1.DataSource = dt;
        ListView1.DataBind();
    }

    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        HiddenField hfid = e.Item.FindControl("Datet") as HiddenField;
        DateTime ddd = DateTime.Parse(hfid.Value);
        Label time = e.Item.FindControl("time") as Label;
        time.Text = dateToText(ddd);
    }

    private string dateToText(DateTime date)
    {
        const int SECOND = 1;
        const int MINUTE = 60 * SECOND;
        const int HOUR = 60 * MINUTE;
        const int DAY = 24 * HOUR;
        const int MONTH = 30 * DAY;
        string cd = db.ExecuteDataTable("SELECT  getdate()").Rows[0][0].ToString();
        var ts = new TimeSpan(DateTime.Parse(cd).Ticks - date.Ticks);
        double delta = Math.Abs(ts.TotalSeconds);

        if (delta < 1 * MINUTE)
        {
            return ts.Seconds == 1 ? "منذ ثانية واحدة" : "منذ " + ts.Seconds+ " ثانية";
        }
        if (delta < 2 * MINUTE)
        {
            return "منذ دقيقة واحدة";
        }
        if (delta < 45 * MINUTE)
        {
            return "منذ "+ ts.Minutes + " دقيقة";
        }
        if (delta < 90 * MINUTE)
        {
            return "منذ ساعة واحدة";
        }
        if (delta < 24 * HOUR)
        {
            return "منذ " + ts.Hours + " ساعة";
        }
        if (delta < 48 * HOUR)
        {
            return "في الأمس";
        }
        if (delta < 30 * DAY)
        {
            return "منذ " + ts.Days + " يوم";
        }
        if (delta < 12 * MONTH)
        {
            int months = Convert.ToInt32(Math.Floor((double)ts.Days / 30));
            return months <= 1 ? "منذ شهر واحد" : "منذ " + months + " شهر";
        }
        else
        {
            int years = Convert.ToInt32(Math.Floor((double)ts.Days / 365));
            return years <= 1 ? "منذ سنة واحدة" : "منذ " + years + " سنة";
        }
    }
}