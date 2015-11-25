using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_DocumentList : AdminPages
{
    string tablename = "Document";
    private string editPage = "DocumentOp.aspx?Op=Edit&id={0}";
    private string addPage = "DocumentOp.aspx?Op=Add";
    public string name = "المعاملات";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Database db = new Database();
            db.LoadDDL("category", "title", ref ddlField, "فئة المعاملة", "catId=1");
            HyperLink3.NavigateUrl = addPage;
            LoadData();
        }
    }
    void LoadData(string title="",string no="",string type="")
    {
        Database db = new Database();
        string where = " 1=1 ";
        if(!string.IsNullOrWhiteSpace(title))
        {
            where += " and Document.title like '%' + @title + '%' ";
            db.AddParameter("@title", title);
        }

        if (!string.IsNullOrWhiteSpace(no))
        {
            where += " and Document.no like '%' + @no + '%' ";
            db.AddParameter("@no", no);
        }

        if (!string.IsNullOrWhiteSpace(no))
        {
            where += " and Document.category=@category ";
            db.AddParameter("@category", type);
        }

        string sql = "Select Document.*,Cat1.title as CatName,cat2.title as SecName,cat3.title as LegalName from (((Document left join category as cat1 on (Document.Category=cat1.id)) left join category as cat2 on (Document.Security=cat2.id)) left join category as cat3 on (document.LegalStaus=cat3.id))  where "+where+" Order By Document.Id desc";
        System.Data.DataSet ds = db.ExecuteDataSet(sql);
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
        Database db = new Database(); string sql = string.Empty;
        db.AddParameter("@id", e.CommandArgument.ToString());
        db.ExecuteNonQuery("delete from " + tablename + " where id =@id;delete from ConectedDoc where masterdocid =@id");
        ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.success(\"تم الحذف بنجاح.\")</SCRIPT>", false);
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
                arrlist.Add(id.Value);
            }
            x++;
        }

        string sql = string.Empty,sql2=String.Empty;

        sql = "delete from " + tablename + " where id in (";
        sql2 = "delete from ConectedDoc where masterdocid in (";

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
            db.ExecuteNonQuery(sql + ";" + sql2);
            ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.success(\"تم الحذف بنجاح\")</SCRIPT>", false);
            
            LoadData();
            CheckBox10.Checked = false;
        }
    }


    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        int no1, no2;
        string no = String.Empty;
        if (int.TryParse(txtFileNo1.Text, out no1) || int.TryParse(txtFileNo2.Text, out no2))
        {
            no = txtFileNo1.Text + "/" + txtFileNo2.Text;
        }
        LoadData(txtFileName.Text,no,ddlField.SelectedValue);
    }
}