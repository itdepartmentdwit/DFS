<%@ Page Title="Sales Report" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true" CodeBehind="SalesReport.aspx.cs" Inherits="DFS.Web.Report.SalesReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Src="~/UserControls/DateRangeSelectorUserControl.ascx" TagPrefix="DBV" TagName="DateRangeSelectorUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/Forms/Sales.js" type= "text/javascript"> </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlSalesReport" runat="server" GroupingText="Sales Report" Height="100%">
        <i>Select date range and click Search button to generate the report.</i>
        <DBV:DateRangeSelectorUserControl runat="server" ID="DateRangeSelectorUserControl"
                                          EnglishStartEndDateSelectorVisible="true"
                                          NepaliYearMonthSelectorVisible="true"
                                          EnglishYearMonthSelectorVisible="true" />
    </asp:Panel>
    <asp:Panel ID="pnlReport" runat="server" Visible="false" Width="100%" Height="100%" BorderWidth="1px" BorderStyle="Solid" BorderColor="#666666">
             <rsweb:reportviewer id="reportViewer" asyncrendering="True" runat="server" width="100%" height="100%" SizeToReportContent="True"
                            waitmessagefont-names="Verdana" waitmessagefont-size="14pt">
        </rsweb:reportviewer>
    </asp:Panel>
    <div id="_dvContainer"></div>
    <asp:HiddenField runat="server" ID="hiddenFieldSearchByNepaliYearMonth" Value="false" />
</asp:Content>