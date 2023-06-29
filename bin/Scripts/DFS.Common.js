/// <reference path="_references.js" />

/*
  @Created by: shashrestha 
  @Abstract : Contains common js methods 
*/

function updateClock() {
    var currentTime = new Date();

    var currentMinutes = currentTime.getMinutes();
    var currentSeconds = currentTime.getSeconds();
    var currentHours = currentTime.getHours();

    // Pad the minutes and seconds with leading zeros, if required
    currentMinutes = (currentMinutes < 10 ? "0" : "") + currentMinutes;
    currentSeconds = (currentSeconds < 10 ? "0" : "") + currentSeconds;

    // Choose either "AM" or "PM" as appropriate
    var timeOfDay = (currentHours < 12) ? "AM" : "PM";

    // Convert the hours component to 12-hour format if needed
    currentHours = (currentHours > 12) ? currentHours - 12 : currentHours;

    // Convert an hours component of "0" to "12"
    currentHours = (currentHours == 0) ? 12 : currentHours;

    // Compose the string for display
    var currentTimeString = currentHours + ":" + currentMinutes + ":" + currentSeconds + " " + timeOfDay;

    // Update the time display
    //document.getElementById("clock").firstChild.nodeValue = currentTimeString;
    return currentTimeString;
}

var DFS = DFS ||
{
    Common: {
        CreateNameSpace: function(namespaceString) {
            var parts = namespaceString.split('.'),
                parent = window,
                currentPart = '';
            for (var i = 0, length = parts.length; i < length; i++) {
                currentPart = parts[i];
                parent[currentPart] = parent[currentPart] || {};
                parent = parent[currentPart];
            }
            return parent;
        },
        GetClockValue: function() {
            return updateClock();
        },
        CheckFunctionType: function(func) {
            if (func && (typeof func == "function")) {
                return true;
            }
            return false;
        },
        SetInterval: function(func, interval) {
            if (this.CheckFunctionType(func))
                setInterval(func, interval);
        },
    },
    Validation: {
        IsEmpty: function(param) {
            return (!param || param.length == 0);
        },
        IsBlankString: function(str) {
            return (!str || /^\s*$/.test(str));
        },
        TryParseInt: function(str, defaultValue) {
            return /^\d+$/.test(str) ? parseInt(str) : defaultValue;
        },
        IsPositiveInteger: function(value) {
            var Regex = /(^\d+$)/;
            return Regex.test(value);
        },
        IsNumberKey: function(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (evt.keyCode == 13)
                return false;
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        },
        IsValidTime: function(sender) {

            var result = false;
            var regex = /^(1[0-2]|(0?[1-9])):[0-5]\d (AM|PM)/i;
            var value = sender.value;
            if (regex.test(value)) {
                alert(value);
                result = true;
                sender.value = '';
            }
            return result;
        }
    },
    Util: {
        GetFileExtension: (function() {
            var fname = "";
            return {
                LowerCase: function(filename) {
                    fname = filename.split('.').pop().toLowerCase();
                    return fname;
                }
            }
        })(),
        CheckBrowser: function() {
            var Name = null;
            var agent = window.navigator.userAgent;
            if (agent.indexOf("Chrome") != -1)
                Name = "Chrome";
            else if (agent.indexOf("MSIE") != -1)
                Name = "IE";
            else if (agent.indexOf("Firefox") != -1)
                Name = "FireFox";
            return Name;
        },
        GetBrowser: function() {
            var ua = navigator.userAgent, tem,
                M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*([\d\.]+)/i) || [];
            if (/trident/i.test(M[1])) {
                tem = /\brv[ :]+(\d+(\.\d+)?)/g.exec(ua) || [];
                return 'IE ' + (tem[1] || '');
            }
            M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
            if ((tem = ua.match(/version\/([\.\d]+)/i)) != null) M[2] = tem[1];
            return M.join(' ');
        },
        BlockingHtml: function(sender, e) {
            IsShiftDown = false;
            var key = e.which ? e.which : e.keyCode;
            if (key == 16) {
                IsShiftDown = true;
            } else if ((IsShiftDown == true) && ((key == 188) || (key == 190))) {
                return false;
            }
        }
    },
    Trigger: {
        BindClickEventOnKeyPress: function(controlId, buttonId, keycode) {
            $('#' + controlId).keyup(function(e) {
                var evt = e ? e : window.event;
                if (evt.keyCode == keycode) {
                    $('#' + buttonId).click();
                    return false;
                }
            });
        },
        BindKeyPressForOnlyNumbers: function(controlId) {
            $('#' + controlId).on('keydown', function(e) {
                var evt = e ? e : window.event;
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                    return false;
                }
                return true;
            });
        }
    },
    Plugins:
    {
        JqToolTip: function() {

        }
    },
    Enum:
    {
        DialogEnum: {
            Error: 1,
            Warning: 2,
            Information: 3
        },
        BrowserEnum:
        {
            GoogleChrome: "Chrome",
            MozillaFireFox: "FireFox",
            InternetExplorer: "IE"
        },
        JsNotify:
        {
            Error: "error",
            Warning: "warning",
            Default: ""
        }
    },
    Notification:
    {
        Dialog: function(title, container, message, width, dialogEnum, content, func) {

            var imagecss = null;
            switch (parseInt(dialogEnum, 10)) {
            case 1:
                imagecss = 'dialogError'
                break;
            case 2:
                imagecss = 'dialogWarning'
                break;
            case 3:
                imagecss = 'dialogInfo'
                break;
            case 0:
                imagecss: 'dialogNone';
            }

            var html = '';
            html = '<div id="dialog-message" title="' + title + '">' + '<p>'
                + '<span class="info-image-span" style="float:left; margin-right:5px;"><img class="' + imagecss + '" alt=""/></span>'
                + message + '</p>'
                + content + '</div>';
            var b = $('#dialog-message').val();
            $(html).appendTo("#" + container);
            var z = '';
            $('#dialog-message').val(z);
            var a = $('#dialog-message').val();
            $('#dialog-message').dialog(
                {
                    dialogClass: 'no-close',
                    modal: true,
                    width: width,
                    resizable: false,
                    position: { my: 'top', at: 'top+150' },
                    buttons: {
                        OK: function() {
                            if (DFS.Common.CheckFunctionType(func))
                                func();

                            else {
                                $(this).dialog("close");
                                $(this).dialog("destroy");
                                $(this).parent().children().remove();
                            }
                        }
                    }
                });
        },
        NotifyJs: function(message, errorType, delayTimeout) {
            if (errorType == DFS.Enum.JsNotify.Default)
                $.jnotify(message, delayTimeout);
            else
                $.jnotify(message, errorType, delayTimeout);
        },
        JsConfirmDialog: function(msg) {
            var result = confirm(msg);
            if (result)
                return true;
            else
                return false;
        }
    },

    Event:
    {
        OnBlur: function(sender) {
            $(sender).css("backgroundColor", "#ffffff");

        },
        OnFocus: function(sender) {
            $(sender).css("backgroundColor", "#FFF5EC");
        }
    }
};