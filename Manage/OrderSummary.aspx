<%@ Page Title="Order Summary" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true"
         CodeBehind="OrderSummary.aspx.cs" Inherits="DFS.Web.ManageFood.OrderSummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .footeros td {
            background-color: #8E8E8E !important;
            color: white;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel ID="updPnlOrderSummaries" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnlOrderSummary" runat="server" GroupingText="Order Summary" Style="float: left; width: 50%">
                <div style="margin: 10px 10px; width: 300px;">
                    <b>Date&nbsp;&nbsp;</b>
                    <asp:TextBox runat="server" ID="txtEngStartDate" ReadOnly="true" ClientIDMode="Static" ValidationGroup="EngStartEndDateValidationGroup" EnableViewState="true" Width="115px">
                    </asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="calExtEngStartDate" runat="server" TargetControlID="txtEngStartDate" CssClass="calendar" Format="MM/dd/yyyy">
                    </ajaxToolkit:CalendarExtender>
                    <asp:Button runat="server" ID="btnDisplay" Text="Display" CssClass="btn" ValidationGroup="EngStartEndDateValidationGroup" CommandArgument="SearchByEnglishStartEndDate" OnClick="btnDisplay_Click1" />
                </div>
                <asp:GridView ID="gvOrderSummary" runat="server" CellPadding="4" ForeColor="#333333"
                              GridLines="Vertical" Width="75%" CssClass="dtTable" AutoGenerateColumns="False"
                              OnRowCommand="gvOrderSummary_RowCommand" OnRowDataBound="gvOrderSummary_RowDataBound"
                              ShowFooter="true">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <EmptyDataTemplate>
                        <strong>No orders to be displayed!</strong>
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:TemplateField HeaderText="Item">
                            <ItemTemplate>
                                <asp:Label ID="lblSummaryItem" runat="server" Text='<%#Bind("FoodName") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterStyle CssClass="noleftborder norightborder" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ordered Quantity">
                            <ItemTemplate>
                                <asp:Label ID="lblSummaryOrderedQty" runat="server" Text='<%#Bind("OrderedQuantity") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <FooterStyle CssClass="noleftborder norightborder" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Delivered Quantity">
                            <ItemTemplate>
                                <asp:Label ID="lblSummaryDeliveredQty" runat="server" Text='<%#Bind("DeliveredQuantity") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <FooterStyle CssClass="noleftborder norightborder" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Still To Deliver">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnSummaryStillToDeliver" Text='<%#Bind("QuantityWaitingForDelivery") %>'
                                                runat="server" CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>'></asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <FooterStyle CssClass="noleftborder norightborder" />
                        </asp:TemplateField>
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle Font-Bold="true" CssClass="footeros" />
                    <HeaderStyle BackColor="#8E8E8E" Font-Bold="True" ForeColor="White" />
                    <PagerSettings PageButtonCount="5" />
                    <PagerStyle BackColor="#8E8E8E" ForeColor="White" HorizontalAlign="left" CssClass="pager" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />

                </asp:GridView>
            </asp:Panel>
            <asp:Panel ID="pnlTimeWiseOrderSummary" runat="server" GroupingText="Time Wise Order Summary"
                       Style="float: right; width: 48%">
                <asp:GridView ID="gvTimeWiseOrderSummary" runat="server" CellPadding="4" ForeColor="#333333"
                              GridLines="Vertical" AutoGenerateColumns="False" OnRowCommand="gvTimeWiseOrderSummary_RowCommand"
                              OnRowDataBound="gvTimeWiseOrderSummary_RowDataBound" CssClass="dtTable">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <EmptyDataTemplate>
                        <strong>No orders to be delivered!</strong>
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:TemplateField HeaderText="Delivery Time">
                            <ItemTemplate>
                                <asp:Label ID="lblTimeWiseDeliveryTime" runat="server" Text='<%#Bind("delivery_time") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Food Items">
                            <ItemTemplate>
                                <asp:Label ID="lblTimeWiseFoodName" runat="server" Text='<%#Bind("name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Still To Deliver">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnTimeWiseStillToDeliver" Text='<%#Bind("to_deliver") %>'
                                                runat="server" CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>'></asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#8E8E8E" Font-Bold="True" ForeColor="White" />

                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#8E8E8E" ForeColor="White" HorizontalAlign="left" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
            </asp:Panel>
            <div class="clear"></div>
            <asp:Panel ID="pnlStillToDeliverPopup" runat="server" GroupingText="Employee Names:To Be Delivered"
                       CssClass="modalPopup" Style="display: none">
                <asp:ListBox ID="txtEmplyeeNamesToDeliver" runat="server" Height="100px" Width="350px" />
                <asp:Button ID="btnOkay" runat="server" Text="Close" />
            </asp:Panel>
            <asp:HiddenField ID="btnHidden" runat="server" />
            <ajaxToolkit:ModalPopupExtender ID="mpeStillToDeliverPopup" runat="server" TargetControlID="btnHidden"
                                            PopupControlID="pnlStillToDeliverPopup" OkControlID="btnOkay" BackgroundCssClass="modalBackground">
            </ajaxToolkit:ModalPopupExtender>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>