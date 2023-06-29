<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/DFS.Master"
         AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="DFS.Web.Account.ChangePassword"
         EnableEventValidation="false" %>

<%@ Register Src="~/UserControls/PasswordStrengthDescriptionUserControl.ascx" TagPrefix="DBV" TagName="PasswordStrengthDescriptionUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="text-align: center; position: fixed; left: 50%; bottom: 50%; z-index: 10000;">
        <asp:UpdateProgress ID="updProgressReport" runat="server">
            <ProgressTemplate>
                <img src="images/ajax-loader.gif" alt="Loading...." />
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>
    <asp:UpdatePanel ID="updpnlChange" runat="server">
        <ContentTemplate>
            <div class="ChangePasswordContainer">
                <DBV:PasswordStrengthDescriptionUserControl runat="server" ID="PasswordStrengthDescriptionUserControl" />
                <table>
                    <tr>
                        <td align="right">
                            <asp:Label ID="lblOldPassword" runat="server" Text="Old Password" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtOldPassword" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvOldPassword" runat="server" ErrorMessage="Old password is required."
                                                        ControlToValidate="txtOldPassword" ForeColor="Red" ValidationGroup="p">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="lblNewPassword" runat="server" Text="New Password" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" ValidateRequestMode="Disabled"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNewPassord" runat="server" ErrorMessage="New password is required."
                                                        ControlToValidate="txtNewPassword" ForeColor="Red" ValidationGroup="p" Display="Dynamic">*</asp:RequiredFieldValidator>
                            <ajaxToolkit:PasswordStrength ID="PasswordStrength1" runat="server"
                                                          TargetControlID="txtNewPassword"
                                                          PreferredPasswordLength="8"
                                                          MinimumNumericCharacters="1"
                                                          MinimumSymbolCharacters="1"
                                                          RequiresUpperAndLowerCaseCharacters="true"
                                                          MinimumLowerCaseCharacters="1"
                                                          MinimumUpperCaseCharacters="1"
                                                          StrengthIndicatorType="Text"
                                                          TextStrengthDescriptions="Very Poor;Weak;Average;Strong;Excellent"
                                                          StrengthStyles="VeryWeekStrength;WeakStrength;AverageStrength;GoodStrength;ExcellentStrength" />
                            <asp:CustomValidator ID="PasswordReqCustomValidator" runat="server"
                                                 ErrorMessage="Password does not meet the requirements."
                                                 Text="*"
                                                 ForeColor="Red"
                                                 ControlToValidate="txtNewPassword"
                                                 OnServerValidate="PasswordReqCustomValidator_ServerValidate"
                                                 ValidationGroup="p"
                                                 Display="Dynamic">
                            </asp:CustomValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="lblConfirm" runat="server" Text="Confirm Password" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" ValidateRequestMode="Disabled"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ErrorMessage="Confirm password is required."
                                                        ControlToValidate="txtConfirm" ForeColor="Red" ValidationGroup="p">*</asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="cvConfirmPassword" runat="server" ErrorMessage="Password and confirm password doesn't match."
                                                  ControlToCompare="txtNewPassword" ControlToValidate="txtConfirm" ForeColor="Red"
                                                  ValidationGroup="p">*</asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:Button ID="btnUpdate" runat="server" OnClick="UpdatePassword" Text="Update"
                                        ValidationGroup="p" Width="100px" CssClass="btn" />
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="p"
                                                   ForeColor="Red" Font-Size="12px" />
                            <asp:Label ID="lblMessage" runat="server" ForeColor="red"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>