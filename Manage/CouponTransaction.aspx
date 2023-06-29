<%@ Page Title="Coupon Transcation" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true" CodeBehind="CouponTransaction.aspx.cs" Inherits="DFS.Web.Manage.CouponTransaction" %>

<%@ Register Assembly="DFS.Web" Namespace="DFS.Web.CustomControls" TagPrefix="cc" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/UserControls/DateRangeSelectorUserControl.ascx" TagPrefix="DBV" TagName="DateRangeSelectorUserControl" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function() {
            $(".chosen_select").chosen({ allow_single_deselect: true });
        });

        function pageLoad() {
            $(".chosen_select").chosen({ allow_single_deselect: true });
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="/Scripts/toastr.min.js" type="text/javascript"> </script>
        <div style="bottom: 50%; left: 50%; position: fixed; text-align: center; z-index: 10000;">
            <asp:UpdateProgress ID="updProgressEmployee" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                <ProgressTemplate>
                    <img src="../images/ajax-loader.gif" alt="Loading...." />
                </ProgressTemplate>
            </asp:UpdateProgress>
        </div>

    
     <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Always" GroupingText="Order Messsage">
            <ContentTemplate>
                  <asp:Panel ID="pnlDateSelector" runat="server" GroupingText="Coupon Transaction" CssClass="fivepixelbottommargin">  
                      <table class="couponTable">
                <tr>
                    <%--<td> Email:</td>
                    <td>   
                        <asp:DropDownList
                runat="server"
                ID="ddlEmail"
                ClientIDMode="Static"
                Width="300"
                
                CssClass="chosen_select">
                        
            </asp:DropDownList>

                    </td>--%>
                       <td>Status :</td>
                    <td>   
                        <asp:DropDownList
                runat="server"
                ID="ddlStatus"
                ClientIDMode="Static"
                    CssClass="chosen_select"   
                    Width="100"
               >
                             </asp:DropDownList>

                    </td>
                    <td> Coupon ID: </td>
                    <td> <asp:TextBox ID="txtCouponId" runat="server" Width="100px"></asp:TextBox></td>
                   
                </tr>
            
            </table>
        <DBV:DateRangeSelectorUserControl runat="server" ID="DateRangeSelectorUserControl"
                                          EnglishStartEndDateSelectorVisible="true"
                                          NepaliYearMonthSelectorVisible="true"
                                          EnglishYearMonthSelectorVisible="true" />
    </asp:Panel>
               
                        <asp:GridView ID="gvCouponTransaction"
                            runat="server"
                            AutoGenerateColumns="False"
                            CellPadding="4"
                            CssClass="dtTable"
                            ForeColor="#333333"
                             PageSize="32"
                               ShowFooter="True"
                      AllowPaging="True"
                              OnRowCommand="gvCouponTransaction_RowCommand"  
                            OnPageIndexChanging="gvCouponTransaction_PageIndexChanging"
                            EnableViewState="true"
                            GridLines="None"
                            Width="100%"
                          >
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <EmptyDataTemplate>
                                <b>No Records.</b>
                            </EmptyDataTemplate>
                            <Columns>
                                                 
                                <asp:TemplateField HeaderText="Used Date" >
                                    <ItemTemplate>
                                        <div class="_dviTRate">
                                            <asp:HiddenField ID="hfTransactionId" runat="server" Value='<%# Eval("Id") %>'></asp:HiddenField>
                                            <asp:Label ID="lblUsedDate" runat="server" Text='<%# Eval("Date") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Name" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblUserName" runat="server" Text='<%# ((string)Eval("UserName")).Replace("|", "<br/>") %>' ></asp:Label>
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                <asp:TemplateField HeaderText="Email" >
                                    <ItemTemplate>
                                        <div class="_dviTQty">
                                            <asp:Label ID="lblEmail" runat="server"  Text='<%# ((string)Eval("Email")).Replace("|", "<br/>") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Coupon Id" HeaderStyle-Width="6%" >
                                    <ItemTemplate>
                                        <div class="_dviTAmount">
                                            <asp:Label ID="lblCouponId" runat="server" Text='<%# ((string)Eval("CouponId")).Replace("|", "<br/>") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                   
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
         
                                <asp:TemplateField HeaderText="Used By" >
                                    <ItemTemplate>
                                        <div class="_dviTAmount">
                                            <asp:Label ID="lblUsedby" runat="server" Text='<%# Eval("UsedBy") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                   
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField> <asp:TemplateField HeaderText="Coupon worth" >
                                    <ItemTemplate>
                                        <div class="_dviTAmount">
                                            <asp:Label ID="lblCouponWorth" runat="server" Text='<%# Eval("CouponWorth") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                   
                                    <ItemStyle HorizontalAlign="Center" />

                                </asp:TemplateField> 
                                       <asp:TemplateField HeaderText="Total Amount" HeaderStyle-Width="10%">
                                    <ItemTemplate>
                                        <div class="_dviTAmount">
                                            <asp:Label ID="lblTotalAmt" runat="server" Text='<%# Eval("TotalAmount") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                   
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField><asp:TemplateField HeaderText="Extra Amount" >
                                    <ItemTemplate>
                                        <div class="_dviTAmount">
                                            <asp:Label ID="lblExtraAmt" runat="server" Text='<%# Eval("ExcessCash") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                   
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Action" HeaderStyle-Width="7%">
                                    <ItemStyle CssClass="Actions" />
                                    <ItemTemplate>
                                            <asp:LinkButton runat="server" ID="lnkDeleteCouponTransaction"  ToolTip="Delete Coupon Transaction" CommandArgument='<%# Eval("Id") %>'
                                            CommandName="lnkDeleteCouponTransaction" OnClientClick=" return DFS.Notification.JsConfirmDialog('Are you sure you want to delete this transaction?'); ">
                                            <img alt="Cancel" src="../images/delete.png"   /></asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
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
                 <asp:Label ID="lblUsedDate" runat="server" Text='<%# Eval("Date") %>'></asp:Label>
          <%
            if (gvCouponTransaction.PageCount > 0)
            { %>
            <p class="paginginfo">
                You are viewing page <%= gvCouponTransaction.PageIndex + 1 %> of <%= gvCouponTransaction.PageCount %>
            </p>
        <% }
        %>
                </ContentTemplate>
         </asp:UpdatePanel>
     <div id="_DialogContainer">
        </div>
</asp:Content>
