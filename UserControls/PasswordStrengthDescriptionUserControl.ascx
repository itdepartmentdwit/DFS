<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PasswordStrengthDescriptionUserControl.ascx.cs" Inherits="DFS.Web.UserControls.PasswordStrengthDescriptionUserControl" %>
<div>
    <b>The new password must:</b>
    <ul class="NewPasswordReqList">
        <li class="NewPasswordReqList">be between 8 and 15 characters</li>
        <li class="NewPasswordReqList">contain at least one numeric character</li>
        <li class="NewPasswordReqList">contain at least one special character</li>
        <li class="NewPasswordReqList">contain at least one uppercase and one lower case letter</li>
    </ul>
</div>
<hr />