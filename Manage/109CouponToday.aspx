<%@ Page Title="109 Coupons Today" Language="C#" AutoEventWireup="true" MasterPageFile="~/DFS.Master" CodeBehind="109CouponToday.aspx.cs" Inherits="DFS.Web.Manage._109CouponToday" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="/timepicker/include/jquery-ui-1.8.14.custom.css" type="text/css" />
    <link rel="stylesheet" href="/timepicker/jquery.ui.timepicker.css?v=0.3.0" type="text/css" />
    <script type="text/javascript" src="/timepicker/include/jquery.ui.core.min.js"> </script>
    <script type="text/javascript" src="/timepicker/include/jquery.ui.widget.min.js"> </script>
    <script type="text/javascript" src="/timepicker/include/jquery.ui.tabs.min.js"> </script>
    <script type="text/javascript" src="/timepicker/include/jquery.ui.position.min.js"> </script>
    <script type="text/javascript" src="/timepicker/jquery.ui.timepicker.js?v=0.3.0"> </script>
    <script type="text/javascript" src="/Scripts/CanteenManager.js"> </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">   
       
    <asp:Panel ID="Search109Orders" runat="server">
        <table class="DateSelectorContainer" style="border: none; width: 25% !important;">
            <tr>
                <td><b>Go To Date</b></td>
                <td>
                    <asp:TextBox runat="server" ID="txt109OrderDate" Width="125px" CssClass="dfs-txt"></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="calExtMissedOrderDate" runat="server" TargetControlID="txt109OrderDate" CssClass="calendar" Format="MM/dd/yyyy" BehaviorID="calExtMissedOrderDate">
                    </ajaxToolkit:CalendarExtender>
                </td>
                <td>
                    <asp:Button ID="btnChangeDate" OnClick="btnChangeDate_Click" runat="server" Text="Go To" CssClass="dfs-btn dfs-btn-small dfs-btn-default" /></td>
            </tr>
        </table>       
        <asp:TextBox ID="txtSearch109Orders" runat="server" TabIndex="32766" CssClass="dfs-txt"></asp:TextBox>
        &nbsp;
        <asp:Button ID="btnSearch109Orders" OnClick="btnSearch109Orders_Click" runat="server" Text="Search" CssClass="dfs-btn dfs-btn-default dfs-btn-small" />
        <br/>
        <asp:Label runat="server">Totals Requested: <%=TotalRequested %></asp:Label>
        <br/>
        <asp:Label runat="server">Totals Delivered: <%=TotalDelivered %></asp:Label>

    </asp:Panel>
    <br />
    <asp:GridView ID="couponGV" runat="server" ForeColor="#333333" ItemType="DFS.Core.ViewModels.ServeItemViewModel"
        CellSpacing="0" CellPadding="4" border="1" CssClass="dtTable todayordergrid" GridLines="Vertical" Width="100%" AutoGenerateColumns="False"
        OnRowDataBound="couponsOrder_RowDataBound"
        OnRowCommand="couponsOrder_RowCommand">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <EmptyDataTemplate>
            No Record(s) Found!
        </EmptyDataTemplate>
        <Columns>
            <asp:TemplateField HeaderText="Customer ID" HeaderStyle-Width="7%">
                <ItemTemplate>
                    <asp:LinkButton ID="lblOrderEmpID" runat="server" CssClass="preview" Text='<%#Item.UserId %>' OnClientClick=" return false; "></asp:LinkButton>
                    <asp:HiddenField ID="hfUseAvatar" Value='<%#Item.UserImage %>' runat="server" />
                    <asp:HiddenField ID="hfIsReady" Value='<%# Item.IsReady %>' runat="server" />
                    <asp:HiddenField ID="hfFoodOrderIDs" Value='<%#Item.Id %>' runat="server" />
                </ItemTemplate>

                <HeaderStyle Width="7%"></HeaderStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Employee Name" HeaderStyle-Width="20%">
                <ItemTemplate>
                    <asp:Label ID="lblFullName" runat="server" Text='<%#Item.FullName %>'></asp:Label>
                </ItemTemplate>

                <HeaderStyle Width="20%"></HeaderStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Item" HeaderStyle-Width="47%">
                <ItemTemplate>
                    <asp:Label ID="lblOrderItem" runat="server" Text='<%#Item.FoodName %>'></asp:Label>
                </ItemTemplate>

                <HeaderStyle Width="47%"></HeaderStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Elapsed Time" HeaderStyle-Width="8%">
                <ItemTemplate>
                    <asp:Label ID="lblElaspedtime" runat="server" Text='<%#string.Format("{0} mins", Item.ElaspedTime) %>'></asp:Label>
                </ItemTemplate>

                <HeaderStyle Width="8%"></HeaderStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Actions" HeaderStyle-Width="18%">
                <ItemTemplate>
                    <asp:Button ID="btnSelect" runat="server" Text="Select" CommandName="select" CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>'
                        CssClass="dfs-btn dfs-btn-default dfs-btn-small" />
                    <asp:Button ID="btnDeliver" runat="server" Text="Delivered" CommandName="deliver" CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>'
                        CssClass="dfs-btn dfs-btn-green dfs-btn-small" />
                </ItemTemplate>

                <HeaderStyle Width="18%"></HeaderStyle>
            </asp:TemplateField>
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#8E8E8E" ForeColor="White" HorizontalAlign="left" CssClass="pager" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
</asp:Content>
