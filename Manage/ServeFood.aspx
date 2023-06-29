<%@ Page Language="C#" AutoEventWireup="true" Title="Serve Queue" CodeBehind="ServeFood.aspx.cs" Inherits="DFS.Web.ManageFood.ServeFood" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <script src="/Scripts/Plugins/jquery-1.7.2.min.js" type="text/javascript"> </script>
        <script src="/Scripts/Plugins/jquery.textfill.min.js"> </script>
        <script src="/Scripts/Forms/ServeFood.js" type="text/javascript"> </script>
        <link rel="shortcut icon" href="images/favicon.png" />
        <link href="/Style/serve.css" rel="stylesheet" />
        <script type="text/javascript">
            $(document).ready(function() {
                serveFood.Init();
                setInterval(serveFood.LoadGrids, 30000);

                $(window).resize(function() {
                    $('#content').css("height", "100%");
                });
            });
        </script>
    </head>
    <body>
        <div id="content">
            <div id="_containerReadyOrders">
            </div>
            <div id="_containerOnProcessOrders">
                <div id="_containerServeLeft">
                </div>
                <div id="_containerServeRight">
                </div>
            </div>
        </div>
    </body>
</html>