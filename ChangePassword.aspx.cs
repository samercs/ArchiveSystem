using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Kalboard360.ClassCode;

public partial class ChangePassword : UsersPages
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Users u = Session["User"] as Users;
        if(u.RequeriedChangePassword)
        {
            ShowAlert("يجب تغير كلمة السر كي تتمكن من تصفح الموقع",MsgType.Warning);
        }
    }

    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {
        if(ValidateData())
        {
            Users u = Session["User"] as Users;
            Database db=new Database();
            db.AddParameter("@password", txtPassword2.Text);
            db.AddParameter("@id", u.Id);
            db.ExecuteNonQuery("update users set password=@password,RequerChange=0 where id=@id");
            u.RequeriedChangePassword = false;
            u.Password = txtPassword2.Text;
            Session["User"] = u;

            ShowAlert("تم التعديل بنجاح . شكرا لك",MsgType.Success);


        }
    }

    private bool ValidateData()
    {
        if(string.IsNullOrWhiteSpace(txtPassword1.Text))
        {
            ShowAlert("الرجاء ادخال كلمة السر الحالة", MsgType.Error);
            return false;
        }
        Users u = Session["User"] as Users;
        if (! u.Password.Equals(txtPassword1.Text))
        {
            ShowAlert("الرجاء التأكد من كلمة السر الحالة", MsgType.Error);
            return false;
        }
        if(txtPassword2.Text.Length<6)
        {
            ShowAlert("كلمة السر الجديدة يجب ان تكون بطول 6 احرف على الاقل", MsgType.Error);
            return false;
        }
        if(!txtPassword2.Text.Equals(txtPassword3.Text))
        {
            ShowAlert("كلمة السر و تأكدي كلمة السر غير متطابقين", MsgType.Error);
            return false;
        }


        return true;
    }
}