$(document).ready(function() {

    $(".nolink").click(function() {
        return false;
    });

    var url = window.location.href;
    var pageName = getTextAfterLastForwardSlash(url);

    $('.menu a').filter(function() {

        //Following two lines of code will only work if href value of anchor tag has forward slash.
        var menuHREF = this.href;
        var menuPageName = getTextAfterLastForwardSlash(menuHREF);

        if (pageName != '' && menuPageName != '' && pageName == menuPageName) {
            var currentAnchor = $(this);
            $(currentAnchor).addClass('activemenu');

            //Following code will only work for second level menu
            $(currentAnchor).parent().parent().prev().addClass('activemenu');
        }
    });

    function getTextAfterLastForwardSlash(pathOrURL) {
        return pathOrURL.substring(pathOrURL.lastIndexOf('/') + 1);
    }
});