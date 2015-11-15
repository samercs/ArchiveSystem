using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            Database db=new Database();
            var count=db.ExecuteScalar("select count(*) from FileNotice where IsShow=0");
            lblFileNoticeCount.InnerText = count.ToString();
        }
    }
}