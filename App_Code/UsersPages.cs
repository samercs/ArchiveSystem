namespace Kalboard360.ClassCode
{
    public class UsersPages : UICaltureBase
    {
        protected override void InitializeCulture()
        {
            base.InitializeCulture();
            Tools t =new Tools();
            if (!t.IsUserLogin(Session))
            {
                Response.Redirect("~/login.aspx?url=" + Request.RawUrl);
            }
        }
    }
}