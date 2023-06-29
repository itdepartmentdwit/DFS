/// <reference path="_references.js" />

function displayAvatar() {
    xOffset = 180;
    yOffset = 20;

    $("a.preview").click(function(e) { e.preventDefault(); });

    $("a.preview").hover(function(e) {
        this.t = this.title;
        this.title = "";
        var c = (this.t != "") ? "<br/>" + this.t : "";
        var imgSrc = $(this).next('input').val() != null ? $(this).next('input').val() : '/images/AvatarImage/avatar-unknown-lg.jpg';
        $("body").append("<p id='preview'><img src='" + imgSrc + "' alt='No Image Available'  height='300' width='250' />" + c + "</p>");
        $("#preview").css("top", (e.pageY - xOffset) + "px")
            .css("left", (e.pageX + yOffset) + "px")
            .fadeIn("slow");
    },
        function() {
            this.title = this.t;
            $("#preview").remove();
        });

    $("a.preview").mousemove(function(e) {
        $("#preview").css("top", (e.pageY - xOffset) + "px")
            .css("left", (e.pageX + yOffset) + "px");
    });
}

// Asp.net wires up any JavaScript method named pageLoad() to the Application.PageLoad

function pageLoad() {

    $('input[id*=txtDeliveryTime], input[id*=txtDelivery]').timepicker({
        showPeriod: true,
        showLeadingZero: true
    });

    displayAvatar();
}

function GetTotalCheckBoxCount(elementId) {
    var count = 0;
    var TargetBaseControl = $('.todayordergrid')[0];
    var TargetChildControl = "chkBoxFoodorder";
    var controls = TargetBaseControl.getElementsByTagName("input");

    for (var i = 0; i < controls.length; ++i) {
        if (controls[i].type == 'checkbox' && controls[i].id.indexOf(TargetChildControl, 0) >= 0)
            count++;
    }

    return count;
}

function GetTotalCheckedCheckBoxCount(elementId) {

    var count = 0;
    var TargetBaseControl = $('.todayordergrid')[0];
    var TargetChildControl = "chkBoxFoodorder";
    var controls = TargetBaseControl.getElementsByTagName("input");

    for (var i = 0; i < controls.length; i++) {
        if (controls[i].type == 'checkbox' && controls[i].id.indexOf(TargetChildControl, 0) >= 0 && controls[i].checked)
            count++;
    }

    return count;
}

function HeaderClick(CheckBox) {

    //Get target base & child control.    
    var TargetBaseControl = $('.todayordergrid')[0];
    var TargetChildControl = "chkBoxFoodorder";

    //Get all the control of the type INPUT in the base control.
    var Inputs = TargetBaseControl.getElementsByTagName("input");

    //Checked/Unchecked all the checkBoxes inside the GridView.
    for (var n = 0; n < Inputs.length; ++n)
        if (Inputs[n].type == 'checkbox' && Inputs[n].id.indexOf(TargetChildControl, 0) >= 0)
            Inputs[n].checked = CheckBox.checked;
}

function ChildClick(CheckBox, HCheckBox) {

    var TotalChkBx = GetTotalCheckBoxCount(HCheckBox);
    var Counter = GetTotalCheckedCheckBoxCount(HCheckBox);

    //get target control.
    var HeaderCheckBox = document.getElementById(HCheckBox);

    //Change state of the header CheckBox.
    if (Counter < TotalChkBx)
        HeaderCheckBox.checked = false;
    else if (Counter == TotalChkBx)
        HeaderCheckBox.checked = true;
}

function customOpen(url) {
    var w = window.open(url, 'Print', 'scrollbars=yes,height=600,width=1000');
    w.focus();
}


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