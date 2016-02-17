using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_UsersOp : AdminPages
{
    string tablename = "Users";
    string listpage = "UsersList.aspx";
    public string name = "المستخدمين";
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
        txtName.Text = ds.Tables[0].Rows[0]["name"].ToString();
        txtUserName.Text = ds.Tables[0].Rows[0]["username"].ToString();
        txtPassword.Text = ds.Tables[0].Rows[0]["password"].ToString();
        txtOrganization.Text = ds.Tables[0].Rows[0]["Organization"].ToString();
        DateTime tmp2;
        if (DateTime.TryParse(ds.Tables[0].Rows[0]["LockedTo"].ToString(),out tmp2))
        {
            txtLockedTo.Text = datets.GregToHijri(tmp2.ToString("d/M/yyyy"), "d/M/yyyy");
        }
        if(ds.Tables[0].Rows[0]["IsActive"].ToString().Equals("True"))
        {
            ddlStatus.SelectedValue = "1";
        }
        else
        {
            ddlStatus.SelectedValue = "0";
        }
        if (ds.Tables[0].Rows[0]["RequerChange"].ToString().Equals("True"))
        {
            RadioButtonList1.SelectedValue = "1";
        }
        else
        {
            RadioButtonList1.SelectedValue = "0";
        }
        txtJobTitle.Text = ds.Tables[0].Rows[0]["JobTitle"].ToString();
        txtPhone.Text = ds.Tables[0].Rows[0]["Phone"].ToString();
        txtMobile.Text = ds.Tables[0].Rows[0]["Mobile"].ToString();
        ViewState["file"] = ds.Tables[0].Rows[0]["img"].ToString();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        AppFunctions v=new AppFunctions();
        if (Request.QueryString["Op"].Equals("Add") && !fileFile.HasFile)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء اختيار الصورة.\")</SCRIPT>", false);
            return;
        }
        if (string.IsNullOrEmpty(txtName.Text))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء ادخال الاسم.\")</SCRIPT>", false);
            return;
        }
        if (string.IsNullOrEmpty(txtOrganization.Text))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء ادخال جهة العمل.\")</SCRIPT>", false);
            return;
        }
        if (string.IsNullOrEmpty(txtUserName.Text))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء ادخال البريد الالكتروني.\")</SCRIPT>", false);
            return;
        }

        if (!v.IsEmailValid(txtUserName.Text))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء التأكد من البريد الالكتروني.\")</SCRIPT>", false);
            return;
        }

        /*DateTime tmp,tmp2;
        
        if (!DateTime.TryParseExact(datets.HijriToGreg(txtAddedDate.Text, "d/M/yyyy"), "d/M/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tmp))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء التأكد من التاريخ الاضافة\")</SCRIPT>", false);
            return;
        }

        if (!DateTime.TryParseExact(datets.HijriToGreg(txtFileDate.Text, "d/M/yyyy"), "d/M/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tmp2))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء التأكد من تاريخ الملف\")</SCRIPT>", false);
            return;
        }*/

        if (fileFile.HasFile)
        {
            if (!Tools.IsImage(fileFile.PostedFile.FileName))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء التأكد من ملف الصورة\")</SCRIPT>", false);
                return;
            }

            try
            {
                if (ViewState["file"] != null)
                {
                    System.IO.File.Delete(Server.MapPath("~/SystemFiles/Users/" + ViewState["file"].ToString()));
                }
                ViewState["file"] = DateTime.Now.Ticks + System.IO.Path.GetFileName(fileFile.PostedFile.FileName);

                fileFile.PostedFile.SaveAs(Server.MapPath("~/SystemFiles/Users/" + ViewState["file"].ToString()));
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"Error : " + ex.Message + "\")</SCRIPT>", false);
                return;
            }
        }


        

        db.AddParameter("@name", txtName.Text);
        db.AddParameter("@username", txtUserName.Text);
        db.AddParameter("@password", txtPassword.Text);
        db.AddParameter("@Organization", txtOrganization.Text);
        db.AddParameter("@RequerChange", RadioButtonList1.SelectedValue);

        DateTime tmp2;
        if (DateTime.TryParseExact(datets.HijriToGreg(txtLockedTo.Text, "d/M/yyyy"), "d/M/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tmp2))
        {
            db.AddParameter("@LockedTo", tmp2);
        }
        else
        {
            db.AddParameter("@LockedTo", DBNull.Value);
        }
        db.AddParameter("@IsActive", ddlStatus.SelectedValue);
        db.AddParameter("@JobTitle",txtJobTitle.Text);
        db.AddParameter("@phone", txtPhone.Text);
        db.AddParameter("@Mobile", txtMobile.Text);
        db.AddParameter("@img", ViewState["file"].ToString());



        if (Request.QueryString["Op"].Equals("Edit"))
        {
            try
            {
                db.AddParameter("@id", Request.QueryString["id"]);
                db.ExecuteNonQuery("Update " + tablename + " Set name=@name,[username]=@username,[img]=@img,password=@password,[RequerChange]=@RequerChange,[LockedTo]=@LockedTo,[IsActive]=@IsActive,[JobTitle]=@JobTitle,[Phone]=@Phone,[Mobile]=@Mobile,Organization=@Organization where Id=@id");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "alertify.alert('تم التعديل ','تم التعديل بنجاح').set('onok', function(closeEvent){ location.href='" + listpage+"'; } );", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"Error : " + ex.Message + "\")</SCRIPT>", false);
            }

        }
        else if (Request.QueryString["Op"] == "Add")
        {
            db.ExecuteNonQuery("Insert into " + tablename + "(name,username,password,RequerChange,LockedTo,IsActive,JobTitle,Phone,Img,Organization,Mobile) Values(@name,@username,@password,@RequerChange,@LockedTo,@IsActive,@JobTitle,@Phone,@Img,@Organization,@Mobile)");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "alertify.alert('تم الاضافة ','تم الاضافة بنجاح').set('onok', function(closeEvent){ location.href='" + listpage + "'; } );", true);
        }
    }

}