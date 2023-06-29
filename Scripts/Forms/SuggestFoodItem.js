/// <reference path="../_references.js" />

/*
  @Created by: shashrestha on Feb17,2013
  @Abstract : Contains all js scripts for SuggestFoodItem.aspx
*/
var suggestFood = suggestFood ||
{
    Variable:
    {
        FoodFileUpload: null,
        RecipeFileUpload: null,
        CheckBoxRecipe: null
    },
    Init: function(foodFileUpload, recipeFileUpload, chkRecipe) {

        var self = this;

        self.Variable.FoodFileUpload = foodFileUpload;
        self.Variable.RecipeFileUpload = recipeFileUpload;
        self.Variable.CheckBoxRecipe = chkRecipe;

        self.RebindEventsAfterPostBack();

        $("#" + chkRecipe).change(function() {
            if ($(this).is(":checked")) {
                $('#_RecipeRow').fadeIn("1000");
            } else
                $('#_RecipeRow').fadeOut("1000");
        });


    },
    RebindEventsAfterPostBack: function() {
        $("#" + suggestFood.Variable.CheckBoxRecipe).is(":checked") ? $('#_RecipeRow').show() : $('#_RecipeRow').hide();
    }        
}