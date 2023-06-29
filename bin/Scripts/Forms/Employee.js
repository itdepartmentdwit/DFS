/// <reference path="../_references.js" />
/// <reference path="../LikeFood.js" />

/*
  @Created by: shashrestha 
  @Abstract : Contains all js scripts for Employee.aspx
*/
var employee = DFS.Common.CreateNameSpace("DFS.Dfs_Employee");

employee.CategoryCount = 0;
employee.Userid = null;
employee.RadioBtnExpand = null;
employee.RadioBtnCollaspe = null;
employee.BtnSearch = null;
employee.TxtSearch = null;
employee.GridViewTodaysMenu = null;
employee.GridViewTodaysOrder = null;
employee.UserType = null;

employee.Init = function(userid, rbtnExpand, rbtnCollapse, btnSearch, txtSearch, gvTodaysMenu, gvTodaysOrder, userType) {
    var self = this;    
    self.CategoryCount = $('#ContentPlaceHolder1_hfCategoryCount').val();
    self.Userid = userid;
    self.RadioBtnExpand = rbtnExpand;
    self.RadioBtnCollaspe = rbtnCollapse;
    self.BtnSearch = btnSearch;
    self.TxtSearch = txtSearch;
    self.GridViewTodaysMenu = gvTodaysMenu;
    self.GridViewTodaysOrder = gvTodaysOrder;
    self.UserType = userType;

    self.Page.BindEvents();
    self.Page.SetJSPlugins();

};

employee.Page = {
    BindEvents: function() {

        $('#' + employee.RadioBtnCollaspe).change(function() {
            employee.Grid.CollapseAll(employee.CategoryCount);
        });

        $('#' + employee.RadioBtnExpand).change(function() {
            employee.Grid.ExpandAll(employee.CategoryCount);
        });

        DFS.Trigger.BindClickEventOnKeyPress(employee.TxtSearch, employee.BtnSearch, 13);

        //$('.btnRefresh').click(function () {
        //    var divID = '#' + this.id;
        //    $('html, body').animate({
        //        scrollTop: $(divID).offset().top
        //    }, 'fast');
        //    //$('html, body').scrollTop($(divID).offset().top);
        //});
    },
    SetJSPlugins: function() {
        /*Binding MultiSelect DropDown*/
        $(".chosen").chosen({
            allow_single_deselect: true,
            no_results_text: "No results matched"
        });

        /*Binding Tooltips*/
        $("a[rel^=lightbox]").tooltip({
            bodyHandler: function() {
                return 'Preview image.';
            },
            showURL: false
        });

        $(".lnkFoodname").tooltip({
            bodyHandler: function() {
                return $(this).attr('fdescription');
            },
            showURL: false
        });

        LikeFoodHandler.SetLikeTooltip();
        LikeFoodHandler.SetDisLikeTooltip();
        /*End of binding toolTips*/
    },
    RebindEventsForPartialPostBack: function() {

    },
    SetScrollForServeGrid: function() {
        //var window_height = $(window).height();
        //var document_height = $(document).height();

        //console.log(document_height);
        //$('html,body').animate({ scrollTop: window_height }, 'fast', function () {
        //});
        console.log($("#fsServeGrid").offset().top);

        $('html, body').scrollTop($(document).height());
        // $(window).scrollTop(100);
    }
};

