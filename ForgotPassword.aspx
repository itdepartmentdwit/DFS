<%@ Page Language="C#" Title="Retrieve Password - Deerwalk Foods System" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs"
         Inherits="DFS.Web.ForgotPassword" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <title>Forgot Password?</title>
        <link href="/Style/forgot-password.css" rel="stylesheet" type="text/css" />
        <link href="Style/jquery.jnotify.css" rel="stylesheet" type="text/css" />
        <script src="Scripts/Plugins/jquery-1.7.2.min.js" type="text/javascript"> </script>
        <script src="Scripts/Plugins/jquery.jnotify.js" type="text/javascript"> </script>
        <link rel="shortcut icon" href="images/favicon.png" />
    </head>
    <body style="border-top: 8px solid #E75E0E; margin: 0;">
        <form id="form1" runat="server">
            <asp:ScriptManager runat="server">
            </asp:ScriptManager>
            <asp:UpdateProgress ID="updProgressFeedback" runat="server" AssociatedUpdatePanelID="upForgotPass">
                <ProgressTemplate>
                    <div style="text-align: center; position: fixed; left: 50%; bottom: 50%; z-index: 10000;">
                        <img src="images/ajax-loader.gif" alt="Loading...." />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:UpdatePanel ID="upForgotPass" runat="server">
                <ContentTemplate>
                    <div class="forgot-pass">
                        <div class="inside-forgot" style="background-color: White">
                            <table cellpadding="0" cellspacing="10">
                                <tr>
                                    <td style="width: 100px;">
                                        <b>Enter email</b>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtEmailadd" runat="server" CssClass="txt-field"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="rfvEmailadd" runat="server" ErrorMessage="Email is required."
                                                                    ControlToValidate="txtEmailadd" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="rexEmailadd" Display="Dynamic" runat="server"
                                                                        ControlToValidate="txtEmailadd" ErrorMessage="Email is not valid." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                                        ForeColor="Red"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <asp:Button ID="btnSubmit" runat="server" OnClick="Submit" Text="Submit" CssClass="btn"
                                                    Style="padding: 3px;" />
                                    </td>
                                    <td></td>
                                </tr>
                            </table>
                        </div>
                    </div>

                </ContentTemplate>
            </asp:UpdatePanel>
        </form>
    </body>
</html>