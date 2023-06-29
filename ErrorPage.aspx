<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ErrorPage.aspx.cs" Inherits="CMS.ErrorPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title></title>
        <style type="text/css">
            .style1 { text-decoration: none; }
        </style>
    </head>
    <body>
        <form id="form1" runat="server">
            <div>
                <h1>
                    An Error Has Occured!
                </h1>
            </div>
            <asp:HyperLink ID="hlnkSuportEmail" runat="server" CssClass="style1">
                <span class="style1">
                    <asp:Label ID="lblSupportEmail" runat="server"></asp:Label></span>
            </asp:HyperLink>

            <h4><a  href="login.aspx" >Go Home Page</a></h4>
        </form>
    </body>
</html>