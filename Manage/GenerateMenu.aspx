<%@ Page Title="Generate Menu" Language="C#" MasterPageFile="~/DFS.Master"
         AutoEventWireup="true" CodeBehind="GenerateMenu.aspx.cs" Inherits="DFS.Web.Manage.GenerateMenu" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/Plugins/jquery-ui-timepicker-addon.js" type="text/javascript"> </script>
    <script src="/Scripts/Plugins/jquery-ui-sliderAccess.js" type="text/javascript"> </script>
    <script src="/Scripts/OrderQuantity.js" type="text/javascript"> </script>
    <link href="/Style/jquery-ui-timepicker-addon.css" rel="stylesheet" type="text/css" />
    <script src="/Scripts/Forms/GenerateMenu.js" type="text/javascript"> </script>
    <script type="text/javascript">
        function pageLoad() {
            generateMenu.Init('<%= gvMenu.ClientID %>');
        }

    </script>
    <script type="text/javascript">
        function compareTimeToToTime(sender, args) {
            var currentRow = $(sender).closest('tr');
            var timeFrom = currentRow.find('[id*=timepickerfrom]').val();
            var timeTo = currentRow.find('[id*=timepickerto]').val();
            var starttime = new Date("2001/01/01 " + timeFrom);
            var endtime = new Date("2001/01/01 " + timeTo);
            args.IsValid = (endtime >= starttime);
        }
    </script>
    
    <script type="text/javascript">
        function compareTimeToFromTime(sender, args) {
            var currentRow = $(sender).closest('tr');
            var timeFrom = currentRow.find('[id*=timepickerfrom]').val();
            var timeTo = currentRow.find('[id*=timepickerto]').val();
            var starttime = new Date("2001/01/01 " + timeFrom);
            var endtime = new Date("2001/01/01 " + timeTo);
            args.IsValid = (endtime >= starttime);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="text-align: center; position: fixed; left: 50%; bottom: 50%; z-index: 10000;">
        <asp:UpdateProgress ID="updProgressMenu" runat="server" AssociatedUpdatePanelID="upMenu">
            <ProgressTemplate>
                <img src="/images/ajax-loader.gif" alt="Loading...." />
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>
    <asp:UpdatePanel ID="upMenu" runat="server" UpdateMode="Always" ChildrenAsTrigger="true">
        <ContentTemplate>
            <div class="generate_menu">
                <asp:ListView ID="LvDays" runat="server">
                    <LayoutTemplate>
                        <div id="div" runat="server" class="tags">
                            <ul>
                                <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                            </ul>
                        </div>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <li>
                            <asp:LinkButton ID="lnbtnday" Text='<%#Bind("Key") %>' CommandArgument='<%#Bind("value") %>' ClientIDMode="AutoID"
                                            CausesValidation="false" OnCommand="lbtn_Command" runat="server"></asp:LinkButton>
                        </li>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <b>No Food Tags available</b>
                    </EmptyDataTemplate>
                </asp:ListView>
                <div class="clear">
                </div>
            </div>
            <div class="food_item">
                <asp:GridView ID="gvMenu" runat="server" AutoGenerateColumns="False" CellPadding="4"
                              ForeColor="#333333" GridLines="None" OnRowDataBound="gvMenu_RowDataBound" CssClass="dtTable">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:TemplateField HeaderText="Food Items">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkBoxFood" runat="server" onclick="generateMenu.Grid.ToggleValidation(this)" />
                                <asp:Label ID="lblFood" runat="server" Text='<%#Bind("FoodName") %>'></asp:Label>
                                <asp:Label ID="lblDiscountedFoodItem" runat="server" ToolTip="Discounted item." Text='<%#Eval("Discount").ToString().Equals("True") ? "*" : "" %>'
                                           Font-Size="Medium" Font-Bold="true" ForeColor="Green"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate">
                            <ItemTemplate>
                                <asp:Label ID="lblRate" runat="server" Text='<%#Bind("Rate") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Available Time">
                            <ItemTemplate>
                                <div class="_dviTAvailTime">
                                    <asp:Label ID="lblTime" runat="server" Text='<%#Bind("AvailableTime") %>' Visible="false"></asp:Label>
                                    From
                                    <asp:TextBox ID="timepickerfrom" runat="server" Width="70px" ReadOnly="true" onfocus="this.blur();"
                                                 CssClass="ui-timepicker-div" ValidationGroup="vgMenu"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="reqValfrom" ValidationGroup="vgMenu" CssClass="rfvFrom" runat="server" ErrorMessage="Start time for Available time is required."
                                                                Text="*" ForeColor="Red" ControlToValidate="timepickerfrom"></asp:RequiredFieldValidator>
                                    To
                                    <asp:TextBox ID="timepickerto" runat="server" Width="70px" onfocus="this.blur();" ReadOnly="true"
                                                 CssClass="ui-timepicker-div" ValidationGroup="vgMenu"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="reqValto" runat="server" ValidationGroup="vgMenu" CssClass="rfvTo" ErrorMessage="End time for Available time is required."
                                                                ForeColor="Red" Text="*" ControlToValidate="timepickerto"></asp:RequiredFieldValidator>
                                                               
                                    <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="End time should be greater than Start" ClientValidationFunction="compareTimeToToTime" ControlToValidate="timepickerto" ForeColor="red" SetFocusOnError="True" ValidationGroup="vgMenu" EnableClientScript="True"></asp:CustomValidator>
                                    <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="" ClientValidationFunction="compareTimeToToTime" ControlToValidate="timepickerfrom" ForeColor="red" SetFocusOnError="True" ValidationGroup="vgMenu" EnableClientScript="True"></asp:CustomValidator>

                                </div>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Initial Quantity">
                            <ItemTemplate>
                                <div class="_dviTIniQty">
                                    <asp:Label ID="lblInitialQty" runat="server" Text='<%#Bind("IntialQty") %>'></asp:Label>
                                </div>
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Available Quantity">
                            <ItemTemplate>
                                <div class="_dviTAvailQty">
                                    <asp:Label ID="lblAvailableQty" runat="server" Text='<%#Bind("AvailableQty") %>'></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Set Quantity">
                            <ItemTemplate>
                                <div class="_dviTSetQty">
                                    <asp:TextBox ID="tbSetQtyNumber" runat="server" Text="0" Width="50px" onkeydown="return (event.keyCode!=13)"
                                                 onkeypress="return DFS.Validation.IsNumberKey(event)" ValidationGroup="vgMenu" onchange="generateMenu.Grid.ValidateTextBox(this)"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="reqValAvailableNumber" CssClass="rfAvailNum" runat="server" ErrorMessage="Available number empty!"
                                                                Text="*" ForeColor="Red" ValidationGroup="vgMenu" ControlToValidate="tbSetQtyNumber" Enabled="true"></asp:RequiredFieldValidator>
                                </div>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Add Quantity">
                            <ItemTemplate>
                                <div class="_dviTAddQty">
                                    <a class="lbtnAddQty" runat="server" id="lbtnAddQty">
                                        <asp:Image ID="imgAdd" CssClass="imgAddQty" ImageUrl="/images/addInactive.png" runat="server" />
                                    </a>
                                </div>
                                <asp:HiddenField ID="hfFoodOrderCount" runat="server" Value='<%#Bind("FoodOrderCount") %>'></asp:HiddenField>
                                <div class="_dviTMenuId">
                                    <asp:HiddenField ID="hfFoodId" runat="server" Value='<%#Bind("FoodId") %>'></asp:HiddenField>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="lblDayOfWeek" runat="server" Text='<%#Bind("DayOfWeek") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#8E8E8E" ForeColor="White" HorizontalAlign="left" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
                <asp:HiddenField ID="btnHidden" runat="server" />

            </div>
            <br />
            <div class="save_btn">
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" ValidationGroup="vgMenu" CausesValidation="true" />
            </div>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowSummary="false"
                                   ShowMessageBox="true" HeaderText="Please fill the required fields." EnableClientScript="true" ValidationGroup="vgMenu" />

            <asp:ModalPopupExtender ID="modalpopup" runat="server" PopupControlID="pnlGeneratemenuError"
                                    TargetControlID="btnHidden" CancelControlID="btnCancel" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:Panel ID="pnlGeneratemenuError" runat="server" CssClass="modalPopup" align="center"
                       Style="display: none">
                <div style="height: 500px; overflow: scroll;">
                    <table width="100%" class="category" style="border: none;" cellpadding="4" cellspacing="2">
                    <tr>
                        <td width="300px">
                            <asp:Literal ID="ltrErrorPlacedAlready" runat="server"></asp:Literal>
                        </td>
                    </tr>
                    <tr align="center">
                        <td>
                            <asp:Button ID="btnCancel" runat="server" Text="Ok" />
                        </td>
                    </tr>
                </div>
            </table>
            </asp:Panel>
            <br />
            <div class='clear'>
            </div>
            <div class='Go-Top'>
                <a href='#top' class='btn' style='float: right; margin-top: -25px; padding: 6px;'>Go
                    To Top</a>
                <div class='clear'>
                </div>
            </div>

        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="click" />
        </Triggers>
    </asp:UpdatePanel>

    <div id="_dvContainer">
    </div>
</asp:Content>