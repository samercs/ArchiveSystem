using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_DocumentOp : AdminPages
{ 
    string tablename = "Document";
    string listpage = "DocumentList.aspx";
    public string name = "المعاملات";
    Database db = new Database();
    Dates datets=new Dates();
    protected void Page_Init(object sender, EventArgs e)
    {
        if (Request.QueryString["Op"] == null) Response.Redirect("Default.aspx");
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Database db = new Database();
            db.LoadDDL("category","title",ref ddlCat,"ادخل فئة المعاملة","catid=1");
            db.LoadDDL("category", "title", ref ddlSec, "ادخل سرية المعاملة", "catid=2");
            db.LoadDDL("category", "title", ref ddlLegal, "ادخل الوضع القانوني", "catid=3");

            DataTable dt = db.ExecuteDataTable("select * from document");
            ddlRDoc1.Items.Add(new ListItem("اختر معاملة", "-1"));
            ddlRDoc2.Items.Add(new ListItem("اختر معاملة", "-1"));
            ddlRDoc3.Items.Add(new ListItem("اختر معاملة", "-1"));
            foreach (DataRow row in dt.Rows)
            {
                ddlRDoc1.Items.Add(new ListItem(row["title"].ToString()+"-"+row["no"].ToString(),row["id"].ToString()));
                ddlRDoc2.Items.Add(new ListItem(row["title"].ToString() + "-" + row["no"].ToString(), row["id"].ToString()));
                ddlRDoc3.Items.Add(new ListItem(row["title"].ToString() + "-" + row["no"].ToString(), row["id"].ToString()));
            }

            if (Request.QueryString["Op"].Equals("Edit"))
            {
                LoadData();
            }
           
        }
    }
    void LoadData()
    {
        db.AddParameter("@id", Request.QueryString["id"]);
        System.Data.DataSet ds = db.ExecuteDataSet("select * from " + tablename + " where id=@id" + ";" + "");
        txtTitle.Text = ds.Tables[0].Rows[0]["title"].ToString();
        string docNo= ds.Tables[0].Rows[0]["no"].ToString();
        string[] docArray = docNo.Split('/');
        txtNo1.Text = docArray[0];
        txtNo2.Text = docArray[1];
        ddlCat.SelectedValue = ds.Tables[0].Rows[0]["category"].ToString();
        ddlSec.SelectedValue = ds.Tables[0].Rows[0]["Security"].ToString();
        ddlLegal.SelectedValue = ds.Tables[0].Rows[0]["LegalStaus"].ToString();

        db.AddParameter("@id", Request.QueryString["id"]);
        DataTable dt = db.ExecuteDataTable("select * from ConectedDoc where MasterDocId=@id");
        int cout = 0;

        foreach (DataRow row in dt.Rows)
        {
            if (cout == 0)
            {
                ddlRDoc1.SelectedValue = row["DetailDocId"].ToString();
            }
            else if (cout == 1)
            {
                ddlRDoc2.SelectedValue = row["DetailDocId"].ToString();
            }
            else if (cout == 2)
            {
                ddlRDoc3.SelectedValue = row["DetailDocId"].ToString();
            }

            ++cout;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txtTitle.Text))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء ادخال موضوع المعاملة.\")</SCRIPT>", false);
            return;
        }

        int no1, no2;

        if (!int.TryParse(txtNo1.Text,out no1) || !int.TryParse(txtNo2.Text, out no2))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء ادخال رقم القيد.\")</SCRIPT>", false);
            return;
        }
        
        db.AddParameter("@title", txtTitle.Text);
        db.AddParameter("@no", txtNo1.Text+"/"+txtNo2.Text);
        db.AddParameter("@category", ddlCat.SelectedValue);
        db.AddParameter("@Security", ddlSec.SelectedValue);
        db.AddParameter("@LegalStaus", ddlLegal.SelectedValue);
        

        if (Request.QueryString["Op"].Equals("Edit"))
        {
            try
            {
                db.AddParameter("@id", Request.QueryString["id"]);
                db.ExecuteNonQuery("Update " + tablename + " Set title=@title,[no]=@no,category=@category,Security=@Security,LegalStaus=@LegalStaus where Id=@id");
                UpdateConectedDoc(Request.QueryString["id"]);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "alertify.alert('تم التعديل ','تم التعديل بنجاح').set('onok', function(closeEvent){ location.href='" + listpage+"'; } );", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"Error : " + ex.Message + "\")</SCRIPT>", false);
            }

        }
        else if (Request.QueryString["Op"] == "Add")
        {
            long docId=db.ExecuteNonQuery_id("Insert into " + tablename + "(Title,no,category,Security,LegalStaus) Values(@Title,@no,@category,@Security,@LegalStaus)");
            UpdateConectedDoc(docId.ToString());
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "alertify.alert('تم الاضافة ','تم الاضافة بنجاح').set('onok', function(closeEvent){ location.href='" + listpage + "'; } );", true);
        }
    }

    private void UpdateConectedDoc(string docId)
    {
        db.AddParameter("@id", docId);
        db.ExecuteNonQuery("delete from ConectedDoc where MasterDocId=@id");

        if (!ddlRDoc1.SelectedValue.Equals("-1") && CanInsert(docId.ToString(), ddlRDoc1.SelectedValue))
        {
            db.AddParameter("@MasterDocId", docId);
            db.AddParameter("@DetailDocId", ddlRDoc1.SelectedValue);
            db.ExecuteNonQuery("insert into ConectedDoc(MasterDocId,DetailDocId) values(@MasterDocId,@DetailDocId)");
        }
        if (!ddlRDoc2.SelectedValue.Equals("-1") && CanInsert(docId.ToString(), ddlRDoc2.SelectedValue))
        {
            db.AddParameter("@MasterDocId", docId);
            db.AddParameter("@DetailDocId", ddlRDoc2.SelectedValue);
            db.ExecuteNonQuery("insert into ConectedDoc(MasterDocId,DetailDocId) values(@MasterDocId,@DetailDocId)");
        }
        if (!ddlRDoc3.SelectedValue.Equals("-1") && CanInsert(docId.ToString(), ddlRDoc3.SelectedValue))
        {
            db.AddParameter("@MasterDocId", docId);
            db.AddParameter("@DetailDocId", ddlRDoc3.SelectedValue);
            db.ExecuteNonQuery("insert into ConectedDoc(MasterDocId,DetailDocId) values(@MasterDocId,@DetailDocId)");
        }
    }

    private bool CanInsert(string docId,string detailDocId)
    {
        Database db=new Database();
        db.AddParameter("@MasterDocId", docId);
        db.AddParameter("@DetailDocId", detailDocId);
        DataTable dt =
            db.ExecuteDataTable("select * from ConectedDoc where MasterDocId=@MasterDocId and DetailDocId=@DetailDocId");


        return dt.Rows.Count == 0 ;
    }

}