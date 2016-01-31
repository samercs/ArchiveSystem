using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MainMasterPage : System.Web.UI.MasterPage
{
    

   

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            Tools t = new Tools();
            if (t.IsUserLogin(Session))
            {
                Users u = Session["User"] as Users;
                LoadMsg();
                Database db = new Database();
                db.AddParameter("@id", u.Id);
                object count = db.ExecuteScalar("select count(*) from msg  where msg.toid=@id and msg.isread=0");
                int tmp;
                if (int.TryParse(count.ToString(), out tmp))
                {
                    if (tmp != 0)
                    {
                        lblMsgCount.InnerText = tmp.ToString();
                    }
                    else
                    {
                        lblMsgCount.InnerHtml = "";
                    }

                }

                UserSesction1.Visible = true;
                UserSection2.Visible = true;
                UserLoginSection1.Visible = false;
            }
            else
            {
                profileLink.Visible = false;
                favLink.Visible = false;
                ProfileLink2.Visible = false;
                FavLink2.Visible = false;

                menu.Attributes["class"] += " extended";
            }
            
        }
    }

    private void LoadMsg()
    {
        Users u = Session["User"] as Users; ;
        Database db = new Database();
        db.AddParameter("@to", u.Id);
        DataTable dt = db.ExecuteDataTable("select top(5) msg.*,Users.name as username from (Msg left join users on (users.id=msg.[from]) ) where msg.ToId=@to order by msg.Id desc");
        ListView1.DataSource = dt;
        ListView1.DataBind();
    }

    protected void btnSendMsg_OnClick(object sender, EventArgs e)
    {
        if(ValidateData())
        {
            string baseClass = "alert msgBox text-center";
            Users u=Session["User"] as Users;
            Database db=new Database();
            db.AddParameter("@from", u.Id);
            db.AddParameter("@title", txtTitle.Text);
            db.AddParameter("@msg", txtMsg.Text);
            db.ExecuteNonQuery("insert into msg([from],title,msg) values(@from,@title,@msg)");
            msg.CssClass = baseClass + " alert-success";
            msg.Visible = true;
            lblMsg.Text = "تم ارسال الرسالة بنجاح";

        }
    }

    private bool ValidateData()
    {
        return true;
    }

    protected void ListView1_OnPagePropertiesChanged(object sender, EventArgs e)
    {
        LoadMsg();
    }
}
