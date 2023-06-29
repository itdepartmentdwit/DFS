<%@ Page Title="109 Operator" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true" CodeBehind="109Restaurant.aspx.cs" Inherits="DFS.Web._109Restaurant" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <script type="text/javascript">
        $(document).ready(function() {
            $(".chosen_select").chosen({ allow_single_deselect: true });
        });
    </script>
    <script src="Scripts/Forms/Employee.js" type="text/javascript"> </script>

    <%--<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>--%>
 
<script type="text/javascript">
 
function preventMultipleSubmissions() {
  $('#<%=btnUse.ClientID %>').prop('disabled', true);
}
 
window.onbeforeunload = preventMultipleSubmissions;
 
</script>
          <div style="bottom: 50%; left: 50%; position: fixed; text-align: center; z-index: 999999;">
            <asp:UpdateProgress ID="updProgressEmployee" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                <ProgressTemplate>
                    <img src="images/ajax-loader.gif" alt="Loading...." />
                </ProgressTemplate>
            </asp:UpdateProgress>
        </div>
     <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Always" GroupingText="Order Messsage">
            <ContentTemplate>
      <asp:Panel ID="pnlDFSCoupon" runat="server" GroupingText="Coupon List">
          <div>
                         <div class="coupon_search_items">
                                <asp:Button ID="btnSearchCoupon" runat="server" Text="Add Coupon (+)" CssClass="emp_btn_search"  OnClick="btnSearchCoupon_Click"
                                />
                              &nbsp;
                                <asp:TextBox ID="txtDFSId" runat="server" Width="150px"  TextMode="Number"
                                    onfocus="javascript:this.select()" ></asp:TextBox>
                                <br />
                            </div>  
          <asp:Button  ID="btnShowHide" runat="server" Text="Show/Hide Claimed Coupon" OnClick="btnShowHideCoupon_Click" CssClass="btn top-margin" />

           <div class="clear"></div>
              </div>

            <asp:Panel ID="pnlFastDeliveryEmpIds" runat="server" >
                <asp:Label ID="lblText" runat="server" Text="No Claimed Coupon "></asp:Label>
                        </asp:Panel>
                        <asp:GridView 
                            ID="gvDFSCoupon"
                            runat="server"
                            AutoGenerateColumns="False"
                            CellPadding="4"
                            CssClass="dtTable"
                            ForeColor="#333333"
                            OnRowCommand="gvDFSCoupon_RowCommand"
                              OnRowDataBound="gvDFSCoupon_RowDataBound"
                            OnRowDeleting="gvDFSCoupon_RowDeleting"
                            
  EnableViewState="true"
                            GridLines="None"
                            AllowPaging="false"
                            Width="100%"
                            ItemType="DFS.Core.ViewModels.DFSCouponViewModel">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <EmptyDataTemplate>
                                <b>No Records.</b>
                            </EmptyDataTemplate>
                            <Columns>
                                                 
                                <asp:TemplateField HeaderText="User Name" >
                                    <ItemTemplate>
                                        <div class="_dviTRate">
                                            <asp:Label ID="lblUserName" runat="server" Text='<%#: Item.UserName %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDate" runat="server" Text='<%#:Item.Date %>' ></asp:Label>
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                <asp:TemplateField HeaderText="Email" >
                                    <ItemTemplate>
                                        <div class="_dviTQty">
                                            <asp:Label ID="lblEmal" runat="server"  Text='<%#:Item.Email %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Coupon ID" >
                                    <ItemTemplate>
                                        <div class="_dviTAmount">
                                            <asp:Label ID="lblCouponId" runat="server" Text='<%#: Item.CouponId %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                   
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Coupon Status" HeaderStyle-Width="19%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCouponStatus" runat="server" Text='<%#: Item.CouponStatus %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-Width="10%">
                                           
                                <HeaderTemplate >
                                        <asp:CheckBox ID="chkBoxHeader" runat="server" onclick='employee.Grid.CheckAllServerMe(this);' Checked="false" CssClass="chkHeader" />
                                   <asp:Label runat="server" Text="Select Coupon"></asp:Label> 
                                    </HeaderTemplate>
                                       <ItemTemplate>
                                        <asp:CheckBox ID="chkBoxSelectCoupon" runat="server" CssClass="chkRow" CommandName="cbServeMe" Checked="false" onclick="employee.Grid.CheckMe(this);"
                                            CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>' />
                                    </ItemTemplate>
                        </asp:TemplateField>
                                <asp:TemplateField HeaderText="Opt." HeaderStyle-Width="7%">
                                    <ItemStyle CssClass="Actions" />
                                    <ItemTemplate>
                                            <asp:LinkButton runat="server" ID="lnkRemoveCoupon"  ToolTip="Delete Coupon" CommandArgument='<%#Item.Id %>'
                                            CommandName="lnkRemoveCoupon" OnClientClick=" return DFS.Notification.JsConfirmDialog('Are you sure you want to remove this from the list?'); ">
                                            <img alt="Cancel" src="images/delete.png"   /></asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                
                            </Columns>
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        </asp:GridView>
          <div>

          <div style="margin-top:20px" id="divUseCoupon" runat="server" visible="false"> 
                  <div style="clear:both; padding-bottom:10px;margin:1px;" >
        <div class="couponDiv">
            <asp:Label ID="lblUsedBy" runat="server" Text="Used By: " CssClass="fivepixelbottommargin"></asp:Label>
        </div>
        <div style="padding-bottom:10px" class="couponDiv">
              <asp:DropDownList
                runat="server"
                ID="ddlName"
                ClientIDMode="Static"
                Width="200"
                
                CssClass="chosen_select">

            </asp:DropDownList>
        </div>
    </div>
    <div style="clear:both;">
        <div class="couponDiv">
            <asp:Label ID="lblAmount" runat="server" Text="Total Amount: "></asp:Label>
        </div>
        <div  class="couponDiv">
           <asp:TextBox ID="txtAmount" runat="server"></asp:TextBox>
                                   <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator" 
                        ControlToValidate="txtAmount" ValidationExpression="^\d+$" EnableClientScript="true" 
                        ErrorMessage="Please Enter Numbers Only" Display="Dynamic" SetFocusOnError="True" ForeColor="Red"/>
        </div>
    </div>
              <div class="clear"></div>
              <br />
                 <div>
               <asp:Button Id="btnVerifyCoupon" runat="server" Text="Verify" CssClass="btn center" OnClick="btnVerifyCoupon_Click"/>
 
                  </div>
              </div>
