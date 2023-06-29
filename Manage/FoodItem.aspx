<%@ Page Title="Add/Edit Food" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true"
         CodeBehind="FoodItem.aspx.cs" Inherits="DFS.Web.ManageFood.FoodItem" ValidateRequest="false"
         EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
    <script type="text/javascript">
        jQuery(document).ready(function() {
            jQuery(".chosen").chosen();
        });
        jQuery(document).load(function() {
            jQuery(".chosen").chosen();
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hfCommandName" runat="server" />
    <asp:HiddenField ID="hfFoodId" runat="server" />
    <asp:Panel ID="pnlFoodItem" runat="server" GroupingText="Food Details" CssClass="NoBorder">
        <div class="food-Item-box">
            <div>
                <div class="left-col">
                    <table width="100%" class="food-detail">
                        <tr>
                            <td colspan="3">
                                <asp:Literal ID="ltrMsg" runat="server" Text="<b>Fields with <font color='red'>*</font> signs are mandatory.</b>"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Literal ID="ltrSubMenuCategory" runat="server" Text="Category&lt;font color='red'&gt;*&lt;/font&gt;"></asp:Literal>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlSubMenuCategory" runat="server" Width="339px" DataTextField="Description"
                                                  DataValueField="Id">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ForeColor="Red" Display="Dynamic"
                                                            ErrorMessage="Food Category is required." ControlToValidate="ddlSubMenuCategory"
                                                            ValidationGroup="fooditem"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td width="20%" valign="top">
                                <asp:Literal ID="ltrFoodName" runat="server" Text="Food Name<font color='red'>*</font>"></asp:Literal>
                            </td>
                            <td width="54%">
                                <asp:TextBox ID="txtFoodName" runat="server" Width="330px" MaxLength="1000"></asp:TextBox>
                            </td>
                            <td width="24%">
                                <asp:RequiredFieldValidator ID="reqValFood" runat="server" ForeColor="Red" Display="Dynamic"
                                                            ErrorMessage="Food name is required." ControlToValidate="txtFoodName" ValidationGroup="fooditem"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <asp:Literal ID="ltrFoodRate" runat="server" Text="Rate<font color='red'>*</font>"></asp:Literal>
                            </td>
                            <td>
                                <asp:TextBox ID="txtFoodRate" runat="server" Width="332px" MaxLength="4"  onkeypress="return DFS.Validation.IsNumberKey(event)"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqValRate" runat="server" ForeColor="Red" Display="Dynamic"
                                                            ErrorMessage="Food rate is required." ControlToValidate="txtFoodRate" ValidationGroup="fooditem"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <asp:Literal ID="ltrFoodRateForDWITStudents" runat="server" Text="Subsidized Rate<font color='red'>*</font>"></asp:Literal>
                            </td>
                            <td>
                                <asp:TextBox ID="txtFoodRateForDWITStudents" runat="server" Width="332px" MaxLength="4" onkeypress="return DFS.Validation.IsNumberKey(event)"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="rfvxtFoodRateForDWITStudents" runat="server" ForeColor="Red" Display="Dynamic"
                                                            ErrorMessage="Subsidize food rate is required." ControlToValidate="txtFoodRateForDWITStudents" ValidationGroup="fooditem"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cmvFoodRateForDWITStudents" ControlToValidate="txtFoodRateForDWITStudents" runat="server" Display="Dynamic"
                                                      ValidationGroup="fooditem" ErrorMessage="Subsidized rate should be less than actual rate." Type="Double" ForeColor="Red" ControlToCompare="txtFoodRate" Operator="LessThanEqual">
                                </asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <asp:Label ID="ltrDescription" runat="server" Text="Description"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtDescription" TextMode="MultiLine" Width="333px" runat="server" MaxLength="1000"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Literal ID="ltrFoodCategory" runat="server" Text="Tags&lt;font color='red'&gt;*&lt;/font&gt;"></asp:Literal>
                            </td>
                            <td>
                                <select id="selectTags" class="chosen" multiple="true" style="width: 339px;" runat="server">
                                    <option>Choose...</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblDiscountFoodItem" runat="server" Text="Discount?"></asp:Label>
                            </td>
                            <td>
                                <asp:CheckBox ID="chkBoxDiscountFoodItem" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblIsInstant" runat="server" Text="Instant?"></asp:Label>
                            </td>
                            <td>
                                <asp:CheckBox ID="chkBoxIsInstantFoodItem" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label runat="server" ID="lblOrderTimeLimit" Text="Order Time Limit?"></asp:Label>
                            </td>
                            <td>
                                <asp:CheckBox runat="server" ID="chkOrderTimeLimit" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label runat="server" ID="lblFree" Text="Free?"></asp:Label>
                            </td>
                            <td>
                                <asp:CheckBox runat="server" ID="chkFree" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label runat="server" ID="lblIsOfficial" Text="Is Official Lunch?"></asp:Label>
                            </td>
                            <td>
                                <asp:CheckBox runat="server" ID="chkIsOfficial" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="right-col">
                    <div class="uploader-border">
                        <IMP:DFSImageUploader runat="server" ID="FoodImageUploader" />
                    </div>
                </div>
                <div class="clear">
                </div>
            </div>
            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" ValidationGroup="fooditem" />
            <asp:Button ID="btnFoodCancel" runat="server" Text="Cancel" OnClientClick=" return confirm('Are you sure you want to leave this page?'); "
                        CausesValidation="false" OnClick="btnFoodCancel_Click" />
        </div>
    </asp:Panel>
</asp:Content>