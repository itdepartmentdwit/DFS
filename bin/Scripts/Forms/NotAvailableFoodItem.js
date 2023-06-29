/// <reference path="../_references.js" />

var ntAvailable = ntAvailable ||
{
    Init: function() {
        $('.datepicker').datepicker({               
            changeMonth: true,
            changeYear: true,
            showAnim: 'fade',
            maxDate: '+0d',
            dateFormat: 'dd/mm/yy'
        });
    },
    Notification: function() {
        DFS.Notification.Dialog("No data found", "_dvContainer", "No records were found with selected dates.", 370, DFS.Enum.DialogEnum.Warning, '', null);
    }
};