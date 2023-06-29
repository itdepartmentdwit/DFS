<%@ Page Title="Add User" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true"
    CodeBehind="AddNewUser.aspx.cs" Inherits="DFS.Web.Admin.AddNewUser" ValidateRequest="false" EnableEventValidation="false" %>

<%@ Register Assembly="DFS.Web" Namespace="DFS.Web.CustomControls" TagPrefix="cc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlAddNewUser" runat="server" GroupingText="User Details">
        <div style="text-align: center; position: fixed; left: 30%; z-index: 10000;">
            <asp:UpdateProgress ID="updProgressEmployee" runat="server">
                <ProgressTemplate>
                    <img src="/images/ajax-loader.gif" alt="Loading...." />
                </ProgressTemplate>
            </asp:UpdateProgress>
        </div>
        <asp:UpdatePanel ID="upPnlAdduser" runat="server" UpdateMode="Always">
            <ContentTemplate>
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
                                    <asp:Label ID="lblFirstName" runat="server" Text="First Name <font color='red'>*</font> " Font-Bold="true"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtFirstname" runat="server" MaxLength="50" Width="180"></asp:TextBox>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="reqValFirstname" runat="server" ErrorMessage="This field is required."
                                        ControlToValidate="txtFirstname" CssClass="rfv" ValidationGroup="AddUser"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtFirstname" CssClass="rfv" ValidationGroup="AddUser"
                                        ErrorMessage="Invalid Input" ValidationExpression="^[a-zA-Z ]*$"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lblMiddlename" runat="server" Text="Middle Name" Font-Bold="true"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtMiddlename" runat="server" MaxLength="50" Width="180"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="rxvMiddleName" runat="server"
                                        ControlToValidate="txtLastname" CssClass="rfv" Display="Dynamic"
                                        ErrorMessage="Invalid Input" ForeColor="Red"
                                        ValidationExpression="^[a-zA-Z ]*$"
                                        ValidationGroup="AddUser"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="ltrLastname" runat="server" Text="Last Name <font color='red'>*</font> " Font-Bold="true"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtLastname" runat="server" MaxLength="50" Width="180"></asp:TextBox><asp:RequiredFieldValidator
                                        Display="Dynamic" ID="reqValLastname" runat="server" ErrorMessage="This field is required."
                                        ControlToValidate="txtLastname" CssClass="rfv" ValidationGroup="AddUser"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                        ControlToValidate="txtLastname" CssClass="rfv" Display="Dynamic"
                                        ErrorMessage="Invalid Input" ForeColor="Red"
                                        ValidationExpression="^[a-zA-Z ]*$"
                                        ValidationGroup="AddUser"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="ltrPhone" runat="server" Text="Phone <font color='red'>*</font> " Font-Bold="true"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPhone" runat="server" Width="180"></asp:TextBox><asp:RequiredFieldValidator
                                        ID="reqValPhone" runat="server" ErrorMessage="This field is required." CssClass="rfv"
                                        ControlToValidate="txtPhone" ValidationGroup="AddUser"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator runat="server" ID="revNumbersOnly" ControlToValidate="txtPhone"
                                        Display="Dynamic" ValidationGroup="AddUser" ForeColor="Red" ErrorMessage="PhoneNumber is not valid !"
                                        ValidationExpression="(^([0-9-]*|\d*\d{1}?\d*)$)"> </asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="ltrEmail" runat="server" Text="Email <font color='red'>*</font> " Font-Bold="true"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtEmail" runat="server" Width="180"></asp:TextBox><asp:RequiredFieldValidator
                                        Display="Dynamic" ID="reqValEmail" runat="server" ErrorMessage="This field is required."
                                        CssClass="rfv" ControlToValidate="txtEmail" ValidationGroup="AddUser"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revtxtEmail" runat="server" ControlToValidate="txtEmail"
                                        Display="Dynamic" ValidationGroup="AddUser" ErrorMessage="Email address is not valid."
                                        ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="ltrUsertype" runat="server" Text="User Type(s) <font color='red'>*</font> " Font-Bold="true"></asp:Label>
                                </td>
                                <td>
                                    <asp:CheckBoxList ID="ddlUsertype" runat="server" BorderStyle="Groove" Width="185px" AutoPostBack="True" OnSelectedIndexChanged="ddlUsertype_SelectedIndexChanged">
                                    </asp:CheckBoxList>
                                    <asp:CustomValidator ID="CustomValidator1" Text="Please select User Type(s)." ForeColor="Red" OnServerValidate="CustomValidator1_ServerValidate" runat="server" ValidationGroup="AddUser" Display="Dynamic"></asp:CustomValidator>
                                </td>
                            </tr>
                            <tr runat="server" id="trDWSUnpaidInternExpenseLimit" visible="false">
                                <td>
                                    <asp:Label runat="server" ID="lblDWSUnpaidInternExpLimit" Text="DWS Unpaid Intern Expense Limit <font color='red'>*</font> " Font-Bold="true"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtDWSUnpaidInternExpenseLimit">
                                    </asp:TextBox>
                                    <asp:CompareValidator runat="server" ID="cmpValidatorDWSUnpaidInternExpenseLimit" ControlToValidate="txtDWSUnpaidInternExpenseLimit" Type="Currency" Operator="DataTypeCheck" ErrorMessage="Invalid input." ForeColor="Red" ValidationGroup="AddUser"></asp:CompareValidator>
                                    <asp:RequiredFieldValidator runat="server" ID="reqFieldValidDWSUnpaidInternExpLimit" ControlToValidate="txtDWSUnpaidInternExpenseLimit" ErrorMessage="This field is required." ForeColor="Red" ValidationGroup="AddUser">
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr runat="server" id="row1" visible="false">
                                <td align="right">
                                    <asp:Label ID="ltrRollNo" runat="server" Text="Roll No <font color='red'>*</font> " Font-Bold="true"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtRollNo" runat="server" ValidationGroup="AddUser" Width="180"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="rvRollNo" runat="server"
                                        ForeColor="Red" Display="Dynamic" ValidationGroup="AddUser"
                                        ErrorMessage="Invalid Input"
                                        ControlToValidate="txtRollNo"
                                        ValidationExpression="^[a-zA-Z0-9\s.\-,]+" />
                                    <asp:RequiredFieldValidator ID="rfRollNo" runat="server" ForeColor="Red" ErrorMessage="This field is required."
                                        Display="Dynamic" ControlToValidate="txtRollNo" ValidationGroup="AddUser" Enabled="false"></asp:RequiredFieldValidator>
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
                            <IMP:DFSImageUploader runat="server" ID="AddUserAvatarUpload" />
                        </div>
                    </div>
                    <div class="clear">
                    </div>
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" OnClick="btnSave_Click"
                        ValidationGroup="AddUser" OnClientClick=" ValidateColorList() " />
                    &nbsp;&nbsp;
                   
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                        OnClientClick=" return confirm('Are you sure you want to leave this page?'); "
                        CausesValidation="false" CssClass="btn" />
                </div>
            </ContentTemplate>
            <%--            <Triggers>--%>
            <%--                <asp:AsyncPostBackTrigger ControlID="ddlUsertype" EventName="SelectedIndexChanged" />--%>
            <%--            </Triggers>--%>
        </asp:UpdatePanel>
    </asp:Panel>
</asp:Content>
