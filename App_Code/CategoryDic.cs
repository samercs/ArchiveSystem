using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CategoryDic
/// </summary>
public class CategoryDic
{
    public Dictionary<string,string> Dictionary { get; set; } 

    public CategoryDic()
    {
        Dictionary = new Dictionary<string, string>();
        Dictionary.Add("1", "فئة المعاملة");
        Dictionary.Add("2", "سرية المعاملة ");
        Dictionary.Add("3", "الوضع القانوني للمعاملة");
        Dictionary.Add("4", "انواع البلاغات");
        Dictionary.Add("5", "المجال - الملفات");
    }

    
}