<%@ Page Title="User Management" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true"
    CodeBehind="UserManagement.aspx.cs" Inherits="DFS.Web.Admin.UserManagement" ValidateRequest="false" EnableEventValidation="false" %>

<%@ Import Namespace="System.Runtime.Remoting.Messaging" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="DFS.Web" Namespace="DFS.Web.CustomControls" TagPrefix="cc" %>
<%@ Register TagPrefix="cc" Namespace="DFS.Web.CustomControls" Assembly="DFS.Web" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        var confirmLock = function (obj) {
            var message = "";
            var yN = $(obj).text();
            if (yN === "N") {
                message = "Are you sure you want to lock this user";
            } else if (yN === "Y") {
                message = "Are you sure you want to unlock this user";
            } else {
                message = "Invalid Data";
            }
            if (confirm(message)) {
                return true;
            }
            return false;
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" id="LoggedInUserCompanyShortName" runat="server" />
    <div style="text-align: center; position: fixed; left: 50%; bottom: 50%; z-index: 10000;">
        <asp:UpdateProgress ID="updProgressMenu" runat="server" AssociatedUpdatePanelID="upUseMgmt">
            <ProgressTemplate>
                <img src="/images/ajax-loader.gif" alt="Loading...." />
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>
    <asp:UpdatePanel ChildrenAsTriggers="true" ID="upUseMgmt" runat="server">
        <ContentTemplate>
            <div>
                <div style="float: left; margin-bottom: 10px;">
                    <div style="margin-bottom: 5px;">
                        <asp:Button runat="server" ID="btnShowFilter" Text="Show Filters" CssClass="btn" />
                        <asp:Button runat="server" ID="btnHideFilter" Text="Hide Filters" CssClass="btn" />
                    </div>
                    <asp:CollapsiblePanelExtender runat="server" ID="cpeFilter"
                        TargetControlID="pnlSearchUser"
                        Collapsed="true"
                        ExpandControlID="btnShowFilter"
                        CollapseControlID="btnHideFilter">
                    </asp:CollapsiblePanelExtender>
                    <asp:Panel runat="server" ID="pnlSearchUser" Style="width: 400px; margin: auto;" BorderStyle="Solid" BorderColor="Black">
                        <table id="tblUserMgmtSelector">
                            <tr>
                                <td colspan="3">
                                    <asp:ValidationSummary ID="ValidationSummary" runat="server" ValidationGroup="UserFilterValidation"
                                        ForeColor="Red" DisplayMode="SingleParagraph" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox runat="server" ID="chkDFSID" />
                                </td>
                                <td>
                                    <b>DFS ID</b>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtDFSID" Width="197px"></asp:TextBox>
                                    <asp:CompareValidator runat="server" ID="cvOnlyIntegerDFSID" ControlToValidate="txtDFSID" ValidationGroup="UserFilterValidation" Operator="DataTypeCheck" Type="Integer" Text="*" ErrorMessage="Invalid DFS ID." ForeColor="Red"></asp:CompareValidator>
                                    <asp:CustomValidator runat="server" ID="cvDFSID" ControlToValidate="txtDFSID" ValidateEmptyText="true" Text="*" ErrorMessage="DFS ID is required." ForeColor="Red" ValidationGroup="UserFilterValidation" OnServerValidate="cvDFSID_ServerValidate"></asp:CustomValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox runat="server" ID="chkFirstName" />
                                </td>
                                <td>
                                    <b>First Name</b>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtFirstName" Width="197px"></asp:TextBox>
                                    <asp:CustomValidator runat="server" ID="cvFirstName" ControlToValidate="txtFirstName" ValidateEmptyText="true" Text="*" ErrorMessage="First name is required." ForeColor="Red" ValidationGroup="UserFilterValidation" OnServerValidate="cvFirstName_ServerValidate"></asp:CustomValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox runat="server" ID="chkMiddleName" />
                                </td>
                                <td>
                                    <b>Middle Name</b>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtMiddleName" Width="197px"></asp:TextBox>
                                    <asp:CustomValidator runat="server" ID="cvMiddleName" ControlToValidate="txtMiddleName" ValidateEmptyText="true" Text="*" ErrorMessage="Middle name is required." ForeColor="Red" ValidationGroup="UserFilterValidation" OnServerValidate="cvMiddleName_ServerValidate"></asp:CustomValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox runat="server" ID="chkLastName" />
                                </td>
                                <td>
                                    <b>Last Name</b>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtLastName" Width="197px"></asp:TextBox>
                                    <asp:CustomValidator runat="server" ID="cvLastName" ControlToValidate="txtLastName" ValidateEmptyText="true" Text="*" ErrorMessage="Last name is required." ForeColor="Red" ValidationGroup="UserFilterValidation" OnServerValidate="cvLastName_ServerValidate"></asp:CustomValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox runat="server" ID="chkEmail" Checked="false" />
                                </td>
                                <td style="width: 75px;">
                                    <b>Email</b>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtEmail" runat="server" Width="197px"></asp:TextBox>
                                    <asp:CustomValidator ID="cvEmail" runat="server" Text="*" ErrorMessage="Email is required." ForeColor="Red" ControlToValidate="txtEmail" ValidationGroup="UserFilterValidation" ValidateEmptyText="true" OnServerValidate="cvEmail_ServerValidate">
                                        <asp:RegularExpressionValidator runat="server" ID="reEmail" ControlToValidate="txtEmail"
                                            ForeColor="Red" Display="None" ErrorMessage="Email is not valid." ValidationGroup="UserFilterValidation"
                                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    </asp:CustomValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox runat="server" ID="chkUserType" />
                                </td>
                                <td>
                                    <b>User Type</b>
                                </td>
                                <td>
                                    <cc:GroupedDropDownList ID="ddlUserType" runat="server" Width="80%"></cc:GroupedDropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox runat="server" ID="chkDeleted" />
                                </td>
                                <td>
                                    <b>Deleted</b>
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlDeleted">
                                        <asp:ListItem Value="true" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="false" Text="No"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox runat="server" ID="chkLocked" />
                                </td>
                                <td>
                                    <b>Locked</b>
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlLocked">
                                        <asp:ListItem Value="true" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Value="false" Text="No"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btn" OnClick="btnFilter_Click" ValidationGroup="UserFilterValidation" />
                                    <asp:Button runat="server" ID="btnClearFilter" Text="Clear" CssClass="btn" OnClick="btnClearFilter_Click" />
                                </td>
                            </tr>

                        </table>
                    </asp:Panel>
                </div>
                <div style="float: right;">
                    <asp:LinkButton ID="lnkAddItem" runat="server" Text="Add New User" CssClass="btn" OnClick="lnkAddItem_Click"></asp:LinkButton>
                </div>
            </div>
            <div style="clear: both;"></div>
            <asp:HiddenField ID="btnHiddenCommandName" runat="server" />
            <asp:GridView ID="gvUserManagement" runat="server"
                AutoGenerateColumns="False"
                GridLines="Both"
                ItemType="DFS.Core.ViewModels.UserListViewModel"
                OnRowDataBound="gvUserManagement_RowDataBound"
                OnRowCommand="gvUserManagement_RowCommand"
                OnPageIndexChanging="gvUserManagement_PageIndexChanging"
                EnableSortingAndPagingCallbacks="True"
                AllowPaging="True"
                AllowSorting="true"
                ForeColor="#333333"
                Width="100%"
                PagerSettings-Mode="NumericFirstLast"
                PagerSettings-Position="TopAndBottom"
                CssClass="Grid" PageSize="25" OnSorting="gvUserManagement_Sorting">
                <EditRowStyle BackColor="#999999" />
                <EmptyDataTemplate>
                    <itemtemplate><b>No record found!</b></itemtemplate>
                </EmptyDataTemplate>
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:TemplateField HeaderText="DFSID" SortExpression="emp_id" HeaderStyle-ForeColor="White">
                        <%--<ItemStyle Width="50px" />--%>
                        <ItemTemplate>
                            <asp:Label ID="lblEmployeeId" runat="server" Font-Names="Arial" Text='<%#Eval("emp_id") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="roll_no" HeaderText="Role No" Visible="false"><%-- HeaderStyle-Width="50px"--%>
                        <%--<HeaderStyle Width="50px" />--%>
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="First Name" SortExpression="first_name" HeaderStyle-ForeColor="White">
                        <%--<HeaderStyle Width="100px" />
                        <ItemStyle Width="75px" />--%>
                        <ItemTemplate>
                            <asp:Label ID="lblFirstname" runat="server" Font-Names="Arial" Text='<%#Eval("first_name") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Middle Name" SortExpression="middle_name" HeaderStyle-ForeColor="White">
                        <%--<HeaderStyle Width="100px" />
                        <ItemStyle Width="100px" />--%>
                        <ItemTemplate>
                            <asp:Label ID="lblMiddlename" runat="server" Font-Names="Arial" Text='<%#Eval("middle_name") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Last Name" SortExpression="last_name" HeaderStyle-ForeColor="White">
                        <%--<HeaderStyle Width="110px" />
                        <ItemStyle Width="110px" />--%>
                        <ItemTemplate>
                            <asp:Label ID="lblLastname" runat="server" Font-Names="Arial" Text='<%#Eval("last_name") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Phone">
                        <%--<HeaderStyle Width="85px" />--%>
                        <ItemTemplate>
                            <asp:Label ID="lblPhone" runat="server" Text='<%#Eval("phone") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email" SortExpression="Email" HeaderStyle-ForeColor="White">
                        <%--<HeaderStyle Width="180px" />
                        <ItemStyle Width="180px" />--%>
                        <ItemTemplate>
                            <asp:Label ID="lblEmail" runat="server" Font-Names="Arial" Text='<%#Eval("Email") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="User Type">
                        <%--<HeaderStyle Width="200px" />--%>
                        <ItemTemplate>
                            <p class="wordBreak">
                                <asp:Label ID="lblUsertype" runat="server" MaxLength="1" Text='<%#Eval("user_type") %>'></asp:Label>
                            </p>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Deleted?" SortExpression="IsDeleted" HeaderStyle-ForeColor="White">
                        <%--<HeaderStyle Width="30px" />
                        <ItemStyle Width="30px" />--%>
                        <ItemTemplate>
                            <asp:Label ID="lblUserActive" runat="server" Text='<%#Eval("IsDeleted").ToString().Equals("False") ? "No" : "Yes" %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Expense Limit"> 
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblDWSUnpaidInternExpenseLimit" Text='<%#Eval("DWSUnpaidInternExpenseLimit") %>'></asp:Label>
                    </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <%--<HeaderStyle Width="60px" />--%>
                        <ItemTemplate>
                            <asp:LinkButton runat="server" ID="LinkButton1" CommandArgument='<%#Eval("emp_id") %>'
                                CommandName="lnkEdit" ToolTip="Edit user">
                                <img src="../images/edit.png" alt="Edit" />
                            </asp:LinkButton>
                            <asp:LinkButton runat="server" ID="lnkUserCancel" CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>'
                                ToolTip="Deactivate user" CommandName="lnkCancel" OnClientClick=" return confirm('Are you sure you want to delete this user?'); "><img src="../images/delete.png" alt="Cancel"  />
                            </asp:LinkButton>
                            <asp:LinkButton ID="lnkResetPW" runat="server" CommandName="MyResetCommand" Font-Size="0.96em" Visible="False"
                                ToolTip="Reset Password" CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>'
                                OnClientClick=" return confirm('Are you sure you want to reset the password for this user?'); ">
                                <img src="../images/reset-password-1.png" alt="Reset PW" />
                            </asp:LinkButton>
                            <asp:HiddenField ID="hfemail" Value='<%# Eval("email") %>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Locked?" SortExpression="isLocked" HeaderStyle-ForeColor="White">
                        <%--<HeaderStyle Width="50px" />
                        <ItemStyle Width="50px" />--%>
                        <ItemTemplate>
                            <asp:LinkButton Text='<%#Eval("isLocked").ToString().Equals("False") ? "N" : "Y" %>' runat="server" OnClientClick=" return confirmLock(this); " ID="lnkBtnLocked" CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>' CommandName="LnkLocked"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" CssClass="GridHeader" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" CssClass="GridPager" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
            <table align="right">
                <tr>
                    <td><strong>Page Size:</strong>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
                            <asp:ListItem Value="5" Text="5" />
                            <asp:ListItem Value="10" Text="10" />
                            <asp:ListItem Value="25" Text="25" Selected="True" />
                            <asp:ListItem Value="50" Text="50" />
                            <asp:ListItem Value="100" Text="100" />
                            <asp:ListItem Value="1000" Text="1000" />
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <br>
            <asp:HiddenField ID="btnHidden" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
