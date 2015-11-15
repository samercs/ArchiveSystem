using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ConectedDocOp : System.Web.UI.Page
{
    string tablename = "ConectedDoc";
    string listpage = "ConectedDocList.aspx";
    public string name = "الملفات المرتبطة";
    Database db = new Database();
    protected void Page_Init(object sender, EventArgs e)
    {
        int pid;
        if(!int.TryParse(Request.QueryString["pid"],out pid))
        {
            Response.Redirect("FileList.aspx");
        }
        if (Request.QueryString["Op"] == null) Response.Redirect("Default.aspx");
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            listpage = "ConectedDocList.aspx?id=" + Request.QueryString["pid"];
            db.LoadDDL("Files","title",ref ddlFile,"الرجاء اختيار الملف","not id=" + Request.QueryString["pid"]);
            if (Request.QueryString["Op"].Equals("Edit"))
            {
                LoadData();
            }
            string filename= db.GetProName("Files", "title", "id", Request.QueryString["pid"]);
            name += " - " + filename;
            lblFilename.Text = filename;
            HyperLink2.NavigateUrl = listpage;
            
        }
    }
    void LoadData()
    {
        db.AddParameter("@id", Request.QueryString["id"]);
        System.Data.DataSet ds = db.ExecuteDataSet("select * from " + tablename + " where id=@id" + ";" + "");
        ddlFile.SelectedValue = ds.Tables[0].Rows[0]["detailDocId"].ToString();
        
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (ddlFile.SelectedValue.Equals("-1"))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء اختيار الملف.\")</SCRIPT>", false);
            return;
        }
        

        db.AddParameter("@masterDocId", Request.QueryString["pid"]);
        db.AddParameter("@DetailDocId", ddlFile.SelectedValue);
        
        if (Request.QueryString["Op"].Equals("Edit"))
        {
            try
            {
                db.AddParameter("@id", Request.QueryString["id"]);
                db.ExecuteNonQuery("Update " + tablename + " Set detailDocId=@detailDocId where Id=@id");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "alertify.alert('تم التعديل ','تم التعديل بنجاح').set('onok', function(closeEvent){ location.href='ConectedDocList.aspx?id=" + Request.QueryString["pid"]+"'; } );", true);
            }

            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"Error : " + ex.Message + "\")</SCRIPT>", false);
            }

        }
        else if (Request.QueryString["Op"] == "Add")
        {
            db.ExecuteNonQuery("Insert into " + tablename + "(masterdocid,detaildocid) Values(@masterdocid,@detaildocid)");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "alertify.alert('تم الاضافة ','تم الاضافة بنجاح').set('onok', function(closeEvent){ location.href='ConectedDocList.aspx?id=" + Request.QueryString["pid"] + "'; } );", true);
        }
    }

}