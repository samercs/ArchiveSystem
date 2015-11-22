using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_FilesList : AdminPages
{
    string tablename = "Files";
    private string editPage = "FileOp.aspx?Op=Edit&id={0}";
    private string addPage = "FileOp.aspx?Op=Add";
    public string name = "الملفات";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Database db=new Database();
            db.LoadDDL("category","title",ref ddlField,"المجال" , "catId=5");
            HyperLink3.NavigateUrl = addPage;
            LoadData();
        }
    }
    void LoadData(string filename="",string no="",string field="")
    {
        Database db = new Database();
        string where = "where 1=1 ";
        if (!string.IsNullOrWhiteSpace(filename))
        {
            where += " and Files.title like '%' + @title + '%' ";
            db.AddParameter("@title", filename);
        }

        if (!string.IsNullOrWhiteSpace(no))
        {
            where += " and Files.[no] like '%' + @no + '%' ";
            db.AddParameter("@no", no);
        }

        if (!field.Equals("-1") && !string.IsNullOrWhiteSpace(field))
        {
            where += " and Files.[field] = @Field ";
            db.AddParameter("@Field", field);
        }

        string sql = "Select * from Files inner join Users on (Files.AddedBy=Users.Id) "+where+" Order By Files.Id desc";

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
        if (!string.IsNullOrWhiteSpace(e.CommandName))
        {
            System.IO.File.Delete(Server.MapPath("~/SystemFiles/Files/"+ e.CommandName));
        }

        db.AddParameter("@id", e.CommandArgument.ToString());
        DataTable dt = db.ExecuteDataTable("select * from FilesAttach where fileId=@id");
        foreach (DataRow row in dt.Rows)
        {
            if (!string.IsNullOrWhiteSpace(row["fileUrl"].ToString()))
            {
                System.IO.File.Delete(Server.MapPath("~/SystemFiles/FilesAttach/" + row["fileUrl"].ToString()));
            }
        }

        db.AddParameter("@id", e.CommandArgument.ToString());
        db.ExecuteNonQuery("delete from FilesAttach where fileId=@id");

        db.AddParameter("@id", e.CommandArgument.ToString());
        db.ExecuteNonQuery("delete from FileComment where fileId=@id");

        db.AddParameter("@id", e.CommandArgument.ToString());
        db.ExecuteNonQuery("delete from FileNotice where fileId=@id");

        db.AddParameter("@id", e.CommandArgument.ToString());
        db.ExecuteNonQuery("delete from UserFav where fileId=@id");

        db.AddParameter("@id", e.CommandArgument.ToString());
        db.ExecuteNonQuery("delete from files where id=@id");


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
                file = (HiddenField)RepeaterLists.Items[x].FindControl("file");
                if (!string.IsNullOrWhiteSpace(file.Value))
                {
                    System.IO.File.Delete(Server.MapPath("~/SystemFiles/Files/" + file.Value));
                }
                arrlist.Add(id.Value);

            }
            x++;
        }

        string insql="(";

        

        if (arrlist.Count > 0)
        {
            for (int i = 0; i < arrlist.Count; i++)
            {
                if (i == 0)
                {
                    insql += arrlist[i].ToString();
                }
                else
                {
                    insql += "," + arrlist[i].ToString();
                    
                }

            }

            insql += ")";

            

            DataTable dt = db.ExecuteDataTable("select * from filesAttach where fileId in " + insql);
            foreach (DataRow row in dt.Rows)
            {
                if (!string.IsNullOrWhiteSpace(row["fileUrl"].ToString()))
                {
                    System.IO.File.Delete(Server.MapPath("~/SystemFiles/FilesAttach/" + row["fileUrl"].ToString()));
                }
            }

            db.ExecuteNonQuery("delete from filesAttach where fileId in " + insql);
            db.ExecuteNonQuery("delete from FileComment where fileId in " + insql);
            db.ExecuteNonQuery("delete from FileNotice where fileId in " + insql);
            db.ExecuteNonQuery("delete from UserFav where fileId in " + insql);
            db.ExecuteNonQuery("delete from " + tablename + " where id in " + insql);

            ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.success(\"تم الحذف بنجاح\")</SCRIPT>", false);
            
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

    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        int no1, no2;
        string no=String.Empty;
        if (int.TryParse(txtFileNo1.Text, out no1) || int.TryParse(txtFileNo2.Text, out no2))
        {
            no = txtFileNo1.Text + "/" + txtFileNo2.Text;
        }
        LoadData(txtFileName.Text,no,ddlField.SelectedValue);
    }
}