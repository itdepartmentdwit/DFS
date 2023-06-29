<%@ Page Title="Edit User" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true"
    CodeBehind="EditUser.aspx.cs" Inherits="DFS.Web.Admin.EditUser" %>

<%@ Register Assembly="DFS.Web" Namespace="DFS.Web.CustomControls" TagPrefix="cc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="bottom: 50%; left: 50%; position: fixed; text-align: center; z-index: 10000;">
        <asp:UpdateProgress ID="updateProgressEditUser" runat="server" AssociatedUpdatePanelID="updatePanelEditUser">
            <ProgressTemplate>
                <img src="/images/ajax-loader.gif" alt="Loading...." />
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>
    <asp:UpdatePanel runat="server" ID="updatePanelEditUser" UpdateMode="Always" ChildrenAsTriggers="true">
        <ContentTemplate>
            <asp:Panel ID="pnlAddNewUser" runat="server" GroupingText="User Details">
                <div class="user-add-box">
                    <div class="left-col">
                        <table>
                            <tr>
                                <td>
                                    <asp:Literal ID="ltrMsg" runat="server" Text="<b>Fields with <font color='red'>*</font> signs are mandatory.</b>"></asp:Literal>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lblFirstname" runat="server" Text="First Name <font color='red'>*</font> " Font-Bold="true"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtFirstname" runat="server"></asp:TextBox>

                                    <asp:RequiredFieldValidator ID="reqValFirstname" runat="server" ErrorMessage="This field is required" ControlToValidate="txtFirstname"
                                        CssClass="rfv" ValidationGroup="EditUser" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator runat="server" ID="rvFirstName" ControlToValidate="txtFirstname"
                                        ValidationGroup="EditUser" ForeColor="Red" Display="Dynamic" ErrorMessage="Invalid Input"
                                        ValidationExpression="^[a-zA-Z ]*$"> </asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lblMiddlename" runat="server" Text="Middle Name" Font-Bold="true"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtMiddlename" runat="server"></asp:TextBox>

                                    <asp:RegularExpressionValidator runat="server" ID="rvMiddleName" ControlToValidate="txtMiddlename"
                                        ValidationGroup="EditUser" ForeColor="Red" Display="Dynamic" ErrorMessage="Invalid Input"
                                        ValidationExpression="^[a-zA-Z ]*$"> </asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="ltrLastname" runat="server" Text="Last Name <font color='red'>*</font> " Font-Bold="true"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtLastname" runat="server"></asp:TextBox>

                                    <asp:RequiredFieldValidator
                                        ID="reqValLastname" runat="server" ErrorMessage="This field is required" ControlToValidate="txtLastname"
                                        CssClass="rfv" ValidationGroup="EditUser" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator runat="server" ID="rvLastName" ControlToValidate="txtLastname"
                                        ValidationGroup="EditUser" ForeColor="Red" Display="Dynamic" ErrorMessage="Invalid Input"
                                        ValidationExpression="^[a-zA-Z ]*$"> </asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lblPhone" runat="server" Text="Phone <font color='red'>*</font> " Font-Bold="true"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>

                                    <asp:RequiredFieldValidator ID="reqValPhone" runat="server" ErrorMessage="This field is required" CssClass="rfv" ControlToValidate="txtPhone"
                                        ValidationGroup="EditUser" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator runat="server" ID="revNumbersOnly" ControlToValidate="txtPhone"
                                        ValidationGroup="EditUser" ForeColor="Red" Display="Dynamic" ErrorMessage="PhoneNumber is not valid!"
                                        ValidationExpression="(^([0-9-]*|\d*\d{1}?\d*)$)"> </asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lblEmail" runat="server" Text="Email <font color='red'>*</font> " Font-Bold="true"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtEmail" runat="server"> </asp:TextBox>
                                    <asp:RequiredFieldValidator ID="reqValEmail" runat="server" ErrorMessage="This field is required" CssClass="rfv" ControlToValidate="txtEmail"
                                        ValidationGroup="EditUser" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revtxtEmail" runat="server" ControlToValidate="txtEmail"
                                        ValidationGroup="EditUser" ErrorMessage="Email address is not valid." ForeColor="Red"
                                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="ltrUsertype" runat="server" Text="User Type <font color='red'>*</font> " Font-Bold="true"></asp:Label>
                                </td>
                                <td id="first">
                                    <asp:CheckBoxList ID="ddlUsertype" runat="server" BorderStyle="Groove" Width="175px" AutoPostBack="True" OnSelectedIndexChanged="ddlUsertype_SelectedIndexChanged">
                                    </asp:CheckBoxList>
                                    <asp:CustomValidator ID="CustomValidator1" Text="Please select User Type(s)" ForeColor="Red" OnServerValidate="CustomValidator1_ServerValidate" runat="server" ValidationGroup="EditUser"></asp:CustomValidator>
                                </td>
                            </tr>
                            <tr runat="server" id="trDWSUnpaidInternExpenseLimit" visible="false">
                                <td>
                                    <asp:Label runat="server" ID="lblDWSUnpaidInternExpLimit" Text="DWS Unpaid Intern Expense Limit <font color='red'>*</font> " Font-Bold="true"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtDWSUnpaidInternExpenseLimit">
                                    </asp:TextBox>
                                    <asp:CompareValidator runat="server" ID="cmpValidatorDWSUnpaidInternExpenseLimit" ControlToValidate="txtDWSUnpaidInternExpenseLimit" Type="Currency" Operator="DataTypeCheck" ErrorMessage="Invalid input." ForeColor="Red" ValidationGroup="EditUser"></asp:CompareValidator>
                                    <asp:RequiredFieldValidator runat="server" ID="reqFieldValidDWSUnpaidInternExpLimit" ControlToValidate="txtDWSUnpaidInternExpenseLimit" ErrorMessage="This field is required." ForeColor="Red" ValidationGroup="EditUser">
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lblActive" runat="server" Text="Active" Font-Bold="true"></asp:Label>

                                </td>
                                <td>
                                    <asp:CheckBox ID="chkboxActive" runat="server" Checked="true" AutoPostBack="true" />
                                </td>
                            </tr>
                            <tr runat="server" id="row1" visible="false">
                                <td align="right">
                                    <asp:Label ID="ltrRollNo" runat="server" Text="Roll No <font color='red'>*</font> " Font-Bold="true"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtRollNo" runat="server" ValidationGroup="EditUser"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfRollNo" runat="server" ForeColor="Red" ErrorMessage="This field is required."
                                        ControlToValidate="txtRollNo" ValidationGroup="EditUser" Enabled="false" Display="Dynamic"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr runat="server" id="row2" visible="false">
                                <td align="right">
                                    <asp:Label runat="server" ID="lblIsDWSIntern" Text="Is DWS Intern?" Font-Bold="true"></asp:Label>
                                </td>
                                <td>
                                    <asp:CheckBox ID="chkIntern" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="right-col">
                        <div class="uploader-border">
                            <IMP:DFSImageUploader ID="editUserAvatarUpload" runat="server" />
                        </div>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" OnClick="btnSave_Click"
                    ValidationGroup="EditUser" />
                &nbsp;&nbsp;
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClientClick=" return confirm('Are you sure you want to leave this page?'); "
                    CausesValidation="false" OnClick="btnCancel_Click" CssClass="btn" />
            </asp:Panel>
            <asp:Panel ID="Panel1" Visible="False" runat="server">
                <asp:Literal ID="Literal1" runat="server" Text="<b>You cannot edit your own user details. Please ask another administrator user to edit your user information.</b>"></asp:Literal>
                <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn" OnClick="btnBack_Click" />
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
