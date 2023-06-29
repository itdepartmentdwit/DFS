<%@ Page Title="Student Balance" Language="C#" AutoEventWireup="true" CodeBehind="StudentBalance.aspx.cs" MasterPageFile="~/DFS.Master" Inherits="DFS.Web.StudentDeposit.StudentBalance"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $(".chosen_select").chosen({ allow_single_deselect: true });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <asp:Panel runat="server" ID="pnlStudentDetails" GroupingText="Student Balance Report" CssClass="fivepixelbottommargin">
        <table cellpadding="5" style="margin: 5px 0 5px 0">
            <tr>
                <td>
                    <strong>Select Email</strong>
                </td>
                <td>
                    <asp:DropDownList
                        runat="server"
                        ID="ddlEmail"
                        ClientIDMode="Static"
                        Width="250"
                        class="chosen_select">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    
                </td>
                <td>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" />                    
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn" OnClick="btnClear_Click" />
                </td>
            </tr>
        </table>        
        <asp:GridView ID="gvStudentDetails" runat="server" AutoGenerateColumns="False" AllowPaging="True" CssClass="Grid" Width="100%"
                      AutoEventWireup="false" PagerSettings-Mode="NumericFirstLast" OnPageIndexChanging="gvStudentDetails_PageIndexChanging" CellPadding="4" ForeColor="#333333" GridLines="Both" OnRowCommand="gvStudentDetails_RowCommand" OnRowDataBound="gvStudentDetails_RowDataBound">
            <EditRowStyle BackColor="#999999" />
            <EmptyDataTemplate>
                <itemtemplate>No results were found !</itemtemplate>
            </EmptyDataTemplate>
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="cmsid" HeaderText="DFS ID" SortExpression="cmsid" />
                <asp:BoundField DataField="rollno" HeaderText="Roll No" SortExpression="rollno" />
                <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="first_name" />
                <asp:BoundField DataField="MiddleName" HeaderText="Middle Name" SortExpression="middle_name" />
                <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="last_name" />
                <asp:BoundField DataField="email" HeaderText="Email Address" SortExpression="email" />
                <asp:BoundField DataField="balance" HeaderText="Balance" SortExpression="balance"
                                DataFormatString="{0:0.00}" />
                <asp:TemplateField HeaderText="Clear Balance" Visible="false">
                    <HeaderStyle Width="50px" />
                    <ItemStyle Width="50px" />
                    <ItemTemplate>
                        <asp:ImageButton ID="lnk" ImageUrl="/images/Clear_Balance.png" CommandName="ClearBalance" ToolTip="Clear Balance" CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>'
                                         OnClientClick=" return confirm('Are you sure you want to clear the balance for this user?'); " runat="server" border="0" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle HorizontalAlign="Left" BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" CssClass="GridHeader" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" CssClass="GridPager" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" Width="
                50px" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <%
            if (gvStudentDetails.PageCount > 0)
            { %>
            <p class="paginginfo">
                You are viewing page <%= gvStudentDetails.PageIndex + 1 %> of <%= gvStudentDetails.PageCount %>
            </p>
        <% }
        %>
    </asp:Panel>
    <!--Panel for editing dwit user deposits-->
    <asp:HiddenField ID="HiddenField1" runat="server" />
    <ajaxToolkit:ModalPopupExtender ID="mpeEditPopup" runat="server" TargetControlID="HiddenField1"
                                    PopupControlID="pnlEditDeposit" BehaviorID="mpeEditPopup" CancelControlID="btnEditCancel"
                                    BackgroundCssClass="modalBackground">
    </ajaxToolkit:ModalPopupExtender>
    <asp:Panel ID="pnlEditDeposit" runat="server" CssClass="modalPopup modalPopupNotification"
               GroupingText="Edit Deposit Details" Style="display: none">
        <table cellspacing="5" cellpadding="2">
            <tr>
                <td colspan="2">
                    <asp:Literal ID="ltrMsg" runat="server" Text="<b>Fields with <font color='red'>*</font> signs are mandatory.</b>"></asp:Literal>
                </td>
                <asp:HiddenField ID="hfUserId" runat="server" />
                <asp:HiddenField ID="hfDepositId" runat="server" />
                <asp:HiddenField ID="hfUserTypeId" runat="server" />
            </tr>
            <tr>
                <td width="30%">
                    <asp:Literal ID="ltrAmount" runat="server" Text="<strong>Amount</strong> <font color='red'>*</font> "></asp:Literal>
                </td>
                <td>
                    <asp:TextBox ID="txtAmount" runat="server" ValidationGroup="Amount"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfAmount" ControlToValidate="txtAmount" ValidationGroup="Amount"
                                                runat="server" ForeColor="Red" ErrorMessage="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="regvAmount" ValidationExpression="^\d+(\.\d\d)?$"
                                                    ValidationGroup="Amount" runat="server" ForeColor="Red" ErrorMessage="The amoount is invalid"
                                                    ControlToValidate="txtAmount"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Literal ID="ltrVoucher" runat="server" Text="<strong>Voucher No</strong> <font color='red'>*</font>"></asp:Literal>
                </td>
                <td>
                    <asp:TextBox ID="txtVoucher" runat="server" ValidationGroup="Amount"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfVoucher" ControlToValidate="txtVoucher" ValidationGroup="Amount"
                                                ForeColor="Red" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Literal ID="Literal1" runat="server" Text="<strong>Deposited date</strong><font color='red'>*</font> "></asp:Literal>
                </td>
                <td>
                    <asp:TextBox ID="txtEditDepositDate" runat="server" ValidationGroup="Amount" onkeypress="javascript:return false;"></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="datepickerEdit" runat="server" TargetControlID="txtEditDepositDate">
                    </ajaxToolkit:CalendarExtender>
                    <asp:RequiredFieldValidator ID="rfEditDepositDate" ControlToValidate="txtEditDepositDate"
                                                ValidationGroup="Amount" ForeColor="Red" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <%--                    <asp:Button ID="btnSaveDeposit" runat="server" Text="Save" OnClick="btnSaveDeposit_Click"--%>
        <%--                                CssClass="btn" CausesValidation="true" ValidationGroup="Amount" />--%>
        <%--                    <asp:Button ID="btnEditCancel" runat="server" Text="Cancel" />--%>
    </asp:Panel>
    <!--Panel for viewing dwit user balance-->
    <asp:HiddenField ID="btnHidden" runat="server" />
    <ajaxToolkit:ModalPopupExtender ID="mpeBalancePopup" runat="server" TargetControlID="btnHidden"
                                    Y="100" PopupControlID="pnlPopup" BehaviorID="mpeBalancePopup" BackgroundCssClass="modalBackground">
    </ajaxToolkit:ModalPopupExtender>
    <asp:Panel ID="pnlPopup" runat="server" CssClass="modalPopup" GroupingText="Current Balance"
               Style="display: none">
        <asp:Label ID="Label1" runat="server">Current Balance :</asp:Label>
        <asp:Label ID="lblUserBalance" runat="server" Font-Bold="true"></asp:Label>
        <br />
        <asp:Button ID="btnSave" runat="server" Text="Ok" />
    </asp:Panel>
    <asp:Button ID="btnGenerateReport" runat="server" Style="cursor: pointer" OnClick="btnGenerateReport_Click"
                ToolTip="Export to Excel" />
</asp:Content>