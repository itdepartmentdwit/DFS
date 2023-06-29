
$(document).ready(function() {

    var dfs_common = DFS.Common;

    dfs_common.SetInterval(function() { $("#clock").html(dfs_common.GetClockValue); }, 1000);

    function ValidateTimepicker(sender) {
        var Timepicker = /^(1[0-2]|(0?[1-9])):[0-5]\d (AM|PM)/i;
        var value = sender.value;
        if (!Timepicker.test(value)) {
            alert("Enter valid time!");
            sender.value = '';
        }
    }

    $(".NHeader").click(function() {
        $(this).parent('ul').find('li:last-child').toggle();
    });
});