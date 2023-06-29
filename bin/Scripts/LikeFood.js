/// <reference path="jquery-1.7.2-vsdoc.js" />
/* Modified on Feb 18, 2014

*/

var LikeFoodHandler =
{
    LikeBtn: "images/like.png",
    LikeBtnActive: "images/like-act.png",
    DisLikeBtn: "images/dislike.png",
    DisLikeBtnActive: "images/dislike-act.png",
    AjaxCall: function(foodid, empId, likeflag, context) {
        $.ajax({
            url: "../WebService/Service.asmx/ProcessLikeRequest",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: JSON.stringify({ 'userid': empId, 'foodid': foodid, 'likeFlag': likeflag }),
            responseType: "json",
            type: 'POST',
            success: function(data) {
                LikeFoodHandler.CallSuccess(data, context);
            },
            error: function(x, y, z) {
                console.log(x);
                console.log(y);
                console.log(z);
            }
        });
    },
    CallSuccess: function(data, context) {
        var lbtnlikeContext = $(context).find('.lnkLikebtn');
        var lbtndislikeContext = $(context).find('.lnkDisLikebtn');
        var json = $.parseJSON(data.d);

        $(lbtnlikeContext).attr('count', json.FoodLikeCount.LikeCount);
        $(lbtndislikeContext).attr('count', json.FoodLikeCount.DisLikeCount);
        if (json.FoodLike) {
            lbtnlikeContext.find('img').attr('src', LikeFoodHandler.LikeBtnActive);
            lbtndislikeContext.find('img').attr('src', LikeFoodHandler.DisLikeBtn);
        } else {
            lbtndislikeContext.find('img').attr('src', LikeFoodHandler.DisLikeBtnActive);
            lbtnlikeContext.find('img').attr('src', LikeFoodHandler.LikeBtn);
        }
    },
    SetLikeTooltip: function() {
        $(".lnkLikebtn").tooltip({
            bodyHandler: function() {
                var count = parseInt($(this).attr('count'));
                var likehtml = '';
                if (count > 0) {
                    likehtml = '<br/>' + '<strong>Likes: ' + count + '</strong>';
                }
                var html = $(this).attr('liketitle') + likehtml;
                return html;
            },
            showURL: false
        });
    },
    SetDisLikeTooltip: function() {
        $(".lnkDisLikebtn").tooltip({
            bodyHandler: function() {
                var count = parseInt($(this).attr('count'));
                var likehtml = '';
                if (count > 0) {
                    likehtml = '<br/>' + '<strong>Dislikes: ' + count + '</strong>';
                }
                var html = $(this).attr('liketitle') + likehtml;
                return html;
            },
            showURL: false
        });
    }
};

function OnFail(result) {
    alert('An error has occured!');
}