employee.Grid = {
    CollapseAll: function(count) {

        for (var i = 1; i <= count; i++) {
            var img = $('.CategoryRow' + i).find("img");
            img.attr('src', 'images/expand.png');
            $('.class' + i).hide();
        }
    },
    ExpandAll: function(count) {
        for (var i = 1; i <= count; i++) {
            var img = $('.CategoryRow' + i).find("img");
            img.attr('src', 'images/collapse.png');
            $('.class' + i).show();
        }
    },
    MenuQuantityChanged: function(sender) {

        var tbvalue = parseInt(sender.value, 10);
        var row = $(sender).parents('tr');        
        var rate = null;
        var vat = null;
        if (employee.UserType == "DWITStudent") {
            rate = row.find('div._dviTSubsidizedRatee').find('.clsSubRate').html();
            vat = (13 * parseInt(rate)) / 100;
        }
        else if (employee.UserType == "DSSStudent") {
            rate = row.find('div._dviTSubsidizedRatee').find('.clsSubRate').html();
            vat = (13 * parseInt(rate)) / 100;
        } 
        else {
            rate = row.find('div._dviTRate').find('.clsRate').html();
            vat = (13 * parseInt(rate)) / 100;
        }

        var availableQty = parseInt(row.find('div._dviTQuantity').find('div.divAvailQty').find('input:hidden').val(), 10);

        var newPrice = 0;
        if (sender.value == null || sender.value == "") {
            sender.value = 0;
        }

        if (tbvalue > availableQty) {

            //$('.jnotify-container').find('.jnotify-message').remove();
            //DFS.Notification.NotifyJs("Order quantity exceeded the available quantity!", DFS.Enum.JsNotify.Error, 3000);

            /*log if food is not available */
            //   var foodTemplateContext = $('td:first', $(sender).closest('tr')).find('div.emp_food_name');

            //employee.AjaxCall.LogUnAvailableFoodQty($(foodTemplateContext).find('input[id*=hfFoodId]').val(),
            //                                        $(foodTemplateContext).find('span[id*=lblMenuItem]').text().trim());

            DFS.Notification.Dialog('Food Unavailable', '_DialogContainer', 'Ordered quantity is not available.', 300, DFS.Enum.DialogEnum.Warning, '', null);
            sender.value = availableQty;
        }
            //else if (!DFS.Validation.IsPositiveInteger(tbvalue)) {

            //    DFS.Notification.Dialog('Invalid order quantity', '_DialogContainer', 'Order quantity must be a postive value.', 320, DFS.Enum.DialogEnum.Warning, '', null);
            //    sender.value = 0;
            //}
        else if (tbvalue > 100) {
            DFS.Notification.Dialog('Order quantity', '_DialogContainer', 'Order quantity must be within 1 to 100.', 320, DFS.Enum.DialogEnum.Warning, '', null);
            sender.value = 0;
        }

        newPrice = rate * parseInt(sender.value, 10);
        newPrice = parseFloat(newPrice).toFixed(2);
        row.find('div._dviTPrice').find('span').text(newPrice);
        var grid = document.getElementById(employee.GridViewTodaysMenu);

        var sum = 0;
        $("#" + employee.GridViewTodaysMenu + " tr").each(function() {
            var rowTotal = $(this).find('div._dviTPrice').find('span').text();
            if (rowTotal != "") {
                sum = sum + parseFloat(rowTotal);
         
            }
          

        });

        //$("#" + employee.GridViewTodaysMenu).find('._dvfTPrice').find('span').html(sum);
        sum = parseFloat(sum).toFixed(2);
        $('#ContentPlaceHolder1_gvTodaysMenu_lblTotal').html(sum);
        //$('#ContentPlaceHolder1_gvTodaysMenu_lblTotal').text(sum);
        $('#ContentPlaceHolder1_hfTotalCost').val(sum);

        return false;
    },
    OrderedQuantityChanged: function(sender) {

        var tbvalue = parseInt(sender.value, 10);

        var newPrice, availableQty, oldQty;
        var row = $(sender).parents('tr');

        hfavailableQty = parseInt(row.find('div._dviTQty').find('input[id*="hfOrderAvailableQty"]').val());
        oldQty = parseInt(row.find('div._dviTQty').find('span[id*=lblOrderQuantity]').text());

        if (sender.value == null || sender.value == "") {
            sender.value = 0;
        }
        if (tbvalue > hfavailableQty) {
            DFS.Notification.Dialog('Food Available Quantity', '_DialogContainer', 'Order quantity exceeded the available quantity!', 380, DFS.Enum.DialogEnum.Warning, '', null);
            sender.value = oldQty;
            return false;
        } else if (!DFS.Validation.IsPositiveInteger(tbvalue)) {
            DFS.Notification.Dialog('Invalid order quantity', '_DialogContainer', 'Order quantity must be a postive value!', 320, DFS.Enum.DialogEnum.Warning, '', null);
            sender.value = 0;
            return false;
        } else if (tbvalue > 100) {
            DFS.Notification.Dialog('Order quantity', '_DialogContainer', 'Order quantity must be within 1 to 100!', 320, DFS.Enum.DialogEnum.Warning, '', null);
            sender.value = 0;
            return false;
        }

        var rowPriceContext = row.find('div._dviTAmount').find('span[id*=lblOrderPrice]');
        $(rowPriceContext).text(parseInt(row.find('div._dviTRate').find('span[id*=lblOrderRate]').text(), 10) * parseInt(sender.value, 10));

        return false;
    },
    ShowHideRows: function ShowHideRows(sender, className) {
        $('.' + className).toggle(function() {
            var img = $(sender).find("img");

            if ($(this).first("tr").is(":visible")) {
                img.attr('src', 'images/collapse.png');
                employee.Grid.CheckExpAllBtn();
            } else {
                img.attr('src', 'images/expand.png');
                employee.Grid.CheckCollAllBtn();
            }
        });
    },
    CheckExpAllBtn: function() {
        var isAllExpanded = true;
        for (var i = 1; i <= employee.CategoryCount; i++) {
            if ($(".class" + i).first().is(":hidden")) {
                isAllExpanded = false;
            }
        }
        if (isAllExpanded) {
            $("#" + employee.RadioBtnExpand).attr('checked', true);
        }
    },
    CheckCollAllBtn: function() {
        var isAllCollapsed = true;
        for (var i = 1; i <= employee.CategoryCount; i++) {
            if ($(".class" + i).first().is(":visible")) {
                isAllCollapsed = false;
            }
        }
        if (isAllCollapsed) {
            $("#" + employee.RadioBtnCollaspe).attr('checked', true);
        }
    },
    checkExpandAllBtn: function() {
        $("#" + employee.RadioBtnExpand).attr('checked', true);
    },
    CheckAllServerMe: function(chkHeader) {

        var grid = $(chkHeader).closest(".dtTable");

        $("input[type=checkbox]", grid).not(":disabled").each(function() {
            if ($(chkHeader).is(":checked")) {
                $(this).attr("checked", "checked");

            } else {
                $(this).removeAttr("checked");
            }
        });
    },
    CheckMe: function(sender) {

        var grid = $(sender).parents("table:first");

        var chkHeader = $("[id*=chkBoxFoodHeader]", grid);
        if (!$(sender).is(":checked")) {
            chkHeader.removeAttr("checked");
        } else {
            if ($("[id*=chkBoxServeMe]", grid).length == $("[id*=chkBoxServeMe]:checked", grid).length) {
                chkHeader.attr("checked", "checked");
            }
        }
    },
    VerifyCheckBoxes: function() {
        var grid = $('#ContentPlaceHolder1_gvTodaysOrder');
        var chkHeader = grid.find('span.chkHeader').find('input:checkbox');

        if ($("[id*=chkBoxServeMe]", grid).length == $("[id*=chkBoxServeMe]:checked", grid).length) {
            chkHeader.attr("checked", "checked");
            //if ($("[id*=chkBoxServeMe]:disabled", grid).length == $("[id*=chkBoxServeMe]:checked", grid).length) {

            //    chkHeader.attr("checked", "checked");
            //}
            //else {
            //    chkHeader.removeAttr("checked");

            //}
        } else {
            chkHeader.removeAttr("checked");
        }
    },
    ConfirmServe: function(chkHeader) {
        var result = false;
        var grid = $('#ContentPlaceHolder1_gvTodaysOrder');

        //var confirmMsg = 'Do you want to serve ';
        //var checkedCount = $('td input:checked', grid).not(":disabled").length;

        //if (checkedCount == 0) {
        //    employee.Notification.SelectFoodItemForServe();
        //    return false;
        //}
        //var items = checkedCount > 1 ? 'these selected items?' : ' selected item?';

        if (confirm("Are you sure?")) {
            result = true;
        }
        return result;
    }
};

