<%@ WebHandler Language="C#" Class="updateMsg" %>

using System;
using System.Web;

public class updateMsg : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        if(context.Request.QueryString["id"]!=null)
        {
            Database db=new Database();
            db.AddParameter("@id", context.Request.QueryString["id"]);
            db.ExecuteNonQuery("update msg set isread=1 where id=@id");    
        }
        
        context.Response.Write("message updated");
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}