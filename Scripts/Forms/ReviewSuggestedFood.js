/// <reference path="../_references.js" />

var reviewFood = reviewFood ||
{
    Init: function() {

        $('.chosen').chosen();
    },
    RecipeDialog: function() {

        $('#_RecipeDialog').dialog(
            {
                dialogClass: 'no-close',
                title: 'Recipe',
                modal: true,
                width: 420,
                resizable: false,
                closeOnEscape: true,
                buttons: {
                    OK: function() {

                        $(this).dialog("close");
                    }
                }
            });
    }
}