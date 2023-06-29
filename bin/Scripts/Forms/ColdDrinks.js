/// <reference path="../_references.js" />

var coldDrinks = coldDrinks ||
{
    Init: function() {
        $(".chosen").chosen();
    },
    Notification: function() {
        DFS.Notification.Dialog("No data found", "_dvContainer", "No records were found with selected parameters.", 380, DFS.Enum.DialogEnum.Warning, '', null);
    },
    NoColdDrinkMessage: function() {
        DFS.Notification.Dialog("No data found", "_dvContainer", "No fooditem available with ColdDrink category.", 370, DFS.Enum.DialogEnum.Error, '', null);
    }
};