</div>


           
               <asp:Panel ID="pnlCouponUsageDetails" runat="server" visible="false"  GroupingText="Messsage" CssClass="couponMessage" >
                   <asp:Label  Font-Bold="true" Font-Size="Large" Text="Coupon(s) used sucessfully." runat="server" ForeColor="Green"></asp:Label>
                   <br />
              <b>  No. of Coupon used: </b>
                <asp:Label ID="lblNoOfCoupon" runat="server" ></asp:Label><br />
                     <b>  Extra Amount to be paid: </b>Rs <asp:Label ID="lblExtraAmt" runat="server" ></asp:Label><br />
                  <b> Total Amount: </b>Rs  <asp:Label ID="lblTotalAmt" runat="server" ></asp:Label><br />
                   <b>Used By: </b>  <asp:Label ID="lblUsername" runat="server" ></asp:Label><br />
                 <input type="button" value="OK" onclick="window.location.href=window.location.href" class="btn">
               

                        </asp:Panel>


                    </asp:Panel>




    <asp:ModalPopupExtender ID="mpeVerifiedCouponinfo" BehaviorID="mpeServeMeinfo" runat="server"
                    PopupControlID="pnlVerifiedCoupon" TargetControlID="hfCouponInfo" CancelControlID="btnCancel"
                    BackgroundCssClass="modalBackground">
                </asp:ModalPopupExtender>


                            <asp:Panel ID="pnlVerifiedCoupon" runat="server" CssClass="modalPopup popupVerifyCouponinfo" Style="display: none;" >
                    <asp:HiddenField ID="hfCouponInfo" runat="server" />
                                  <div class="headertext">Verify Coupon Transaction 
                                   <div style="float: right;">
                                         <asp:Button ID="Button3" runat="server" Text="X" CssClass="btn1" Height="20" Width="20" OnClientClick="return reload();" />
                    </div>
                             </div>
                                 <div id="Div1" runat="server" style="max-height: 500px; overflow: auto;">
                      <asp:GridView 
                            ID="gvVerifiedGrid"
                            runat="server"
                            AutoGenerateColumns="False"
                           CssClass="user-table" Width="100%"
                            ItemType="DFS.Core.ViewModels.DFSCouponViewModel">
                            
                                                    <Columns>
                                                 
                                <asp:TemplateField HeaderText="UserName" >
                                    <ItemTemplate>
                                        <div class="_dviTRate">
                                            <asp:Label ID="lblUserName" runat="server" Text='<%#: Item.UserName %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDate" runat="server" Text='<%#:Item.Date %>' ></asp:Label>
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                <asp:TemplateField HeaderText="Email" >
                                    <ItemTemplate>
                                        <div class="_dviTQty">
                                            <asp:Label ID="lblEmal" runat="server"  Text='<%#:Item.Email %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Coupon ID" >
                                    <ItemTemplate>
                                        <div class="_dviTAmount">
                                            <asp:Label ID="lblCouponId" runat="server" Text='<%#: Item.CouponId %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                   
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Coupon Status" HeaderStyle-Width="19%">
                                      <ItemStyle Width="20%" ForeColor="White" BackColor="Green"/>
                                    <ItemTemplate>
                                        <asp:Label ID="lblCouponStatus" runat="server" Text='<%#: Item.CouponStatus %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                       
                                                              
                            </Columns>
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                   </asp:GridView>
                                     <br />
                                <div style="font-weight:bold;line-height:2">
                                    Used By: <asp:Label ID="lblUsedByVerified" runat="server"></asp:Label><br />
                                    Total no. of coupon: <asp:Label ID="lblTotalVerifiedCoupon" runat="server"></asp:Label><br />
                                    Total Amount: Rs  <asp:Label ID="lblVeriedTotalAmt" runat="server"> </asp:Label><br />
                                    Extra Amount: Rs  <asp:Label ID="lblVeriedExtraAmt" runat="server"> </asp:Label>
                                </div>
                    <div style="float: right;">
                        <asp:Button ID="btnUse" runat="server" Text="Use" CssClass="btn1" Height="24" Width="60" OnClick="btnUseCoupon_Click" UseSubmitBehavior="false"
   OnClientClick="this.disabled='true';"/>
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn1" Height="24" Width="60" OnClientClick="return reload();"/>
                    </div>
                                     </div>
                </asp:Panel>
                </ContentTemplate>
         </asp:UpdatePanel>
     <div id="_DialogContainer">
        </div>
</asp:Content>
