<%@ Page Title="Coupon Usage Report" Language="C#"  MasterPageFile="~/DFS.Master" AutoEventWireup="true" CodeBehind="~/Report/109CouponUsageReport.aspx.cs" Inherits="DFS.Web.Report._109CouponUsageReport" EnableViewState="true" %>


<%@ Register Assembly="DFS.Web" Namespace="DFS.Web.CustomControls" TagPrefix="cc" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/UserControls/DateRangeSelectorUserControl.ascx" TagPrefix="DBV" TagName="DateRangeSelectorUserControl" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register TagPrefix="cc" Namespace="DFS.Web.CustomControls" Assembly="DFS.Web" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/Forms/CouponUsage.js" type="text/javascript"> </script>
      <script type="text/javascript">
        $(document).ready(function() {
            $(".chosen_select").chosen({ allow_single_deselect: true });
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlDateSelector" runat="server" GroupingText="DFS Coupon Usage" CssClass="fivepixelbottommargin">   

               <asp:RadioButtonList runat="server" ID="searchByRadiobuttonList" RepeatDirection="Horizontal" Font-Bold="true" AutoPostBack="true" OnSelectedIndexChanged="searchByRadiobuttonList_SelectedIndexChanged">
                <asp:ListItem Selected="True" Text="Used Coupons (As per Used date)" Value="Transaction" />
                <asp:ListItem Text="All Coupons (As per Order date)" Value="NonTransaction" />
            </asp:RadioButtonList>
          <div id="filterDiv" runat="server" visible="false"> 
            <table class="couponTable">
                <tr>
                    <td> Email:</td>
                    <td>   
                        <asp:DropDownList
                runat="server"
                ID="ddlEmail"
                ClientIDMode="Static"
                Width="300"
                
                CssClass="chosen_select">
                        
            </asp:DropDownList>

                    </td>
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
        </div>
        <DBV:DateRangeSelectorUserControl runat="server" ID="DateRangeSelectorUserControl"
                                          EnglishStartEndDateSelectorVisible="true"
                                          NepaliYearMonthSelectorVisible="true"
                                          EnglishYearMonthSelectorVisible="true" />

<%--              <div style="font-weight:bold;">
            <p style="margin-left: 3px; font-size:14px"><u><b>Coupon Summary:  </b></u></p>
                  <table class="couponTable">
                      <tr>
                          <td style="color:darkblue">Issued:</td>
                          <td>30</td>
                          <td style="color:darkgreen">Claimed:</td>
                          <td>40</td>
                            <td style="color:red">Expired:</td>
                          <td>10</td>
                          <td style="color:orangered">Used:</td>
                          <td>80</td>
                      </tr>
                   
                  </table>

</div>--%>
      
    </asp:Panel>
    <asp:Panel ID="pnlReportTransaction" runat="server" Visible="false" Width="100%" BorderWidth="1px" BorderStyle="Solid" BorderColor="#666666">
        <rsweb:ReportViewer ID="reportViewer" AsyncRendering="false" runat="server" Width="100%"
                            WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
        </rsweb:ReportViewer>
    </asp:Panel>
    <asp:Panel ID="pnlReportNonTransaction" runat="server" Visible="false" Width="100%" BorderWidth="1px" BorderStyle="Solid" BorderColor="#666666">
        <rsweb:ReportViewer ID="reportViewer1" AsyncRendering="false" runat="server" Width="100%"
                            WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
        </rsweb:ReportViewer>
    </asp:Panel>
    <div id="_dvContainer"></div>
</asp:Content>