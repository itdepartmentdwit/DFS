/// <reference path="../_references.js" />

// check before we create the namespace
var MultiFileUploader = MultiFileUploader || {
    Id: 0,
    MaxUploads: 3,
    DivFiles: null,
    DivListBox: null,
    BtnAdd: null,
    FilesTable: null,
    alert: function() {

    },
    Init: function(maxLimit, panelFilesId, panelListboxId) {
        this.MaxUploads = maxLimit;
        this.DivFiles = panelFilesId;
        this.DivListBox = panelListboxId;
        this.FilesTable = $('#' + MultiFileUploader.DivListBox).find('table');

    },
    CreateFile: function() {
        var IpFile = document.createElement('input');
        IpFile.id = IpFile.name = 'IpFile_' + MultiFileUploader.Id++;
        IpFile.type = 'file';
        return IpFile;
    },
    GetTopFile: function() {

        var Inputs = $('#' + MultiFileUploader.DivFiles + ' :input');
        var IpFile = null;

        for (var n = 0; n < Inputs.length && Inputs[n].type == 'file'; ++n) {
            IpFile = Inputs[n];
            break;
        }
        return IpFile;
    },
    GetTotalFilesCount: (function() {
        return $('#' + MultiFileUploader.DivFiles + ' :input').size();
    }),
    GetTotalItemsCount: function() {
        var divs = $('#' + MultiFileUploader.DivListBox).children('div');
        return divs != null ? divs.size() : 0;
    },
    AddFile: function() {
        var max = MultiFileUploader.MaxUploads;
        var IpFile = MultiFileUploader.GetTopFile();
        if (IpFile == null || IpFile.value == null || IpFile.value.length == 0) {
            alert('Please select a file to add.');
            return;
        }
        var NewIpFile = MultiFileUploader.CreateFile();
        $(NewIpFile).insertBefore(IpFile);

        if (max != 0 && MultiFileUploader.GetTotalFilesCount() - 1 == max) {
            NewIpFile.disabled = true;
            $('#' + MultiFileUploader.BtnAdd).attr('disabled', 'True');
        }
        IpFile.style.display = 'none';
        $('#' + MultiFileUploader.DivListBox).append(MultiFileUploader.CreateItem(IpFile));
    },
    CreateItem: function(ipFile) {

        var Item = document.createElement('div');
        Item.style.backgroundColor = '#ffffff';
        Item.style.fontWeight = 'normal';
        Item.style.textAlign = 'left';
        Item.style.verticalAlign = 'middle';
        Item.style.cursor = 'default';
        Item.style.height = 20 + 'px';
        var Splits = ipFile.value.split('\\');
        console.log(Splits);
        Item.innerHTML = Splits[Splits.length - 1] + '&nbsp;';
        Item.value = ipFile.id;
        Item.title = ipFile.value;
        var A = document.createElement('a');
        A.innerHTML = 'Delete';
        A.id = 'A_' + MultiFileUploader.Id++;
        A.style.color = 'blue';
        A.onclick = function(e) {
            e.preventDefault();
            var Max = MultiFileUploader.MaxUploads;
            $(this).parent().remove();

            if (Max != 0 && MultiFileUploader.GetTotalFilesCount() - 1 < Max) {
                MultiFileUploader.GetTopFile().disabled = false;
                $('#' + MultiFileUploader.BtnAdd).attr('disabled', 'false');
            }
        }
        Item.appendChild(A);
        //Item.onmouseover = function () {
        //    Item.bgColor = Item.style.backgroundColor;
        //    Item.fColor = Item.style.color;
        //    Item.style.backgroundColor = '#C6790B';
        //    Item.style.color = '#ffffff';
        //    Item.style.fontWeight = 'bold';
        //}
        //Item.onmouseout = function () {
        //    Item.style.backgroundColor = Item.bgColor;
        //    Item.style.color = Item.fColor;
        //    Item.style.fontWeight = 'normal';
        //}
        return Item;
    },
    DisableTop: function() {
        if (MultiFileUploader.GetTotalItemsCount() == 0) {
            alert('Please browse at least one file to upload.');
            return false;
        }
        MultiFileUploader.GetTopFile().disabled = true;

        return true;
    },
    Clear: function() {
        $('#' + MultiFileUploader.DivListBox).html('');
        $('#' + MultiFileUploader.DivFiles).html('');
        $('#' + MultiFileUploader.DivFiles).append(MultiFileUploader.CreateFile());
        $('#' + MultiFileUploader.BtnAdd).attr('disabled', 'false');

    }
};