<%@ Page Title="Daily Hot Drinks Intake" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true" CodeBehind="HotDrinksIntake.aspx.cs" Inherits="DFS.Web.ManageFood.HotDrinksIntake" %>

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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel ID="updtPanel" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnlTeaQuantity" runat="server" GroupingText="Day's Tea/Coffee Quanity">
                <asp:Label ID="lblTea" Text="Tea:" runat="server"></asp:Label>
                <asp:DropDownList ID="ddlTeaType" runat="server">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rvChooseHotDrinkType" runat="server" ValidationGroup="s"
                                            ForeColor="Red" ErrorMessage="Please choose tea/coffee type." ControlToValidate="ddlTeaType"
                                            InitialValue="0">*
                </asp:RequiredFieldValidator>
                <asp:Label ID="lblDate" runat="server" Text="Date:"></asp:Label>
                <asp:TextBox ID="txtDate" runat="server" onkeypress="javascript:return false"></asp:TextBox>
                <asp:CalendarExtender ID="calexDate" runat="server" TargetControlID="txtDate" CssClass="calendar">
                </asp:CalendarExtender>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="s" ControlToValidate="txtDate"
                                      Type="Date" Operator="LessThanEqual" ForeColor="Red" ErrorMessage="Date can not exceed present date.">*</asp:CompareValidator>
               
                <asp:RequiredFieldValidator ID="rvEnterDate" runat="server" ValidationGroup="s"
                                            ForeColor="Red" ErrorMessage="Please enter date." ControlToValidate="txtDate">*</asp:RequiredFieldValidator>
                <asp:Label ID="lblQuantity" Text="Quantity:" runat="server"></asp:Label>
                <asp:TextBox ID="txtQuantity" onkeypress="return isNumberKey(event)" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rvEnterQuantity" ValidationGroup="s" ForeColor="Red"
                                            runat="server" ErrorMessage="Please enter quantity." ControlToValidate="txtQuantity">*</asp:RequiredFieldValidator>
                <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="s" OnClick="btnSave_Click"
                            CssClass="btn" />
                <asp:ValidationSummary ID="ValidationSummary" runat="server" ValidationGroup="s"
                                       ForeColor="Red" ShowMessageBox="true" ShowSummary="false" DisplayMode="List" />
                <br /><br />
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>