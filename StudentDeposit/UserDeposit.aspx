<%@ Page Title="Users Deposit" Language="C#" AutoEventWireup="true" MasterPageFile="~/DFS.Master" CodeBehind="UserDeposit.aspx.cs" Inherits="DFS.Web.StudentDeposit.UserDeposit" %>

<%@ Register Src="~/UserControls/DateRangeSelectorUserControl.ascx" TagPrefix="DBV" TagName="DateRangeSelectorUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="../Scripts/Plugins/chosen.jquery.js"> </script>
    <link href="../Style/chosen.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            $(".chosen_select").chosen({ allow_single_deselect: true });
        });

        function pageLoad() {
            $(".chosen_select").chosen({ allow_single_deselect: true });
        }

        function Clear() {
            var labelObj = document.getElementById("<%= lblBalance.ClientID %>");
            labelObj.value = "";

            labelObj.value = "";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="bottom: 50%; left: 50%; position: fixed; text-align: center; z-index: 10000;">
        <asp:UpdateProgress ID="updProgressUserDeposit" runat="server" AssociatedUpdatePanelID="upanelDeposits">
            <ProgressTemplate>
                <img src="../images/ajax-loader.gif" alt="Loading...." />
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>
    <asp:UpdatePanel ID="upanelDeposits" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <div class="deposit_item">               
                <asp:LinkButton ID="lnkAddStudentDeposit" runat="server" CssClass="dfs-btn dfs-btn-blue" OnClick="lnkAddStudentDeposit_Click">Add DSS Student Deposit</asp:LinkButton>
                <br />
                <div style="margin-top: 8px;">
                    <asp:Panel ID="pnlDateSelector" runat="server" GroupingText="Search" CssClass="fivepixelbottommargin">
                        <asp:DropDownList
                            runat="server"
                            ID="ddlEmail"
                            ClientIDMode="Static"
                            Width="300"
                            class="chosen_select">
                        </asp:DropDownList>
                        <DBV:DateRangeSelectorUserControl runat="server" ID="DateRangeSelectorUserControl"
                            EnglishStartEndDateSelectorVisible="true"
                            NepaliYearMonthSelectorVisible="true"
                            EnglishYearMonthSelectorVisible="true" />
                    </asp:Panel>
                    <asp:GridView ID="gvDeposits" runat="server" ForeColor="#333333" AutoGenerateColumns="False" AllowPaging="True" GridLines="Both" CssClass="Grid" Width="100%"
                        OnPageIndexChanging="gvDeposits_PageIndexChanging" CellPadding="4" PagerSettings-Mode="NumericFirstLast" OnRowCommand="gvDeposits_RowCommand">
                        <AlternatingRowStyle ForeColor="#284775" BackColor="White" />
                        <EmptyDataTemplate>
                            <itemtemplate>No results were found !</itemtemplate>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:TemplateField Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lbldwituserdeposit_id" Text='<%#Eval("DSSStudentDepositID") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="DWITUserDepositID" HeaderText="DWITUserDepositID" SortExpression="DWITUserDepositID"
                                Visible="false" />
                            <asp:TemplateField HeaderText="DFS ID" SortExpression="DFSID">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lblCanteenID" runat="server" Text='<%#Eval("DFSID") %>' ToolTip="View Curerent Balance"
                                        CommandArgument='<%#Eval("DFSID") %>' CommandName="View" CssClass="lbtnEmpIDClass"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
                            <asp:BoundField DataField="MiddleName" HeaderText="Middle Name" SortExpression="MiddleName" />
                            <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                            <asp:BoundField DataField="Email" HeaderText="Email Address" SortExpression="email" />
                            <asp:BoundField DataField="Amount" HeaderText="Deposited Amount" SortExpression="amount"
                                DataFormatString="{0:0.00}" />
                            <asp:BoundField DataField="DepositDate" HeaderText="Deposit Date" SortExpression="DepositDate" />
                            <asp:BoundField DataField="VoucherNo" HeaderText="Voucher No" SortExpression="VoucherNo" />
                            <asp:TemplateField Visible="false">
                                <ItemStyle Width="50px" />
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" ID="lnkItemEdit" CommandArgument='<%#Eval("DSSStudentDepositID") %>'
                                        ToolTip="Edit deposit details" CommandName="CmdEdit">
                                        <img src="/images/edit.png" alt="Edit" />
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EditRowStyle BackColor="#999999" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" CssClass="GridHeader" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" CssClass="GridPager" />
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                    </asp:GridView>
                </div>
                <%
                    if (gvDeposits.PageCount > 0)
                    { %>
                <p class="paginginfo">
                    You are viewing page <%= gvDeposits.PageIndex + 1 %> of <%= gvDeposits.PageCount %>
                </p>
                <% }
                %>
            </div>
            <div class="clear"></div>
            <asp:HiddenField ID="btnHidden" runat="server" />
            <ajaxToolkit:ModalPopupExtender ID="mpeBalancePopup" runat="server" TargetControlID="btnHidden"
                Y="100" PopupControlID="pnlPopup" BehaviorID="mpeBalancePopup" OkControlID="btnOk" BackgroundCssClass="modalBackground">
            </ajaxToolkit:ModalPopupExtender>
            <asp:Panel ID="pnlPopup" runat="server" CssClass="modalPopup" GroupingText="Current Balance"
                Style="display: none; padding: 10px;">
                <asp:Label ID="Label1" runat="server">Current Balance :</asp:Label>
                <asp:Label ID="lblBalance" runat="server" Font-Bold="true"></asp:Label>
                <div style="width: 100%; text-align: center; margin-top: 10px;">
                    <asp:Button ID="btnSave" runat="server" Text="Ok" OnClientClick=" Clear() " />
                </div>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:Button ID="btnGenerateReportCM" runat="server" Text="" Style="cursor: pointer" ToolTip="Export to Excel" OnClick="btnGenerateReport_Click" />
</asp:Content>