employee.AjaxCall = {
    LikeFoodItemEvent: function(me, likeflag) {
        var foodid = $('input[type="hidden"]', $(me).closest('td').find('.divFoodId')).val();
        LikeFoodHandler.AjaxCall(foodid, employee.Userid, likeflag, $(me).parent('td'));
        return false;
    },
    LogUnAvailableFoodQty: function(foodid, foodName) {

        var jsonData = {
            'UserId': employee.Userid,
            'FoodId': foodid,
            'FoodName': foodName
        };
        $.ajax({
            type: "POST",
            url: "Handlers/LogUnAvailableQty.ashx",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: JSON.stringify(jsonData),
            responseType: "json",
            success: function(data) {
                if (data != "success") {
                    alert(data);
                }
            },
            error: OnFail
        });
    }
};

employee.FoodShare = {
    ValidateShare: function() {
        if ($('#ContentPlaceHolder1_gvSharedUser tr').length > 1) {
            $find('mpeShareFood').hide();
            return true;
        } else {
            alert("Please add users to share.");
            return false;
        }
    },
    ValidateAddingUser: function() {
        if ($("#ContentPlaceHolder1_selectEmpName :selected").index() == 0) {
            alert('Please select an employee.');
            return false;
        } else {
            return true;
        }
    },
    ValidatePrice: function(sender) {
        var positiveInteger = /(^\d+$)/;
        if (!positiveInteger.test(sender.value) || parseInt(sender.value) <= 0 || sender.value == null || sender.value == '') {
            alert("Shared price must be a positive integer and greater than zero!");
            sender.value = '1';
        }
    },
    ChangeSharedPrice: function(sender) {
        this.ValidatePrice(sender);
        var foodAmount = parseInt($("#ContentPlaceHolder1_hfTotSharedFoodAmount").val());
        var totSharedPrice = 0;
        do {
            $("#ContentPlaceHolder1_gvSharedUser tr:has(td):not(:first) input[type=text]").each(function(i, item) { //sums all shared price except first row              
                totSharedPrice += parseInt($(item).val());
            });
            if (totSharedPrice > foodAmount) {
                alert("The total contributing price by shared users exceeded the actual cost for the food order.");
                totSharedPrice = 0;
                sender.value = 1;
            } else {
                break;
            }
        } while (1)
        $("#ContentPlaceHolder1_gvSharedUser tr:has(td):first input[type=text]").val(foodAmount - totSharedPrice);
    }
};

employee.Notification =
{
    SelectFoodItemForServe: function() {
        DFS.Notification.Dialog("Select FoodItem", "_DialogContainer", "Please select fooditem(s) to be served.", 328, DFS.Enum.DialogEnum.Warning, '', null);
    },
    SelectCouponToBeClaimed: function () {
        DFS.Notification.Dialog("Select FoodItem", "_DialogContainer", "Please select Coupon(s) to be claimed.", 328, DFS.Enum.DialogEnum.Warning, '', null);
    }
    };


function clickButton(e, buttonid) {
    var evt = e ? e : window.event;
    var bt = document.getElementById(buttonid);
    if (bt) {
        if (evt.keyCode == 13) {
            bt.click();
            return false;
        }
    }
}