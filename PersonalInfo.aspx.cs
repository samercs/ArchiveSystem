using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PersonalInfo : UICaltureBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            Users u=Session["User"] as Users;
            txtName.Text = u.Name;
            txtJobTitle.Text = u.JobTitle;
            txtPhoneNumber.Text = u.Phone;
            txtUserName.Text = u.UserName;
            txtPassword.Attributes.Add("value",u.Password);
            
        }
    }

    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {
        if(ValidateData())
        {
            Users u = Session["User"] as Users;
            string imgFileName = u.Image;
            
            if(fileImg.HasFile)
            {
                if (string.IsNullOrWhiteSpace(imgFileName))
                {
                    imgFileName = DateTime.Now.Ticks + "-" + System.IO.Path.GetFileName(fileImg.PostedFile.FileName);
                }
                
                fileImg.PostedFile.SaveAs(Server.MapPath("~/SystemFiles/Users/" + imgFileName));
            }


            Database db=new Database();
            db.AddParameter("@name", txtName.Text);
            db.AddParameter("@phone", txtPhoneNumber.Text);
            db.AddParameter("@img", imgFileName);
            db.AddParameter("@id", u.Id);
            db.ExecuteNonQuery("update users set phone=@phone,name=@name,img=@img where id=@id");


            u.Name = txtName.Text;
            u.Phone = txtPhoneNumber.Text;
            u.Image = imgFileName;


            Session["User"] = u;

            ShowAlert("تم التعديل بنجاح . شكرا لك",MsgType.Success);
            Response.Redirect("PersonalInfo.aspx");

        }
    }

    private bool ValidateData()
    {
        if(string.IsNullOrWhiteSpace(txtName.Text))
        {
            ShowAlert("الرجاء ادخال الاسم", MsgType.Error);
            return false;
        }
        AppFunctions f=new AppFunctions();
        if (!f.IsPhoneValid(txtPhoneNumber.Text))
        {
            ShowAlert("الرجاء التأكد من رقم الهاتف", MsgType.Error);
            return false;
        }
        if(fileImg.HasFile)
        {
            List<string> acceptedExe=new List<string>();
            acceptedExe.Add(".jpg");
            acceptedExe.Add(".gif");
            acceptedExe.Add(".png");
            string exe = System.IO.Path.GetExtension(fileImg.PostedFile.FileName).ToLower();
            if (!acceptedExe.Contains(exe))
            {
                ShowAlert("الرجاء اختيار ملف صورة", MsgType.Error);
                return false;
            }
        }

        return true;
    }
}