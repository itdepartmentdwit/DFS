<%@ Page Title="Holiday Setting" Language="C#" MasterPageFile="~/DFS.Master"
         AutoEventWireup="true" CodeBehind="Holiday.aspx.cs" Inherits="DFS.Web.Admin.Holiday" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .content { overflow: visible !important; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="/Scripts/Plugins/jquery.shorten.js" type="text/javascript"> </script>
    <script type="text/javascript">

        function pageLoad(sender, args) {
            $('.MessageText').shorten({ showChars: 95, moreText: 'View more', lessText: 'View less' });
        }
    </script>
    
    <asp:UpdatePanel ID="upnl1" runat="server">
        <ContentTemplate>
            <div>
                <asp:Label ID="lblDate" runat="server" Text="Date:"></asp:Label>
                <asp:TextBox ID="txtDate" runat="server" onkeypress="javascript:return false" onpaste="return false"></asp:TextBox>
                <asp:CalendarExtender ID="calexDate" runat="server" TargetControlID="txtDate" CssClass="calendar">
                </asp:CalendarExtender>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="s"
                                            ForeColor="Red" ErrorMessage="Please enter date" ControlToValidate="txtDate">*</asp:RequiredFieldValidator>
                <asp:Label ID="lblDescription" runat="server" Text="Description:"></asp:Label>
                <asp:TextBox ID="txtDescription" runat="server" ValidateRequestMode="Disabled"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rvTextDescription" runat="server" ValidationGroup="s" ControlToValidate="txtDescription"
                                            ForeColor="Red" ErrorMessage="Please enter description">*</asp:RequiredFieldValidator>
                <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="s" OnClick="btnSave_Click" />
                <asp:Label ID="Label1" runat="server" Text="lblMsg1" Visible="False"></asp:Label>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="s"
                                       ForeColor="Red" ShowMessageBox="true" ShowSummary="false" DisplayMode="List" />
            </div>
            <div>
                <asp:CompareValidator ID="dvtxtDate" runat="server" Type="Date" Operator="DataTypeCheck"
                                      ControlToValidate="txtDate" ErrorMessage="Please enter a valid date." ForeColor="Red" ValidationGroup="s">
                </asp:CompareValidator>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="upnl2" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnlHolidays" runat="server" GroupingText="Holidays">
                <asp:Label ID="lblYear" runat="server" Text="Year:"></asp:Label>
                <asp:DropDownList ID="ddlYear" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged">
                    <asp:ListItem Value="2012" Text="2012"></asp:ListItem>
                    <asp:ListItem Value="2013" Text="2013"></asp:ListItem>
                    <asp:ListItem Value="2014" Text="2014"></asp:ListItem>
                    <asp:ListItem Value="2015" Text="2015"></asp:ListItem>
                    <asp:ListItem Value="2016" Text="2016"></asp:ListItem>
                </asp:DropDownList>
                <br />
                <asp:Label ID="lblMsg" runat="server" Text="No record found!" Visible="false" Font-Bold="True"
                           ForeColor="#CC3300"></asp:Label>
                <asp:GridView ID="gvHolidays" runat="server" AutoGenerateColumns="False" OnRowCancelingEdit="gvHolidays_RowCancelingEdit"
                              CssClass="dtTable" CellPadding="4" OnRowEditing="gvHolidays_RowEditing" OnRowUpdating="gvHolidays_RowUpdating">
                    <Columns>
                        <asp:TemplateField HeaderText="" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblId" runat="server" Text='<%#Bind("Id") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Holiday">
                            <ItemTemplate>
                                <asp:Label ID="lblHoliday" runat="server" Text='<%#Bind("Holiday") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtHoliday" runat="server" Text='<%#Bind("Holiday") %>' ValidateRequestMode="Disabled"></asp:TextBox>
                                <br />
                                <asp:CompareValidator ID="dvtxtHoliday" runat="server" Type="Date" Operator="DataTypeCheck"
                                                      ControlToValidate="txtHoliday" ErrorMessage="Please enter a valid date." ForeColor="Red">
                                </asp:CompareValidator>
                                <asp:CalendarExtender ID="calextStartDate" runat="server" TargetControlID="txtHoliday"
                                                      CssClass="calendar">
                                </asp:CalendarExtender>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description">
                            <ItemTemplate>
                                <div class="mydiv" style="width: 860px;">
                                    <pre style="padding: 0px; margin: 0px;">   
                                    <asp:Label ID="lblDescription" CssClass="MessageText" Font-Names="Arial" runat="server"
                                               Text='<%#Bind("Description") %>' TextMode="Multiline"></asp:Label>
                                 </pre>
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div class="mydiv">
                                    <asp:TextBox ID="txtDescription" Style="width: 860px;" runat="server" Text='<%#Server.HtmlDecode(Eval("Description").ToString()) %>'
                                                 TextMode="Multiline" ValidateRequestMode="Disabled"></asp:TextBox>
                                </div>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:Button ID="lnkEdit" CssClass="btn" Text="Edit" runat="server" CausesValidation="false"
                                            CommandName="Edit"></asp:Button>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Button ID="lnkUpdate" CssClass="btn" Text="Update" runat="server" CausesValidation="false" CommandName="Update" PostBackUrl="~/Holiday.aspx" />
                                <asp:Button ID="lnkCancel" CssClass="btn" Text="Cancel" runat="server" CausesValidation="false" CommandName="Cancel" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="White" ForeColor="#333333" />
                    <HeaderStyle BackColor="#8E8E8E" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#8E8E8E" ForeColor="White" HorizontalAlign="left" />
                    <RowStyle BackColor="White" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F7F7F7" />
                    <SortedAscendingHeaderStyle BackColor="#487575" />
                    <SortedDescendingCellStyle BackColor="#E5E5E5" />
                    <SortedDescendingHeaderStyle BackColor="#275353" />
                </asp:GridView>
            </asp:Panel>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnSave" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>