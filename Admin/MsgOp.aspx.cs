using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_MsgOp : System.Web.UI.Page
{
    string tablename = "Msg";
    string listpage = "MsgList.aspx";
    public string name = "البريد الوارد";
    Dates datets = new Dates();
    Database db = new Database();
    protected void Page_Init(object sender, EventArgs e)
    {
        if (Request.QueryString["id"] == null) Response.Redirect("ContactUsList.aspx");
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            HyperLink2.NavigateUrl = listpage;
            LoadData();
            
        }
    }
    void LoadData()
    {
        db.AddParameter("@id", Request.QueryString["id"]);
        System.Data.DataSet ds = db.ExecuteDataSet("select msg.*,users.username,users.name from " + tablename + " inner join users on (msg.[from]=users.id) where msg.id=@id" + ";update msg set isread=1 where id=@id");
        lblName.Text = ds.Tables[0].Rows[0]["username"].ToString() + " " + ds.Tables[0].Rows[0]["name"].ToString() ;
        lblAddDate.Text = datets.GregToHijri(DateTime.Parse(ds.Tables[0].Rows[0]["AddDate"].ToString()).ToString("d/M/yyyy"), "d/MMM/yyyy");
        lblSubject.Text = ds.Tables[0].Rows[0]["title"].ToString();
        lblTxt.Text = ds.Tables[0].Rows[0]["msg"].ToString();
        ViewState["toid"]= ds.Tables[0].Rows[0]["from"].ToString();

    }


    protected void btnSendMsg_OnClick(object sender, EventArgs e)
    {
        Response.Redirect("SendMsg.aspx?toId=" + ViewState["toid"].ToString() );
    }
}