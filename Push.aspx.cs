using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Azure.NotificationHubs;

public partial class Push : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSend_Click(object sender, EventArgs e)
    {
        string notificationHubName = "test";
        string notificationHubConnection =
            "Endpoint=sb://orangejetpack.servicebus.windows.net/;SharedAccessKeyName=DefaultFullSharedAccessSignature;SharedAccessKey=uMJHQThBSc1EsIcMms3PyTasVUW1cwhaAdyZSAHraXU=";

        NotificationHubClient hub = NotificationHubClient
    .CreateClientFromConnectionString(notificationHubConnection, notificationHubName);

        var androidNotificationPayload = "{ \"data\" : {\"message\":\"" + TextBox1.Text + "\"}}";

        try
        {
            //var result = await hub.SendGcmNativeNotificationAsync(androidNotificationPayload);
            hub.SendGcmNativeNotificationAsync(androidNotificationPayload)
                .ContinueWith(FailSend, TaskContinuationOptions.OnlyOnFaulted);
            
            Response.Write("Notification has been send");
        }
        catch (System.Exception ex)
        {
            // Write the failure result to the logs.
            Response.Write("Push.SendAsync Error, "+ ex.Message);
        }
    }

    public void FailSend(Task task)
    {
        Response.Write(task.Exception);
    }
}