using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    private readonly Tools t;

    public MasterPage()
    {
        t=new Tools();
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Database db=new Database();
            db.AddParameter("@pageKey", "ContactUs");
            DataTable dt = db.ExecuteDataTable("select * from Pages where PageKey=@pageKey");
            if (dt.Rows.Count > 0)
            {
                Repeater1.DataSource = dt;
                Repeater1.DataBind();
            }
            db.LoadDDL("Filetarget","title",ref ddlField,"المجال");
            db.LoadDDL("country", "name", ref ddlCountry, "الدولة", "lang=2");
            if (!t.IsUserLogin(Session))
            {
                mainContainerBody.Attributes["class"] += " extended";
            }
            else
            {
                Panel1.Visible = true;
            }
            
        }
    }

    protected void btnSearchFile_OnClick(object sender, EventArgs e)
    {
        Dates datets = new Dates();
        if (string.IsNullOrWhiteSpace(txtFileName.Text) && ddlField.SelectedValue.Equals("-1") && ddlCountry.SelectedValue.Equals("-1") &&
            string.IsNullOrWhiteSpace(txtDate.Text) && string.IsNullOrWhiteSpace(txtNo1.Text) && string.IsNullOrWhiteSpace(txtNo2.Text))
        {
            DivError.Visible = true;
            lblError.Text = "الرجاء ادخال قيم البحث";
            return;
        }

        DivError.Visible = false;

        DateTime tmp;
        int no1, no2;
        if (!string.IsNullOrWhiteSpace(txtFileName.Text) ||
            DateTime.TryParseExact(datets.HijriToGreg(txtDate.Text, "d/M/yyyy"), "d/M/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out tmp) || !ddlField.SelectedValue.Equals("-1") || !ddlCountry.SelectedValue.Equals("-1") || int.TryParse(txtNo1.Text,out no1) || int.TryParse(txtNo2.Text, out no2))
        {
            Response.Redirect(String.Format("SearchFile.aspx?name={0}&date={1}&category={2}&no={3}&country={4}",txtFileName.Text,txtDate.Text,ddlField.SelectedValue,txtNo1.Text+"/"+txtNo2.Text,ddlCountry.SelectedValue));
        }
    }

    protected void btnSearchUsers_OnClick(object sender, EventArgs e)
    {
        if (string.IsNullOrWhiteSpace(txtUserName.Text) && string.IsNullOrWhiteSpace(txtJobTitle.Text) && string.IsNullOrWhiteSpace(txtOrganization.Text))
        {
            DivError2.Visible = true;
            lblError2.Text = "الرجاء ادخال قيم البحث";
            return;
        }
        DivError2.Visible = false;

        if (!string.IsNullOrWhiteSpace(txtUserName.Text) || !string.IsNullOrWhiteSpace(txtJobTitle.Text) || !string.IsNullOrWhiteSpace(txtOrganization.Text))
        {
            Response.Redirect(String.Format("SearchUser.aspx?name={0}&jobTitle={1}&organization={2}", txtUserName.Text, txtJobTitle.Text,txtOrganization.Text));
        }
    }
}
