<%@ Page Title="Cold Drinks Report" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true" CodeBehind="ColdDrinksReport.aspx.cs" Inherits="DFS.Web.Report.ColdDrinksReport" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/UserControls/DateRangeSelectorUserControl.ascx" TagPrefix="DBV" TagName="DateRangeSelectorUserControl" %>
<%@ Register TagPrefix="asp" Namespace="Microsoft.Reporting.WebForms" Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/Plugins/chosen.jquery.js"> </script>
    <link href="../Style/chosen.css" rel="stylesheet" />
    <script src="../Scripts/Forms/ColdDrinks.js"> </script>
   
    <script type="text/javascript">
        function pageLoad(sender, args) { coldDrinks.Init(); }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="text-align: center; position: fixed; left: 50%; bottom: 50%; z-index: 10000;">
        <asp:UpdateProgress ID="updProgressReport" runat="server">
            <ProgressTemplate>
                <img src="/images/ajax-loader.gif" alt="Loading...." />
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>

    <asp:Panel ID="pnlColdDrinksReport" runat="server" GroupingText="Cold Drinks Report">
        <%--   <h2>Cold Drinks Report</h2>--%>
        <i>Select date range and click Search button to generate the report.</i>
        <DBV:DateRangeSelectorUserControl runat="server" ID="DateRangeSelectorUserControl"
                                          EnglishStartEndDateSelectorVisible="false"
                                          NepaliYearMonthSelectorVisible="true"
                                          EnglishYearMonthSelectorVisible="true" />
    </asp:Panel>

    <asp:HiddenField ID="hfColdDrinksPopUp" runat="server" />

    <asp:Panel ID="pnlColdDrinks" runat="server" CssClass="modalPopup" Style="width: 26%; display: none;">
        <select id="selectColdDrinks" class="chosen" multiple="true" style="width: 339px;" runat="server" data-placeholder="Select Cold Drinks">
            <option>Choose Cold Drinks</option>
        </select>
        <br />
        <br />
        <asp:Button ID="btnColdDrinksSave" runat="server" Text="View Report"
                    OnClick="btnColdDrinksSave_Click" />
        <asp:Button ID="btnColdDrinksClose" runat="server" Text="Cancel" CausesValidation="false" OnClick="btnColdDrinksClose_Click" />
    </asp:Panel>

    <asp:ModalPopupExtender ID="mpeColdDrinks" runat="server" BehaviorID="mpeColdDrinks" PopupControlID="pnlColdDrinks"
                            CancelControlID="btnColdDrinksClose" TargetControlID="hfColdDrinksPopUp" BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>
    <asp:HiddenField runat="server" ID="hiddenFieldSearchByNepaliYearMonth" Value="false" />

    <asp:Panel ID="pnlReport" runat="server" Visible="false" Width="100%" BorderWidth="1px" BorderStyle="Solid" BorderColor="#666666">
        <rsweb:ReportViewer ID="reportViewer" AsyncRendering="false" runat="server" Width="100%" Height="500px"
                            WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
        </rsweb:ReportViewer>
    </asp:Panel>
    <div id="_dvContainer"></div>
</asp:Content>