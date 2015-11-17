using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_DocumentOp : System.Web.UI.Page
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
        txtNo.Text = ds.Tables[0].Rows[0]["no"].ToString();
        ddlCat.SelectedValue = ds.Tables[0].Rows[0]["category"].ToString();
        ddlSec.SelectedValue = ds.Tables[0].Rows[0]["Security"].ToString();
        ddlLegal.SelectedValue = ds.Tables[0].Rows[0]["LegalStaus"].ToString();
        
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txtTitle.Text))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء ادخال موضوع المعاملة.\")</SCRIPT>", false);
            return;
        }
        if (string.IsNullOrEmpty(txtNo.Text))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء ادخال رقم القيد.\")</SCRIPT>", false);
            return;
        }
        
        db.AddParameter("@title", txtTitle.Text);
        db.AddParameter("@no", txtNo.Text);
        db.AddParameter("@category", ddlCat.SelectedValue);
        db.AddParameter("@Security", ddlSec.SelectedValue);
        db.AddParameter("@LegalStaus", ddlLegal.SelectedValue);
        

        if (Request.QueryString["Op"].Equals("Edit"))
        {
            try
            {
                db.AddParameter("@id", Request.QueryString["id"]);
                db.ExecuteNonQuery("Update " + tablename + " Set title=@title,[no]=@no,category=@category,Security=@Security,LegalStaus=@LegalStaus where Id=@id");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "alertify.alert('تم التعديل ','تم التعديل بنجاح').set('onok', function(closeEvent){ location.href='" + listpage+"'; } );", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"Error : " + ex.Message + "\")</SCRIPT>", false);
            }

        }
        else if (Request.QueryString["Op"] == "Add")
        {
            db.ExecuteNonQuery("Insert into " + tablename + "(Title,no,category,Security,LegalStaus) Values(@Title,@no,@category,@Security,@LegalStaus)");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "alertify.alert('تم الاضافة ','تم الاضافة بنجاح').set('onok', function(closeEvent){ location.href='" + listpage + "'; } );", true);
        }
    }

}