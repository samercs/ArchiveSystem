<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Push.aspx.cs" Inherits="Push" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td>
                    Text
                </td>
                <td>
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Button ID="btnSend" runat="server" Text="Send Notification" OnClick="btnSend_Click" />
                </td>
                
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
