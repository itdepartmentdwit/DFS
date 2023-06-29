<%@ Page Title="Dinner Report" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true" CodeBehind="DinnerReport.aspx.cs" MaintainScrollPositionOnPostback="true" Inherits="DFS.Web.Report.DinnerReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Src="~/UserControls/DateRangeSelectorUserControl.ascx" TagPrefix="DBV" TagName="DateRangeSelectorUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/Forms/Dinner.js" type= "text/javascript"> </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlDinnerReport" runat="server" GroupingText="Dinner Report">        
        <i>Select date range and click Search button to generate the report.</i>
        <DBV:DateRangeSelectorUserControl runat="server" ID="DateRangeSelectorUserControl"
                                          EnglishStartEndDateSelectorVisible="true"
                                          NepaliYearMonthSelectorVisible="true"
                                          EnglishYearMonthSelectorVisible="true" />
    </asp:Panel>
    <asp:Panel ID="pnlReport" runat="server" Visible="false" Width="100%" BorderWidth="1px" BorderStyle="Solid" BorderColor="#666666">
        <rsweb:ReportViewer ID="reportViewer" AsyncRendering="false" runat="server" Width="100%" Height="400px"
                            WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
        </rsweb:ReportViewer>
    </asp:Panel>
    <div id="_dvContainer"></div>
    <asp:HiddenField runat="server" ID="hiddenFieldSearchByNepaliYearMonth" Value="false" />
</asp:Content>