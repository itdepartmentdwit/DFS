<%@ Page Title="Free Food Report" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true" CodeBehind="FreeFoodReport.aspx.cs" Inherits="DFS.Web.Report.FreeFoodReport" %>

<%@ Register Src="~/UserControls/DateRangeSelectorUserControl.ascx" TagPrefix="DBV" TagName="DateRangeSelectorUserControl" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register TagPrefix="cc" Namespace="DFS.Web.CustomControls" Assembly="DFS.Web" %>
<%@ Register TagPrefix="cc" Namespace="DFS.Web.CustomControls" Assembly="DFS.Web" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/Forms/FreeFoodReport.js" type="text/javascript"> </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlDateSelector" runat="server" GroupingText="Free Food Report" CssClass="fivepixelbottommargin">
        <i>Select User Type, date range and click Search button to generate the report.</i><br/><br />
        <strong>User Type</strong>&nbsp;&nbsp;&nbsp;<cc:GroupedDropDownList
                                                        ID="ddlUserType"
                                                        runat="server"
                                                        Style="height: 22px"
                                                        DataTextField="Text"
                                                        DataValueField="Value"
                                                        DataGroupField="Group"
                                                        Visible="True"
                                                        ClientIDMode="Static"
                                                        class="chosen_select">
                                                    </cc:GroupedDropDownList>
        <DBV:DateRangeSelectorUserControl runat="server" ID="DateRangeSelectorUserControl"
                                          EnglishStartEndDateSelectorVisible="true"
                                          NepaliYearMonthSelectorVisible="true"
                                          EnglishYearMonthSelectorVisible="true" />
    </asp:Panel>
    <asp:Panel ID="pnlReport" runat="server" Visible="false" Width="100%" BorderWidth="1px" BorderStyle="Solid" BorderColor="#666666">
        <rsweb:ReportViewer ID="reportViewer" AsyncRendering="false" runat="server" Width="100%" Height="100%" SizeToReportContent="true"
                            WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
        </rsweb:ReportViewer>
    </asp:Panel>
    <div id="_dvContainer"></div>
</asp:Content>