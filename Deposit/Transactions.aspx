<%@ Page Title="Transactions" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true" CodeBehind="Transactions.aspx.cs" Inherits="DFS.Web.Deposit.Transactions1" %>
<%@ Register Src="~/UserControls/DateRangeSelectorUserControl.ascx" TagPrefix="DBV" TagName="DateRangeSelectorUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/Plugins/chosen.jquery.js"> </script>
    <link href="../Style/chosen.css" rel="stylesheet" />
  
    <script type="text/javascript">

        $(document).ready(function() {
            $(".chosen_select").chosen({ allow_single_deselect: true });
        });

        function pageLoad() {
            $(".chosen_select").chosen({ allow_single_deselect: true });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlDateSelector" runat="server" GroupingText="Search" CssClass="fivepixelbottommargin">
        <asp:DropDownList
            runat="server"
            ID="ddlEmail"
            ClientIDMode="Static"
            Width="300"
            CssClass="chosen_select">
        </asp:DropDownList>
        <DBV:DateRangeSelectorUserControl runat="server" ID="DateRangeSelectorUserControl"
                                          EnglishStartEndDateSelectorVisible="true"
                                          NepaliYearMonthSelectorVisible="true"
                                          EnglishYearMonthSelectorVisible="true" />
    </asp:Panel>
    
    <asp:GridView ID="gvTransaction" runat="server" ForeColor="#333333" AutoGenerateColumns="False"   Width="100%"  GridLines="Both"  CssClass="Grid" Style="table-layout: auto;"
                  CellPadding="4"  >
        <AlternatingRowStyle ForeColor="#284775" BackColor="White" />
        <EmptyDataTemplate>
            <itemtemplate>No results were found !</itemtemplate>
        </EmptyDataTemplate>
        <Columns>
            <asp:BoundField DataField="DFSID" HeaderText="DFSID" SortExpression="DFSID" />
            <asp:BoundField DataField="DepositDate" HeaderText="Transaction Date" SortExpression="depositdate" />
            <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="amount" DataFormatString="{0:0.00}" />
            <asp:BoundField DataField="Balance" HeaderText="Balance" SortExpression="balance"
                            DataFormatString="{0:0.00}" />
            <asp:BoundField DataField="VoucherNumber" HeaderText="Voucher No" SortExpression="voucherno" />
            <asp:BoundField DataField="IsDeposit" HeaderText="IsDeposit" SortExpression="IsDeposit" />
            <asp:TemplateField Visible="false">
            </asp:TemplateField>
        </Columns>
                                                 
        <EditRowStyle BackColor="#999999" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center"/>
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
   
    <asp:Button ID="btnGenerateReportCM" runat="server" Text=""
                Style="cursor: pointer" ToolTip="Export to Excel" OnClick="btnGenerateReportCM_Click"  />
</asp:Content>