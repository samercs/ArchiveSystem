using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Users
/// </summary>
public class Users
{
    public string Id { get; set; }
    public string Name { get; set; }
    public string UserName { get; set; }
    public string Password { get; set; }
    public string Image { get; set; }
    public string Phone { get; set; }
    public string JobTitle { get; set; }

    public bool RequeriedChangePassword { get; set; }

    public Users()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}