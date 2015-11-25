using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_SendMsg : AdminPages
{
    
    public string name = "مراسلة المستخدمين";
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string json="";
            Database db=new Database();
            DataTable dt = db.ExecuteDataTable("select * from users where isActive=1");
            json = "[";
            for (int i=0;i<dt.Rows.Count; i++)
            {
                if(i==0)
                {
                    json += "{ id: "+ dt.Rows[i]["id"].ToString() + ", name: \""+ dt.Rows[i]["name"].ToString() + "\" }";
                }
                else
                {
                    json += ",{ id: " + dt.Rows[i]["id"].ToString() + ", name: \"" + dt.Rows[i]["name"].ToString() + "\" }";
                }
                
            }
            json += "]";
            ViewState["json"] = json;

            

            if (Request.QueryString["toid"] != null)
            {
                string name = db.GetProName("users", "name", "id", Request.QueryString["toid"]);
                if (!string.IsNullOrWhiteSpace(name))
                {
                    ViewState["toid"] = "[{id: " + Request.QueryString["toid"] + ", name: \"" + name + "\"}]";
                }
                else
                {
                    ViewState["toid"] = "[]";
                }
                
            }
            else
            {
                ViewState["toid"] = "[]";
            }
        }
    }


    protected void btnSave_OnClick(object sender, EventArgs e)
    {
        string researchid = txtResearchList.Text;
        if(string.IsNullOrWhiteSpace(researchid) && !CheckBox1.Checked)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء اختيار مستخدم على الاقل\")</SCRIPT>", false);
            return;
        }
        if (string.IsNullOrWhiteSpace(txtSubject.Text))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء ادخال عنوان الرسالة\")</SCRIPT>", false);
            return;
        }
        if (string.IsNullOrWhiteSpace(txtTxt.Text))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "<SCRIPT LANGUAGE=\"JavaScript\">alertify.error(\"الرجاء ادخال  الرسالة\")</SCRIPT>", false);
            return;
        }
        Database db=new Database();
        DataTable dt;

        if(!CheckBox1.Checked)
        {
            dt = db.ExecuteDataTable("select * from users where isActive=1 and (id in (" + researchid + "))");
        }
        else
        {
            dt = db.ExecuteDataTable("select * from users where isActive=1");
        }
        List<string> to=new List<string>();
        AppFunctions validate=new AppFunctions();
        foreach (DataRow row in dt.Rows)
        {
            db.AddParameter("@from", "-1");
            db.AddParameter("@Title", txtSubject.Text);
            db.AddParameter("@msg", txtTxt.Text);
            db.AddParameter("@toId", row["id"].ToString());
            db.ExecuteNonQuery("insert into msg ([from],title,msg,toId) values(@from,@title,@msg,@toId)");
        }

        ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteMsg", "alertify.alert('تم الارسال ','تم الارسال بنجاح').set('onok', function(closeEvent){ location.href='MsgList.aspx'; } );", true);


    }

    protected void CheckBox1_OnCheckedChanged(object sender, EventArgs e)
    {
        rowData.Visible = !CheckBox1.Checked;
        
    }
}