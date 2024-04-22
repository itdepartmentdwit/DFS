<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DateRangeSelectorUserControl.ascx.cs" Inherits="DFS.Web.UserControls.DateRangeSelectorUserControl" %>
<table class="DateSelectorContainer" style="border: none; width: 690px !important;" >    
    <tr>
        <td colspan="5" style="border: none; background: none; padding: 2px 0 !important;">
            <asp:CustomValidator ID="EnglishEndDateCustomValidator" runat="server"
                                 ControlToValidate="txtEngEndDate" 
                                 ErrorMessage="English End Date must be greater than or equal to English Start Date."
                                 SetFocusOnError="true"
                                 CssClass="msg-error"
                                 Display="Dynamic"
                                 OnServerValidate="EnglishEndDateCustomValidator_ServerValidate"
                                 ValidationGroup="EngStartEndDateValidationGroup">
            </asp:CustomValidator>
        </td>
    </tr>
    <tr runat="server" id="engStartEndDateRow" >
        <td><b>English Start Date</b></td>
        <td>
            <asp:TextBox runat="server" ID="txtEngStartDate" ReadOnly="true" ClientIDMode="Static" ValidationGroup="EngStartEndDateValidationGroup" EnableViewState="true" Width="115px">
            </asp:TextBox>
            <ajaxToolkit:CalendarExtender ID="calExtEngStartDate" runat="server" TargetControlID="txtEngStartDate" CssClass="calendar" Format="MM/dd/yyyy">
            </ajaxToolkit:CalendarExtender>
        </td>
        <td><b>English End Date</b>
        </td>
        <td>
            <asp:TextBox runat="server" ID="txtEngEndDate" ReadOnly="true" ClientIDMode="Static" ValidationGroup="EngStartEndDateValidationGroup" EnableViewState="true" Width="115px"></asp:TextBox>
            <ajaxToolkit:CalendarExtender ID="calExtEngEndDate" runat="server" TargetControlID="txtEngEndDate" CssClass="calendar" Format="MM/dd/yyyy">
            </ajaxToolkit:CalendarExtender>
        </td>
        <td>
            <asp:Button runat="server" ID="btnSearchByEngStartEndDate" Text="Search" CssClass="btn" ValidationGroup="EngStartEndDateValidationGroup" CommandArgument="SearchByEnglishStartEndDate" OnClick="btnSearch_Click" />
        </td>
    </tr>
    <tr runat="server" id="nepaliYearMonthRow">
        <td class="DtSelContFirstCol"><b>Select Nepali Year</b></td>
        <td class="DtSelContSecondCol">
            <asp:DropDownList runat="server" ID="ddNepaliYear" Width="120px">
            </asp:DropDownList>
        </td>
        <td class="DtSelContThirdCol"><b>Select Nepali Month</b></td>
        <td class="DtSelContFourthCol">
            <asp:DropDownList runat="server" ID="ddNepaliMonth" Width="120px">
                <asp:ListItem Text="Baisakh" Value="1"></asp:ListItem>
                <asp:ListItem Text="Jestha" Value="2"></asp:ListItem>
                <asp:ListItem Text="Ashad" Value="3"></asp:ListItem>
                <asp:ListItem Text="Shrawan" Value="4"></asp:ListItem>
                <asp:ListItem Text="Bhadra" Value="5"></asp:ListItem>
                <asp:ListItem Text="Ashwin" Value="6"></asp:ListItem>
                <asp:ListItem Text="Kartik" Value="7"></asp:ListItem>
                <asp:ListItem Text="Mangsir" Value="8"></asp:ListItem>
                <asp:ListItem Text="Poush" Value="9"></asp:ListItem>
                <asp:ListItem Text="Magh" Value="10"></asp:ListItem>
                <asp:ListItem Text="Falgun" Value="11"></asp:ListItem>
                <asp:ListItem Text="Chaitra" Value="12"></asp:ListItem>
            </asp:DropDownList>
        </td>
        <td class="DtSelContFifthCol">
            <asp:Button runat="server" ID="btnSearchByNepYearMonth" CssClass="btn" Text="Search" CommandArgument="SearchByNepaliYearMonth" OnClick="btnSearch_Click" />
        </td>
    </tr>
    <tr runat="server" id="engYearMonthRow">
        <td><b>Select English Year</b></td>
        <td>
            <asp:DropDownList runat="server" ID="ddEngYear" Width="120px"> <%--SelectMethod="GetEnglishYears"--%>
            </asp:DropDownList>
        </td>
        <td><b>Select English Month</b></td>
        <td>
            <asp:DropDownList runat="server" ID="ddEngMonth"  Width="120px">
                <asp:ListItem Text="January" Value="1"></asp:ListItem>
                <asp:ListItem Text="February" Value="2"></asp:ListItem>
                <asp:ListItem Text="March" Value="3"></asp:ListItem>
                <asp:ListItem Text="April" Value="4"></asp:ListItem>
                <asp:ListItem Text="May" Value="5"></asp:ListItem>
                <asp:ListItem Text="June" Value="6"></asp:ListItem>
                <asp:ListItem Text="July" Value="7"></asp:ListItem>
                <asp:ListItem Text="August" Value="8"></asp:ListItem>
                <asp:ListItem Text="September" Value="9"></asp:ListItem>
                <asp:ListItem Text="October" Value="10"></asp:ListItem>
                <asp:ListItem Text="November" Value="11"></asp:ListItem>
                <asp:ListItem Text="December" Value="12"></asp:ListItem>
            </asp:DropDownList>
        </td>
        <td>
            <asp:Button runat="server" ID="btnSearchByEngYearMonth" CssClass="btn" Text="Search" CommandArgument="SearchByEnglishYearMonth" OnClick="btnSearch_Click" />
        </td>
    </tr>
</table>