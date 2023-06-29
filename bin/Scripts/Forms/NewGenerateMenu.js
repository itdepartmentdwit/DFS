/// <reference path="../DFS.Common.js" />
/// <reference path="../_references.js" />

/*
@Created On : 01/25/2014 by ShaShrestha
@Abstract : Contains Js scripts for GenerateMenu.aspx

*/

var newGenerateMenu = DFS.Dfs_generateMenu ||
{
    Controls:
    {
        Grid: null
    },
    Init: function(gvMenu) {
        var self = newGenerateMenu;
        self.Controls.Grid = gvMenu;

        $('#_dvContainer').hide();
        self.BindEvents();

    },
    BindEvents: function() {

        //Binding TimePicker
        $(".ui-timepicker-div").timepicker({
            controlType: 'select',
            oneLine: true,
            timeFormat: 'hh:mm tt'
        });

        //Bind [Go To Top] btn
        $("a[href='#top']").click(function() {
            $("html, body").animate({ scrollTop: 0 }, "slow");
            return false;
        });

        //Bind add quantity linkbutton to open dialog
        $('.lbtnAddQty').click(function (e) {
            if ($(this).attr("disabled") === "disabled") {
                e.preventDefault();
                return false;
            }
            var html = '<span style="color:red; display:none;" id="_txtemptyErr"></span>'
                + '<div style="padding-top:4px;"><span style="color:red; font-weight:bold; padding-right:2px;">*</span>'
                + '<label for="_txtAddedQty" style="padding-right:5px;"><strong>Enter Quantity: </strong></label>'
                + '<input type="text" id="_txtAddedQty" style="width:45px;" onkeypress="return DFS.Validation.IsNumberKey(event)"/></div>';

            var foodid = $('input[type="hidden"]', $(this).closest('td').find('div._dviTMenuId')).val();
            var iniQtCtx = $('span', $(this).closest('tr').find('div._dviTIniQty'));
            var avQtyCtx = $('span', $(this).closest('tr').find('div._dviTAvailQty'));

            DFS.Notification.Dialog('Add Quantity', '_dvContainer', '', 260, 0, html, function () { newGenerateMenu.AjaxCall.AddQty(foodid, iniQtCtx, avQtyCtx) });
        });


    },
    AjaxCall:
        {
            AddQty: function (foodid, iniQtCtx, avQtyCtx) { /*calls handler in webApplication to update menuitem qty*/

                var errContext = $('span#_txtemptyErr');
                if (DFS.Validation.IsEmpty($('input#_txtAddedQty').val())) {
                    $(errContext).show();
                    $(errContext).text('Available quantity is required.');
                    return false;
                } else
                    $(errContext).hide();

                if (!DFS.Validation.IsPositiveInteger($('input[id=_txtAddedQty]').val())) {
                    errContext.show();
                    errContext.text("Quantity must a valid number.");
                    return false;
                }

                $.ajax({
                    url: "/Handlers/AddMenuQty.ashx",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: { fId: foodid, qty: $('#_txtAddedQty').val() },
                    responseType: "json",
                    success: function (data) {
                        if (data.Success) {
                            $(iniQtCtx).text(data.Items[0].Value);
                            $(avQtyCtx).text(data.Items[1].Value);
                        } else
                            alert(data.ResultMessage);
                        $('#dialog-message').dialog("close");
                        $('#dialog-message').dialog("destroy");
                        $('#dialog-message').parent().children().remove();

                    },
                    error: function (x, h, r) {
                        console.log(r);
                    }
                });
            }
        },
    Grid: {
        ToggleValidation: function(sender) {

            var row = $(sender).parents('tr');

            var lnkBtn = row.find('div._dviTAddQty').find('a.lbtnAddQty');
            var divEditBtn = row.find('div._dviTAction');

            var tbEditButton = divEditBtn.find('a[id*=btnMenuEdit]');

            var editBtnAttr = document.getElementById($(tbEditButton).attr('id'));

            if (sender.checked) {
           
                $(tbEditButton).removeAttr('disabled');
                //divEditBtn.find('img').attr('src', '/images/edit.png')
                tbEditButton.removeClass("dfsButton-faded");
                tbEditButton.addClass("dfsButton");

                $(lnkBtn).removeAttr('disabled');
                lnkBtn.find('img').attr('src', '/images/addActive.png')
                //ValidatorEnable(lnkBtn, true)
                //ValidatorEnable(reqValAvailableTimeTo, true);
                //ValidatorEnable(reqValAvailableNumber, true);
            } else {
           
                $(tbEditButton).attr('disabled', 'disabled');
                tbEditButton.removeClass("dfsButton");
                tbEditButton.addClass("dfsButton-faded");
                $(lnkBtn).attr('disabled', 'disabled');
                lnkBtn.find('img').attr('src', '/images/addInactive.png')
             
            }
        },
        ValidateTextBox: function(sender) {
            var value = sender.value;

            if (DFS.Validation.IsEmpty(value)) {
                DFS.Notification.Dialog('Empty Value', '_dvContainer', 'The quantity number cannot be empty!', 320, DFS.Enum.DialogEnum.Warning, '', null);
                sender.value = '0';
            } else if (sender.value > 1000) {
                DFS.Notification.Dialog('Set quantity', '_dvContainer', 'Set quantity must be within 1 to 1000!', 320, DFS.Enum.DialogEnum.Warning, '', null);

                sender.value = 0;
            }
        }
    }
}