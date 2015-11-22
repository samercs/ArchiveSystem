using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSearchFile_OnClick(object sender, EventArgs e)
    {

        if (string.IsNullOrWhiteSpace(txtFileName.Text) && string.IsNullOrWhiteSpace(txtTarget.Text) &&
            string.IsNullOrWhiteSpace(txtDate.Text))
        {
            DivError.Visible = true;
            lblError.Text = "الرجاء ادخال قيم البحث";
            return;
        }

        DivError.Visible = false;

        DateTime tmp;
        if (!string.IsNullOrWhiteSpace(txtFileName.Text) ||
            DateTime.TryParseExact(txtDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None,
                out tmp) || !string.IsNullOrWhiteSpace(txtTarget.Text))
        {
            Response.Redirect(String.Format("SearchFile.aspx?name={0}&date={1}&category={2}",txtFileName.Text,txtDate.Text,txtTarget.Text));
        }
    }

    protected void btnSearchUsers_OnClick(object sender, EventArgs e)
    {
        if (string.IsNullOrWhiteSpace(txtUserName.Text) && string.IsNullOrWhiteSpace(txtJobTitle.Text))
        {
            DivError2.Visible = true;
            lblError2.Text = "الرجاء ادخال قيم البحث";
            return;
        }
        DivError2.Visible = false;

        if (!string.IsNullOrWhiteSpace(txtUserName.Text) || !string.IsNullOrWhiteSpace(txtJobTitle.Text))
        {
            Response.Redirect(String.Format("SearchUser.aspx?name={0}&jobTitle={1}", txtUserName.Text, txtJobTitle.Text));
        }
    }
}
