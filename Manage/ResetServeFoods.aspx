<%@ Page Title="Reset Food Orders" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true" CodeBehind="ResetServeFoods.aspx.cs" Inherits="DFS.Web.ManageFood.ResetServeFoods" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel ID="upPanel" runat="server">
        <ContentTemplate>
            <asp:Timer ID="timer" runat="server" OnTick="timer_Tick" Interval="20000">
            </asp:Timer>
            <asp:Panel ID="pnlLog" GroupingText="Reset FoodOrder Log" runat="server">
                <div id="SearchPanel">
                    <br />
                    <asp:Label ID="lblSearch" runat="server" Text="Type search keyword here" Font-Bold="true"></asp:Label>&nbsp
                    <asp:TextBox ID="txtSearch" runat="server" Width="250px"></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" />
                    <br />

                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtSearch"
                                                    Display="Dynamic" ErrorMessage="Invalid Input" ForeColor="Red" ValidationExpression="^[0-9a-zA-Z ]+$"></asp:RegularExpressionValidator>
                </div>
                <asp:GridView ID="gvResetLog" runat="server" AutoGenerateColumns="False" CellPadding="4"
                              CssClass="dtTable" ForeColor="#333333" GridLines="None" ItemType="DFS.Core.ViewModels.ResetLogViewModel">
                    <AlternatingRowStyle BackColor="White" />
                    <EmptyDataTemplate>
                        <strong>No Record(s) Found!</strong>
                    </EmptyDataTemplate>

                    <Columns>
                        <asp:TemplateField HeaderText="DFS ID">
                            <ItemTemplate>
                                <asp:Label ID="lblUserId" runat="server" Text="<%#Item.UserID %>"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Full Name">
                            <ItemTemplate>
                                <asp:Label ID="lblFullName" runat="server" Text="<%#Item.FullName %>"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Food Name">
                            <ItemTemplate>
                                <asp:Label ID="lblFoodName" runat="server" Text="<%#Item.FoodName %>"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty">
                            <ItemTemplate>
                                <asp:Label ID="lblQty" runat="server" Text="<%#Item.Qty %>"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Label ID="lblStatus" runat="server" Text="<%#Item.Status %>"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Last Serve Time">
                            <ItemTemplate>
                                <asp:Label ID="lblLastServeTime" runat="server" Text='<%#Item.LastServeTime %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Reset Time">
                            <ItemTemplate>
                                <asp:Label ID="lblResetTime" runat="server" Text="<%#Item.ResetTime %>"></asp:Label>
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
    </asp:UpdatePanel>
</asp:Content>