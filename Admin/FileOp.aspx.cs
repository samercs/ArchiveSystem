﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_FileOp : AdminPages
{
    string tablename = "Files";
    string listpage = "FileList.aspx";
    public string name = "الملفات";
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
            db.LoadDDL("FileTarget", "title", ref ddlTarget, "اختر المجال");
            db.LoadDDL("FileType","title",ref ddlType,"اختر النوع");
            db.LoadDDL("FileStatus", "title", ref ddlStatus, "اختر الحالة");
            db.LoadDDL("FileSecurity", "title", ref ddlSecurity, "اختر درجة السرية");
            db.LoadDDL("Country", "name", ref ddlCountry, "اختر الدولة", "lang=2");
            db.LoadDDL("FileField", "title", ref ddlField, "المعنين");
            if (Request.QueryString["Op"].Equals("Edit"))
            {
                LoadData();
                rowAttache.Visible = false;
            }
            else
            {
                txtFileDate.Text = datets.GregToHijri(DateTime.Now.ToString("d/M/yyyy"), "d/M/yyyy");
                txtAddedDate.Text = datets.GregToHijri(DateTime.Now.ToString("d/M/yyyy"), "d/M/yyyy");
                ddlCountry.SelectedValue = "2";
            }
        }
    }
    void LoadData()
    {
        db.AddParameter("@id", Request.QueryString["id"]);
        System.Data.DataSet ds = db.ExecuteDataSet("select * from " + tablename + " where id=@id" + ";" + "");
        txtTitle.Text = ds.Tables[0].Rows[0]["title"].ToString();
        string fileNo= ds.Tables[0].Rows[0]["no"].ToString();
        string[] fileNoArray = fileNo.Split('/');
        txtNo1.Text = fileNoArray[0];
        txtNo2.Text = fileNoArray[1];
        txtFrom.Text = ds.Tables[0].Rows[0]["from"].ToString();
        txtTo.Text = ds.Tables[0].Rows[0]["to"].ToString();
        ddlTarget.SelectedValue = ds.Tables[0].Rows[0]["target"].ToString();
        ddlType.SelectedValue = ds.Tables[0].Rows[0]["type"].ToString();
        ddlSecurity.SelectedValue = ds.Tables[0].Rows[0]["Security"].ToString();
        txtDesc.Text = ds.Tables[0].Rows[0]["Desc"].ToString();
        txtAddedDate.Text =  datets.GregToHijri(DateTime.Parse(ds.Tables[0].Rows[0]["AddedDate"].ToString()).ToString("d/M/yyyy"),"d/M/yyyy");
        txtFileDate.Text = datets.GregToHijri(DateTime.Parse(ds.Tables[0].Rows[0]["FileDate"].ToString()).ToString("d/M/yyyy"), "d/M/yyyy");
        ddlStatus.SelectedValue = ds.Tables[0].Rows[0]["Status"].ToString();
        ddlField.SelectedValue = ds.Tables[0].Rows[0]["Field"].ToString();
        txtFileKey.Text = ds.Tables[0].Rows[0]["FileKey"].ToString();

        ddlCountry.SelectedValue = ds.Tables[0].Rows[0]["Country"].ToString();
        ViewState["file"] = ds.Tables[0].Rows[0]["fileurl"].ToString();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["Op"].ToLower()== "add" && !fileFile.HasFile)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء اختيار الملف.\")</SCRIPT>", false);
            return;
        }
        if (string.IsNullOrEmpty(txtTitle.Text))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء اختيار العنوان.\")</SCRIPT>", false);
            return;
        }
        int x = 0;
        if (string.IsNullOrWhiteSpace(txtNo1.Text) || string.IsNullOrWhiteSpace(txtNo2.Text))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء ادخال رقم الملف.\")</SCRIPT>", false);
            return;
        }
        if(!int.TryParse(txtNo1.Text, out x) || !int.TryParse(txtNo2.Text, out x))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"رقم الملف يقبل الأعداد الصحيحة فقط..\")</SCRIPT>", false);
            return;
        }

        int no1, no2;
        if(!int.TryParse(txtNo1.Text,out no1) || !int.TryParse(txtNo2.Text, out no2))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء التأكد من رقم الملف.\")</SCRIPT>", false);
            return;
        }
        
        DateTime tmp,tmp2;
        
        if (!DateTime.TryParseExact(datets.HijriToGreg(txtAddedDate.Text, "d/M/yyyy"), "d/M/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tmp))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء التأكد من التاريخ الاضافة\")</SCRIPT>", false);
            return;
        }

        if (!DateTime.TryParseExact(datets.HijriToGreg(txtFileDate.Text, "d/M/yyyy"), "d/M/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tmp2))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء التأكد من تاريخ الملف\")</SCRIPT>", false);
            return;
        }

        if (ddlTarget.SelectedValue.Equals("-1"))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء اختيار مجال الملف\")</SCRIPT>", false);
            return;
        }
        if (ddlType.SelectedValue.Equals("-1"))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء اختيار نوع الملف\")</SCRIPT>", false);
            return;
        }
        if (ddlSecurity.SelectedValue.Equals("-1"))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء اختيار درجة السرية الملف\")</SCRIPT>", false);
            return;
        }
        if (ddlField.SelectedValue.Equals("-1"))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء اختيار المعنين\")</SCRIPT>", false);
            return;
        }
        if (ddlStatus.SelectedValue.Equals("-1"))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء اختيار حالة الملف \")</SCRIPT>", false);
            return;
        }
        if (ddlCountry.SelectedValue.Equals("-1"))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء اختيار الدولة \")</SCRIPT>", false);
            return;
        }

        string no = txtNo1.Text + "/" + txtNo2.Text;
        db.AddParameter("@no", no);
        string sql = "select * from files where no=@no";
        if (Request.QueryString["Op"].Equals("Edit"))
        {
            sql += " and not id=@id";
            db.AddParameter("@id", Request.QueryString["id"]);
        }
        DataTable dt = db.ExecuteDataTable(sql);
        if(dt.Rows.Count!=0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"رقم الملف مدخل من قبل\")</SCRIPT>", false);
            return;
        }


        if (fileFile.HasFile)
        {
            if (!Tools.IsDoc(fileFile.PostedFile.FileName))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء التأكد من الملف\")</SCRIPT>", false);
                return;
            }

            try
            {
                if (ViewState["file"] != null)
                {
                    System.IO.File.Delete(Server.MapPath("~/SystemFiles/Files/" + ViewState["file"].ToString()));
                }
                ViewState["file"] = DateTime.Now.Ticks + System.IO.Path.GetFileName(fileFile.PostedFile.FileName);

                string filePath = Server.MapPath("~/SystemFiles/Files/" + ViewState["file"].ToString());
                fileFile.PostedFile.SaveAs(filePath);

                if (filePath.ToLower().EndsWith(".pdf"))
                {
                    string customizedText = String.Format("Social Polisies Directory - NCSS");
                    FileInfo pdfFileInfo = new FileInfo(filePath);
                    byte[] fileBytes = FooTheoryPdf.WriteToPdf(pdfFileInfo, customizedText);
                    File.WriteAllBytes(filePath, fileBytes);

                }
                


            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"Error : " + ex.Message + "\")</SCRIPT>", false);
                return;
            }
        }

        AdminInfo admin=Session["AdminInfo"] as AdminInfo; ;

        db.AddParameter("@title", txtTitle.Text);
        db.AddParameter("@no", txtNo1.Text +"/"+txtNo2.Text);
        db.AddParameter("@from", txtFrom.Text);
        db.AddParameter("@to", txtTo.Text);
        db.AddParameter("@target", ddlTarget.SelectedValue);
        db.AddParameter("@security", ddlSecurity.SelectedValue);
        db.AddParameter("@desc", txtDesc.Text);
        db.AddParameter("@addedBy",admin.Id);
        db.AddParameter("@fileDate", tmp2);
        db.AddParameter("@addedDate", tmp);
        db.AddParameter("@status", ddlStatus.SelectedValue);
        db.AddParameter("@type", ddlType.SelectedValue);
        db.AddParameter("@Field", ddlField.SelectedValue);
        db.AddParameter("@fileKey", txtFileKey.Text);
        db.AddParameter("@country", ddlCountry.SelectedValue);
        db.AddParameter("@fileurl", ViewState["file"].ToString());



        if (Request.QueryString["Op"].Equals("Edit"))
        {
            try
            {
                db.AddParameter("@id", Request.QueryString["id"]);
                db.ExecuteNonQuery("Update " + tablename + " Set title=@title,[Type]=@Type,[FileUrl]=@FileUrl,status=@status,[no]=@no,[from]=@from,[to]=@to,[target]=@target,security=@security,Country=@Country,[fileDate]=@FileDate,[desc]=@desc,[AddedDate]=@AddedDate,AddedBy=@AddedBy,FileKey=@FileKey,Field=@Field where Id=@id");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "alertify.alert('تم التعديل ','تم التعديل بنجاح').set('onok', function(closeEvent){ location.href='" + listpage+"'; } );", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"Error : " + ex.Message + "\")</SCRIPT>", false);
            }

        }
        else if (Request.QueryString["Op"] == "Add")
        {
            long fileId = db.ExecuteNonQuery_id("Insert into " + tablename + "(Title,no,[from],[to],target,security,Country,status,[Type],[Fileurl],addeddate,filedate,addedby,[desc],FileKey,Field) Values(@Title,@no,@from,@to,@target,@security,@Country,@status,@Type,@Fileurl,@addeddate,@filedate,@addedby,@desc,@FileKey,@Field)");
            if (attachedFile1.HasFile && Tools.IsDoc(attachedFile1.PostedFile.FileName))
            {
                string fileName = DateTime.Now.Ticks + "_" +
                                  System.IO.Path.GetFileName(attachedFile1.PostedFile.FileName);
                attachedFile1.PostedFile.SaveAs(Server.MapPath("~/SystemFiles/FilesAttach/" + fileName));

                db.AddParameter("@fileId", fileId);
                string title = string.IsNullOrWhiteSpace(txtAttachedTitle1.Text) ? fileName : txtAttachedTitle1.Text;
                db.AddParameter("@Title", title);
                db.AddParameter("@FileUrl", fileName);
                db.ExecuteNonQuery("insert into FilesAttach(fileId,Title,FileUrl) values(@fileId,@Title,@FileUrl)");

            }
            if (attachedFile2.HasFile && Tools.IsDoc(attachedFile2.PostedFile.FileName))
            {
                string fileName = DateTime.Now.Ticks + "_" +
                                  System.IO.Path.GetFileName(attachedFile2.PostedFile.FileName);
                attachedFile2.PostedFile.SaveAs(Server.MapPath("~/SystemFiles/FilesAttach/" + fileName));

                string title = string.IsNullOrWhiteSpace(txtAttachedTitle2.Text) ? fileName : txtAttachedTitle2.Text;

                db.AddParameter("@fileId", fileId);
                db.AddParameter("@Title", title);
                db.AddParameter("@FileUrl", fileName);
                db.ExecuteNonQuery("insert into FilesAttach(fileId,Title,FileUrl) values(@fileId,@Title,@FileUrl)");

            }
            if (attachedFile3.HasFile && Tools.IsDoc(attachedFile3.PostedFile.FileName))
            {
                string fileName = DateTime.Now.Ticks + "_" +
                                  System.IO.Path.GetFileName(attachedFile3.PostedFile.FileName);
                attachedFile3.PostedFile.SaveAs(Server.MapPath("~/SystemFiles/FilesAttach/" + fileName));

                string title = string.IsNullOrWhiteSpace(txtAttachedTitle3.Text) ? fileName : txtAttachedTitle3.Text;

                db.AddParameter("@fileId", fileId);
                db.AddParameter("@Title", title);
                db.AddParameter("@FileUrl", fileName);
                db.ExecuteNonQuery("insert into FilesAttach(fileId,Title,FileUrl) values(@fileId,@Title,@FileUrl)");

            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "alertify.alert('تم الاضافة ','تم الاضافة بنجاح').set('onok', function(closeEvent){ location.href='" + listpage + "'; } );", true);
        }
    }

}