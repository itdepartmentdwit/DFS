<%@ Page Title="Expense Report" Language="C#" MasterPageFile="~/DFS.Master"
AutoEventWireup="true" CodeBehind="ExpenseReport.aspx.cs"
Inherits="DFS.Web.Report.ExpenseReport" %> <%@ Register Assembly="DFS.Web"
Namespace="DFS.Web.CustomControls" TagPrefix="cc" %> <%@ Register
Src="~/UserControls/DateRangeSelectorUserControl.ascx" TagPrefix="DBV"
TagName="DateRangeSelectorUserControl" %> <%@ Register
Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register TagPrefix="cc" Namespace="DFS.Web.CustomControls"
Assembly="DFS.Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <script type="text/javascript">
    $(document).ready(function () {
      $(".chosen_select").chosen({ allow_single_deselect: true });
    });
  </script>
</asp:Content>
<asp:Content
  ID="Content2"
  ContentPlaceHolderID="ContentPlaceHolder1"
  runat="server"
>
  <input type="hidden" id="LoggedInUserCompanyShortName" runat="server" />
  <asp:Panel runat="server" ID="filterPanel" GroupingText="Filters">
    <asp:Panel
      runat="server"
      ID="searchByFilterPanel"
      Visible="false"
      CssClass="fivepixelbottommargin"
    >
      <asp:RadioButtonList
        runat="server"
        ID="searchByRadiobuttonList"
        RepeatDirection="Horizontal"
        Font-Bold="true"
        AutoPostBack="true"
        OnSelectedIndexChanged="searchByRadiobuttonList_SelectedIndexChanged"
      >
        <asp:ListItem
          Selected="True"
          Text="Search by Email"
          Value="SEARCHBYEMAIL"
        />
        <asp:ListItem Text="Search by User Type" Value="SEARCHBYUSERTYPE" />
      </asp:RadioButtonList>

      <asp:DropDownList
        runat="server"
        ID="ddlEmail"
        ClientIDMode="Static"
        Width="300"
        CssClass="chosen_select"
      >
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
        Width="300"
        CssClass="chosen_select"
      >
      </cc:GroupedDropDownList>

      <%--
      <td>
        <asp:Label
          runat="server"
          ID="lblItemList"
          Text=" Display With Items List:"
          Font-Bold="true"
        >
        </asp:Label>
        <asp:CheckBox runat="server"></asp:CheckBox>
      </td>
      --%>
      <br />
      <table width="375px">
        <tr>
          <td><b> Display Using:</b></td>
          <td>
            <asp:RadioButtonList
              runat="server"
              ID="displayByRadiobuttonList"
              RepeatDirection="Horizontal"
              Font-Bold="true"
              AutoPostBack="true"
            >
              <asp:ListItem
                Selected="True"
                Text="User Details"
                Value="UserDetails"
              />
              <asp:ListItem Text="Item List" Value="ItemList" />
            </asp:RadioButtonList>
          </td>
        </tr>
      </table>
    </asp:Panel>
    <DBV:DateRangeSelectorUserControl
      runat="server"
      ID="DateRangeSelectorUserControl"
      EnglishStartEndDateSelectorVisible="true"
      NepaliYearMonthSelectorVisible="true"
      EnglishYearMonthSelectorVisible="true"
    />
  </asp:Panel>
  <asp:Panel
    ID="pnlExpenseByEmail"
    GroupingText="Expense"
    runat="server"
    Visible="false"
  >
    <p>
      <asp:Label
        runat="server"
        ID="lblCurrentFilterByEmail"
        CssClass="currentfilter"
      ></asp:Label>
    </p>
    <asp:GridView
      runat="server"
      ID="gvExpenseByEmail"
      AutoGenerateColumns="False"
      CellPadding="4"
      CssClass="dtTable"
      ForeColor="white"
      GridLines="None"
      ShowFooter="True"
      AllowPaging="True"
      PageSize="32"
      OnRowDataBound="gvExpenseByEmail_RowDataBound"
      OnRowCommand="gvExpenseByEmail_RowCommand"
      OnPageIndexChanging="gvExpenseByEmail_PageIndexChanging"
      ItemType="DFS.Core.ViewModels.ExpenseByEmail"
      ClientIDMode="Static"
    >
      <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
      <EmptyDataTemplate>
        <span style="color: #cc3300"><b>No Records Found!</b> </span>
      </EmptyDataTemplate>
      <Columns>
        <asp:TemplateField HeaderText="Date" ItemStyle-HorizontalAlign="Center">
          <ItemTemplate>
            <asp:Label
              runat="server"
              ID="lblOrderDate"
              Text="<%# Item.OrderDate %>"
            ></asp:Label>
          </ItemTemplate>
          <HeaderStyle CssClass="aligncenter" />
          <ItemStyle CssClass="aligncenter" />
          <FooterStyle CssClass="norightborder" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Name">
          <ItemTemplate>
            <asp:Label
              runat="server"
              ID="lblName"
              Text="<%# Item.FullName %>"
            ></asp:Label>
          </ItemTemplate>
          <FooterStyle CssClass="noleftborder norightborder" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Email">
          <ItemTemplate>
            <asp:Label
              runat="server"
              ID="lblEmail"
              Text="<%# Item.Email %>"
            ></asp:Label>
          </ItemTemplate>
          <FooterStyle CssClass="noleftborder norightborder" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="DFS ID">
          <ItemTemplate>
            <asp:Label
              runat="server"
              ID="lblDFSID"
              Text="<%# Item.DFSID %>"
            ></asp:Label>
          </ItemTemplate>
          <FooterStyle CssClass="noleftborder norightborder" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="User Type">
          <ItemTemplate>
            <asp:Label
              runat="server"
              ID="lblUserType"
              Text="<%# Item.UserType %>"
            ></asp:Label>
          </ItemTemplate>
          <FooterStyle CssClass="noleftborder textalignright" />
          <FooterTemplate> Total </FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Expense">
          <ItemTemplate>
            <asp:LinkButton
              runat="server"
              ID="lnkExpense"
              Text="<%# Item.Liability %>"
              CommandName="ShowDetails"
              CommandArgument="<%#(((GridViewRow) Container).RowIndex) %>"
            >
            </asp:LinkButton>
          </ItemTemplate>
          <FooterTemplate>
            <asp:Label ID="lblTotalExpense" runat="server"></asp:Label>
          </FooterTemplate>
          <HeaderStyle CssClass="alignright" />
          <ItemStyle CssClass="alignright" />
          <FooterStyle CssClass="alignright" />
        </asp:TemplateField>
      </Columns>
      <EditRowStyle BackColor="#999999" />
      <FooterStyle BackColor="#8e8e8e" Font-Bold="True" ForeColor="White" />
      <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" />
      <PagerSettings PageButtonCount="5" />
      <PagerStyle
        BackColor="#8E8E8E"
        ForeColor="White"
        HorizontalAlign="left"
        CssClass="pager"
      />
      <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
      <SelectedRowStyle
        BackColor="#E2DED6"
        Font-Bold="True"
        ForeColor="#333333"
      />
      <SortedAscendingCellStyle BackColor="#E9E7E2" />
      <SortedAscendingHeaderStyle BackColor="#506C8C" />
      <SortedDescendingCellStyle BackColor="#FFFDF8" />
      <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <% if (gvExpenseByEmail.PageCount > 0) { %>
    <p class="paginginfo">
      You are viewing page <%= gvExpenseByEmail.PageIndex + 1 %> of <%=
      gvExpenseByEmail.PageCount %>
    </p>
    <% } %>
  </asp:Panel>
  <asp:HiddenField ID="btnHiddenField" runat="server" />
  <asp:ModalPopupExtender
    ID="btnHiddenField_ModalPopupExtender"
    runat="server"
    Enabled="True"
    PopupControlID="pnlFoodOrderForTheDatePopup"
    TargetControlID="btnHiddenField"
    CancelControlID="btnOK"
    BackgroundCssClass="modalBackground"
  >
  </asp:ModalPopupExtender>
  <asp:Panel
    ID="pnlFoodOrderForTheDatePopup"
    runat="server"
    Style="display: none;"
    CssClass="orderForDatePopup"
  >
    <asp:GridView
      ID="gvFoodOrderForTheDate"
      runat="server"
      AutoGenerateColumns="False"
      ShowFooter="True"
      BackColor="White"
      BorderColor="#336666"
      BorderStyle="Double"
      BorderWidth="3px"
      CellPadding="4"
      GridLines="Horizontal"
      OnRowDataBound="gvFoodOrderForTheDate_RowDataBound"
    >
      <Columns>
        <asp:TemplateField HeaderText="Item">
          <ItemTemplate>
            <asp:Label
              ID="lblItem"
              runat="server"
              Text='<%#Bind("name") %>'
            ></asp:Label>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Quantity">
          <ItemTemplate>
            <asp:Label
              ID="lblQuantity"
              runat="server"
              Text='<%#Bind("quantity") %>'
            ></asp:Label>
          </ItemTemplate>
          <HeaderStyle CssClass="alignright" />
          <ItemStyle CssClass="alignright" />
          <FooterStyle CssClass="alignright" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Rate">
          <ItemTemplate>
            <asp:Label
              ID="lblRate"
              runat="server"
              Text='<%#Bind("rate") %>'
            ></asp:Label>
          </ItemTemplate>
          <FooterTemplate>
            <asp:Label
              ID="lblTotal"
              runat="server"
              Text="Total:"
              Font-Bold="true"
            ></asp:Label>
          </FooterTemplate>
          <HeaderStyle CssClass="alignright" />
          <ItemStyle CssClass="alignright" />
          <FooterStyle CssClass="alignright" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Price">
          <ItemTemplate>
            <asp:Label
              ID="lblPrice"
              runat="server"
              Text='<%#Bind("price") %>'
            ></asp:Label>
          </ItemTemplate>
          <FooterTemplate>
            <asp:Label
              ID="lblTotalPrice"
              runat="server"
              Font-Bold="true"
            ></asp:Label>
          </FooterTemplate>
          <HeaderStyle CssClass="alignright" />
          <ItemStyle CssClass="alignright" />
          <FooterStyle CssClass="alignright" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Discount">
          <ItemTemplate>
            <asp:Label
              ID="lblDiscount"
              runat="server"
              Text='<%#Bind("discount") %>'
            ></asp:Label>
          </ItemTemplate>
          <FooterTemplate>
            <asp:Label
              ID="lblTotalDiscount"
              runat="server"
              Font-Bold="true"
            ></asp:Label>
          </FooterTemplate>
          <HeaderStyle CssClass="alignright" />
          <ItemStyle CssClass="alignright" />
          <FooterStyle CssClass="alignright" />
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Subsidy">
          <ItemTemplate>
            <asp:Label
              runat="server"
              ID="lblSubsidy"
              Text='<%#Bind("subsidy") %>'
            ></asp:Label>
          </ItemTemplate>
          <FooterTemplate>
            <asp:Label
              ID="lblTotalSubsidy"
              runat="server"
              Font-Bold="true"
            ></asp:Label>
          </FooterTemplate>
          <HeaderStyle CssClass="alignright" />
          <ItemStyle CssClass="alignright" />
          <FooterStyle CssClass="alignright" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Net Price">
          <ItemTemplate>
            <asp:Label
              ID="lblNetPrice"
              runat="server"
              Text='<%#Eval("net_price","{0:n}")%>'
            ></asp:Label>
          </ItemTemplate>
          <FooterTemplate>
            <asp:Label
              ID="lblTotalNetPrice"
              runat="server"
              Font-Bold="true"
            ></asp:Label>
          </FooterTemplate>
          <HeaderStyle CssClass="alignright" />
          <ItemStyle CssClass="alignright" />
          <FooterStyle CssClass="alignright" />
        </asp:TemplateField>
      </Columns>

      <FooterStyle BackColor="White" ForeColor="#333333" />
      <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
      <PagerStyle
        BackColor="#8E8E8E"
        ForeColor="White"
        HorizontalAlign="Left"
      />
      <RowStyle BackColor="White" ForeColor="#333333" />
      <SelectedRowStyle
        BackColor="#339966"
        Font-Bold="True"
        ForeColor="White"
      />
      <SortedAscendingCellStyle BackColor="#F7F7F7" />
      <SortedAscendingHeaderStyle BackColor="#487575" />
      <SortedDescendingCellStyle BackColor="#E5E5E5" />
      <SortedDescendingHeaderStyle BackColor="#275353" />
    </asp:GridView>
    <br />
    <br />
    <asp:Button ID="btnOK" Text="OK" runat="server" />
  </asp:Panel>
  <asp:Panel
    ID="pnlExpenseByUserType"
    GroupingText="Expense"
    runat="server"
    Visible="false"
  >
    <p>
      <asp:Label
        runat="server"
        ID="lblCurrentFilterByUserType"
        CssClass="currentfilter"
      ></asp:Label>
    </p>
    <asp:GridView
      runat="server"
      ID="gvExpenseByUserType"
      AutoGenerateColumns="False"
      CellPadding="4"
      CssClass="dtTable"
      ForeColor="white"
      GridLines="None"
      ShowFooter="True"
      AllowPaging="True"
      PageSize="100"
      ItemType="DFS.Core.ViewModels.ExpenseByUserType"
      ClientIDMode="Static"
      OnPageIndexChanging="gvExpenseByUserType_PageIndexChanging"
      OnRowDataBound="gvExpenseByUserType_RowDataBound"
    >
      <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
      <EmptyDataTemplate>
        <span style="color: #cc3300"><b>No Records Found!</b> </span>
      </EmptyDataTemplate>
      <Columns>
        <asp:TemplateField HeaderText="Date" ItemStyle-HorizontalAlign="Center">
          <ItemTemplate>
            <asp:Label
              runat="server"
              ID="lblOrderDate"
              Text="<%# Item.Date %>"
            ></asp:Label>
          </ItemTemplate>
          <HeaderStyle CssClass="aligncenter" />
          <ItemStyle CssClass="aligncenter" />
          <FooterStyle CssClass="norightborder" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Name">
          <ItemTemplate>
            <asp:Label
              runat="server"
              ID="lblName"
              Text="<%# Item.FullName %>"
            ></asp:Label>
          </ItemTemplate>
          <FooterStyle CssClass="norightborder" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Email">
          <ItemTemplate>
            <asp:Label
              runat="server"
              ID="lblEmail"
              Text="<%# Item.Email %>"
            ></asp:Label>
          </ItemTemplate>
          <FooterStyle CssClass="norightborder noleftborder" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="DFS ID">
          <ItemTemplate>
            <asp:Label
              runat="server"
              ID="lblDFSID"
              Text="<%# Item.DFSID %>"
            ></asp:Label>
          </ItemTemplate>
          <HeaderStyle CssClass="alignright" />
          <ItemStyle CssClass="alignright" />
          <FooterStyle CssClass="norightborder noleftborder" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="User Type">
          <ItemTemplate>
            <asp:Label
              runat="server"
              ID="lblUserType"
              Text="<%# Item.UserType %>"
            ></asp:Label>
          </ItemTemplate>
          <FooterTemplate> Total </FooterTemplate>
          <FooterStyle CssClass="noleftborder alignright" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Expense">
          <ItemTemplate>
            <asp:Label
              runat="server"
              ID="lblExpense"
              Text="<%# Item.Expense %>"
            ></asp:Label>
          </ItemTemplate>
          <FooterTemplate>
            <asp:Label ID="lblTotalExpense" runat="server"></asp:Label>
          </FooterTemplate>
          <HeaderStyle CssClass="alignright" />
          <ItemStyle CssClass="alignright" />
          <FooterStyle CssClass="alignright" />
        </asp:TemplateField>
      </Columns>
      <EditRowStyle BackColor="#999999" />
      <FooterStyle BackColor="#8e8e8e" Font-Bold="True" ForeColor="White" />
      <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" />
      <PagerSettings PageButtonCount="5" />
      <PagerStyle
        BackColor="#8E8E8E"
        ForeColor="White"
        HorizontalAlign="left"
        CssClass="pager"
      />
      <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
      <SelectedRowStyle
        BackColor="#E2DED6"
        Font-Bold="True"
        ForeColor="#333333"
      />
      <SortedAscendingCellStyle BackColor="#E9E7E2" />
      <SortedAscendingHeaderStyle BackColor="#506C8C" />
      <SortedDescendingCellStyle BackColor="#FFFDF8" />
      <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <% if (gvExpenseByUserType.PageCount > 0) { %>
    <p class="paginginfo">
      You are viewing page <%= gvExpenseByUserType.PageIndex + 1 %> of <%=
      gvExpenseByUserType.PageCount %>
    </p>
    <% } %>
  </asp:Panel>

  <asp:Panel
    ID="pnlExpensesByFoodItem"
    GroupingText="Expense"
    runat="server"
    Visible="false"
  >
    <p>
      <asp:Label
        runat="server"
        ID="lblCurrentFilterByFoodItem"
        CssClass="currentfilter"
      ></asp:Label>
    </p>
    <asp:GridView
      runat="server"
      ID="gvExpensesByFoodItem"
      AutoGenerateColumns="False"
      CellPadding="4"
      CssClass="dtTable"
      ForeColor="white"
      GridLines="None"
      ShowFooter="True"
      AllowPaging="True"
      PageSize="32"
      ItemType="DFS.Core.ViewModels.ExpensesByFoodItem"
      ClientIDMode="Static"
      OnPageIndexChanging="gvExpenseByFoodItem_PageIndexChanging"
      OnRowDataBound="gvExpenseByFoodItem_RowDataBound"
    >
      <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
      <EmptyDataTemplate>
        <span style="color: #cc3300"><b>No Records Found!</b> </span>
      </EmptyDataTemplate>
      <Columns>
        <asp:TemplateField
          HeaderText="Food Name"
          ItemStyle-HorizontalAlign="Center"
        >
          <ItemTemplate>
            <asp:Label
              runat="server"
              ID="lblFoodName"
              Text="<%# Item.FoodName %>"
            ></asp:Label>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Rate">
          <ItemTemplate>
            <asp:Label
              runat="server"
              ID="lblRate"
              Text="<%# Item.Rate %>"
            ></asp:Label>
          </ItemTemplate>
          <FooterStyle CssClass="norightborder" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Quantity">
          <ItemTemplate>
            <asp:Label
              runat="server"
              ID="lblQuantity"
              Text="<%# Item.Quantity %>"
            ></asp:Label>
          </ItemTemplate>
          <FooterStyle CssClass="norightborder" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Expense">
          <ItemTemplate>
            <asp:Label
              runat="server"
              ID="lblExpense"
              Text="<%# Item.Expense %>"
            ></asp:Label>
          </ItemTemplate>
          <FooterTemplate>
            <asp:Label ID="lblTotalExpense" runat="server"></asp:Label>
          </FooterTemplate>
          <HeaderStyle CssClass="alignright" />
          <ItemStyle CssClass="alignright" />
          <FooterStyle CssClass="alignright" />
        </asp:TemplateField>
      </Columns>
      <EditRowStyle BackColor="#999999" />
      <FooterStyle BackColor="#8e8e8e" Font-Bold="True" ForeColor="White" />
      <HeaderStyle BackColor="#8e8e8e" Font-Bold="True" />
      <PagerSettings PageButtonCount="5" />
      <PagerStyle
        BackColor="#8E8E8E"
        ForeColor="White"
        HorizontalAlign="left"
        CssClass="pager"
      />
      <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
      <SelectedRowStyle
        BackColor="#E2DED6"
        Font-Bold="True"
        ForeColor="#333333"
      />
      <SortedAscendingCellStyle BackColor="#E9E7E2" />
      <SortedAscendingHeaderStyle BackColor="#506C8C" />
      <SortedDescendingCellStyle BackColor="#FFFDF8" />
      <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <% if (gvExpensesByFoodItem.PageCount > 0) { %>
    <p class="paginginfo">
      You are viewing page <%= gvExpensesByFoodItem.PageIndex + 1 %> of <%=
      gvExpensesByFoodItem.PageCount %>
    </p>
    <% } %>
  </asp:Panel>
  <asp:Button
    ID="btnGenerateReport"
    runat="server"
    Style="cursor: pointer"
    OnClick="btnGenerateReport_Click"
    ToolTip="Export to Excel"
  />
</asp:Content>
