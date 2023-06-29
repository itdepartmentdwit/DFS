<%@ Page Title="Process Orders" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true"
    CodeBehind="CanteenManager.aspx.cs" Inherits="DFS.Web.ManageFood.CanteenManager" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="/timepicker/include/jquery-ui-1.8.14.custom.css" type="text/css" />
    <link rel="stylesheet" href="/timepicker/jquery.ui.timepicker.css?v=0.3.0" type="text/css" />
    <script type="text/javascript" src="/timepicker/include/jquery.ui.core.min.js"> </script>
    <script type="text/javascript" src="/timepicker/include/jquery.ui.widget.min.js"> </script>
    <script type="text/javascript" src="/timepicker/include/jquery.ui.tabs.min.js"> </script>
    <script type="text/javascript" src="/timepicker/include/jquery.ui.position.min.js"> </script>
    <script type="text/javascript" src="/timepicker/jquery.ui.timepicker.js?v=0.3.0"> </script>
    <script type="text/javascript" src="/Scripts/CanteenManager.js"> </script>
    <style type="text/css">
        .greenColor {
            background-color: green;
            color: white;
            padding: 7px 40px 7px 40px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div>
        <div id="divLoader">
            <asp:UpdateProgress ID="updProgressCanteenManager" runat="server">
                <ProgressTemplate>
                    <img src="/images/ajax-loader.gif" alt="Loading...." />
                </ProgressTemplate>
            </asp:UpdateProgress>
        </div>
        <a href="OrderSummary.aspx" target="_blank" class="btn">Today Order's Summary</a>
        <asp:HyperLink ID="hlManualFoodOrder" runat="server" CssClass="btn" NavigateUrl="~/FoodOrder.aspx"
            Visible="false">Manual Food Order</asp:HyperLink>
        <div style="font-size: 14px; font-weight: bold; text-align: center !important; color: #e55608; margin-bottom: -18px">
            <label>109 Coupon Count :</label>
            <asp:Label ID="lbl109CouponCount" runat="server" Text="10"></asp:Label>
        </div>

        <br />
        <br />
        <asp:Panel ID="pnlTodayOrder" runat="server" GroupingText="Today's Order" Width="100%">
            <asp:UpdatePanel ID="updPnlTodayOrder" runat="server" UpdateMode="Always" ChildrenAsTriggers="true">
                <ContentTemplate>
                    <asp:Panel ID="pnlFastDelivery" runat="server">
                        <asp:Panel ID="pnlFastDeliveryEmpIds" runat="server">
                        </asp:Panel>
                        <asp:GridView ID="gvIndividualOrder" runat="server" AutoGenerateColumns="False" CellPadding="4"
                            CssClass="dtTable" ForeColor="#333333" GridLines="None" OnRowCommand="gvIndividualOrder_RowCommand"
                            OnRowDataBound="gvIndividualOrder_RowDataBound">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:TemplateField HeaderText="Employee ID">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lblIndividualEmpID" runat="server" Text='<%#Bind("EmployeeID") %>'
                                            CssClass="preview"></asp:LinkButton>
                                        <asp:HiddenField ID="lblEmail" Value='<%#Bind("Email") %>' runat="server" />
                                        <asp:HiddenField ID="hfUseAvatar" Value='<%#Bind("ImagePath") %>' runat="server" />
                                        <asp:HiddenField ID="hfIndividualServeMe" Value='<%#Bind("FoodServe") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Employee Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIndividualEmpName" runat="server" Text='<%#Bind("EmployeeName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Item">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIndividualOrderItem" runat="server" Text='<%#Bind("FoodName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Quantity">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIndividualOrderQuantity" runat="server" Text='<%#Bind("FoodQuantity") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIndividualStatus" runat="server" Text='<%#Bind("Status") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Ordered Time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIndividualOrderedTime" runat="server" Text='<%#Bind("OrderedTime") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delivered Time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIndividualDeliveryTime" runat="server" Text='<%#Bind("DeliveryTime") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Elapsed Time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIndividualEt" runat="server" Text='<%#Bind("ElapsedTime") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField Visible="true" HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:Button ID="btnIndividualServeMe" runat="server" Text="Serve Me" CommandName="ServeMe"
                                            CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>' CssClass="btn1" />
                                        <asp:Button ID="btnIndividualDeliver" runat="server" Text="Deliver" CommandName="deliver"
                                            CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>' CssClass="btnDeliver" />
                                        <asp:Button ID="btnIndividualNotAvailable" runat="server" Text="Cancel" CommandName="notAvailable" Visible="false"
                                            CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>' CssClass="btn" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIndividualFoodOrderID" runat="server" Text='<%#Bind("FoodOrderID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIndividualPrice" runat="server" Text='<%#Bind("FoodPrice") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                        </asp:GridView>
                    </asp:Panel>
                    <asp:Panel runat="server" ID="pnlOrderMgmt">
                        <div class="canteen_mag">
                            <table style="width: 100%; margin: 0; padding: 0;">
                                <tr>
                                    <td width="25%">
                                        <div class="order_menu">
                                            <ul>
                                                <li>
                                                    <asp:LinkButton ID="lnkPending" runat="server" ClientIDMode="AutoID" CommandArgument="PENDING" OnClick="lnkOrderStatus_Click" Visible="false">PENDING</asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="lnkToBeServed" runat="server" ClientIDMode="AutoID" CommandArgument="TO BE SERVED" OnClick="lnkOrderStatus_Click">TO BE SERVED</asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="lnkOnProcess" runat="server" ClientIDMode="AutoID" CommandArgument="ON PROCESS" OnClick="lnkOrderStatus_Click">ON PROCESS</asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="lnkDelivered" runat="server" ClientIDMode="AutoID" CommandArgument="DELIVERED" OnClick="lnkOrderStatus_Click">DELIVERED</asp:LinkButton>
                                                </li>
                                            </ul>
                                        </div>
                                    </td>
                                    <td width="75%">
                                        <asp:Button ID="btnSearch" runat="server" Text="Search" Style="float: right; margin-right: 5px"
                                            OnClick="btnSearch_Click" CssClass="btn" />
                                        <asp:TextBox ID="tbSearch" runat="server" Style="float: right; margin-right: 5px; margin-left: 21px;"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <asp:GridView ID="gvTodayOrder" runat="server" CellPadding="4" ForeColor="#333333"
                            GridLines="Vertical" Width="100%" AutoGenerateColumns="False" OnRowDataBound="gvTodayOrder_RowDataBound"
                            OnRowCommand="gvTodayOrder_RowCommand" CssClass="dtTable todayordergrid">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <EmptyDataTemplate>
                                <strong>No Record(s) Found!</strong>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="Employee ID">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lblOrderEmpID" runat="server" CssClass="preview"  Text='<%#Bind("EmployeeID") %>'>
                                        </asp:LinkButton>
                                        <asp:HiddenField ID="lblEmail" Value='<%#Bind("Email") %>' runat="server" />
                                        <asp:HiddenField ID="hfUseAvatar" Value='<%#Bind("ImagePath") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Employee Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblOrderEmpName" runat="server" Text='<%#Bind("EmployeeName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Item">
                                    <ItemTemplate>
                                        <asp:Label ID="lblOrderItem" runat="server" Text='<%#Bind("FoodName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Quantity">
                                    <ItemTemplate>
                                        <asp:Label ID="lblOrderQuantity" runat="server" Text='<%#Bind("FoodQuantity") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <asp:Label ID="lblOrderStatus" runat="server" Text='<%#Bind("Status") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Ordered Time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblOrderOrderedTime" runat="server" Text='<%#Bind("OrderedTime") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delivered Time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblOrderDeliveryTime" runat="server" Text='<%#Bind("DeliveryTime") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:Button ID="btnServeMe" runat="server" Text="Serve Me" CommandName="Serve Me" CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>' CssClass="btn1" />
                                        <asp:Button ID="btnNotAvailable" runat="server" Text="Cancel" CommandName="notAvailable"
                                            CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>' Width="100px" CssClass="btn" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFoodOrderID" runat="server" Text='<%#Bind("FoodOrderID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPrice" runat="server" Text='<%#Bind("FoodPrice") %>'></asp:Label>
                                    </ItemTemplate>
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
                        <asp:GridView ID="gvToBeServed" runat="server" ForeColor="#333333" ItemType="DFS.Core.ViewModels.ServeItemViewModel"
                            CellSpacing="0" CellPadding="4" border="1" CssClass="dtTable todayordergrid" GridLines="Vertical" Width="100%" AutoGenerateColumns="False"
                            OnRowDataBound="gvToBeServed_RowDataBound"
                            OnRowCommand="gvToBeServed_RowCommand">
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
                                        <asp:HiddenField ID="hfFoodOrderIDs" Value='<%#Item.FoodOrderId %>' runat="server" />
                                        <asp:HiddenField ID="hfEmail" Value='<%#Item.UserRole %>' runat="server" />

                                        
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Employee Name" HeaderStyle-Width="20%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFullName" runat="server" Text='<%#Item.FullName %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Item" HeaderStyle-Width="47%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblOrderItem" runat="server" Text='<%#Item.FoodName %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Elapsed Time" HeaderStyle-Width="8%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblElaspedtime" runat="server" Text='<%#string.Format("{0} mins", Item.ElaspedTime) %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Actions" HeaderStyle-Width="18%">
                                    <ItemTemplate>
                                        <asp:Button ID="btnReady" runat="server" Text="Ready" CommandName="Ready" CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>'
                                            CssClass="btnReady" />
                                        <asp:Button ID="btnReset" runat="server" Text="Reset" CommandName="reset" CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>'
                                            CssClass="btn1" />
                                        <asp:Button ID="btnDeliver" runat="server" Text="Deliver" CommandName="deliver" CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>'
                                            CssClass="btnDeliver" />
                                        <asp:Button ID="btnNotAvailable" runat="server" Text="Cancel" CommandName="notavailable" CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>'
                                            CssClass="btn" />
                                    </ItemTemplate>
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
                    </asp:Panel>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="lnkToBeServed" />
                    <asp:AsyncPostBackTrigger ControlID="lnkDelivered" />
                    <asp:AsyncPostBackTrigger ControlID="lnkOnProcess" />
                </Triggers>
            </asp:UpdatePanel>
        </asp:Panel>
    </div>
</asp:Content>
