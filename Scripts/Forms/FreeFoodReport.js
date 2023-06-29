/// <reference path="../_references.js" />

var freefoodreport = freefoodreport ||
{
    NoRecordsFoundMessage: function() {
        DFS.Notification.Dialog("No records found.", "_dvContainer", "No records found.", 370, DFS.Enum.DialogEnum.Information, '', null);
    }
};