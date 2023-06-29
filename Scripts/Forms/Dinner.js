/// <reference path="../_references.js" />

var dinner = dinner ||
{
    Notification: function() {
        DFS.Notification.Dialog("No data found", "_dvContainer", "No records were found with selected dates.", 370, DFS.Enum.DialogEnum.Information, '', null);
    }
};