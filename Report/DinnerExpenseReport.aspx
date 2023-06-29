<%@ Page Title="Dinner Expense Report" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true" CodeBehind="DinnerExpenseReport.aspx.cs" Inherits="DFS.Web.Report.DinnerExpenseReport" %>

<%@ Register Assembly="DFS.Web" Namespace="DFS.Web.CustomControls" TagPrefix="cc" %>
<%@ Register Src="~/UserControls/DateRangeSelectorUserControl.ascx" TagPrefix="DBV" TagName="DateRangeSelectorUserControl" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register TagPrefix="cc" Namespace="DFS.Web.CustomControls" Assembly="DFS.Web" %>
<%@ Import Namespace="Elmah.ContentSyndication" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function() {
            $(".chosen_select").chosen({ allow_single_deselect: true });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel runat="server" ID="filterPanel" GroupingText="Dinner Expense Report">
        <asp:Panel runat="server" ID="searchByFilterPanel" Visible="false" CssClass="fivepixelbottommargin">
            <asp:RadioButtonList runat="server" ID="searchByRadiobuttonList" RepeatDirection="Horizontal" Font-Bold="true" AutoPostBack="true" OnSelectedIndexChanged="searchByRadiobuttonList_SelectedIndexChanged">
                <asp:ListItem Selected="True" Text="Search by Email" Value="SEARCHBYEMAIL" />
                <asp:ListItem Text="Search by User Type" Value="SEARCHBYUSERTYPE" />
            </asp:RadioButtonList>
            <asp:DropDownList
                runat="server"
                ID="ddlEmail"
                ClientIDMode="Static"
                Width="300"
                class="chosen_select">
            </asp:DropDownList>
            <cc:GroupedDropDownList
                ID="ddlUserType"
                runat="server"
                Style="height: 22px"
                DataTextField="Text"
                DataValueField="Value"
                DataGroupField="Group"
                Visible="false"
                ClientIDMode="Static"
                class="chosen_select">
            </cc:GroupedDropDownList>
        </asp:Panel>
        <DBV:DateRangeSelectorUserControl runat="server" ID="DateRangeSelectorUserControl"
                                          EnglishStartEndDateSelectorVisible="true"
                                          NepaliYearMonthSelectorVisible="true"
                                          EnglishYearMonthSelectorVisible="true" />
    </asp:Panel>
    <asp:Panel ID="pnlExpenseByEmail" GroupingText="Expense" runat="server" Visible="false">
        <p>
            <asp:Label runat="server" ID="lblCurrentFilterByEmail" CssClass="currentfilter"></asp:Label>
        </p>
        <asp:GridView runat="server" ID="gvExpenseByEmail"
                      AutoGenerateColumns="False"
                      CellPadding="4"
                      CssClass="dtTable"
                      ForeColor="white"
                      GridLines="None"
                      ShowFooter="True"
                      AllowPaging="True"
                      PageSize="32"
                      OnRowCommand="gvExpenseByEmail_RowCommand"
                      OnPageIndexChanging="gvExpenseByEmail_PageIndexChanging"
                      ItemType="DFS.Core.ViewModels.ExpenseByEmail"
                      ClientIDMode="Static">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <EmptyDataTemplate>
                <span style="color: #CC3300"><b>No Records Found!</b> </span>
            </EmptyDataTemplate>
            <Columns>
                <asp:TemplateField HeaderText="Date" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblOrderDate" Text='<%# Item.OrderDate %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle CssClass="aligncenter" />
                    <ItemStyle CssClass="aligncenter" />
                    <FooterStyle CssClass="norightborder" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Username">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblName" Text='<%# Item.FullName %>'></asp:Label>
                    </ItemTemplate>
                    <FooterStyle CssClass="noleftborder norightborder" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Email">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblEmail" Text='<%# Item.Email %>'></asp:Label>
                    </ItemTemplate>
                    <FooterStyle CssClass="noleftborder norightborder" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="DFS ID">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblDFSID" Text='<%# Item.DFSID %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle CssClass="alignright" />
                    <ItemStyle CssClass="alignright" />
                    <FooterStyle CssClass="noleftborder norightborder" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="User Type">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblUserType" Text='<%# Item.UserType %>'></asp:Label>
                    </ItemTemplate>
                    <FooterStyle CssClass="noleftborder textalignright" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Item">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblDinner" Text='<%# Item.DinnerName %>'></asp:Label>
                    </ItemTemplate>
                    <FooterStyle CssClass="noleftborder textalignright" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Quantity">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblDinnerQuantity" Text='<%# Item.Quantity %>'></asp:Label>
                    </ItemTemplate>
                    <FooterStyle CssClass="noleftborder textalignright" />
                </asp:TemplateField>
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#8e8e8e" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" />
            <PagerSettings PageButtonCount="5" />
            <PagerStyle BackColor="#8E8E8E" ForeColor="White" HorizontalAlign="left" CssClass="pager" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <%
            if (gvExpenseByEmail.PageCount > 0)
            { %>
            <p class="paginginfo">
                You are viewing page <%= gvExpenseByEmail.PageIndex + 1 %> of <%= gvExpenseByEmail.PageCount %>
            </p>
        <% }
        %>
    </asp:Panel>
    <asp:HiddenField ID="btnHiddenField" runat="server" />
    <asp:ModalPopupExtender ID="btnHiddenField_ModalPopupExtender" runat="server"
                            Enabled="True" PopupControlID="pnlFoodOrderForTheDatePopup" TargetControlID="btnHiddenField"
                            CancelControlID="btnOK" BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>
    <asp:Panel ID="pnlFoodOrderForTheDatePopup" runat="server" Style="display: none;"
               CssClass="orderForDatePopup">
        <asp:GridView ID="gvFoodOrderForTheDate" runat="server" AutoGenerateColumns="False"
                      CssClass="dtTable" ShowFooter="True" BackColor="White" BorderColor="#336666" BorderStyle="Double"
                      BorderWidth="3px" CellPadding="4" GridLines="Horizontal" OnRowDataBound="gvFoodOrderForTheDate_RowDataBound">
            <Columns>
                <asp:TemplateField HeaderText="Item">
                    <ItemTemplate>
                        <asp:Label ID="lblItem" runat="server" Text='<%#Bind("name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Rate">
                    <ItemTemplate>
                        <asp:Label ID="lblRate" runat="server" Text='<%#Bind("rate") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Quantity">
                    <ItemTemplate>
                        <asp:Label ID="lblQuantity" runat="server" Text='<%#Bind("quantity") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Price">
                    <ItemTemplate>
                        <asp:Label ID="lblPrice" runat="server" Text='<%#Bind("price") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblTotalPrice" runat="server" Font-Bold="true"></asp:Label>
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Discount">
                    <ItemTemplate>
                        <asp:Label ID="lblDiscount" runat="server" Text='<%#Bind("discount") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblTotalDiscount" runat="server" Font-Bold="true"></asp:Label>
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Net Price">
                    <ItemTemplate>
                        <asp:Label ID="lblNetPrice" runat="server" Text='<%#Bind("net_price") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblTotalNetPrice" runat="server" Font-Bold="true"></asp:Label>
                    </FooterTemplate>
                </asp:TemplateField>

            </Columns>
            <FooterStyle BackColor="White" ForeColor="#333333" />
            <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#8E8E8E" ForeColor="White" HorizontalAlign="left" />
            <RowStyle BackColor="White" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F7F7F7" />
            <SortedAscendingHeaderStyle BackColor="#487575" />
            <SortedDescendingCellStyle BackColor="#E5E5E5" />
            <SortedDescendingHeaderStyle BackColor="#275353" />
        </asp:GridView>
        <br />
        <br />
        <asp:Button ID="btnOK" Text="OK" runat="server" />
    </asp:Panel>
    <asp:Panel ID="pnlExpenseByUserType" GroupingText="Expense" runat="server" Visible="false">
        <p>
            <asp:Label runat="server" ID="lblCurrentFilterByUserType" CssClass="currentfilter"></asp:Label>
        </p>
        <asp:GridView runat="server" ID="gvExpenseByUserType"
                      AutoGenerateColumns="False"
                      CellPadding="4"
                      CssClass="dtTable"
                      ForeColor="white"
                      GridLines="None"
                      ShowFooter="True"
                      AllowPaging="True"
                      PageSize="100"
                      ItemType="DFS.Core.ViewModels.ExpenseByUserType"
                      OnRowDataBound="gvExpenseByUserType_RowDataBound"
                      ClientIDMode="Static" OnPageIndexChanging="gvExpenseByUserType_PageIndexChanging">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <EmptyDataTemplate>
                <span style="color: #CC3300"><b>No Records Found!</b> </span>
            </EmptyDataTemplate>
            <Columns>
                 <asp:TemplateField HeaderText="Date" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblOrderDate" Text='<%# Item.Date %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle CssClass="aligncenter" />
                    <ItemStyle CssClass="aligncenter" />
                    <FooterStyle CssClass="norightborder" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Username">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblName" Text='<%# Item.FullName %>'></asp:Label>
                    </ItemTemplate>
                    <FooterStyle CssClass="norightborder" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Email">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblEmail" Text='<%# Item.Email %>'></asp:Label>
                    </ItemTemplate>
                    <FooterStyle CssClass="norightborder noleftborder" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="DFS ID">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblDFSID" Text='<%# Item.DFSID %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle CssClass="alignright" />
                    <ItemStyle CssClass="alignright" />
                    <FooterStyle CssClass="norightborder noleftborder" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="User Type">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblUserType" Text='<%# Item.UserType %>'></asp:Label>
                    </ItemTemplate>
                    <FooterStyle CssClass="noleftborder alignright" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Dinner Details">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblDinnerDetails" Text='<%# Item.LstDinnerDetails %>'></asp:Label>
                        <%--<asp:Repeater ID="rptrFoodDetails" runat="server" DataSource='<%# Item.LstDinnerDetails %>'>--%>
                      <%--      <ItemTemplate>
                                <asp:Label ID="lblFoodName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>'></asp:Label>
                                <span style="float: right;"> 
                                    <asp:Label ID="lblFoodCount" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Count") %>'></asp:Label>
                                </span>
                                <br/>
                            </ItemTemplate>
                        </asp:Repeater>--%>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#8e8e8e" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" />
            <PagerSettings PageButtonCount="5" />
            <PagerStyle BackColor="#8E8E8E" ForeColor="White" HorizontalAlign="left" CssClass="pager" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <%
            if (gvExpenseByUserType.PageCount > 0)
            { %>
            <p class="paginginfo">
                You are viewing page <%= gvExpenseByUserType.PageIndex + 1 %> of <%= gvExpenseByUserType.PageCount %>
            </p>
        <% }
        %>
    </asp:Panel>
    <asp:Button ID="btnGenerateReport" runat="server" Style="cursor: pointer" OnClick="btnGenerateReport_Click"
                ToolTip="Export to Excel" />
</asp:Content>