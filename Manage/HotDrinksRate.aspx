<%@ Page Title="Hot Drinks Rate" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true" CodeBehind="HotDrinksRate.aspx.cs" Inherits="DFS.Web.ManageFood.HotDrinksRate" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }
    </script>
    <style type="text/css">
        .table-border {
            width: 50%;
            border: none;
        }

        .td { border: none; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel ID="updtPanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnlSetRate" GroupingText="Set Tea/Coffee Rate" runat="server">
                <div class="form-wrapper">
                <asp:Label ID="lblCurrentTeaRates" runat="server" Text="Current Tea Rates:" CssClass="frm-heading"></asp:Label>
                <table id="HotDrinks" class="table-border">
                    <tr>
                        <td width="90px" class="table-border">
                            <asp:Label ID="lblRateBlackTea" Text="Black Tea: " runat="server"></asp:Label>
                        </td>
                        <td width="200px" class="table-border">
                            <asp:TextBox ID="txtRateBlackTea" runat="server" ReadOnly="true"></asp:TextBox>
                        </td>                        
                        <td width="90px" class="table-border">
                            <asp:Label ID="lblRateMilkTea" Text="Milk Tea: " runat="server"></asp:Label>
                        </td>
                        <td class="table-border">
                            <asp:TextBox ID="txtRateMilkTea" runat="server" ReadOnly="true"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td width="90px" class="table-border">
                            <asp:Label ID="lblRateBlackCoffee" runat="server" CssClass="frm-lbl"
                                       Text="Black Coffee: " Width="72px"></asp:Label>
                        </td>
                        <td width="200px" style="border: none">
                            <asp:TextBox ID="txtRateBlackCoffee" runat="server" ReadOnly="true"></asp:TextBox>
                        </td>

                        <td style="border: none">
                            <asp:Label ID="lblRateMilkCoffee0" runat="server"
                                       Text="Milk Coffee: " Width="72px"></asp:Label></td>
                        <td class="auto-style3" style="border: none;">
                            <asp:TextBox ID="txtRateMilkCoffee" runat="server" ReadOnly="true"></asp:TextBox></td>
                    </tr>
                    <tr style="border: none">
                        <td style="border: none">
                            <asp:Label ID="lblTeaType" Text="Tea/Coffee:" runat="server"></asp:Label></td>
                        <td style="border: none">
                            <asp:DropDownList ID="ddlTea" runat="server" style="margin-right: 0;">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rvChooseTea" runat="server" ValidationGroup="r"
                                                        ForeColor="Red" ErrorMessage="Please choose Tea/Coffee." ControlToValidate="ddlTea"
                                                        InitialValue="0">*
                            </asp:RequiredFieldValidator>
                        </td>
                        <td style="border: none">
                            <asp:Label ID="lblSetRate" Text="Rate:" runat="server"></asp:Label></td>
                        <td style="border: none">
                            <asp:TextBox ID="txtSetRate" runat="server" onkeypress="return isNumberKey(event)"  style="margin-right: 0;">
                            </asp:TextBox>
                            <asp:RequiredFieldValidator ID="rvRate" runat="server" ValidationGroup="r" Display="Dynamic"
                                                        ForeColor="Red" ErrorMessage="Rate is required." ControlToValidate="txtSetRate">*
                            </asp:RequiredFieldValidator>
                        </td>
                        <td class="table-border">
                            <asp:Button ID="btnSet" Text="Set" runat="server" ValidationGroup="r" OnClick="btnSet_Click"
                                        CssClass="btn" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <asp:ValidationSummary ID="ValidationSummary" runat="server" ValidationGroup="r"
                                                   ForeColor="Red" ShowMessageBox="false" ShowSummary="true" DisplayMode="List" />
                        </td>
                    </tr>
                </table>
                <ajaxToolkit:ConfirmButtonExtender ID="cbe" BehaviorID="cbe" runat="server" TargetControlID="btnSet"
                                                   ConfirmText="Are you sure you want to set?" />
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>