<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ImageUploader.ascx.cs"
            Inherits="DFS.Web.UserControls.UserAvatar" %>
<script src="../Scripts/DFS.Common.js"> </script>
<script type="text/javascript">

    function beginUpload(sender, args) {
        $('#divSuccess').hide();
        $('#divError').hide();
    }

    function uploadComplete(sender, args) {
        var fileInputElement = sender.get_inputFile();
        fileInputElement.value = "";
        var fileExtension = DFS.Util.GetFileExtension.LowerCase(args.get_fileName());
        var $lblMsg = $('#divSuccess');
        var $lblError = $('#divError');
        // array of allowed file type extensions  
        var validFileExtensions = new Array("jpg", "jpeg", "png", "gif", "bmp");
        var flag = false;
        // loop over the valid file extensions to compare them with uploaded file  
        for (var index = 0; index < validFileExtensions.length; index++) {
            if (fileExtension.toLowerCase() == validFileExtensions[index].toString().toLowerCase()) {
                flag = true;
            }
        }

        if (flag == false) {
            $lblError.show();
            $lblError.text("File extension not supported.");

            return;
        }

        var validLength = true;

        if (parseInt(args.get_length()) > 4194304) {
            $lblError.show();
            $lblError.text('File size should be less than 4MB.');
            validLength = false;
            return;
        }

        if ((flag == true) && (validLength == true)) {
            $lblMsg.show();
            $lblMsg.text("Upload complete");
        }
    }

    function uploadError(sender, args) {
        $("#ContentPlaceHolder1_AddUserAvatarUpload_lblErr").text(args.get_errorMessage());

    }
</script>
<asp:UpdatePanel ID="upPanelAvatar" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
       
        <div class="upload-title">
            Upload Image
        </div>
        <br />
        <div class="upload-pding">
            <asp:Image ID="imgFullImage" runat="server" CssClass="uploaded-image" />
            <ajaxToolkit:AsyncFileUpload runat="server" ID="fileUpload" CompleteBackColor="White" Width="240"
                                         ToolTip="Click here to upload" OnClientUploadError=" uploadError " OnClientUploadComplete=" uploadComplete "
                                         OnClientUploadStarted=" beginUpload " OnUploadedComplete="FileUploadComplete" ThrobberID="loader"
                                         UploaderStyle="Modern" />
            <br />
            <br />
            <div class="msg-error" id="divError" style="display: none;">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </div>
            <asp:Label ID="lblErr" runat="server" ForeColor="Red"></asp:Label>
            <div class="msg-success" id="divSuccess" style="display: none;">
            </div>
        </div>
    </ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="fileUpload" />
    </Triggers>
</asp:UpdatePanel>
<asp:HiddenField ID="_hfImageDetail"  runat="server"   Value="a"/>
<br />

<div>
    <asp:Image ID="loader" runat="server" ImageUrl="~/images/ajax-loader1.gif" Style="display: none;" />
</div>