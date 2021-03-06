﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_UsersList : AdminPages
{
    string tablename = "Users";
    private string editPage = "UsersOp.aspx?Op=Edit&id={0}";
    private string addPage = "UsersOp.aspx?Op=Add";
    public string name = "المستخدمين";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            HyperLink3.NavigateUrl = addPage;
            LoadData();
        }
    }
    void LoadData()
    {
        Database db = new Database();
        System.Data.DataSet ds = db.ExecuteDataSet("Select * from users order by id desc");
        RepeaterLists.DataSource = ds.Tables[0];
        RepeaterLists.DataBind();
        Cache["dt1"] = ds.Tables[0];
    }
    protected void CheckBox10_CheckedChanged(object sender, EventArgs e)
    {
        //CheckBox cbAll = RepeaterLists.Controls[0].Controls[0].FindControl("CheckBox10") as CheckBox;
        foreach (ListViewItem r in RepeaterLists.Items)
        {
            CheckBox cb = r.FindControl("CheckBox1") as CheckBox;
            if (CheckBox10.Checked)
            {
                cb.Checked = true;
            }
            else
            {
                cb.Checked = false;
            }
        }
    }
    protected void ListView1_PagePropertiesChanged(object sender, EventArgs e)
    {
        if (Cache["dt1"] != null)
        {
            RepeaterLists.DataSource = (System.Data.DataTable)Cache["dt1"];
            RepeaterLists.DataBind();
        }
        else
        {
            LoadData();
        }
        CheckBox10.Checked = false;
    }
    protected void btnDelete_Command(object sender, CommandEventArgs e)
    {
        if (!string.IsNullOrWhiteSpace(e.CommandName))
        {
            System.IO.File.Delete(Server.MapPath("~/SystemFiles/Users/"+ e.CommandName));
        }

        Database db = new Database();
        string sql = string.Empty;
        string sql2 = string.Empty;

        sql = "delete from " + tablename + " where id =" + e.CommandArgument;
        sql2 = "delete from FileComment where UserId =" + e.CommandArgument;

        if (db.ExecuteNonQuery(sql2+";"+sql) >= 1)
        {
            ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.success(\"تم الحذف بنجاح.\")</SCRIPT>", false);
        }
        LoadData();
    }
    protected void btnEdit_Command(object sender, CommandEventArgs e)
    {
        Response.Redirect(String.Format(editPage,e.CommandArgument.ToString()));
    }
    protected void btnContactDelete_Click(object sender, EventArgs e)
    {
        Database db = new Database();
        HiddenField id, file;
        ArrayList arrlist = new ArrayList();

        int x = 0;

        foreach (ListViewItem rptItem in RepeaterLists.Items)
        {

            CheckBox chk = (CheckBox)rptItem.FindControl("CheckBox1");
            if (chk.Checked)
            {
                id = (HiddenField)RepeaterLists.Items[x].FindControl("id");
                file = (HiddenField)RepeaterLists.Items[x].FindControl("file");
                if (!string.IsNullOrWhiteSpace(file.Value))
                {
                    System.IO.File.Delete(Server.MapPath("~/SystemFiles/Users/" + file.Value));
                }
                arrlist.Add(id.Value);

            }
            x++;
        }

        string sql = string.Empty;
        string sql2 = string.Empty;

        sql = "delete from " + tablename + " where id in (";
        sql2 = "delete from FileComment where UserId in (";

        if (arrlist.Count > 0)
        {
            for (int i = 0; i < arrlist.Count; i++)
            {
                if (i == 0)
                {
                    sql += arrlist[i].ToString();
                    sql2 += arrlist[i].ToString();
                }
                else
                {
                    sql += "," + arrlist[i].ToString();
                    sql2 += "," + arrlist[i].ToString();
                }

            }

            sql += ")";
            sql2 += ")";

            db.ExecuteNonQuery(sql2);

            if (db.ExecuteNonQuery(sql) >= 1)
            {
                ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.success(\"تم الحذف بنجاح\")</SCRIPT>", false);
            }
            LoadData();
            CheckBox10.Checked = false;
        }
    }


    protected void btnEditStatus_OnCommand(object sender, CommandEventArgs e)
    {
        Database db = new Database();
        db.AddParameter("@id", e.CommandArgument.ToString());
        db.ExecuteNonQuery("update files set status=(1-status) where id = @id");
        LoadData();
    }
}