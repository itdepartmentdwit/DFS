
<%@ Page Title="Order food" Language="C#" MasterPageFile="~/DFS.Master"
    AutoEventWireup="true" CodeBehind="Employee.aspx.cs" Inherits="DFS.Web.Employee" ValidateRequest="false" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Import Namespace="Microsoft.AspNet.Identity" %>
<%@ Import Namespace="DFS.Core.ViewModels" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Style/chosen.css" rel="stylesheet" type="text/css" />
    <link href="/Content/toastr.css" rel="stylesheet" type="text/css" />
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />


    <script src="Scripts/LikeFood.js" type="text/javascript"> </script>
    <script src="Scripts/Plugins/chosen.jquery.js" type="text/javascript"> </script>
    <script src="Scripts/Forms/Employee.js" type="text/javascript"> </script>
    <script src="/Scripts/toastr.min.js" type="text/javascript"> </script>
    <style type="text/css">
        .ui-state-default .ui-icon {
            background: url("http://code.jquery.com/ui/1.10.3/themes/smoothness/images/ui-icons_888888_256x240.png") repeat scroll -96px -128px rgba(0, 0, 0, 0);
            border: medium none;
        }

        .ui-state-default:hover {
            background: url("http://code.jquery.com/ui/1.10.3/themes/smoothness/images/ui-icons_222222_256x240.png") repeat scroll -96px -128px rgba(0, 0, 0, 0);
        }

        .ui-dialog-titlebar {
            text-align: center;
            font-weight: normal !important;
        }

        #messageBox li {
            list-style: decimal;
        }

        #messageBox h4 {
            margin: 0;
        }

        #messageBox ol {
            margin: 5px;
        }
    </style>
    <script type="text/javascript">
        var Page;
        var xPos, yPos;

        function reload() {
            location.reload();
        }

        function OnInitializeRequest(sender, args) {
            var postBackElement = args.get_postBackElement();
            if (Page.get_isInAsyncPostBack() && (postBackElement.id == "ContentPlaceHolder1_btnPlaceOrder" || postBackElement.id == "ContentPlaceHolder1_btnShare")) {
                // alert('Your request is already in process! Please be patient!');
                DFS.Notification.Dialog('Multiple Request', '_DialogContainer', 'Your request is already in process. Please be patient!', 300, DFS.Enum.DialogEnum.Warning, '', null);
                args.set_cancel(true);
            }
        }

        // pageLoad is executed after every postback, synchronous or asynchronous.

        function pageLoad(sender, args) {
            Page = Sys.WebForms.PageRequestManager.getInstance();
            Page.add_initializeRequest(OnInitializeRequest);

            var timeClock = new Date().getHours();

            function couponTimeAlert() {
                var currentDate = new Date();
                if (currentDate.getHours() == 10 && currentDate.getMinutes() == 0 && currentDate.getSeconds() == 0) {
                    toastr.options = {
                        "closeButton": false,
                        "debug": false,
                        "newestOnTop": false,
                        "progressBar": true,
                        "positionClass": "toast-bottom-right",
                        "preventDuplicates": false,
                        "showDuration": "300",
                        "hideDuration": "1000",
                        "timeOut": 0,
                        "extendedTimeOut": 0,
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        "hideMethod": "fadeOut",
                        "tapToDismiss": false
                    };

                    toastr["warning"]("You cannot change your selection of 109 Coupon after 9:45 AM.<br /><br /><button class='dfs-btn' id=\"coupon-btn\">OK</button>", "Warning");

                    $('#coupon-btn').on('click', function () {
                        toastr.remove();
                    });
                }
            }



            $(document).ready(function () {
                var userId = parseInt('<%=Microsoft.AspNet.Identity.IdentityExtensions.GetUserId<int>(User.Identity)%>');

                var userType = '<%= userType %>';
                var userTypes = userType.split(',');
                if (userTypes.includes("DWSStaff")) {
                    checkFirstVisit(userId);
                    setInterval(couponTimeAlert, 1000);
                }
            });

            function checkFirstVisit(userId) {

                if (document.cookie.indexOf('DFSCookie') == -1) {

                    document.cookie = 'DFSCookie=1';

                    changeOfficialButtons(userId);

                    officialDialog();
                }
                else {

                }
            }


            function officialDialog() {
                $('#_DialogOfficialLunch').dialog(
                    {
                        dialogClass: 'no-close',
                        //title: 'Deerwalk Official Lunch <br>(Please select your lunch by 10 AM so that the canteen can plan better.)',
                        modal: true,
                        width: 700,
                        resizable: false,
                        close: function (event, ui) {
                            location.reload();
                        }
                    }).closest(".ui-dialog")
                    .find(".ui-dialog-title")
                    .html("<strong style=\"text-align:justify\">Deerwalk Official Lunch</strong><br>Please select your lunch by 10 AM so that the canteen can plan better.");
            }

            function changeOfficialButtons(userId) {
                $.ajax({
                    url: "Employee.aspx/checkOfficialOrders",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: '{ UserId:' + userId + '}',
                    responseType: "json",
                    type: 'POST',
                    complete: function (response) {
                        var initialObj = JSON.parse(response.responseText);
                        if (initialObj.d.IsSuccess) {
                            $(".official").removeClass("dfs-btn-green").addClass("dfs-btn-default");
                            $(".official").text('Select');
                            var orderedTag = "#dfs-btn-" + initialObj.d.StatusMessage;
                            $(orderedTag).removeClass("dfs-btn-default").addClass("dfs-btn-green");
                            $(orderedTag).text("Selected");
                        }
                    }
                });
            }

            employee.Init('<%= Microsoft.AspNet.Identity.IdentityExtensions.GetUserId<int>(User.Identity) %>', '<%= rbExpand.ClientID %>', '<%= rbCollapse.ClientID %>',
                '<%= btnSearchFood.ClientID %>', '<%= txtSearchFood.ClientID %>', '<%= gvTodaysMenu.ClientID %>',
                '<%= gvTodaysOrder.ClientID %>', '<%= userType %>');

            $("#btnfakeOrder").click(function (e) {

                e.preventDefault();

                $('#_DialogContainerFool').dialog(
                    {
                        dialogClass: 'no-close',
                        title: 'April Fool',
                        modal: true,
                        width: 380,
                        resizable: false
                    });
            });

            $("#btnOfficialLunch").click(function (e) {

                //toastr.options = {
                //    "closeButton": false,
                //    "debug": false,
                //    "newestOnTop": false,
                //    "progressBar": true,
                //    "positionClass": "toast-bottom-right",
                //    "onclick":location.reload(),
                //    "preventDuplicates": false,
                //    "showDuration": "300",
                //    "hideDuration": "1000",
                //    "timeOut": 0,
                //    "extendedTimeOut": 0,
                //    "showEasing": "swing",
                //    "hideEasing": "linear",
                //    "showMethod": "fadeIn",
                //    "hideMethod": "fadeOut",
                //    "tapToDismiss": false
                //};

                //toastr["success"]("This is a message text.kljahdjkashjkdgaskjdgashdasdgaslksd <br /><br /><button type=\"button\" class=\"btn clear\">Yes</button>", "Some title text");



                e.preventDefault();

                var userId = <%=Microsoft.AspNet.Identity.IdentityExtensions.GetUserId<int>(User.Identity)%>

                    changeOfficialButtons(userId);

                officialDialog();
            });

            $(".official").on('click', function () {
                $(".official").removeClass("dfs-btn-green").addClass("dfs-btn-default").removeClass("selected");
                $(".official").text('Select');

                if ($(this).attr('class').includes('selected')) {
                    $(this).removeClass("dfs-btn-green").removeClass('selected').addClass("dfs-btn-default");
                    $(this).text('Select');
                } else {
                    $(this).removeClass("dfs-btn-default").addClass("dfs-btn-green").addClass('selected');
                    $(this).text("Selected");
                    var orderId = $(this).attr("id").split('-')[2];
                    officialSelect(parseInt(orderId));
                }

            });

            var okBtn = "</br></br><button id=\"okBtn\" class=\"dfs-btn dfs-btn-small\">OK</button>";
            var errorOkBtn = "</br></br><button id=\"errorOkBtn\" class=\"dfs-btn dfs-btn-small\">OK</button>";

            function officialSelect(OrderId) {
                $("#dfs-ajax-loader").css('display', 'block');
                $('.official').addClass('dfs-btn-disabled');
                var userId = <%=Microsoft.AspNet.Identity.IdentityExtensions.GetUserId<int>(User.Identity)%>
                    $.ajax({
                        url: "Employee.aspx/SelectOfficialMenu",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: '{OrderId:' + OrderId + ', UserId:' + userId + '}',
                        responseType: "json",
                        type: 'POST',
                        complete: function (response) {
                            toastr.options = {
                                "closeButton": false,
                                "debug": false,
                                "newestOnTop": false,
                                "progressBar": true,
                                "positionClass": "toast-bottom-right",
                                "preventDuplicates": false,
                                "showDuration": "300",
                                "hideDuration": "1000",
                                "timeOut": 0,
                                "extendedTimeOut": 0,
                                "showEasing": "swing",
                                "hideEasing": "linear",
                                "showMethod": "fadeIn",
                                "hideMethod": "fadeOut",
                                "tapToDismiss": false
                            };

                            var responseObj = JSON.parse(response.responseText);
                            //alert(JSON.stringify(responseObj));
                            $("#dfs-ajax-loader").css('display', 'none');
                            if (responseObj.d.IsSuccess) {
                                toastr["success"](responseObj.d.StatusMessage + okBtn, "");
                                //alert(responseObj.d.StatusMessage);
                                $('#okBtn').on('click', function () {
                                    location.reload();
                                });
                                //toastr.option.onclick = location.reload();
                                //slocation.reload();
                            } else {

                                var $toast = toastr["error"](responseObj.d.StatusMessage + errorOkBtn, "");
                                $('#errorOkBtn').on('click', function () {
                                    $toast.remove();
                                    location.reload();
                                });


                                //alert(responseObj.d.StatusMessage);
                            }
                        }
                    });
            }
            //LoadOnPageLoad();

        }

                <%--function LoadOnPageLoad() {
            var tr = $("#<%= gvTodaysOrder.ClientID %> tr").parent();
            var trMenu = $("#<%= gvTodaysMenu.ClientID %> tr");
            var flag = "False";
            var dinnerFlag = "False";
            var AllTextBox = tr.find("input[id*='ContentPlaceHolder1_gvTodaysOrder_hfFree_']");
            for (var i = 0; i <= AllTextBox.length; i++) {

                var isFree = tr.find("input[id*='ContentPlaceHolder1_gvTodaysOrder_hfFree_" + i + "']").val();
                var isDinner = tr.find("input[id*='ContentPlaceHolder1_gvTodaysOrder_setdinnertag_" + i + "']").val();
                var foodStatus = tr.find("span[id*='ContentPlaceHolder1_gvTodaysOrder_lblOrderStatus_" + i + "']").text();
                if (isFree == "True" && foodStatus != "NOT AVAILABLE") {
                    flag = "True";
                }
                if (isDinner == 5 && foodStatus != "NOT AVAILABLE") {
                    dinnerFlag = "True";
                }
            }
            var ab = $("#ContentPlaceHolder1_IsInternHiddenField").val();
            var dinnertag = $("#ContentPlaceHolder1_setdinnertag1").val();
            trMenu.find(".emp_food_name").find("input[name$=IsFreeExist]").val(flag);  //set value of order table in todays order menu hidden field so that to restrict order more free food..
            trMenu.find(".emp_food_name").find("input[name$=IsdinnerOrder]").val(dinnerFlag);  //set value of order table in todays order menu hidden field so that to restrict order more free food..
            trMenu.find(".emp_food_name").find("input[name$=setdinnertag]").val(dinnertag);  //set value of order table in todays order menu hidden field so that to restrict order more free food..
            var a = trMenu.find(".emp_food_name").find("input[name$=setdinnertag]").val();  //set value of order table in todays order menu hidden field so that to restrict order more free food..


            return;
        }--%>

        function DisableShareIfFree() {
            var trMenu = $("#<%= gvTodaysMenu.ClientID %> tr");
            var AllTextBox = trMenu.find("input[id*='ContentPlaceHolder1_gvTodaysMenu_txtMenuQuantity_']");

            for (var i = 0; i <= AllTextBox.length; i++) {
                var txtVal = trMenu.find("input[id*='ContentPlaceHolder1_gvTodaysMenu_txtMenuQuantity_" + i + "']").val();
                var hfFree = trMenu.find("input[id*='ContentPlaceHolder1_gvTodaysMenu_hfFree_" + i + "']").val();
                if (hfFree == "True" && txtVal == 1) {
                    {
                        $.jnotify('Free Foods Cannot be shared ', 'error', '3000');
                    }
                    return false;
                }
            }
        }
    </script>
    <script type="text/javascript" src="Scripts/OrderQuantity.js"> </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <img src="images/ajax-loader.gif" alt="Loading...." id="dfs-ajax-loader" style="bottom: 50%; left: 50%; position: fixed; text-align: center; z-index: 10000; display: none" />
    <div>
        <input type="hidden" id="IsInternHiddenField" runat="server" />
        <input type="hidden" id="setdinnertag1" runat="server" />
        <input type="hidden" id="IsFreeExist" />
        <input type="hidden" id="hfFoodLikeCount" value="0" />
        <input type="hidden" id="hfShowRateToolTip" runat="server" value="false" />
        <asp:HiddenField ID="HdnSelectedRowIndex" runat="server" />
        <asp:HiddenField ID="hfTotalCost" runat="server" />
        <asp:Panel ID="pnlOrderCancelConfirm" runat="server" CssClass="modalPopup" Style="display: none;">
            <div>
                Are you sure you want to cancel this order?
                <br />
                <br />
                <asp:Button ID="btnYes" Text="Yes" runat="server" />
                <asp:Button ID="btnNo" Text="No" runat="server" />
            </div>
        </asp:Panel>
        <div style="bottom: 50%; left: 50%; position: fixed; text-align: center; z-index: 10000;">
            <asp:UpdateProgress ID="updProgressEmployee" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                <ProgressTemplate>
                    <img src="images/ajax-loader.gif" alt="Loading...." />
                </ProgressTemplate>
            </asp:UpdateProgress>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Always" GroupingText="Order Messsage">
            <ContentTemplate>
                <asp:Panel ID="pnlOrderLimit" runat="server" CssClass="modalPopup popupServeMeinfo" Style="display: none;">
                    <asp:HiddenField ID="hfOrderLimitInfo" runat="server" />
                    <div class="headertext">
                        Order Message 
                                   <div style="float: right;">
                                       <asp:Button ID="Button2" runat="server" Text="X" CssClass="btn1" Height="20" Width="20" />
                                   </div>
                    </div>
                    <div id="successDiv" runat="server" visible="false" style="margin-bottom: 5px">
                        <p>
                            Following items were ordered.
                                      <b>Please click </b>
                            <asp:Button ID="Button1" CssClass="dummybtn" Text="Serve Me" Font-Bold="true" runat="server" Enabled="false" />
                            <b>button before 30 minutes of last availability time.</b>
                        </p>
                    </div>
                    <asp:GridView ID="gvOrderDetails" runat="server" AutoGenerateColumns="false" Visible="true" ItemType="DFS.Core.ViewModels.FoodOrderTimeLimitViewModel"
                        CssClass="user-table" Width="100%" OnRowDataBound="gvOrderLImitInfo_RowDataBound">

                        <Columns>
                            <asp:TemplateField HeaderText="Food Name">
                                <ItemStyle Width="50%" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsmfoodName" runat="server" Text='<%#Item.FoodName %>' Font-Bold="true"></asp:Label>
                                    <asp:HiddenField ID="hfFoodordervalid" runat="server" Value='<%#Item.FoodOrderValid %>'></asp:HiddenField>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Available Time">
                                <ItemStyle Width="30%" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsmAvailableTime" runat="server" Text='<%#Item.AvailableTimes %>' Font-Bold="true"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Order Status">
                                <ItemStyle Width="20%" BackColor="Green" ForeColor="White" />
                                <ItemTemplate>
                                    <asp:Label ID="lblStatus" runat="server" Text='Ordered' Font-Bold="true"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <br />
                    <div style="margin-top: 7px;">

                        <p>

                            <asp:Label ID="lblNoteText" runat="server" Text='Following items could not be ordered because your order time does not fall in the specific availability time.' Visible="false"></asp:Label>

                        </p>
                    </div>
                    <asp:GridView ID="gvOrderLImitInfo" runat="server" AutoGenerateColumns="false" Visible="true" ItemType="DFS.Core.ViewModels.FoodOrderTimeLimitViewModel"
                        CssClass="user-table" Width="100%" OnRowDataBound="gvOrderLImitInfo_RowDataBound">

                        <Columns>
                            <asp:TemplateField HeaderText="Food Name">
                                <ItemStyle Width="50%" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsmfoodName" runat="server" Text='<%#Item.FoodName %>' Font-Bold="true"></asp:Label>
                                    <asp:HiddenField ID="hfFoodordervalid" runat="server" Value='<%#Item.FoodOrderValid %>'></asp:HiddenField>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Available Time">
                                <ItemStyle Width="30%" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsmAvailableTime" runat="server" Text='<%#Item.AvailableTimes %>' Font-Bold="true"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Order Status">
                                <ItemStyle Width="20%" BackColor="Red" ForeColor="White" />
                                <ItemTemplate>
                                    <asp:Label ID="lblOrderStatus" runat="server" Text='Failed' Font-Bold="true"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <br />
                    <div style="float: right;">
                        <asp:Button ID="btnOrderLimitOK" runat="server" Text="Close" CssClass="btn1" Height="24" Width="60" />
                    </div>
                </asp:Panel>
                <asp:ModalPopupExtender ID="mpeOrderinfo" BehaviorID="mpeOrderinfo" runat="server"
                    PopupControlID="pnlOrderLimit" TargetControlID="hfOrderLimitInfo" CancelControlID="btnOrderLimitOK"
                    BackgroundCssClass="modalBackground">
                </asp:ModalPopupExtender>


                <asp:Panel ID="pnlServeMeInfo" runat="server" CssClass="modalPopup popupServeMeinfo" Style="display: none;">
                    <asp:HiddenField ID="hfServeMeInfo" runat="server" />
                    <div class="headertext">
                        Order Message 
                                   <div style="float: right;">
                                       <asp:Button ID="Button3" runat="server" Text="X" CssClass="btn1" Height="20" Width="20" OnClientClick="return reload();" />
                                   </div>
                    </div>
                    <div id="validServeInfo" runat="server" visible="false">
                        <p>
                            Following Items are now being readied. Please appear in Canteen within 10 minutes.
                        </p>
                    </div>
                    <asp:GridView ID="gvServeMeInfo" runat="server" AutoGenerateColumns="false" Visible="true" ItemType="DFS.Core.ViewModels.ServeMeOrderItemViewModel"
                        CssClass="user-table" Width="100%" OnRowDataBound="gvServeMeInfo_RowDataBound">

                        <Columns>
                            <asp:TemplateField HeaderText="Food Name">
                                <ItemStyle Width="50%" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsmfoodName" runat="server" Text='<%#Item.FoodName %>' Font-Bold="true"></asp:Label>
                                    <asp:HiddenField ID="hfServeMevalid" runat="server" Value='<%#Item.ServeMeValid %>'></asp:HiddenField>
                                    <asp:HiddenField ID="hfTimeExceeded" runat="server" Value='<%#Item.timeExceeded %>'></asp:HiddenField>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Available Time">
                                <ItemStyle Width="30%" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsmAvailableTime" runat="server" Text='<%#Item.AvailableTimes %>' Font-Bold="true"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status">
                                <ItemStyle Width="20%" ForeColor="White" BackColor="Green" />
                                <ItemTemplate>
                                    <asp:Label ID="lblvalidStatus" runat="server" Text='Served' Font-Bold="true"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <div id="notValidDiv" runat="server" visible="false">
                        <p>
                            Following Items cannot be served at this time because it's time has been expired.
                        </p>
                    </div>
                    <asp:GridView ID="notServedGrid" runat="server" AutoGenerateColumns="false" Visible="true" ItemType="DFS.Core.ViewModels.ServeMeOrderItemViewModel"
                        CssClass="user-table" Width="100%">
                        <Columns>
                            <asp:TemplateField HeaderText="Food Name">
                                <ItemStyle Width="50%" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsmfoodName" runat="server" Text='<%#Item.FoodName %>' Font-Bold="true"></asp:Label>
                                    <asp:HiddenField ID="hfServeMevalid" runat="server" Value='<%#Item.ServeMeValid %>'></asp:HiddenField>
                                    <asp:HiddenField ID="hfTimeExceeded" runat="server" Value='<%#Item.timeExceeded %>'></asp:HiddenField>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Available Time">
                                <ItemStyle Width="30%" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsmAvailableTime" runat="server" Text='<%#Item.AvailableTimes %>' Font-Bold="true"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status">
                                <ItemStyle Width="20%" ForeColor="White" BackColor="Red" />
                                <ItemTemplate>
                                    <asp:Label ID="lblnotValidStatus" runat="server" Text='Failed' Font-Bold="true"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <div style="margin-top: 7px;">

                        <p>
                            <strong><i>Note: Food items can be marked to be Served within 30 minutes of the last availability time. 
                                For example, If a food item is available from  11:30 am- 3:00 pm , you cannot mark the item to be Served after 3:30 pm , you need to mark the item to be served within the 30 minutes of the availability time.
                                If you failed to serve the item please contact canteen.
                            </i>
                            </strong>
                        </p>
                    </div>
                    <div style="float: right;">
                        <asp:Button ID="btnServeMeOk" runat="server" Text="Close" CssClass="btn1" Height="24" Width="60" OnClientClick="return reload();" />
                    </div>
                </asp:Panel>
                <asp:ModalPopupExtender ID="mpeServeMeinfo" BehaviorID="mpeServeMeinfo" runat="server"
                    PopupControlID="pnlServeMeInfo" TargetControlID="hfServeMeInfo" CancelControlID="btnServeMeOk"
                    BackgroundCssClass="modalBackground">
                </asp:ModalPopupExtender>
                <asp:Panel ID="pnlInvalidDinnerOrders" runat="server" CssClass="modalPopup popupServeMeinfo" Style="display: none;">
                    <asp:HiddenField ID="hiddenFieldInvalidDinnerOrders" runat="server" />
                    <p>
                        <b>Dinner items in red cannot be ordered after
                            <asp:Label runat="server" ID="lblInvalidDinnerOrderMsg"></asp:Label>. Please exclude those items before placing order.
                        </b>
                    </p>
                    <asp:GridView ID="gvOrderTimeLimitFoods" runat="server" AutoGenerateColumns="false" Visible="true" ItemType="DFS.Core.Persistence.Food"
                        CssClass="user-table" Width="100%" OnRowDataBound="gvOrderTimeLimitFoods_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="Food Name">
                                <ItemStyle Width="50%" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsmfoodName" runat="server" Text='<%#Item.Name %>' Font-Bold="true"></asp:Label>
                                    <asp:HiddenField ID="hfOrderTimeLimit" runat="server" Value='<%#Item.OrderTimeLimit %>'></asp:HiddenField>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Ingredients">
                                <ItemStyle Width="50%" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsmAvailableTime" runat="server" Text='<%#Item.Description %>' Font-Bold="true"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <div style="float: right; margin-top: 5px;">
                        <asp:Button ID="btnInvalidDinnerOrdersPopupClose" runat="server" Text="Close" CssClass="btn1" Height="24" Width="60" />
                    </div>
                </asp:Panel>
                <asp:ModalPopupExtender ID="mpeInvalidDinnerOrders" BehaviorID="mpeInvalidDinnerOrders" runat="server"
                    PopupControlID="pnlInvalidDinnerOrders" TargetControlID="hiddenFieldInvalidDinnerOrders" CancelControlID="btnInvalidDinnerOrdersPopupClose"
                    BackgroundCssClass="modalBackground">
                </asp:ModalPopupExtender>
                <%--<asp:Panel ID="pnlShareFood" runat="server" CssClass="modalPopup" Style="display: none; width: 40%;">
                    <div class="food-share">
                        <asp:HiddenField ID="hfTotSharedFoodAmount" runat="server" />
                        <asp:Label ID="lblFoodId" runat="server" Text="" Visible="False"></asp:Label>
                        <fieldset>
                            <legend>Food Share</legend>
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td width="42%" style="font-weight: bold;">
                                        <span>Item: </span>
                                        <asp:Label ID="lblFoodName" runat="server" Text=""></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblFoodQuantity" runat="server" Text="" Visible="False"></asp:Label>
                                        <select id="selectEmpName" class="chosen" multiple="false" style="width: 200px;"
                                            runat="server">
                                        </select>
                                        <asp:Button ID="btnAddUser" runat="server" Text="Add User" OnClientClick=" return employee.FoodShare.ValidateAddingUser(); "
                                            OnClick="btnAddUser_Click" />
                                    </td>
                                </tr>
                            </table>
                            <table class="user-table" cellpadding="0" cellspacing="0" style="margin: 0 !important; padding: 0 !important;">
                                <tr>
                                    <th width="13%">Emp. ID
                                    </th>
                                    <th width="51%" style="text-align: center;">Employee Name
                                    </th>
                                    <th width="22%">Shared Amount
                                    </th>
                                    <th>Action
                                    </th>
                                </tr>
                            </table>
                            <asp:Panel ID="pnlContainer" runat="server" ScrollBars="Vertical" Style="max-height: 100px; min-height: 30px;">
                                <div class="btm-share-tbl">
                                    <asp:GridView ID="gvSharedUser" runat="server" AutoGenerateColumns="false" Visible="true"
                                        CssClass="user-table" Width="100%" OnRowDataBound="gvSharedUser_RowDataBound"
                                        ShowHeader="false">
                                        <EmptyDataTemplate>
                                            No User Selected
                                        </EmptyDataTemplate>
                                        <Columns>
                                            <asp:TemplateField HeaderText="Employee ID">
                                                <ItemStyle Width="13.4%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmpId" runat="server" Text='<%#Eval("SharedUserId") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Employee Name">
                                                <ItemStyle Width="52.8%" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmpName" runat="server" Text='<%#Eval("SharedUserFullName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Shared Amount">
                                                <ItemStyle Width="22.6%" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="tbSharePrice" runat="server" Text='<%#Eval("SharedPrice") %>' onkeypress="return  DFS.Validation.IsNumberKey(event)"
                                                        onchange="employee.FoodShare.ChangeSharedPrice(this)" onfocus="this.select()" Width="65px" Style="float: right; margin-right: 5px; text-align: right;"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Action">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkBtnCancel" runat="server" CommandName="Cancel" CommandArgument='<%#Eval("SharedUserId") %>'
                                                        OnClick="lbtnCancel_Click" OnClientClick=" return confirm('Are you sure you want to cancel sharing with this user?'); ">Delete</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </asp:Panel>
                            <div style="clear: both">
                            </div>
                            <div style="margin-top: 5px">
                                <asp:Button ID="btnShare" runat="server" Text="Share" OnClientClick=" return employee.FoodShare.ValidateShare() "
                                    OnClick="btnShare_Click" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" />
                            </div>
                        </fieldset>
                    </div>
                </asp:Panel>
                <asp:Panel ID="pnlSharedUsers" runat="server" CssClass="modalPopup" Style="display: none; width: 30%">
                    <div class="food-share">
                        <fieldset>
                            <legend>Sharing Details</legend>
                            <asp:GridView ID="gvSharedUsersAndAmount" runat="server" AutoGenerateColumns="False"
                                CssClass="user-table">
                                <Columns>
                                    <asp:TemplateField HeaderText="Employee Name">
                                        <ItemStyle Width="70%" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblEmpName" runat="server" Text='<%#Eval("SharedUserFullName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Shared Amount">
                                        <ItemStyle Width="30%" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblSharedPrice" runat="server" Text='<%#Eval("SharedPrice") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </fieldset>
                    </div>
                    <asp:Button ID="btnClose" runat="server" Text="Close" />
                </asp:Panel>
                <asp:HiddenField ID="hfSharedUsers" runat="server" />
                <asp:ModalPopupExtender ID="mpeSharedUsers" BehaviorID="mpeSharedUsers" runat="server"
                    PopupControlID="pnlSharedUsers" TargetControlID="hfSharedUsers" CancelControlID="btnClose"
                    BackgroundCssClass="modalBackground">
                </asp:ModalPopupExtender>--%>
                <div id="leftside">
                    <asp:HiddenField ID="hfCategoryCount" runat="server" />
                    <asp:Panel ID="pnlTodaysMenu" runat="server" GroupingText="Today's Menu">
                        <div class="official-lunch-field">
                            <div class="emp_search_items" style="margin-top: 14px">
                                <asp:TextBox ID="txtSearchFood" runat="server" onkeypress="return clickButton(event,'ContentPlaceHolder1_btnSearchFood')"
                                    onfocus="javascript:this.select()" TabIndex="32766"></asp:TextBox>
                                &nbsp;
                            <asp:Button ID="btnSearchFood" runat="server" Text="Search" CssClass="emp_btn_search"
                                OnClick="btnSearchFood_Click" TabIndex="32767" />
                                <br />
                            </div>

                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Style="float: right; margin-right: 5px;"
                                AutoPostBack="false" ControlToValidate="txtSearchFood" ErrorMessage="Invalid Input"
                                ForeColor="Red" ValidationExpression="^[0-9a-zA-Z ]+$"></asp:RegularExpressionValidator>

                            <% if (userType.Split(',').Contains("DWSStaff") || (userType.Split(',').Contains("DWITStudent") && Isintern))
                                { %>
                            <button style="float: left; width: 50%" class="dfs-btn dfs-btn-blue" id="btnOfficialLunch"><span class="fa fa-cutlery fa-lg">&nbsp;</span>Official Lunch</button>
                            <% } %>
                        </div>

                        <div class="clear">
                        </div>
                        <% if ((DateTime.Now.Month == 4) && (DateTime.Now.Day == 1))
                            { %>
                        <br />
                        <table class="dtTable" cellspacing="0" cellpadding="4" id="ContentPlaceHolder1_gvTodaysMenu" style="border-collapse: collapse; color: #333333;">
                            <tr style="background-color: #5D7B9D; color: White; font-weight: bold;">
                                <th scope="col">Item</th>
                                <th scope="col">&nbsp;</th>
                                <th scope="col">Available Time</th>
                                <th scope="col">Init.</th>
                                <th scope="col">Avail.</th>
                                <th align="center" scope="col">Quantity</th>
                                <th scope="col"></th>
                            </tr>
                            <tr>
                                <td style="width: 370px;">

                                    <div class="emp_food_name">
                                        <span id="ContentPlaceHolder1_gvTodaysMenu_lblMenuItem_0">Free Official Beer (Carlsberg 350ml)</span>
                                    </div>
                                </td>
                                <td style="width: 22px;">
                                    <a id="ContentPlaceHolder1_gvTodaysMenu_lnkbtnMenuItem_1" rel="lightbox" href="images/FoodImage/beer.jpg">
                                        <img id="ContentPlaceHolder1_gvTodaysMenu_imgFood_1" src="images/image-preview.png" alt="Preview"></a>
                                </td>
                                <td style="width: 60px;">
                                    <span id="ContentPlaceHolder1_gvTodaysMenu_lblMenuAvailableTime_0" style="display: inline-block; width: 110px;">3:00 pm-09:00 pm
                                    </span>
                                </td>
                                <td align="center" style="width: 28px;">
                                    <div style="width: 28px;">
                                        <span id="ContentPlaceHolder1_gvTodaysMenu_lblInitialQty_0">250</span>
                                    </div>
                                </td>
                                <td align="center" style="width: 20px;">
                                    <div style="width: 20px;">
                                        <span id="ContentPlaceHolder1_gvTodaysMenu_lblAvailableQty_0">132</span>
                                    </div>
                                </td>
                                <td align="center">
                                    <div class="_dviTQuantity" style="width: 50px;">
                                        <div class="divAvailQty">
                                            <input type="text" value="1" readonly="readonly" style="width: 35px;">
                                        </div>
                                    </div>
                                </td>
                                <td align="center" style="width: 28px;">
                                    <div class="_dviTPrice">
                                        <button id="btnfakeOrder" class="btn">Order</button>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <% }
                        %>
                        <div class="note">
                            <%--<div id="DiscountText" runat="server">
                                &#8226; Green-starred<img src="images/astric.png" alt="*" />orders are given 10% discount when received between 1:30 PM to 3:30
                            PM.
                            </div>--%>
                            <div id="FreeText" runat="server" visible="false">
                                &#8226; Blue-starred <span style="color: #1637FF; font-size: 16px;">*</span> items are sponsored by Deerwalk Services and are free of cost.                           
                            </div>
                            <div class="notetopmargin">
                                &#8226; Please order Dinner set by
                                <asp:Label runat="server" ID="lblMaxDinnerOrderTimeNote"></asp:Label>. If not, you will have to order other dinner items.
                            </div>
                        </div>

                        <asp:LinkButton ID="lnkAll" class="all-items" runat="server" CommandArgument="All"
                            OnCommand="lnkAll_Click">All Items</asp:LinkButton>
                        <asp:Panel ID="pnlExpColl" runat="server" CssClass="emp_collExp">
                            <span class="expand">
                                <asp:RadioButton ID="rbExpand" GroupName="MenuItems" runat="server" Text="Expand All"
                                    Checked="true" TabIndex="2" /></span> <span class="expand">
                                        <asp:RadioButton ID="rbCollapse" GroupName="MenuItems" runat="server" Text="Collapse All"
                                            TabIndex="3" /></span>
                        </asp:Panel>
                        <asp:ListView ID="LvTags" runat="server">
                            <LayoutTemplate>
                                <div id="Div1" runat="server" class="tags emp_menu_tags">
                                    <ul>
                                        <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                                    </ul>
                                </div>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <li>
                                    <asp:LinkButton ID="lbTag" Text='<%#Eval("Description") %>' TabIndex="4" CommandArgument='<%#Eval("FoodTagId") %>'
                                        OnCommand="lbtn_Command" runat="server"></asp:LinkButton>
                                </li>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                                <b>No Food Tags available</b>
                            </EmptyDataTemplate>
                        </asp:ListView>
                        <div class="clear">
                        </div>

                        <div id="_DialogOfficialLunch" style="display: none;">
                            <asp:Repeater ID="OfficialGrid" runat="server">
                                <ItemTemplate>
                                    <table style="border: 0px; width: 100%">
                                        <tr style="padding-right: 5px; border-radius: 5px 0 0 5px; box-shadow: 0 0 3px grey">
                                            <%--<td><span class="fa fa-info-circle" style="color: #2F8BE8"></span><td>--%>
                                            <td style="padding: 5px; background: #d2691e; border-radius: 5px 0 0 5px; font-size: larger; width: 11%">
                                                <figcaption><span class="weirdFont" style="font-size:larger;color: white"><%#Eval("AvailableTime").ToString().Split('-')[0] %></span></figcaption>
                                                <figcaption style="font-size: x-small; padding: 0 40%">to</figcaption>
                                                <figcaption><span class="weirdFont" style="font-size:larger;color: #a52a2a"><%#Eval("AvailableTime").ToString().Split('-')[1] %></span></figcaption>
                                            </td>
                                            <td style="width: 60%">
                                                <figcaption><b><%# Eval("FoodName") %></b></figcaption>
                                                <figcaption style="font-size: smaller; color: #333333"><%# Eval("FoodDescription") %></figcaption>
                                            </td>
                                            <%--<td width="5%">
                                                <asp:LinkButton ID="lnkbtnMenuItem" runat="server" rel="lightbox" href='<%#Eval("FoodImagePath") %>'>
                                                    <asp:Image ID="imgFood" runat="server" AlternateText="Preview" ImageUrl="~/images/image-preview.png" />
                                                </asp:LinkButton>
                                            </td>--%>
                                            <%--<td style="width: 20%">
                                                <figcaption style="font-size: smaller; color: #333333">Available Quantity:</figcaption>
                                                <figcaption><b><%# Eval("AvailableQuantity") %> / <%#Eval("InitialQuantity") %></b></figcaption>
                                            </td>--%>
                                            <td style="width: 10%">
                                                <%--<%# if (Eval("AvailableTime"))
                                                   {%>
                                                    <button class="official dfs-btn dfs-btn-default dfs-btn-small" id="dfs-btn-<%# Eval("FoodID")%>">Select</button>
                                                <%}
                                                   else
                                                   {%>--%>
                                                <button class="dfs-btn dfs-btn-small dfs-btn-<%#(bool)Eval("IsDisabled")?"disabled":"default official"%>" id="dfs-btn-<%# Eval("FoodID")%>" style="margin-right: 8px; width: 100px;">Select</button>
                                                <%--<%} %>--%>
                                                
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:Repeater>
                            <hr />
                            <div id="messageBox">
                                <h4>How to get 109 Coupon:</h4>
                                <ol style="font-size: small">
                                    <li>To get  the coupons, select 109 Coupon by 9:45 AM.</li>
                                    <li>109 Coupon can be used at 109 Degrees for lunch, snacks, dinner or during weekends</li>
                                    <li>The coupon is valid till 30 days and is transferable.</li>
                                </ol>

                                <h4>How to use 109 Coupon:</h4>
                                <ol style="font-size: small">
                                    <li>Claim the number of coupon(s) that you want to use.</li>
                                    <li>You must declare to the waiter that you want to use the 109 Coupon before you ask for the bill.</li>
                                    <li>Tell your <b>DFS ID(s)</b> at the 109 degree counter.</li>
                                    <li>You need to pay in cash the difference amount. (For instance, if your bill amount is Rs 220 and you use the discount coupon of Rs 200, you will have to pay Rs 20 cash.)</li>
                                    <li>
                                        You will not receive any bill for the items where you use the discount coupon. 
                                        User will get coupon usage email notification(s) for that transaction. 
                                        Also, Transaction can be seen in the <b>Coupon Usage Report</b>.
                                    </li>
                                    <li>You cannot carry forward unused discount amount. (For instance, if your bill amount is Rs 150 and you use the discount coupon of Rs 200, you will not get Rs 50 back.)</li>
                                    <li>When you use 109 Coupon, you will not be eligible for any other discounts. </li>
                                </ol>

                            </div>
                            <%--<ul>
                                <li style="list-style: none">If you want 109 Coupon, you must select it by 9:45 AM. You will not be eligible for the coupon after that. </li>
                                <li style="list-style: none">If you selected 109 Coupon, please collect it from canteen by 5 PM.</li>
                                <ul style="margin-left: 25px">
                                    <li style="list-style: disc">109 Coupon is valid only at 109 Degrees.</li>
                                    <li style="list-style: disc">The coupon is transferrable but valid for only 30 days.</li>
                                    <li style="list-style: disc">If you fail to collect the 109 Coupon by 5 PM, the coupon is void.</li>
                                </ul>
                            </ul>--%>
                        </div>


                        <asp:GridView ID="gvTodaysMenu" runat="server" CellPadding="4" ForeColor="#333333" CssClass="dtTable"
                            GridLines="None" AutoGenerateColumns="False" ShowFooter="True" OnRowDataBound="gvTodaysMenu_RowDataBound">
                            <AlternatingRowStyle BackColor="White" ForeColor="#fff" />
                            <EmptyDataTemplate>
                                <asp:Label runat="server" Text="No Menu has been placed yet!" OnLoad="lblEmptyDataTemplate_OnLoad"
                                    ID="lblEmptyDataTemplate" Font-Bold="true"></asp:Label>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="ID" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMenuItemID" runat="server" Text='<%#Bind("FoodID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblfoodnamewithdescription" runat="server" Text='<%#Bind("FoodNameWithDescription") %>'></asp:Label>
                                        <asp:Label ID="lbfooddesc" runat="server" Text='<%#Bind("FoodDescription") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Item">
                                    <ItemStyle Width="370px" />
                                    <ItemTemplate>
                                        <asp:Image ID="imgCategory" runat="server" AlternateText="" Visible="false" />
                                        <div class="emp_food_name">
                                            <asp:Label ID="lblMenuItem" runat="server" Text='<%#Bind("FoodName") %>'></asp:Label>
                                            <asp:Label ID="lblDiscountedFoodItem" runat="server" Text='<%#IsDiscountAvailable(Eval("IsDiscounted") + "," + Eval("AvailableTime")) %>'
                                                Font-Size="17px" Font-Bold="true" ForeColor="#008053"></asp:Label>
                                            <asp:Label ID="lblFreeIndicator" runat="server" Text="*" Font-Bold="false" ForeColor="#1637FF" Font-Size="14" Visible="false"></asp:Label>
                                            <asp:HiddenField ID="hfFoodId" runat="server" Value='<%#Bind("FoodID") %>' />
                                            <asp:HiddenField ID="hfFree" runat="server" Value='<%#Bind("IsFree") %>' />
                                            <asp:HiddenField ID="IsFreeExist" runat="server" />
                                            <asp:HiddenField ID="IsdinnerOrder" runat="server" />
                                            <asp:HiddenField ID="setdinnertag" runat="server" />
                                            <asp:HiddenField ID="UserType" runat="server" Value='<%#userType %>' />
                                            <asp:HiddenField ID="hfIsDinnerItem" runat="server" Value='<%#Bind("IsDinnerItem") %>' />
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="IMG">
                                    <ItemStyle Width="22px" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkbtnMenuItem" runat="server" rel="lightbox" href='<%#Eval("FoodImagePath") %>'>
                                            <asp:Image ID="imgFood" runat="server" AlternateText="Preview" ImageUrl="~/images/image-preview.png" />
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Available Time">
                                    <ItemStyle Width="60" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblMenuAvailableTime" Width="110" runat="server" Text='<%#Bind("AvailableTime") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Rate">
                                    <ItemStyle Width="30" />
                                    <ItemTemplate>
                                        <div class="_dviTRate">
                                            <asp:Label ID="lblMenuRate" runat="server" Text='<%#Bind("Rate") %>' CssClass="clsRate"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sub. Rate" Visible="false">
                                    <ItemStyle Width="30" />
                                    <ItemTemplate>
                                        <div class="_dviTSubsidizedRatee">
                                            <asp:Label ID="lblSubsidizedRate" runat="server" Text='<%#Bind("SubsidizedRate") %>' CssClass="clsSubRate"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Init. Qty">
                                    <ItemStyle Width="28" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <div style="width: 28px;">
                                            <asp:Label ID="lblInitialQty" runat="server" Text='<%#Bind("InitialQuantity") %>' />
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Avail. Qty" ItemStyle-HorizontalAlign="Center">
                                    <ItemStyle Width="20" />
                                    <ItemTemplate>
                                        <div style="width: 20px;">
                                            <asp:Label ID="lblAvailableQty" runat="server" Text='<%#Bind("AvailableQuantity") %>' />
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Quantity" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div class="_dviTQuantity" style="width: 80px;">
                                            <div class="divAvailQty">
                                                <asp:HiddenField ID="hfAvailQty" runat="server" Value='<%#Bind("AvailableQuantity") %>'></asp:HiddenField>
                                            </div>
                                            <asp:Image runat="server" ID="imgDecrease" ImageUrl="images/Decrease1.png" onclick="DecOrderQuantity(this);"
                                                CssClass="decrease" />
                                            <asp:TextBox ID="txtMenuQuantity" autocomplete="off" runat="server" onkeydown=" return (event.keyCode!=13);"
                                                onchange="javascript:employee.Grid.MenuQuantityChanged(this);" AutoPostBack="false"
                                                CssClass="qnt-box"></asp:TextBox>
                                            <asp:Image runat="server" ID="imgIncrease" ImageUrl="images/Increase1.png" onclick="IncOrderQuantity(this) ;"
                                                CssClass="increase" />
                                        </div>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="Label1" runat="server" Text="Total: "></asp:Label>
                                    </FooterTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Price">
                                    <ItemStyle Width="28" />
                                    <ItemTemplate>
                                        <div class="_dviTPrice">
                                            <asp:Label ID="lblMenuPrice" runat="server" Text="0" ClientIDMode="Static"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <div class="_dvfTPrice">
                                            <asp:Label ID="lblTotal" runat="server" Text="0.00"></asp:Label>
                                        </div>
                                    </FooterTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#8e8e8e" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />

                            <%--                            <PagerSettings PageButtonCount="5" />
                            <PagerStyle BackColor="#8E8E8E" ForeColor="White" HorizontalAlign="left" CssClass="pager" />--%>
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                        </asp:GridView>
                        <div>
                           
                            <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" OnClick="btnPlaceOrder_Click" />
                            <%--<asp:Button ID="btnShareFood" runat="server" Visible="False" Text="Share Food" OnClick="
                                btnShareFood_Click"
                                OnClientClick=" if (DisableShareIfFree() == false) {return false;}; " />
                            <asp:HiddenField ID="hfShareFood" runat="server" />
                            <asp:ModalPopupExtender ID="mpeShareFood" BehaviorID="mpeShareFood" runat="server"
                                TargetControlID="hfShareFood" PopupControlID="pnlShareFood" CancelControlID="btnCancel"
                                BackgroundCssClass="modalBackground">
                            </asp:ModalPopupExtender>--%>
                        </div>
                    </asp:Panel>
                    <div class="clear">
                    </div>
                </div>
                <div id="rightside">

                    <% if (ShowCurrentBalance)
                        { %>
                    <asp:Panel ID="pnlBalance" runat="server" Visible="false" CssClass="cur-balance">
                        <asp:Label ID="Label2" runat="server" ForeColor="Black">Available Balance: </asp:Label>
                        <asp:Label ID="lblUserBalance" Font-Bold="true" runat="server"></asp:Label>
                    </asp:Panel>
                    <div class="clear">
                    </div>
                    <br />
                    <% }
                    %>
                    <asp:Panel ID="pnlTodaysOrder" runat="server" GroupingText="Today's Order">
                        <asp:Button ID="btnServeMeSelected" runat="server" CssClass="btn" Text="Serve Me" Font-Bold="true" Visible="true"
                            OnClientClick=" return employee.Grid.ConfirmServe(this); " OnClick="btnServeMeSelected_Click" Style="margin-bottom: 5px;" />
                        <asp:GridView
                            ID="gvTodaysOrder"
                            runat="server"
                            AutoGenerateColumns="False"
                            CellPadding="4"
                            CssClass="dtTable"
                            ForeColor="#333333"
                            GridLines="None"
                            OnRowDataBound="gvTodaysOrder_RowDataBound"
                            OnRowCommand="gvTodaysOrder_RowCommand"
                            ShowFooter="True"
                            AllowPaging="false"
                            Width="100%"
                            ItemType="DFS.Core.ViewModels.TodaysOrderViewModel">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <EmptyDataTemplate>
                                <b>No order is placed yet!</b>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderStyle-Width="1%">
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkBoxFoodHeader" runat="server" onclick='employee.Grid.CheckAllServerMe(this);' Checked="true" CssClass="chkHeader" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:HiddenField ID="lblOrderDeliveryTime" runat="server" Value='<%#: Item.DeliveryTime.HasValue ? Item.DeliveryTime.Value.ToShortTimeString() : string.Empty %>'></asp:HiddenField>

                                        <asp:Label ID="lblOrderTableID" runat="server" Text='<%#: Item.FoodOrderID %>' Visible="false"></asp:Label>
                                        <asp:HiddenField ID="hfServe" runat="server" Value='<%#: Item.Serve %>' />
                                        <asp:HiddenField ID="hfFree" runat="server" Value='<%#: Item.IsFree %>' />
                                        <asp:HiddenField ID="hfIsFoodShared" runat="server" Value='<%#: Item.IsFoodShared %>' Visible="false" />
                                        <asp:HiddenField ID="hfDiscount" runat="server" Value='<%#: Item.Discount %>' />
                                        <asp:CheckBox ID="chkBoxServeMe" runat="server" CssClass="chkRow" CommandName="cbServeMe" Checked="true" onclick="employee.Grid.CheckMe(this);"
                                            CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Item" HeaderStyle-Width="43%">
                                    <ItemTemplate>
                                        <%--   <asp:LinkButton ID="lnkOrderItem" runat="server" Text='<%#:Item.FoodName %>' CommandName="ShowSharedUsers"
                                            CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>' Enabled="false" ></asp:LinkButton>--%>
                                        <asp:Label ID="lnkOrderItem" runat="server" Text='<%#:Item.FoodName %>' HtmlEncode="false"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblTotals" runat="server" Text="Total" />
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Rate" HeaderStyle-Width="3%">
                                    <ItemTemplate>
                                        <div class="_dviTRate">
                                            <asp:Label ID="lblOrderRate" runat="server" Text='<%#: Item.Rate %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Qty." HeaderStyle-Width="4%">
                                    <ItemTemplate>
                                        <div class="_dviTQty">
                                            <asp:Label ID="lblOrderQuantity" runat="server" Width="23px" Text='<%#:Item.Quantity %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Amt." HeaderStyle-Width="4%">
                                    <ItemTemplate>
                                        <div class="_dviTAmount">
                                            <asp:Label ID="lblOrderPrice" runat="server" Text='<%#: Item.NetPrice %>'></asp:Label>
                                            <asp:Label ID="lblDiscountedFoodItem" runat="server" Font-Size="Medium" Font-Bold="true"
                                                ForeColor="Green" ToolTip="Discounted price." Style='cursor: pointer;'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <div class="_dvfTAmount">
                                            <asp:Label ID="lblTotalPrice" runat="server"></asp:Label>
                                        </div>
                                    </FooterTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status" HeaderStyle-Width="19%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblOrderStatus" runat="server" Text='<%#: Item.Status %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Ord. Time" HeaderStyle-Width="7%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblOrderOrderTime" runat="server" Text='<%#: Item.OrderTime.HasValue ? Item.OrderTime.Value.ToShortTimeString() : string.Empty %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Max Serve Time" HeaderStyle-Width="12%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblServeTime" runat="server" Text='<%#: Item.ServeTime %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Opt." HeaderStyle-Width="7%">
                                    <ItemStyle CssClass="Actions" />
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" ID="lnkOrderCancel" Visible="false" ToolTip="Cancel Order" CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>'
                                            CommandName="lnkOrderCancel" OnClientClick=" return DFS.Notification.JsConfirmDialog('Are you sure you want to cancel this order?'); ">
                                            <img alt="Cancel" src="images/delete.png"   /></asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#8e8e8e" Font-Bold="True" ForeColor="white" />
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        </asp:GridView>
                    </asp:Panel>



                    <asp:Panel ID="pnlExpiredItem" runat="server" GroupingText="Expired Items">

                        <asp:GridView
                            ID="gvExpired"
                            runat="server"
                            AutoGenerateColumns="False"
                            CellPadding="4"
                            CssClass="dtTable"
                            ForeColor="#333333"
                            GridLines="None"
                            ShowFooter="True"
                            AllowPaging="false"
                            Width="100%"
                            ItemType="DFS.Core.ViewModels.TodaysOrderViewModel">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <EmptyDataTemplate>
                                <b>No items are expired!!</b>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="Item" HeaderStyle-Width="43%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblOrderTableID" runat="server" Text='<%#: Item.FoodOrderID %>' Visible="false"></asp:Label>
                                        <asp:HiddenField ID="hfServe" runat="server" Value='<%#: Item.Serve %>' />
                                        <asp:HiddenField ID="hfFree" runat="server" Value='<%#: Item.IsFree %>' />
                                        <asp:HiddenField ID="hfIsFoodShared" runat="server" Value='<%#: Item.IsFoodShared %>' Visible="false" />
                                        <asp:HiddenField ID="hfDiscount" runat="server" Value='<%#: Item.Discount %>' />
                                        <asp:LinkButton ID="lnkExpiredOrderItem" runat="server" Text='<%#:Item.FoodName %>' CommandName="ShowSharedUsers"
                                            CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>' Enabled="false"></asp:LinkButton>
                                    </ItemTemplate>
                                    <%--                                    <FooterTemplate>
                                        <asp:Label ID="lblTotals" runat="server" Text="Total" />
                                    </FooterTemplate>--%>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Rate" HeaderStyle-Width="3%">
                                    <ItemTemplate>
                                        <div class="_dviTRate">
                                            <asp:Label ID="lblExpiredOrderRate" runat="server" Text='<%#: Item.Rate %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Qty." HeaderStyle-Width="4%">
                                    <ItemTemplate>
                                        <div class="_dviTQty">
                                            <asp:Label ID="lblOrderQuantity" runat="server" Width="23px" Text='<%#:Item.Quantity %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Amt." HeaderStyle-Width="4%">
                                    <ItemTemplate>
                                        <div class="_dviTAmount">
                                            <asp:Label ID="lblOrderPrice" runat="server" Text='<%#: Item.NetPrice %>'></asp:Label>
                                            <asp:Label ID="lblDiscountedFoodItem" runat="server" Font-Size="Medium" Font-Bold="true"
                                                ForeColor="Green" ToolTip="Discounted price." Style='cursor: pointer;'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <%--                                    <FooterTemplate>
                                        <div class="_dvfTAmount">
                                            <asp:Label ID="lblTotalPrice" runat="server"></asp:Label>
                                        </div>
                                    </FooterTemplate>--%>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status" HeaderStyle-Width="19%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblExpiredOrderStatus" runat="server" Text='<%#: Item.Status %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Ord. Time" HeaderStyle-Width="7%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblExpiredOrderOrderTime" runat="server" Text='<%#: Item.OrderTime.HasValue ? Item.OrderTime.Value.ToShortTimeString() : string.Empty %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Max Serve Time" HeaderStyle-Width="12%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblExpiredServeTime" runat="server" Text='<%#: Item.ServeTime %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <%--   <asp:TemplateField HeaderText="Opt." HeaderStyle-Width="7%">
                                    <ItemStyle CssClass="Actions" />
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" ID="lnkOrderCancel" Visible="false" ToolTip="Cancel Order" CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>'
                                            CommandName="lnkOrderCancel" OnClientClick=" return DFS.Notification.JsConfirmDialog('Are you sure you want to cancel this order?'); ">
                                            <img alt="Cancel" src="images/delete.png"   /></asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>--%>
                            </Columns>
                            <FooterStyle BackColor="#8e8e8e" Font-Bold="True" ForeColor="white" />
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        </asp:GridView>
                    </asp:Panel>

                   

                    <asp:Panel ID="pnlDfsCoupon" runat="server" GroupingText="Active 109 Coupon">
                        <asp:Button ID="btnClaimCoupon" runat="server" CssClass="btn" Text="Claim" Font-Bold="true" Style="margin-bottom: 5px;" OnClick="btnClaimCoupon_Click" />
                        <div>
                            <table border="1px" width="100%" style="border-collapse: collapse;" class="dtTable">
                                <thead style="background-color: #8E8E8E; color: white; line-height: 25px;" runat="server" id="couponHeader">
                                    <th>
                                        <asp:CheckBox ID="chkBoxFoodHeader" runat="server" onclick='employee.Grid.CheckAllServerMe(this);' Checked="false" CssClass="chkCouponHeader" /></th>
                                    <th>Coupon Id</th>
                                    <th>Status</th>
                                    <th>Expire Date</th>
                                    <th>Opt.</th>

                                </thead>
                                <asp:Repeater ID="rptDfsCoupon" runat="server" Visible="true" OnItemDataBound="rptDfsCoupon_ItemDataBound">
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkSelectCoupon" runat="server" Checked="false" /></td>
                                            <td>
                                                <asp:HiddenField ID="hfId" Value='<%# Eval("Id") %>' runat="server" />
                                                <asp:HiddenField ID="hfDate" Value='<%# Eval("CreatedDate") %>' runat="server" />
                                                <asp:Label ID="lblCouponId" runat="server" Text='<%# Eval("CouponId") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblExpireDate" runat="server" Text='<%# Eval("ExpireDate", "{0:d}") %>'></asp:Label>
                                                (
                                                <asp:Label ID="lblExpiresIn" runat="server" Text='<%# Eval("ExpiresIn") %>'></asp:Label>
                                                )
                                            </td>
                                            <td>
                                                <asp:LinkButton runat="server" ID="lnkCouponCancel" Visible="false" OnCommand="lnkCouponCancel_click" ToolTip="Cancel Order" CommandArgument='<%#(((RepeaterItem) Container).DataItem) %>'
                                                    CommandName="lnkCouponCancel" OnClientClick=" return DFS.Notification.JsConfirmDialog('Are you sure you want to cancel this order?'); ">
                                            <img alt="Cancel" src="images/delete.png"   /></asp:LinkButton></td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate></FooterTemplate>

                                </asp:Repeater>
                            </table>


                        </div>

                        <asp:Label ID="lblCouponDetails" CssClass="notetopmargin" runat="server" Text="<b>Note: </b> To use a coupon, you need to select it and press on 'Claim' button.<br/><span style='    margin: 0 0 0 35px;'> Unused coupons will expire after 30 days.</span>"> </asp:Label>
                        <div id="rptfooterDiv" class="dtTable emptyDataDisplay" visible="false" runat="server">
                            <asp:Label ID="lblEmptyData"
                                Text="No Data To Display" runat="server">
                            </asp:Label>
                        </div>
                    </asp:Panel>

                     <asp:Panel ID="pnlDfsReadyCoupon" runat="server" GroupingText="Claimed Coupon(s)">
                        <table border="1" width="100%" style="border-collapse: collapse;" class="dtTable">
                            <thead style="background-color: #8E8E8E; color: white; line-height: 25px;" runat="server" id="claimedCouponheader">

                                <th>Coupon Id</th>
                                <th>Status</th>
                                <th>Expire Date</th>

                            </thead>
                            <asp:Repeater ID="rptClaimedCoupon" runat="server" Visible="true" OnItemDataBound="rptClaimedCoupon_ItemDataBound">
                                <ItemTemplate>
                                    <tr>

                                        <td>
                                            <asp:HiddenField ID="hfId" Value='<%# Eval("Id") %>' runat="server" />
                                            <asp:Label ID="lblCouponId" runat="server" Text='<%# Eval("CouponId") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("CouponStatus") %>' Font-Bold="true" ForeColor="#E55607"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblExpireDate" runat="server" Text='<%# Eval("ExpireDate", "{0:d}") %>'></asp:Label>
                                            (
                                                <asp:Label ID="lblExpiresIn" runat="server" Text='<%# Eval("ExpiresIn") %>'></asp:Label>
                                            )
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate></FooterTemplate>
                            </asp:Repeater>
                        </table>
                         <asp:Label ID="Label3" CssClass="notetopmargin" runat="server" Text="<b>Note: </b>Please tell your DFS ID when you are paying at the 109 counter. <br/> <span style='    margin: 0 0 0 33px;'>Unused coupons will expire after 30 days.</span>"> </asp:Label>
                        
                       
                    </asp:Panel>




                    <%--                    <fieldset id="fsServeGrid">--%>
                    <%--                        <legend>Serve Queue--%>
                    <%--                            <span style="float: left"></span>--%>
                    <%--                        </legend>--%>
                    <%--                         <asp:Button ID="btnShowServeQueue" runat="server" CssClass="btn" Text="Show Serve Queue" Font-Bold="true" Visible="true"--%>
                    <%--                             style="margin-bottom:5px;" OnClick="btnShowServeQueue_Click" />   --%>
                    <%--                        <asp:Panel ID="pnlshow" runat="server" Visible="False" >                    --%>
                    <%--                        <div style="margin-bottom: 5px;">--%>
                    <%--                            <div style="float: right; margin-top: -25px;">--%>
                    <%--                                <asp:LinkButton ID="lnkBtnRefreshServeGrid"  runat="server" OnClick="lnkBtnRefreshServeGrid_Click" ToolTip="Refresh Grid" CssClass="btn btnRefresh">--%>
                    <%--                                    Refresh--%>
                    <%--                                </asp:LinkButton>--%>
                    <%--                            </div>--%>
                    <%--                            <div style="clear: both;"></div>--%>
                    <%--                            <div style="background-color: #eaeaea; padding: 4px;">--%>
                    <%--                                <span style="color: #5f5f5f; font-family: Arial; font-size: 0.9em; font-weight: bold;">Only top 26 requests, in the order of 'Serve Me' time, are displayed here. Click the Refresh button to see updated list.--%>
                    <%--                                </span>--%>
                    <%--                            </div>--%>
                    <%--                        </div>--%>
                    <%--                        <div id="_containerReadyOrders" >--%>
                    <%--                            <asp:Repeater ID="reapReadyOrders" runat="server" OnItemDataBound="reapReadyOrders_ItemDataBound">--%>
                    <%--                                <ItemTemplate>--%>
                    <%--                                    <div><%#Container.DataItem.ToString() %></div>--%>
                    <%--                                </ItemTemplate>--%>
                    <%--                                <FooterTemplate>--%>
                    <%--                                    <asp:Label runat="server" ID="lblNoRecords" Visible="false" Text="No Records" Font-Bold="true">--%>
                    <%--                                    </asp:Label>--%>
                    <%--                                </FooterTemplate>--%>
                    <%--                            </asp:Repeater>--%>
                    <%--                        </div>--%>
                    <%--                        <div style="clear: left;"></div>--%>
                    <%--                        <asp:GridView ID="gvServe" runat="server" CellPadding="4" ForeColor="#333333" CssClass="dtTable serve_table"--%>
                    <%--                            GridLines="None" ShowFooter="False" AutoGenerateColumns="false" ItemType="DFS.Core.ViewModels.ServeItemViewModel"--%>
                    <%--                            OnRowDataBound="gvServe_RowDataBound" >--%>
                    <%--                            <EmptyDataTemplate>--%>
                    <%--                                <b>No Records</b>--%>
                    <%--                            </EmptyDataTemplate>--%>
                    <%--                            <Columns>--%>
                    <%--                                <asp:TemplateField HeaderText="User ID" HeaderStyle-Width="9%">--%>
                    <%--                                    <ItemTemplate>--%>
                    <%--                                        <asp:Label ID="lblUserId" runat="server" Text='<%#Item.UserId %>'></asp:Label>--%>
                    <%--                                    </ItemTemplate>--%>
                    <%--                                </asp:TemplateField>--%>
                    <%--                                <asp:TemplateField HeaderText="Elapsed Time" HeaderStyle-Width="16%">--%>
                    <%--                                    <ItemTemplate>--%>
                    <%--                                        <asp:Label ID="lblElaspedTime" runat="server" Text='<%# Item.ElaspedTime + " mins" %>'></asp:Label>--%>
                    <%--                                        <asp:HiddenField ID="hfSMReady" Value="<%#Item.IsReady %>" runat="server" />--%>
                    <%--                                        <asp:HiddenField ID="hfSMDeliveryLate" Value="<%#Item.DeliveryLate %>" runat="server" />--%>
                    <%--                                    </ItemTemplate>--%>
                    <%--                                </asp:TemplateField>--%>
                    <%--                                <asp:TemplateField HeaderText="Food Name" HeaderStyle-Width="75%">--%>
                    <%--                                    <ItemTemplate>--%>
                    <%--                                        <asp:Label ID="lblFoodname" runat="server" Text='<%#Item.FoodName %>'></asp:Label>--%>
                    <%--                                    </ItemTemplate>--%>
                    <%--                                </asp:TemplateField>--%>
                    <%--                            </Columns>--%>
                    <%--                            <EditRowStyle BackColor="#999999" />--%>
                    <%--                            <FooterStyle BackColor="#8e8e8e" Font-Bold="True" ForeColor="white" />--%>
                    <%--                            <HeaderStyle BackColor="#8e8e8e" Font-Bold="True" ForeColor="White" />--%>
                    <%--                            <PagerStyle BackColor="#8E8E8E" ForeColor="White" HorizontalAlign="left" />--%>
                    <%--                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />--%>
                    <%--                        </asp:GridView>--%>
                    <%--                    </asp:Panel>--%>
                    <%--                    </fieldset>--%>
                    <%-- <br />
                    <asp:Panel ID="pnlMonthlyExpenses" runat="server" GroupingText="Current Month Expenses">
                        <asp:GridView ID="gvMonthlyExpenses" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="dtTable"
                            ForeColor="#333333" GridLines="None" OnRowDataBound="gvMonthlyExpenses_RowDataBound"
                            ShowFooter="True" OnRowCommand="gvMonthlyExpenses_RowCommand">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <EmptyDataTemplate>
                                <b>No expense(s) available for the current month!</b>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblOrderDate" runat="server" Text='<%#Bind("ExpenseDate") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Expense">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkExpense" runat="server" Text='<%#Bind("price") %>' CommandArgument='<%#(((GridViewRow) Container).RowIndex) %>'></asp:LinkButton>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblTotalExpense" runat="server"></asp:Label>
                                    </FooterTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#8e8e8e" Font-Bold="True" ForeColor="White" />
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
                    <asp:HiddenField ID="" runat="server" />
                    <asp:ModalPopupExtender ID="btnHiddenField_ModalPopupExtender" runat="server" Enabled="True"
                        PopupControlID="pnlFoodOrderForTheDatePopup" TargetControlID="btnHiddenField"
                        CancelControlID="btnOK" BackgroundCssClass="modalBackground">
                    </asp:ModalPopupExtender>
                    <asp:Panel ID="pnlFoodOrderForTheDatePopup" runat="server" Style="display: none;"
                        CssClass="orderForDatePopup">
                        <asp:GridView ID="gvFoodOrderForTheDate" runat="server" AutoGenerateColumns="False" CssClass="dtTable"
                            ShowFooter="True" BackColor="White" BorderColor="#336666" BorderStyle="Double"
                            OnRowDataBound="gvFoodOrderForTheDate_RowDataBound" BorderWidth="3px" CellPadding="4"
                            GridLines="Horizontal">
                            <Columns>
                                <asp:TemplateField HeaderText="Item">
                                    <ItemTemplate>
                                        <asp:Label ID="lblItem" runat="server" Text='<%#Bind("name") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Rate">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRate" runat="server" Text='<%#Bind("rate") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="alignright" />
                                    <ItemStyle CssClass="alignright" />
                                    <FooterStyle CssClass="alignright" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Quantity">
                                    <ItemTemplate>
                                        <asp:Label ID="lblQuantity" runat="server" Text='<%#Bind("quantity") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblQuantityTotal" Font-Bold="true" Text="Total: " runat="server"></asp:Label>
                                    </FooterTemplate>
                                    <HeaderStyle CssClass="alignright" />
                                    <ItemStyle CssClass="alignright" />
                                    <FooterStyle CssClass="alignright" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Price">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPrice" runat="server" Text='<%#Bind("price") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblTotalPrice" Font-Bold="true" runat="server"></asp:Label>
                                    </FooterTemplate>
                                    <HeaderStyle CssClass="alignright" />
                                    <ItemStyle CssClass="alignright" />
                                    <FooterStyle CssClass="alignright" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Discount">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDiscount" runat="server" Text='<%#Bind("discount") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblTotalDiscount" Font-Bold="true" runat="server"></asp:Label>
                                    </FooterTemplate>
                                    <HeaderStyle CssClass="alignright" />
                                    <ItemStyle CssClass="alignright" />
                                    <FooterStyle CssClass="alignright" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Net Price">
                                    <ItemTemplate>
                                        <asp:Label ID="lblNetprice" runat="server" Text='<%#Bind("net_price") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblTotalNetprice" Font-Bold="true" runat="server"></asp:Label>
                                    </FooterTemplate>
                                    <HeaderStyle CssClass="alignright" />
                                    <ItemStyle CssClass="alignright" />
                                    <FooterStyle CssClass="alignright" />
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="White" ForeColor="#333333" />
                            <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#8E8E8E" ForeColor="White" HorizontalAlign="left" />
                            <RowStyle BackColor="White" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F7F7F7" />
                            <SortedAscendingHeaderStyle BackColor="#487575" />
                            <SortedDescendingCellStyle BackColor="#E5E5E5" />
                            <SortedDescendingHeaderStyle BackColor="#275353" />
                        </asp:GridView>
                        <br />
                        <br />
                        <asp:Button ID="btnOK" Text="OK" runat="server" />
                    </asp:Panel>--%>
                </div>
                <div class="clear">
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div id="_DialogContainer">
        </div>
        <div id="_DialogContainerFool" style="display: none;">
            <div style="margin: 0 auto 0 auto; width: 260px;">
                <h2>Happy April Fools Day</h2>
            </div>
            <img src="images/aprilfool.jpg" alt="Happy April Fools Day" />
        </div>
    </div>
</asp:Content>
