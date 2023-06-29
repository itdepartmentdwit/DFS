

var suggestedItemDetail = suggestedItemDetail ||
{
    Init: function() {


        $('.lnkRecipePreview').click(function(e) {
            e.preventDefault();
            $(this).parent('div').next('div', '._RecipeContainer').fadeToggle(400, "linear");
        });
    }
}