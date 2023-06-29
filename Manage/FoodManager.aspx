<%@ Page Title="Add/Edit Food" Language="C#" MasterPageFile="~/DFS.Master"
         AutoEventWireup="true" CodeBehind="FoodManager.aspx.cs" Inherits="DFS.Web.ManageFood.FoodManager" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        //        $(document).ready(function () {
        //            $('a[rel*=lightbox]').Lightbox()({ fixedNavigation: true });
        //        });

        // Sys.Application.add_load(pageLoad);

        function displayFoodImage() {
            xOffset = 180;
            yOffset = 20;

            $("a.preview").click(function(e) {
                e.preventDefault();
            });

            $("a.preview").hover(function(e) {
                this.t = $(this).attr("tooltxt");

                this.title = "";
                var c = (this.t != "") ? "<div id='title-Container'><div id='title-details'><span id='title-content'>" + this.t + "</span></div></div>" : "";
                var imgSrc = $(this).next('input').val() != null ? $(this).next('input').val() : 'images/notavailable.png';
                $("body").append("<div id='preview-wrapper'><div id='preview-img'><img src='" + imgSrc + "' alt='No Image Available'  /></div>" + c + "</div>"); //height='320' width='280' 
                $("#preview-wrapper")
                    .css("top", (e.pageY - xOffset) + "px")
                    .css("left", (e.pageX + yOffset) + "px")
                    .fadeIn("slow");
            },
                function() {
                    this.title = this.t;
                    $("#preview-wrapper").remove();
                });

            $("a.preview").mousemove(function(e) {
                $("#preview")
                    .css("top", (e.pageY - xOffset) + "px")
                    .css("left", (e.pageX + yOffset) + "px");
            });
        }

        ;

        function pageLoad() {

            displayFoodImage();
            var modalPopup = $find("mpeEditPopup");
            if (modalPopup != null) {
                modalPopup.add_shown(function() {
                    // alert('add_shown event fires');
                });
            }
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }

        function validateMe(sender) {
            var value = sender.value;
            var positiveInteger = /(^\d+$)/;
            if (!positiveInteger.test(value)) {
                alert("Rate must be a valid positive integer!");
                sender.value = '0';

            }
        }

        function getParentRow(obj) {
            while (obj.tagName != "TR") {
                if (isFireFox()) {
                    obj = obj.parentNode;
                } else {
                    obj = obj.parentElement;
                }
            }
            return obj;
        }

        function isFireFox() {
            return navigator.appName == "Netscape";
        }

        $(document).ready(function() {

            displayFoodImage();
        });
    </script>
    <style type="text/css">
        #preview-wrapper {
            position: absolute;
            border: 4px solid #ccc;
            background: #333;
            display: none;
            color: #fff;
            box-shadow: 4px 4px 3px rgba(103, 115, 130, 1);
            background: #fff;
        }

        #preview-wrapper img {
            height: 320px;
            width: 270px;
        }

        #title-details {
            position: absolute;
            width: 96.3%;
            float: left;
            text-align: left;
            line-height: 1.1em;
            background: #000000;
            color: #fff;
            margin-top: -23px;
            padding: 4px 5px;
            opacity: 0.7;
            height: 15px;
            text-align: center;
        }

        #title-content {
            font-size: 13px;
            font-weight: bold;
            line-height: 1em;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <div style="float: left; margin-right: 10px;">
            <asp:LinkButton ID="lnkAddItem" runat="server" Text="Add Food Item" OnClick="lnkAddItem_Click"></asp:LinkButton>
        </div>
        <div class="Search-box">
            <div>
                <asp:TextBox ID="txtFoodSearch" runat="server" Width="197px"></asp:TextBox>
                <asp:Button ID="btnFoodSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnFoodSearch_Click" />
                <div style="clear: left">
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtFoodSearch"
                                                    Display="Dynamic" ErrorMessage="Invalid Entry" ForeColor="White" ValidationExpression="^[0-9a-zA-Z ()'\/\\|]+$"></asp:RegularExpressionValidator>
                </div>
            </div>
        </div>
        <div style="clear: left">
        </div>
    </div>
    <br />
    <asp:GridView ID="gvFoodManager" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="dtTable"
                  ForeColor="#333333" GridLines="Vertical" OnRowCommand="gvFoodManager_RowCommand"
                  OnRowDataBound="gvFoodManager_RowDataBound" ItemType="DFS.Core.ViewModels.FoodViewModel">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:TemplateField HeaderText="Food Name" HeaderStyle-Width="18%">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkbtnFoodName" runat="server" CssClass="preview" ToolTip="<%# Item.Name %>"
                                    Text="<%# Item.Name %>"></asp:LinkButton>
                    <asp:HiddenField ID="hfFoodImage" runat="server" Value="<%# Item.ImagePath %>" />
                    <asp:Label ID="lblDiscountedFoodItem" runat="server" Text='<%# Item.Discount ? "*" : "" %>' Font-Size="Medium" Font-Bold="true" ForeColor="Green"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Rate" HeaderStyle-Width="5%">
                <ItemTemplate>
                    <asp:Label ID="lblRate" runat="server" Text="<%# Item.Rate %>"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Subsidized Rate" HeaderStyle-Width="12%">
                <ItemTemplate>
                    <asp:Label ID="lblSubsidizedRate" Width="100px" runat="server" Text="<%# Item.SubsidizedRate %>"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Description" HeaderStyle-Width="25%">
                <ItemTemplate>
                    <asp:Label ID="lblDescription" runat="server" Text="<%# Item.Description %>"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Instant?" HeaderStyle-Width="5%">
                <ItemTemplate>
                    <asp:Label ID="lblInstant" runat="server" Text='<%# Item.IsInstant ? "YES" : "NO" %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Order Time Limit?" HeaderStyle-Width="12%">
                <ItemTemplate>
                    <asp:Label ID="lblOrderTimeLimit" runat="server" Text='<%# Item.OrderTimeLimit ? "YES" : "NO" %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Free?" HeaderStyle-Width="5%">
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblFree" Text='<%# Item.Free ? "YES" : "NO" %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Category" HeaderStyle-Width="10%">
                <ItemTemplate>
                    <asp:Label ID="lblCategory" runat="server" Text="<%# Item.Category %>"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Tag(s)" HeaderStyle-Width="3%">
                <ItemTemplate>
                    <asp:Label ID="lblTag" runat="server" Text="<%# Item.Tags %>"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Label ID="lblFoodId" runat="server" Text="<%# Item.FoodID %>"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Action" HeaderStyle-Width="5%">
                <ItemStyle Width="50" />
                <ItemTemplate>
                    <asp:LinkButton runat="server" ID="lnkEdit" CommandArgument="<%# Item.FoodID %>" CommandName="EditCmd">
                        <img src="/images/edit.png" alt="Edit" />
                    </asp:LinkButton>
                    <asp:LinkButton runat="server" ID="lnkMenuItemCancel" CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>'
                                    CommandName="lnkItemCancel" OnClientClick=" return confirm('Are you sure you want to delete this menu item?'); "><img src="/images/delete.png" alt="Cancel"  />
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
</asp:Content>