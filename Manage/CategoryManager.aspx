<%@ Page Title="Add/Edit Category" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true"
         CodeBehind="CategoryManager.aspx.cs" Inherits="DFS.Web.ManageFood.CategoryManager" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel ID="upPanelCategory" runat="server" ChildrenAsTriggers="true">
        <ContentTemplate>
            <asp:HiddenField ID="hfCommandName" runat="server" />
            <asp:HiddenField ID="hfId" runat="server" />
            <asp:LinkButton ID="lnkAddItem" class="add-category" runat="server" Text="Add Category" CommandName="CmdAdd"
                            OnClick="lnkAddItem_Click"></asp:LinkButton>
            <asp:Panel ID="pnlFoodItem" runat="server" GroupingText="Food Category">
                <asp:Panel ID="pnlOrderCancelConfirm" runat="server" CssClass="modalPopup" Style="display: none">
                    <table style="border: none;">
                        <tr>
                            <td style="border-right: none;">Are you sure you want to delete this category?</td>
                        </tr>
                        <tr>
                            <td style="border-right: none;">
                                <asp:Button ID="btnYes" runat="server" Text="Yes" />
                                <asp:Button ID="btnNo" runat="server" Text="No" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:GridView ID="gvFoodCategory" runat="server" AutoGenerateColumns="False" CellPadding="4"
                              ForeColor="#ffffff" GridLines="None" PageSize="10" AllowPaging="True"
                              CssClass="dtTable" AllowSorting="true" ShowFooter="false" OnRowCommand="gvCategory_RowCommand" OnPageIndexChanging="gvFoodCategory_PageIndexChanging">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <EmptyDataTemplate>
                        <itemtemplate>No record found!</itemtemplate>
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:TemplateField HeaderText="S.No.">
                            <ItemStyle Width="200px" />
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                                <asp:Label ID="lblID" Text='<%#Eval("id") %>' runat="server" Visible="false" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Category Name" SortExpression="Title">
                            <ItemStyle Width="210px" />
                            <ItemTemplate>
                                <asp:Label ID="lblcategoryname" runat="server" Text='<%#Eval("Description") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemStyle Width="50px" />
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="lnkItemEdit" ToolTip="Edit Category" CommandName="CmdEdit"
                                                OnClick="lnkItemEdit_Click">
                                    <img src="/images/edit.png" alt="Edit" />
                                </asp:LinkButton>
                                <asp:LinkButton runat="server" ToolTip="Delete Category" ID="lnkItemDelete" CommandName="CmdDelete">
                                    <img src="/images/delete.png" alt="Delete">
                                </asp:LinkButton>
                                <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="lnkItemDelete"
                                                        PopupControlID="pnlOrderCancelConfirm" CancelControlID="btnNo" OkControlID="btnYes"
                                                        BackgroundCssClass="modalBackground">
                                </asp:ModalPopupExtender>
                                <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="lnkItemDelete"
                                                           DisplayModalPopupID="ModalPopupExtender1">
                                </asp:ConfirmButtonExtender>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#8e8e8e" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#8E8E8E" Font-Bold="True" />
                    <PagerStyle BackColor="#8E8E8E" ForeColor="White" HorizontalAlign="left" CssClass="pager" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
                <div style="margin-top: 5px;">
                    <i>You are viewing page <%= gvFoodCategory.PageIndex + 1 %> of <%= gvFoodCategory.PageCount %></i>
                </div>
            </asp:Panel>
            <asp:HiddenField ID="btnHidden" runat="server" />
            <asp:ModalPopupExtender ID="modalpopup" runat="server" PopupControlID="pnlAddcategory"
                                    TargetControlID="btnHidden" CancelControlID="btnFoodCancel" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:Panel ID="pnlAddcategory" runat="server" CssClass="modalPopup" align="center" Width="280px"
                       Style="display: none">
                <table width="100%" class="category" style="border: none;">
                    <tr>
                        <td style="border-right: none;"></td>
                        <td colspan="2" style="border-right: none;">
                            <asp:RequiredFieldValidator ID="reqValFood" runat="server" ForeColor="Red" Display="Dynamic"
                                                        ErrorMessage="Food Category is required." ControlToValidate="txtFoodCategory"
                                                        ValidationGroup="fooditem"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td width="40%" valign="top" style="border: none;">
                            <asp:Literal ID="ltrFoodName" runat="server" Text="Food Category<font color='red'>*</font>"></asp:Literal>
                        </td>
                        <td width="40%" style="border-right: none;">
                            <asp:TextBox ID="txtFoodCategory" runat="server" Width="185px"></asp:TextBox>

                        </td>
                        <td width="20%" style="border-right: none;"></td>
                    </tr>

                    <tr>
                        <td style="border-right: none;"></td>
                        <td colspan="2" class="btnsave_category" style="border-right: none;">
                            <asp:Button ID="btnSave" runat="server" Text="Add" ValidationGroup="fooditem" OnClick="btnSave_Click" />
                            <asp:Button ID="btnFoodCancel" runat="server" Text="Cancel" /></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:RegularExpressionValidator ID="revFoodCategory" runat="server"
                                                            ForeColor="Red" Display="Dynamic" ValidationGroup="fooditem"
                                                            ErrorMessage="Invalid input"
                                                            ControlToValidate="txtFoodCategory"
                                                            ValidationExpression="^[a-zA-Z0-9\s.\-,:]+" /></td>
                        <td></td>
                    </tr>
                </table>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>