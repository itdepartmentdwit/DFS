<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="DFS.Web.Login" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Deerwalk Foods System</title>
    <asp:PlaceHolder runat="server">
        <%: Styles.Render("~/Content/css") %>
    </asp:PlaceHolder>

    <link rel="shortcut icon" href="images/favicon.png" />

    <style type="text/css">
        .style1 {
            color: #808080;
        }

        .style2 {
            text-decoration: none;
        }

        .fixed label {
            padding: 2px 0 0 0;
        }
    </style>
</head>
<body style="background-image: none; border-top: 8px solid #E75E0E;">
    <form id="form2" runat="server" defaultfocus="txtUsername">
        <div class="login">
            <div>
                <div class="apk">
                </div>
                <div style="clear: right">
                </div>
            </div>
            <a href="http://deerwalkfoods.com" class="pfix" target="_blank">Deerwalk Foods</a><br />
            <h1></h1>
            <table cellpadding="0" cellspacing="10" width="100%">
                <tr>
                    <td></td>
                    <td colspan="2" style="text-align: left; color: Red; font-size: 15px; font-style: italic;">
                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" ValidationGroup="login" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblUsername" runat="server" Text="Username"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtUsername" runat="server" autocomplete="off"></asp:TextBox>
                        <asp:HiddenField ID="hidTest" runat="server" Value="SomeValue" />
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" Display="None" ErrorMessage="Username is required."
                            ControlToValidate="txtUsername" ValidationGroup="login" ForeColor="Red" Font-Size="12px">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator1" ControlToValidate="txtUsername"
                            ForeColor="Red" Display="None" ErrorMessage="Email is not valid." ValidationGroup="login"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" ValidateRequestMode="Disabled"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="rfvPassword" Display="None" runat="server" ErrorMessage="Password is required."
                            ControlToValidate="txtPassword" ValidationGroup="login" ForeColor="Red" Font-Size="12px">*</asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvValidateLogin" runat="server"
                            ValidationGroup="login" Display="None"></asp:CustomValidator>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnLogin" runat="server" Text="Sign in" ValidationGroup="login" OnClick="CheckLogin" />
                        <asp:CheckBox ID="chkRememberMe" runat="server" Text="Remember me" />
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:HyperLink runat="server" ID="hlnkForgotPassword" Text="Forgot Password?" Font-Size="14px"
                            NavigateUrl="~/ForgotPassword.aspx"></asp:HyperLink>
                    </td>
                    <td></td>
                </tr>
                <% if (ShowApkDownloadSection)
                    { %>
                <tr>
                    <td colspan="3" align="center">
                        <div style="padding: 0 0 10px 7px">
                            <asp:LinkButton ID="lnkdwnload" runat="server" CssClass="dwnloadapk" Text="Download DFS for Android"
                                OnClick="lnkdwnload_Click">
                                <asp:Image ID="img" runat="server" ImageUrl="~/images/download_anaroid_App.png" />
                            </asp:LinkButton>
                        </div>
                    </td>
                </tr>
                <% }
                %>
                <tr>
                    <td colspan="3" style="text-align: center; padding: 5px 0 0 0;">
                        <span>For support, email to </span>
                        <asp:HyperLink ID="hlnkSuportEmail" runat="server" CssClass="style2">
                            <span class="style1">
                                <asp:Label ID="lblSupportEmail" runat="server"></asp:Label></span>
                        </asp:HyperLink>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="text-align: center;">
                        <asp:Label ID="lblVersion" runat="server" Font-Size="10px"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
