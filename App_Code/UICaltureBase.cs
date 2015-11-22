using Microsoft.VisualBasic;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Globalization;
using System.Resources;
using System.Threading;
using System.Reflection;
using System.Web;
using System.Web.UI.WebControls;


public class UICaltureBase : System.Web.UI.Page
{
    protected override void InitializeCulture()
    {
        string pageName = System.IO.Path.GetFileName(Request.PhysicalPath);
        pageName = pageName.ToLower();
        if (!(pageName.Equals("login.aspx") || pageName.Equals("forgetpassword.aspx")) && Session["User"] == null)
        {
            Response.Redirect("login.aspx?url=" + Request.RawUrl);
        }

        HttpCookie CultureCookie = Request.Cookies["ASLang"];

        CultureInfo ci;
        if (CultureCookie == null)
        {
            ci = new CultureInfo("ar-JO");
        }
        else
        {
            ci = new CultureInfo(CultureCookie.Value);
        }
        Thread.CurrentThread.CurrentCulture = ci;
        Thread.CurrentThread.CurrentUICulture = ci;
        base.InitializeCulture();
        switch (Page.Culture)
        {
            case "Arabic (Jordan)":
                Page.Theme = "Ar";
                break;
            default:
                Page.Theme = "En";
                break;
        }


    }


    public void ShowAlert(string text, MsgType msgType)
    {
        string baseClass = "alert msgBox text-center";
        Panel panel = Master.FindControl("msg") as Panel;
        Label lbl = Master.FindControl("lblMsg") as Label;
        if (panel == null)
        {
            panel = Master.Master.FindControl("msg") as Panel;
            lbl = Master.Master.FindControl("lblMsg") as Label;
        }
        panel.Visible = true;
        switch (msgType)
        {
            case MsgType.Success:
                panel.CssClass = baseClass + " alert-success";
                break;
            case MsgType.Error:
                panel.CssClass = baseClass + " alert-danger";
                break;
            case MsgType.Warning:
                panel.CssClass = baseClass + " alert-warning";
                break;

        }
        
        lbl.Text = text;

    }
}

public enum MsgType
{
    Success = 1,
    Error = 2,
    Warning = 3
}


