<%@ Page Language="C#" Title="Reset Password - Deerwalk Foods System" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="DFS.Web.ResetPassword" %>

<%@ Register Src="~/UserControls/PasswordStrengthDescriptionUserControl.ascx" TagPrefix="DBV" TagName="PasswordStrengthDescriptionUserControl" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <title>Reset Password</title>
        <link href="Style/Style.css" rel="stylesheet" type="text/css" />
        <link href="Style/jquery.jnotify.css" rel="stylesheet" type="text/css" />
        <script src="Scripts/Plugins/jquery-1.7.2.min.js" type="text/javascript"> </script>
        <script src="Scripts/Plugins/jquery.jnotify.js" type="text/javascript"> </script>
        <link rel="shortcut icon" href="images/favicon.png" />
    </head>
    <body style="border-top: 8px solid #E75E0E; margin: 0;">
        <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
            </asp:ScriptManager>
            <div class="ChangePasswordContainer" id="ChangePasswordContainer" runat="server" visible="false" >
                <DBV:PasswordStrengthDescriptionUserControl runat="server" ID="PasswordStrengthDescriptionUserControl" />
                <table>
                    <tr>
                        <td align="right">
                            <b>New Password</b>
                        </td>
                        <td>
                            <asp:TextBox ID="txtNewPassword" runat="server" CssClass="txt-field" TextMode="Password" ValidateRequestMode="Disabled"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtNewPassword"
                                                        ErrorMessage="New Password is required." ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
                            <ajaxToolkit:PasswordStrength ID="psPasswordStrength" runat="server"
                                                          TargetControlID="txtNewPassword"
                                                          PreferredPasswordLength="8"
                                                          MinimumNumericCharacters="1"
                                                          MinimumSymbolCharacters="1"
                                                          RequiresUpperAndLowerCaseCharacters="true"
                                                          MinimumLowerCaseCharacters="1"
                                                          MinimumUpperCaseCharacters="1"
                                                          StrengthIndicatorType="Text"
                                                          TextStrengthDescriptions="Very Poor;Weak;Average;Strong;Excellent"
                                                          StrengthStyles="VeryWeekStrength;WeakStrength; AverageStrength;GoodStrength;ExcellentStrength" />
                            <asp:CustomValidator ID="PasswordReqCustomValidator" runat="server"
                                                 ErrorMessage="Password does not meet the requirements."
                                                 Text="*"
                                                 ForeColor="Red"
                                                 ControlToValidate="txtNewPassword"
                                                 OnServerValidate="PasswordReqCustomValidator_ServerValidate"
                                                 Display="Dynamic">
                            </asp:CustomValidator>

                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <b>Confirm Password</b>
                        </td>
                        <td>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="txt-field" TextMode="Password" ValidateRequestMode="Disabled"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                                                        ErrorMessage="Confirm Password is required." ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="cvPasswordMatch" runat="server" ControlToCompare="txtNewPassword"
                                                  ControlToValidate="txtConfirmPassword" ErrorMessage="Passwords do not match."
                                                  ForeColor="Red" Display="Dynamic">*</asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:Button ID="btnSubmit" runat="server" Text="Reset" CssClass="btn" Style="padding: 3px; margin-top: 5px; width: 100px;"
                                        OnClick="Submit" />
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" Font-Size="12px" />
                            <asp:Label ID="lblStatus" runat="server" Text="" Style="color: #FF0000">
                            </asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </body>
</html>