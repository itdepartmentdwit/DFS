<%@ Page Title="Notifications" Language="C#" AutoEventWireup="true"
         MasterPageFile="~/DFS.Master" CodeBehind="Notifications.aspx.cs" Inherits="DFS.Web.Admin.Notifications" ValidateRequest="false" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/Plugins/jquery.shorten.js" type="text/javascript"> </script>

    <script type="text/javascript">

        function pageLoad(sender, args) {
            $('.MessageText').shorten({ showChars: 50, moreText: 'View more', lessText: 'View less' });
        }

        function mpeAddShow() {
            var tbTitle = document.getElementById('<%= tbTitle.ClientID %>');
            tbTitle.value = '';
            var tbmsg = document.getElementById('<%= tbMsg.ClientID %>');
            tbmsg.value = '';
            var hiddenCommandName = document.getElementById('<%= hfCommandName.ClientID %>');
            hiddenCommandName.value = 'Add';
            return false;
        }

        function showEditPopup(sender) {
            var hidden = document.getElementById('<%= btnHidden.ClientID %>');
            var row = getParentRow(sender);
            hidden.value = row.rowIndex;

        }


        function HidePopup() {
            $('#<%= mpeEditPopup.ClientID %>').hide();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:LinkButton ID="lnkAddItem" runat="server" Text="Add Notification" OnClick="lnkAddItem_Click"
                    ToolTip="Add new notification"></asp:LinkButton>
    <div id="SearchPanel">
        <br />
        <asp:Label ID="lblSearch" runat="server" Text="Type search keyword here" Font-Bold="true"></asp:Label>&nbsp
        <asp:TextBox ID="txtSearch" runat="server" Width="450px"></asp:TextBox>
        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" />
        <br />

        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtSearch"
                                        Display="Dynamic" ErrorMessage="Invalid Input" ForeColor="Red" ValidationExpression="^[0-9a-zA-Z ]+$"></asp:RegularExpressionValidator>
    </div>
    <asp:UpdatePanel ID="upPanelNotification" runat="server" ChildrenAsTriggers="true">
        <ContentTemplate>

            <asp:HiddenField ID="hfCommandName" runat="server" />
            <asp:HiddenField ID="hfNotificationId" runat="server" />
            <br />
            <asp:GridView ID="gvNotifications" runat="server" AutoGenerateColumns="False" CellPadding="4"
                          CssClass="new_table" ForeColor="#333333" GridLines="None" OnRowCommand="gvNotifications_RowCommand"
                          PageSize="10" AllowPaging="True" AllowSorting="true" OnPageIndexChanging="gvNotifications_PageIndexChanging"
                          OnSorting="gvNotifications_Sorting" OnRowDataBound="gvNotifications_RowDataBound"
                          ShowFooter="true">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <EmptyDataTemplate>
                    <itemtemplate>No results were found !</itemtemplate>
                </EmptyDataTemplate>
                <Columns>
                    <asp:BoundField DataField="NotificationId" Visible="false" />
                    <asp:TemplateField HeaderText="Title" SortExpression="Title" HeaderStyle-ForeColor="White">
                        <ItemStyle Width="210px" />
                        <ItemTemplate>
                            <div style="width: 200px;" class="mydiv">
                                <pre>  
                            <asp:Label ID="lblTitle" runat="server" Font-Names="Arial" Text='<%#Eval("Title") %>'></asp:Label>
                             </pre>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Message Text" HeaderStyle-ForeColor="White" SortExpression="MessageText">
                        <ItemStyle />
                        <ItemTemplate>
                            <div style="width: 580px;" class="mydiv">
                                <pre style="padding: 0px; margin: 0px;">         
                           <asp:Label ID="lblMsg" runat="server" Font-Names="Arial"  CssClass="MessageText" Text='<%#Eval("MessageText") %>'></asp:Label>                                 
                            </pre>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="lblTotalCount" runat="server"></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Published" SortExpression="Published" HeaderStyle-ForeColor="White">
                        <ItemStyle Width="100px" />
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblStatus" Text='<%#Eval("Published").ToString().Equals("True") ? "Yes" : "No" %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Updated Date" DataField="UpdatedDate" HeaderStyle-ForeColor="White" SortExpression="UpdatedDate"
                                    HtmlEncode="false" DataFormatString="{0:F}" />
                    <asp:TemplateField HeaderText="Actions" HeaderStyle-ForeColor="White">
                        <ItemStyle Width="50px" />
                        <ItemTemplate>
                            <asp:LinkButton runat="server" ID="lnkItemEdit" CommandArgument='<%#Eval("NotificationId") %>'
                                            ToolTip="Edit notification" CommandName="CmdEdit">
                                <img src="/images/edit.png" alt="Edit" />
                            </asp:LinkButton>
                            <asp:LinkButton runat="server" ToolTip="Publish notification" ID="lnkItemPublish"
                                            CommandArgument='<%#Eval("NotificationId") %>' CommandName="CmdPublish" OnClientClick=" return confirm('Are you sure you want to Publish this notification?'); "><img src="/images/Publish.png" alt="Cancel"  />
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#DFDFDF" Font-Bold="True" ForeColor="#333333" HorizontalAlign="Left" />
                <PagerSettings Mode="NumericFirstLast" PageButtonCount="3" FirstPageText="First"
                               LastPageText="Last" />
                <PagerStyle CssClass="PagerStyle" />
            </asp:GridView>
            <i>You are viewing page
                <%= gvNotifications.PageIndex + 1 %>
                of
                <%= gvNotifications.PageCount %>
            </i>
            <asp:HiddenField ID="btnHidden" runat="server" />
            <asp:ModalPopupExtender ID="mpeEditPopup" runat="server" TargetControlID="btnHidden"
                                    PopupControlID="pnlPopup" BehaviorID="mpeEditPopup" CancelControlID="btnEditCancel"
                                    BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:Panel ID="pnlPopup" runat="server" CssClass="modalPopup modalPopupNotification"
                       GroupingText="Add Notification" Style="display: none">
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblTitle" runat="server" Text="Title" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbTitle" runat="server" Width="300px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ErrorMessage="*" ForeColor="Red"
                                                        ControlToValidate="tbTitle" ValidationGroup="popup"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblMsg" runat="server" Text="Message"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbMsg" runat="server" TextMode="MultiLine" Width="300px" Height="80px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvMsg" runat="server" ErrorMessage="*" ControlToValidate="tbMsg"
                                                        ForeColor="Red" ValidationGroup="popup"></asp:RequiredFieldValidator>
                        </td>
                    </tr>

                </table>
                <br />
                <br />
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" ValidationGroup="popup" />
                <asp:Button ID="btnEditCancel" runat="server" Text="Cancel" />
            </asp:Panel>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="lnkAddItem" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>