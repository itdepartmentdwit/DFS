<%@ Page Title="Add Deposit" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true"
         CodeBehind="AddDeposit.aspx.cs" Inherits="DFS.Web.Deposit.AddDeposit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/Plugins/chosen.jquery.js"> </script>
    <link href="../Style/chosen.css" rel="stylesheet" />
    <script type="text/javascript">
        var Page;

        function OnInitializeRequest(sender, args) {

            var postBackElement = args.get_postBackElement();

            if (Page.get_isInAsyncPostBack() && postBackElement.id == "ContentPlaceHolder1_btnSave") {
                alert('Your request is already in processing state! Please be patient!!');
                args.set_cancel(true);

                document.getElementById('<%= btnSave.ClientID %>').disabled = "disabled";
                document.getElementById('<%= btnEditCancel1.ClientID %>').disabled = "disabled";
            }
        }

        jQuery(document).ready(function() {
            jQuery(".chosen").chosen();
        })

        function pageLoad() {
            jQuery(".chosen").chosen();
            Page = Sys.WebForms.PageRequestManager.getInstance();
            Page.add_initializeRequest(OnInitializeRequest);
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="text-align: center; position: fixed; left: 30%; z-index: 10000;">
        <asp:UpdateProgress ID="updProgressEmployee" runat="server">
            <ProgressTemplate>
                <img src="/images/ajax-loader.gif" alt="Loading...." />
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>
    <asp:UpdatePanel ID="upanelUserDetails" runat="server" RenderMode="Inline" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="user-add-box">
                <div class="left-col">
                    <fieldset>
                        <legend>Deposit Money</legend>
                        <table cellpadding="4" cellspacing="0" class="border-none">
                            <tr>
                                <td colspan="2">
                                    <asp:Literal ID="ltrMsg" runat="server" Text="<b>Fields with <font color='red'>*</font> signs are mandatory.</b>"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 150px;">
                                    <asp:Literal ID="ltrDwitCanteenId" runat="server" Text="DFS ID <font color='red'>*</font> "></asp:Literal>
                                </td>
                                <td>
                                    <%--<select id="cmbUsers" class="chosen" multiple="false" style="width: 142px;" runat="server" onchange="cmbUsers_SelectedIndexChanged">
                                        <option>Choose...</option>
                                    </select>--%>
                                    <asp:DropDownList ID="cmbUsers" CssClass="chosen" runat="server" OnSelectedIndexChanged="cmbUsers_SelectedIndexChanged" 
                                                      AutoPostBack="true" Width="140px">
                                        <%--                                        <asp:ListItem Selected="True">Choose StudentID</asp:ListItem>--%>
                                        <%--                                        <asp:ListItem Selected="True" Text="Please Select an item" Value ="2"></asp:ListItem>--%>
                                    </asp:DropDownList>
                                    <%-- <ajaxToolkit:ComboBox ID="cmbUsers" AutoCompleteMode="SuggestAppend" runat="server"
                                        ForeColor="Red" CssClass="limitheight" CaseSensitive="false" AutoPostBack="True"
                                        OnSelectedIndexChanged="cmbUsers_SelectedIndexChanged" DropDownStyle="DropDownList" >
                                    </ajaxToolkit:ComboBox>--%>
                           
                                    <asp:RequiredFieldValidator ID="rfcmbUsers" ControlToValidate="cmbUsers" ValidationGroup="Amount"
                                                                Display="Dynamic" runat="server" ForeColor="Red" ErrorMessage="Please select DFS Id." InitialValue="0">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Literal ID="ltrAmount" runat="server" Text="Amount <font color='red'>*</font> "></asp:Literal>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtAmount" runat="server" MaxLength="6"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="regvAmount" ValidationExpression="^\d+(\.\d\d)?$"
                                                                    Display="Dynamic" ValidationGroup="Amount" runat="server" ForeColor="Red" ErrorMessage="The amount is invalid."
                                                                    ControlToValidate="txtAmount">*</asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="RangeValAmount" runat="server" ControlToValidate="txtAmount"
                                                        Display="Dynamic" ForeColor="Red" ValidationGroup="Amount" ErrorMessage="Amount should be between 500 to 10000."
                                                        MaximumValue="10000" MinimumValue="500" Type="Currency">*
                                    </asp:RangeValidator>
                                    <asp:RequiredFieldValidator ID="rfAmount" ControlToValidate="txtAmount" ValidationGroup="Amount"
                                                                Display="Dynamic" CssClass="aaa" runat="server" ForeColor="Red" ErrorMessage="Amount is required.">*</asp:RequiredFieldValidator>
                                    <br />
                                    <%--    "^\d+(\.\d\d)?$"--%>
                                    <%--((0)+(\.[1-9](\d)?))|((0)+(\.(\d)[1-9]+))|(([1-9]+(0)?)+(\.\d+)?)|(([1-9]+(0)?)+(\.\d+)?)--%>
                                    <%-- ^\$?([0-9]{1,3},([0-9]{3},)*[0-9]{3}|[0-9]+)(.[0-9][0-9])?$  allows commas--%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Literal ID="ltrConfirmAmount" runat="server" Text="Confirm Amount <font color='red'>*</font> "></asp:Literal>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtConfirmAmount" runat="server" MaxLength="6"></asp:TextBox>
                                    <asp:RequiredFieldValidator Display="Dynamic" ID="rfConfirmAmount" runat="server"
                                                                ErrorMessage="Confirm amount is required." ForeColor="Red" ControlToValidate="txtConfirmAmount"
                                                                ValidationGroup="Amount">*</asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CvAmount" runat="server" Operator="Equal" ControlToValidate="txtConfirmAmount"
                                                          ErrorMessage="Amount and confirm amount are not equal." ControlToCompare="txtAmount"
                                                          Display="Dynamic" ValidationGroup="Amount" ForeColor="Red">*</asp:CompareValidator>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                            <td>
                                <asp:Literal ID="ltrVoucher" runat="server" Text=" Voucher No <font color='red'>*</font> "></asp:Literal>
                                <label for="">
                                </label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtVoucher" runat="server"></asp:TextBox>
                                <br />
                                <asp:RegularExpressionValidator ID="rvVoucher" runat="server"
                                                                ForeColor="Red" Display="Dynamic" ValidationGroup="Amount"
                                                                ErrorMessage="Enter only letters or numbers."
                                                                ControlToValidate="txtVoucher"
                                                                ValidationExpression="^[a-zA-Z0-9\s.\-,]+" />
                                <asp:RequiredFieldValidator ID="rfVoucher" ControlToValidate="txtVoucher" ValidationGroup="Amount"
                                                            Display="Dynamic" ForeColor="Red" runat="server" ErrorMessage="Voucher is required."></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="CustomVoucherNoValidator" runat="server"
                                                     ForeColor="Red"
                                                     Display="Dynamic"
                                                     ErrorMessage="Voucher Number is invalid. Already used."
                                                     ControlToValidate="txtVoucher"
                                                     ValidationGroup="Amount"
                                                     OnServerValidate="CustomVoucherNoValidator_ServerValidate"></asp:CustomValidator>
                            </td>
                            <tr>
                                <td></td>
                                <td>
                                    <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="Amount" OnClick="btnSave_Click" />
                                    <asp:Button ID="btnEditCancel1" runat="server" Text="Cancel" CssClass="btn" OnClientClick=" return confirm('Are you sure you want to leave this page?'); "
                                                CausesValidation="false" OnClick="btnEditCancel1_Click" />
                                    <asp:ValidationSummary ID="ValidationSummary" runat="server" ValidationGroup="Amount"
                                                           ForeColor="Red" ShowMessageBox="True" ShowSummary="false" DisplayMode="List" />
                                </td>
                            </tr>
                        </tr>
                        </table>
                    </fieldset>
                </div>

                <div class="right-col">
                    <asp:Panel ID="pnlUserDetails" runat="server" Visible="false">
                        <fieldset style="min-height: 172px;">
                            <legend>Dwit User Details</legend>
                            <table cellpadding="3" cellspacing="1" class="border-none">
                                <tr>
                                    <td style="width: 100px;">
                                        <strong>First Name</strong>
                                    </td>
                                    <td style="width: 235px;">
                                        <asp:Label ID="txtFname" runat="server"></asp:Label>
                                    </td>
                                    <td rowspan="5" style="width: 160px;">
                                        <asp:LinkButton ID="lnkUserImage" rel="lightbox" runat="server" CausesValidation="false">
                                            <asp:Image ID="imgUser" runat="server" CssClass="img-student" AlternateText="No Image" />
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <strong>Middle Name</strong>
                                    </td>
                                    <td>
                                        <asp:Label ID="txtMname" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <strong>Last Name</strong>
                                    </td>
                                    <td>
                                        <asp:Label ID="txtLname" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <strong>Email</strong>
                                    </td>
                                    <td>
                                        <asp:Label ID="txtEmail" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <strong>User Type</strong>
                                    </td>
                                    <td>
                                        <asp:Label ID="txtUserType" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <strong>Current Balance</strong>
                                    </td>
                                    <td>
                                        <asp:Label ID="txtBalance" runat="server" ></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </asp:Panel>
                </div>
                <div class="clear">
                </div>
            </div>
            <br />
           
           
        </ContentTemplate>
        <%-- <Triggers>
            <asp:AsyncPostBackTrigger ControlID="cmbUsers" EventName="SelectedIndexChanged" />
        </Triggers>--%>
    </asp:UpdatePanel>
</asp:Content>