/// <reference path="../_references.js" />

var employeeCouponList = employeeCouponList ||
    {
        NoRecordsFoundMessage: function () {
            DFS.Notification.Dialog("No records found.", "_dvContainer", "No records found.", 370, DFS.Enum.DialogEnum.Information, '', null);
        }
    };