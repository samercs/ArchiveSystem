﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Kalboard360.ClassCode;

public partial class SearchFile : UICaltureBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            Database db = new Database();
            db.LoadDDL("FileTarget", "title", ref ddlField, "المجال");
            db.LoadDDL("country", "name", ref ddlCountry, "الدولة", "lang=2");
            db.LoadDDL("FileType", "Title", ref ddlType, "النوع");
            string title = Request.QueryString["name"];
            string date = Request.QueryString["date"];
            string target = Request.QueryString["category"];
            string country = Request.QueryString["country"];
            string type = Request.QueryString["type"];
            string no = Request.QueryString["no"];
            txtTitle.Text = title;
            ddlField.SelectedValue = target;
            ddlCountry.SelectedValue = country;
            ddlType.SelectedValue = type;
            txtFileDate.Text = date;
            if (no != null)
            {
               // string[] noArray = no.Split('/');
                if (no.Length > 0)
                {
                    txtNo1.Text = no;
                }
            }

            LoadData(txtTitle.Text,no,ddlField.SelectedValue,txtFileDate.Text,ddlCountry.SelectedValue,ddlType.SelectedValue);
        }
    }

    private void LoadData(string title="",string no="",string target="",string date="",string country="",string type="")
    {
        Dates dates =new Dates();
        Database db = new Database();
        //Users u = Session["User"] as Users;
        //  db.AddParameter("@id", u.Id);
        string sql;
        if (Session["User"] == null)
        {
            sql = "select files.*,FileTarget.title as TargetName,FileType.Title as TypeName from  (files left join FileTarget on files.Target=FileTarget.id) inner join FileType on Files.Type=FileType.Id where files.[Security] in (1)";

        }
        else
        {
            sql = "select files.*,FileTarget.title as TargetName,FileType.Title as TypeName from  (files left join FileTarget on files.Target=FileTarget.id) inner join FileType on Files.Type=FileType.Id where  files.[Security] in (1,2)";
        }
            if (!string.IsNullOrWhiteSpace(title))
        {
            sql += " and (files.title like '%' + @title + '%' or files.[No] like '%' + @title + '%' or files.[From] like '%' + @title + '%' or files.[To] like '%' + @title + '%' or files.[Desc] like '%' + @title + '%' or files.[FileKey] like '%' + @title + '%')";
            db.AddParameter("@title", title);
        }
        if (!string.IsNullOrWhiteSpace(no))
        {
            sql += " and files.no like '%' + @no + '%'";
            db.AddParameter("@no", no);
        }
        if (!string.IsNullOrWhiteSpace(target) && !target.Equals("-1"))
        {
            sql += " and files.[target] = @Field";
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
        if (!string.IsNullOrWhiteSpace(country) && !country.Equals("-1"))
        {
            sql += " and files.[country] = @country";
            db.AddParameter("@country", country);
        }
        if (!string.IsNullOrWhiteSpace(type) && !type.Equals("-1"))
        {
            sql += " and files.[type] = @type";
            db.AddParameter("@type", type);
        }

        if (ddlSort.SelectedValue != "-1")
        {
            if (ddlSort.SelectedValue == "1") {
                sql += " order by files.fileDate desc";
            }
            else if (ddlSort.SelectedValue == "2")
            {
                sql += " order by files.fileDate asc";
            }
            else if (ddlSort.SelectedValue == "3")
            {
                sql += " order by files.Title";
            }
        }
        DataTable dt = db.ExecuteDataTable(sql);
        Repeater1.DataSource = dt;
        Repeater1.DataBind();
    }


    protected void Repeater1_OnPagePropertiesChanged(object sender, EventArgs e)
    {
        LoadData(txtTitle.Text, txtNo1.Text, ddlField.SelectedValue, txtFileDate.Text,ddlCountry.SelectedValue);
    }

    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        LoadData(txtTitle.Text, txtNo1.Text, ddlField.SelectedValue, txtFileDate.Text,ddlCountry.SelectedValue);
    }

    protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadData(txtTitle.Text, txtNo1.Text, ddlField.SelectedValue, txtFileDate.Text, ddlCountry.SelectedValue);
    }

    protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadData(txtTitle.Text, txtNo1.Text, ddlField.SelectedValue, txtFileDate.Text, ddlCountry.SelectedValue);
    }

    protected void ddlField_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadData(txtTitle.Text, txtNo1.Text, ddlField.SelectedValue, txtFileDate.Text, ddlCountry.SelectedValue);
    }

    protected void txtTitle_TextChanged(object sender, EventArgs e)
    {
        LoadData(txtTitle.Text, txtNo1.Text, ddlField.SelectedValue, txtFileDate.Text, ddlCountry.SelectedValue);
    }


    protected void txtFileDate_TextChanged(object sender, EventArgs e)
    {
      //  Response.Redirect("d");
        LoadData(txtTitle.Text, txtNo1.Text, ddlField.SelectedValue, txtFileDate.Text, ddlCountry.SelectedValue);
    }

    protected void txtNo1_TextChanged(object sender, EventArgs e)
    {
        LoadData(txtTitle.Text, txtNo1.Text, ddlField.SelectedValue, txtFileDate.Text, ddlCountry.SelectedValue);
    }
}