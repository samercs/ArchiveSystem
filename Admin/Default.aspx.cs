﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Default : AdminPages
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            Database db=new Database();
            var count=db.ExecuteScalar("select count(*) from FileNotice where IsShow=0");
            if (int.Parse(count.ToString()) > 0)
            {
                lblFileNoticeCount.InnerText = String.Format("لديك {0} بلاغ جديد", count.ToString());
            }

            count = db.ExecuteScalar("select count(*) from FileComment where Status=0");
            if (int.Parse(count.ToString()) > 0)
            {
                lblFileCommentCount.InnerText = String.Format("لديك {0} تعليقات غير مفعل", count.ToString());
            }

            count = db.ExecuteScalar("select count(*) from Users where IsActive=0");
            if (int.Parse(count.ToString()) > 0)
            {
                lblUsersCount.InnerText = String.Format("لديك {0} مستخدم غير مفعل", count.ToString());
            }

            count = db.ExecuteScalar("select count(*) from Msg inner join users on (msg.[from]=users.id) where isNull(msg.toid,-1)=-1 and msg.IsRead=0");
            if (int.Parse(count.ToString()) > 0)
            {
                lblMsgCount.InnerText = String.Format("لديك {0} رسالة جديدة", count.ToString());
            }

        }
    }
}