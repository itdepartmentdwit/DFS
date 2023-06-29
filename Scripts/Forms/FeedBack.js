/// <reference path="../_references.js" />

/*
  @Created by: shashrestha 
  @Abstract : Contains all js scripts for Feedback.aspx
*/

var feedback = DFS.Common.CreateNameSpace("DFS.Dfs_Feedback");

feedback.BtnSendFeedBack = null;
feedback.BtnSendResponse = null;
feedback.TxtFeedBack = null;
feedback.TxtResponse = null;
feedback.MaxFeedBackLength = null;
feedback.BaseUrl = null;

feedback.Init = function(btnSendFeedback, btnSendResponse, txtFeedBack, txtResponse) {

    var self = this;
    self.BtnSendFeedBack = btnSendFeedback;
    self.BtnSendResponse = btnSendResponse;
    self.TxtFeedBack = txtFeedBack;
    self.TxtResponse = txtResponse;
    self.MaxFeedBackLength = 500;

    $(".imgFeedback").tooltip({
        bodyHandler: function() {
            return '<b>Preview Image.</b>';
        },
        showURL: false
    });

    self.HideProgressImage();
    self.ToggleFileUploadVisibility();

    $("#" + self.BtnSendFeedBack).click(function() {

        var resultFeedBack = !DFS.Validation.IsEmpty($("#" + self.TxtFeedBack).val());
        var hasFiles = self.CheckIfFileUploadHasValues();
        if (!resultFeedBack) {
            DFS.Notification.Dialog('Feedback', 'dvContainer', 'Feedback message cannot be empty.', 315, DFS.Enum.DialogEnum.Warning, '', null);
            return false;
        } else if (resultFeedBack & $("#_cbFBUpload").is(':checked')) {
            if (!hasFiles) {
                DFS.Notification.Dialog('ImageUpload', 'dvContainer', 'Please select image to upload.', 280, DFS.Enum.DialogEnum.Warning, '', null);
                //alert("Please select image to upload.");
                return false;
            } else {
                self.ShowProgressImage();
                return true;
            }
        }
    });

    $("#" + this.TxtFeedBack).keyup(function() {
        var txtbox = $(this);
        var maxLen = self.MaxFeedBackLength;
        if (txtbox.val().length > (maxLen - 1)) {
            var cont = txtbox.val();
            txtbox.val(cont.substring(0, (maxLen - 1)));
            alert('Feedback message cannot exceed than ' + maxLen + ' characters');
            return false;
        }
    });

    $("#_cbFBUpload").change(function() {
        if ($(this).is(":checked")) {
            $("#divFeedBackImgUpload").fadeIn("1000");
        } else
            $("#divFeedBackImgUpload").fadeOut("1000");
    });
}

/*Client side Events need to be binded again after Partial PostBack*/
feedback.RebindMethodAfterPartialPostBack = function() {
    $("#" + feedback.BtnSendResponse).click(function() {
        if (!DFS.Validation.IsEmpty($("#" + feedback.TxtResponse).val()))
            return true;

        alert("Response message cannot be empty.");
        return false;
    });

    $('.FeedbackMessage').shorten({ showChars: 100, moreText: 'View more', lessText: 'View less' });
};

feedback.ToggleFileUploadVisibility = function() {
    $("#_cbFBUpload").is(':checked') ? $("#divFeedBackImgUpload").show()
        : $("#divFeedBackImgUpload").hide();
};

feedback.SetFileUploadAfterError = function() {

    if (!DFS.Validation.IsBlankString($('.msg-error').html())) /*if errors were seen while uploading*/ {
        $("#_cbFBUpload").attr('checked', true);
        this.ToggleFileUploadVisibility();
        $('input:file').MultiFile('reset');
    }
    feedback.HideProgressImage();
};

feedback.CheckIfFileUploadHasValues = function() {
    var has_selected_file = $('input[type=file]').filter(function() {
        return $.trim(this.value) != ''
    }).length > 0;
    $('#ContentPlaceHolder1_hfFileUppload').val(has_selected_file);
    return has_selected_file;
};

feedback.ShowProgressImage = function() {
    $('#_fbImgLoader').show();
}

feedback.HideProgressImage = function() {
    $('#_fbImgLoader').hide();
}