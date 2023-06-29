<%@ Page Title="Hot Drinks Report" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true"
         CodeBehind="HotDrinksReport.aspx.cs" Inherits="DFS.Web.Report.HotDrinksReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/UserControls/DateRangeSelectorUserControl.ascx" TagPrefix="DBV" TagName="DateRangeSelectorUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function Notification() {
            DFS.Notification.Dialog("No data found", "_dvContainer", "No records were found with selected parameters.", 380, DFS.Enum.DialogEnum.Warning, '', null);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlHotDrinksReports" runat="server" GroupingText="Hot Drinks Report">
        <i>Select date range and click Search button to generate the report.</i>
        <DBV:DateRangeSelectorUserControl runat="server" ID="DateRangeSelectorUserControl"
                                          EnglishStartEndDateSelectorVisible="true"
                                          NepaliYearMonthSelectorVisible="true"
                                          EnglishYearMonthSelectorVisible="true" />
    </asp:Panel>
    <asp:Panel ID="pnlReport" runat="server" Visible="false" Width="100%" BorderWidth="1px" BorderStyle="Solid" BorderColor="#666666">
        <rsweb:ReportViewer ID="reportViewer" AsyncRendering="false" runat="server" Width="100%" Height="500px"
                            WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
        </rsweb:ReportViewer>
        <%-- <rsweb:ReportViewer ID="ReportViewer1" runat="server"></rsweb:ReportViewer> --%>
    </asp:Panel>
    <div id="_dvContainer"></div>
</asp:Content>