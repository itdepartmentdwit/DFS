<%@ Page Title="109 Coupons Total Report" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true" CodeBehind="109CouponsTotalReport.aspx.cs" Inherits="DFS.Web.Manage._109CouponsTotalReport" %>

<%@ Register Src="~/UserControls/DateRangeSelectorUserControl.ascx" TagPrefix="DBV" TagName="DateRangeSelectorUserControl" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register TagPrefix="cc" Namespace="DFS.Web.CustomControls" Assembly="DFS.Web" %>
<%@ Register TagPrefix="cc" Namespace="DFS.Web.CustomControls" Assembly="DFS.Web" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/Forms/FreeFoodReport.js" type="text/javascript"> </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlDateSelector" runat="server" GroupingText="109 Coupons Total" CssClass="fivepixelbottommargin">
        <i>Select date range and click Search button to generate the report.</i><br />
        <br />

        <DBV:DateRangeSelectorUserControl runat="server" ID="DateRangeSelectorUserControl"
            EnglishStartEndDateSelectorVisible="true"
            NepaliYearMonthSelectorVisible="true"
            EnglishYearMonthSelectorVisible="true" />
    </asp:Panel>
    <div>
        <table class="rptTable">
            <thead>
                <tr>
                    <td>Customer ID</td>
                    <td>Customer Name</td>
                    <td>109 Orders Quantity</td>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="order109Repeater" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td><%#Eval("UserId") %></td>
                            <td><%#Eval("Name") %></td>
                            <td><%#Eval("OrderQuantity") %></td>
                        </tr>
                    </ItemTemplate>

                </asp:Repeater>
                <tr>
                    <td colspan="2">Total Orders : </td>
                    
                    <td><%=TotalOrderQuantity %></td>
                </tr>
            </tbody>
        </table>
    </div>

    <div id="_dvContainer"></div>
</asp:Content>
