/// <reference path="../_references.js" />

var viewSuggesteditem = viewSuggesteditem ||
{
    UserId: null,
    Init: function(userId) {
        this.UserId = userId;
        $('.lnkRecipePreview').click(function(e) {
            e.preventDefault();
            $(this).parent('div').next('div', '._RecipeContainer').fadeToggle(400, "linear");
        });

        $("div.voteArrow").click(function() {
            viewSuggesteditem.Vote($(this));
        });
    },
    Vote: function(context) {

        var foodsuggestionId = context.attr('Id');
        var isThisAnUpVote = context.hasClass("up");
        var totalVotesDiv = context.parent().children(".totalVotes").eq(0);
        var hasVoted, otherVoteIcon, voteValue;

        // Get the other vote icon (e.g., the down vote if the user just clicked up vote
        if (isThisAnUpVote)
            otherVoteIcon = context.parent().children("div.down").eq(0);
        else
            otherVoteIcon = context.parent().children("div.up").eq(0);

        // Update the display accordingly...
        if (isThisAnUpVote) {
            context.toggleClass("upvoted");
            otherVoteIcon.removeClass("downvoted");
        } else {
            context.toggleClass("downvoted");
            otherVoteIcon.removeClass("upvoted");
        }

        // Determine voteValue
        if (isThisAnUpVote) {
            hasVoted = context.hasClass("upvoted") || otherVoteIcon.hasClass("upvoted");
            voteValue = hasVoted ? 1 : 0;
        } else {
            hasVoted = context.hasClass("downvoted") || otherVoteIcon.hasClass("downvoted");
            voteValue = hasVoted ? -1 : 0;
        }

        $.ajax({
            url: "../WebService/Service.asmx/ProcessVoteRequest",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: JSON.stringify({ 'Id': foodsuggestionId, 'userId': viewSuggesteditem.UserId, 'voteValue': voteValue }),
            responseType: "json",
            type: 'POST',
            success: function(data) {
                alert($.parseJSON(data.d));
                totalVotesDiv.html($.parseJSON(data.d));

            },
            error: function(x, y, z) {
                console.log(x);
                console.log(y);
                console.log(z);
            }
        });

    }
}