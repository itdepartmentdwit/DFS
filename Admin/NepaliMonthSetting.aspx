<%@ Page Title="Nepali Date Setting" Language="C#" MasterPageFile="~/DFS.Master"
AutoEventWireup="true" CodeBehind="NepaliMonthSetting.aspx.cs"
Inherits="DFS.Web.Admin.NepaliMonthSetting" EnableEventValidation="false" %> <%@
Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit"
TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <style type="text/css">
    .content {
      overflow: visible !important;
    }
  </style>
</asp:Content>
<asp:Content
  ID="Content2"
  ContentPlaceHolderID="ContentPlaceHolder1"
  runat="server"
>
  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
      <div>
        <asp:Label
          ID="lblChooseYear"
          runat="server"
          Text="Choose Nepali Year:"
        ></asp:Label>
        <asp:DropDownList ID="ddlNepYear" runat="server">
          <asp:ListItem
            Selected="True"
            Text="--Choose Year--"
            Value="0"
          ></asp:ListItem>
          <asp:ListItem Value="2068" Text="2068"></asp:ListItem>
          <asp:ListItem Value="2069" Text="2069"></asp:ListItem>
          <asp:ListItem Value="2070" Text="2070"></asp:ListItem>
          <asp:ListItem Value="2071" Text="2071"></asp:ListItem>
          <asp:ListItem Value="2072" Text="2072"></asp:ListItem>
          <asp:ListItem Value="2073" Text="2073"></asp:ListItem>
          <asp:ListItem Value="2074" Text="2074"></asp:ListItem>
          <asp:ListItem Value="2075" Text="2075"></asp:ListItem>
          <asp:ListItem Value="2076" Text="2076"></asp:ListItem>
          <asp:ListItem Value="2077" Text="2077"></asp:ListItem>
          <asp:ListItem Value="2078" Text="2078"></asp:ListItem>
          <asp:ListItem Value="2079" Text="2079"></asp:ListItem>
          <asp:ListItem Value="2080" Text="2080"></asp:ListItem>
          <asp:ListItem Value="2081" Text="2081"></asp:ListItem>
        </asp:DropDownList>
        <asp:RequiredFieldValidator
          ID="RequiredFieldValidator1"
          runat="server"
          ValidationGroup="s"
          ForeColor="Red"
          ErrorMessage="Please choose Year"
          ControlToValidate="ddlNepYear"
          InitialValue="0"
          >*
        </asp:RequiredFieldValidator>
        <asp:Label
          ID="lblChooseMonth"
          runat="server"
          Text="Choose Nepali Month:"
        ></asp:Label>
        <asp:DropDownList ID="ddlNepMonth" runat="server"> </asp:DropDownList>
        <asp:RequiredFieldValidator
          ID="RequiredFieldValidator2"
          runat="server"
          ValidationGroup="s"
          ForeColor="Red"
          ErrorMessage="Please choose Month"
          ControlToValidate="ddlNepMonth"
          InitialValue="0"
          >*
        </asp:RequiredFieldValidator>
        <asp:Label
          ID="lblStartDate"
          runat="server"
          Text="Start Date"
        ></asp:Label>
        <asp:TextBox ID="txtStartDate" runat="server"></asp:TextBox>
        <asp:CalendarExtender
          ID="calextStartDate"
          runat="server"
          TargetControlID="txtStartDate"
          CssClass="calendar"
        >
        </asp:CalendarExtender>
        <asp:CompareValidator
          ID="DateValidator1"
          runat="server"
          Operator="LessThan"
          Type="Date"
          ControlToValidate="txtStartDate"
          ErrorMessage="Timing between start date and end date is incorrect!"
          ControlToCompare="txtEndDate"
          ValidationGroup="s"
          ForeColor="Red"
          >*</asp:CompareValidator
        >
        <asp:Label ID="lblEndDate" runat="server" Text="End Date"></asp:Label>
        <asp:TextBox ID="txtEndDate" runat="server"></asp:TextBox>
        <asp:CalendarExtender
          ID="calextEndDate"
          runat="server"
          TargetControlID="txtEndDate"
          CssClass="calendar"
        >
        </asp:CalendarExtender>
        <asp:Button
          ID="btnSave"
          runat="server"
          Text="Save"
          Style="cursor: pointer"
          ValidationGroup="s"
          OnClick="btnSave_Click"
        />
        <br />
        <asp:Label
          ID="lblMsg"
          runat="server"
          Text="Start date or end date already exists for another month."
          ForeColor="Red"
          Visible="false"
        ></asp:Label>
        <asp:ValidationSummary
          ID="ValidationSummary1"
          runat="server"
          ValidationGroup="s"
          ForeColor="Red"
          ShowMessageBox="true"
          ShowSummary="false"
          DisplayMode="List"
        />
      </div>
    </ContentTemplate>
    <Triggers>
      <asp:AsyncPostBackTrigger ControlID="btnSave" />
    </Triggers>
  </asp:UpdatePanel>
  <br />
  <asp:UpdatePanel ID="UpdatePanel2" runat="server">
    <ContentTemplate>
      <asp:Label
        ID="lblNepaliYear"
        runat="server"
        Text="Nepali Year"
      ></asp:Label>
      <asp:DropDownList
        ID="ddlNepaliYear"
        runat="server"
        AutoPostBack="True"
        OnSelectedIndexChanged="ddlNepaliYear_SelectedIndexChanged"
      >
        <asp:ListItem Value="2068" Text="2068"></asp:ListItem>
        <asp:ListItem Value="2069" Text="2069"></asp:ListItem>
        <asp:ListItem Value="2070" Text="2070"></asp:ListItem>
        <asp:ListItem Value="2071" Text="2071"></asp:ListItem>
        <asp:ListItem Value="2072" Text="2072"></asp:ListItem>
        <asp:ListItem Value="2073" Text="2073"></asp:ListItem>
        <asp:ListItem Value="2074" Text="2074"></asp:ListItem>
        <asp:ListItem Value="2075" Text="2075"></asp:ListItem>
        <asp:ListItem Value="2076" Text="2076"></asp:ListItem>
        <asp:ListItem Value="2077" Text="2077"></asp:ListItem>
        <asp:ListItem Value="2078" Text="2078"></asp:ListItem>
        <asp:ListItem Value="2079" Text="2079"></asp:ListItem>
        <asp:ListItem Value="2080" Text="2080"></asp:ListItem>
      </asp:DropDownList>
      <br />
      <div>
        <asp:GridView
          ID="gvNepaliMonths"
          runat="server"
          AutoGenerateColumns="False"
          OnRowEditing="gvNepaliMonths_RowEditing"
          CssClass="dtTable"
          OnRowUpdating="gvNepaliMonths_RowUpdating"
          OnRowCancelingEdit="gvNepaliMonths_RowCancelingEdit"
          CellPadding="4"
        >
          <Columns>
            <asp:TemplateField HeaderText="Month No." Visible="false">
              <ItemTemplate>
                <asp:Label
                  ID="lblNepMonthNo"
                  runat="server"
                  Text='<%#Bind("NepMonthNo") %>'
                ></asp:Label>
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Year">
              <ItemTemplate>
                <asp:Label
                  ID="lblNepYear"
                  runat="server"
                  Text='<%#Bind("NepYear") %>'
                ></asp:Label>
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Month">
              <ItemTemplate>
                <asp:Label
                  ID="lblNepMonth"
                  runat="server"
                  Text='<%#Bind("NepMonth") %>'
                ></asp:Label>
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="English Start Date">
              <ItemTemplate>
                <asp:Label
                  ID="lblEngStartDate"
                  runat="server"
                  Text='<%#Bind("EngStartDate") %>'
                ></asp:Label>
              </ItemTemplate>
              <EditItemTemplate>
                <asp:TextBox
                  ID="txtEngStartDate"
                  Text='<%#Bind("EngStartDate") %>'
                  runat="server"
                  onkeypress="javascript:return false"
                ></asp:TextBox>
                <asp:CompareValidator
                  ID="dvEngStartDate"
                  runat="server"
                  Type="Date"
                  Operator="DataTypeCheck"
                  ControlToValidate="txtEngStartDate"
                  ErrorMessage="Please enter a valid date."
                  ForeColor="Red"
                >
                </asp:CompareValidator>
                <asp:CalendarExtender
                  ID="calextStartDate"
                  runat="server"
                  TargetControlID="txtEngStartDate"
                  CssClass="calendar"
                >
                </asp:CalendarExtender>
              </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="English End Date">
              <ItemTemplate>
                <asp:Label
                  ID="lblEngEndDate"
                  runat="server"
                  Text='<%#Bind("EngEndDate") %>'
                ></asp:Label>
              </ItemTemplate>
              <EditItemTemplate>
                <asp:TextBox
                  ID="txtEngEndDate"
                  runat="server"
                  Text='<%#Bind("EngEndDate") %>'
                  onkeypress="javascript:return false"
                ></asp:TextBox>
                <asp:CompareValidator
                  ID="dvEngEndDate"
                  runat="server"
                  Type="Date"
                  Operator="DataTypeCheck"
                  ControlToValidate="txtEngEndDate"
                  ErrorMessage="Please enter a valid date."
                  ForeColor="Red"
                >
                </asp:CompareValidator>
                <asp:CalendarExtender
                  ID="calextEndDate"
                  runat="server"
                  TargetControlID="txtEngEndDate"
                  CssClass="calendar"
                >
                </asp:CalendarExtender>
              </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Actions">
              <ItemTemplate>
                <asp:Button
                  ID="lnkEdit"
                  CssClass="btn"
                  Text="Edit"
                  runat="server"
                  CommandName="Edit"
                ></asp:Button>
              </ItemTemplate>
              <EditItemTemplate>
                <asp:Button
                  ID="lnkUpdate"
                  CssClass="btn"
                  Text="Update"
                  runat="server"
                  CommandName="Update"
                />
                <asp:Button
                  ID="lnkCancel"
                  CssClass="btn"
                  Text="Cancel"
                  runat="server"
                  CommandName="Cancel"
                />
              </EditItemTemplate>
            </asp:TemplateField>
          </Columns>
          <FooterStyle BackColor="White" ForeColor="#333333" />
          <HeaderStyle BackColor="#8E8E8E" Font-Bold="True" ForeColor="White" />
          <PagerStyle
            BackColor="#8E8E8E"
            ForeColor="White"
            HorizontalAlign="left"
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
      </div>
    </ContentTemplate>
  </asp:UpdatePanel>
</asp:Content>
