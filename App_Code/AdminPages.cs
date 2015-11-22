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


public class AdminPages : System.Web.UI.Page
{



    protected override void OnInit(EventArgs e)
    {

        List<string> admin1 = new List<string>();
        admin1.Add("default.aspx");
        admin1.Add("filelist.aspx");
        admin1.Add("fileop.aspx");
        admin1.Add("filenoticelist.aspx");
        admin1.Add("filenoticeop.aspx");
        admin1.Add("filesattachlist.aspx");
        admin1.Add("filesattachop.aspx");
        admin1.Add("conecteddoclist.aspx");
        admin1.Add("conecteddocop.aspx");

        List<string> admin2 = new List<string>();
        admin2.Add("default.aspx");
        admin2.Add("documentlist.aspx");
        admin2.Add("documentop.aspx");
        


        AdminInfo admin=Session["AdminInfo"] as AdminInfo;
        string pageName = System.IO.Path.GetFileName(Request.PhysicalPath);
        pageName = pageName.ToLower();
        if (pageName.Equals("login.aspx"))
        {
            
        }
        else
        {
            if(admin==null)
            {
                Response.Redirect("login.aspx?url=" + Request.RawUrl);
            }
            else
            {
                if(admin.Permition.Equals("*"))
                {
                    
                }
                else if(admin.Permition.Equals("1"))
                {
                    if(!admin1.Contains(pageName))
                    {
                        Response.Redirect("login.aspx?msg=ليس لديك صلاحيات لمشاهدة هذة الصفحة");
                    }
                }
                else if(admin.Permition.Equals("2"))
                {
                    if (!admin2.Contains(pageName))
                    {
                        Response.Redirect("login.aspx?msg=ليس لديك صلاحيات لمشاهدة هذة الصفحة");
                    }
                }
            }
        }




        base.OnInit(e);
    }
}


    


