<%@ Page Title="Feedback" Language="C#" MasterPageFile="~/DFS.Master" AutoEventWireup="true"
    CodeBehind="Feedback.aspx.cs" Inherits="DFS.Web.Feedback" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="aspToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="Scripts/Plugins/jquery.shorten.js" type="text/javascript"> </script>
    <script src="Scripts/Forms/FeedBack.js" type="text/javascript"> </script>
    <script src="Scripts/Plugins/jquery.MultiFile.js" type="text/javascript"> </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('<%= FileUpload1.ClientID %>').MultiFile();

            feedback.Init('<%= btnSend.ClientID %>', '<%= btnSendResponse.ClientID %>',
                '<%= txtFeedback.ClientID %>', '<%= txtSendResponse.ClientID %>');

        });

        function pageLoad(sender, args) {
            feedback.RebindMethodAfterPartialPostBack();
            feedback.HideProgressImage();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdateProgress ID="updProgressFeedback" runat="server" DynamicLayout="true">
        <ProgressTemplate>
            <div style="text-align: center; position: fixed; left: 50%; bottom: 50%; z-index: 9999999;">
                <img src="images/ajax-loader.gif" alt="Loading...." />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:Button ID="btnGenerateReport" runat="server" Text="Generate Report to Excel" class="export-excel" value="Export Excel"
        Visible="false" Style="cursor: pointer" ToolTip="Export to Excel" OnClick="btnGenerateReport_Click" />
    <br />
    <div id="dvContainer"></div>
    <asp:UpdatePanel ID="updpnlFeedback" runat="server">
        <ContentTemplate>
            <div class="user_feedback">
                <asp:Panel ID="pnlViewFeedback" runat="server" GroupingText="">
                    <asp:HiddenField ID="hfId" runat="server" />
                    <asp:GridView ID="gvFeedback" runat="server"
                        AutoGenerateColumns="False"
                        CellPadding="4"
                        CssClass="Grid"
                        Width="100%"
                        ForeColor="#333333"
                        GridLines="Both"
                        AllowPaging="True"
                        PagerSettings-Mode="NumericFirstLast"
                        PagerSettings-Position="TopAndBottom"
                        OnRowCommand="gvFeedback_RowCommand"
                        OnPageIndexChanging="gvFeedback_PageIndexChanging">
                        <EditRowStyle BackColor="#999999" />
                        <EmptyDataTemplate>
                            <itemtemplate><b>No record found!</b></itemtemplate>
                        </EmptyDataTemplate>
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="Date" HeaderText="Date" HeaderStyle-Width="6%" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center" />
                            <asp:TemplateField HeaderText="User" HeaderStyle-Width="20%">
                                <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lblEmail" runat="server" Text='<%#Eval("UserEmail") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Name" HeaderStyle-Width="22%">
                                <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Feedback" HeaderStyle-Width="38%">
                                <ItemTemplate>
                                    <p class="wordBreak" style="text-align: left;">
                                        <asp:Label ID="lblRemarks" runat="server" Font-Names="Arial" CssClass="FeedbackMessage"
                                            Text='<%# Bind("Remarks") %>'></asp:Label>
                                    </p>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-Width="5%" HeaderText="Image" Visible="True">
                                <ItemTemplate>
                                    <div style="padding-top: 8px; text-align: center;">
                                        <asp:ListView ID="lvFeedBackImages" runat="server" DataSource='<%#FillListView(Container) %>'
                                            OnItemDataBound="lvFeedBackImages_ItemDataBound">
                                            <LayoutTemplate>
                                                <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkbtnFbImg" runat="server" data-lightbox='<%#Eval("FeedBackId") %>' href='<%#Eval("FilePath") %>'>
                                                    <asp:Image ID="imgFeedBack" runat="server" CssClass="imgFeedback" AlternateText="Preview" ImageUrl="~/images/image-preview.png" />
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:ListView>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Response" HeaderStyle-Width="25%">
                                <ItemTemplate>
                                    <p class="wordBreak" style="text-align: left;">
                                        <asp:Label ID="lblResponse" runat="server" CssClass="FeedbackMessage" Text='<%#Eval("Response") %>'></asp:Label>
                                    </p>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Respond" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkRespond" runat="server" CommandName="Popup" ToolTip="Respond"
                                        CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>'>
                                        <img src="images/respond.png" alt="Respond"/></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblId" runat="server" Text='<%#Bind("Id") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" CssClass="GridHeader" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" CssClass="GridPager" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                    </asp:GridView>
                </asp:Panel>
            </div>
            <br />
            <div>
                <asp:Panel ID="pnlSendResponse" runat="server" GroupingText="" CssClass="modalPopup">
                    <asp:TextBox ID="txtSendResponse" runat="server" TextMode="MultiLine" Width="100%" ValidateRequestMode="Disabled" Height="105px" CssClass="MultiLineTextBox"></asp:TextBox>
                    <br />
                    <br />
                    <asp:Button ID="btnSendResponse" runat="server" Text="Send" CssClass="btn" OnClick="btnSendResponse_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" />
                </asp:Panel>
                <div style="display: none">
                    <asp:HiddenField ID="btnHiddenField" runat="server" />
                    <aspToolkit:ModalPopupExtender ID="btnHiddenField_ModalPopupExtender" runat="server"
                        Enabled="True" RepositionMode="RepositionOnWindowResizeAndScroll" TargetControlID="btnHiddenField"
                        PopupControlID="pnlSendResponse" CancelControlID="btnCancel" BackgroundCssClass="modalBackground">
                    </aspToolkit:ModalPopupExtender>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvFeedback" EventName="PageIndexChanging" />
            <asp:PostBackTrigger ControlID="btnSend" />
        </Triggers>
    </asp:UpdatePanel>
    <div style="width: 950px;">
        <div style="float: left; width: 506px;">
            <asp:Panel ID="pnlFeedback" runat="server" GroupingText="">
                <asp:Label ID="lblMsg" runat="server" Text="Type your feedback here!"></asp:Label><br />
                <asp:TextBox ID="txtFeedback" runat="server" TextMode="MultiLine" Width="500px" ValidateRequestMode="Disabled"></asp:TextBox>
                <span id="span_error" style="color: Red; display: none"></span>
                <%--<input id="_cbFBUpload" type="checkbox" name="cbUpload" /><span> Upload image.</span>--%>
                <div style="float: left; margin-top: 17px;">
                    <div id="" class="_MultipleContainer" style="border: 2px solid #848484">
                        <div class="upload-title">
                            Upload Image
                        </div>
                        <div class="upload-pding">
                            <asp:HiddenField ID="hfFileUppload" runat="server" />
                            <%--<div id="DivErrorMsgs">
                                <asp:Literal ID="ltrUploadMsg" runat="server" Text=""> </asp:Literal>
                            </div>--%>
                            <asp:FileUpload ID="FileUpload1" runat="server" class="multi" accept=".png,.jpg,.jpeg,.gif,.bmp"
                                maxlength="3" ForeColor="transparent"/>
                            <div>
                                <img id="_fbImgLoader" src="images/ajax-loader1.gif" alt="Uploading..." height="24" width="24" />
                            </div>
                        </div>
                    </div>
                    <br />
                </div>
                <asp:Button ID="btnSend" runat="server" Text="Send" OnClick="btnSend_Click" />
            </asp:Panel>
        </div>
        <div class="clear"></div>
    </div>
</asp:Content>
