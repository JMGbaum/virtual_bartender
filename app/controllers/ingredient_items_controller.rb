class IngredientItemsController < ApplicationController
  def create
    @ingredient = Ingredient.find(params[:id])
    @user = User.find(params[:id])
    IngredientItem.create(ingredient_id: @ingredient.id, user_id: @user.id)
    redirect_to(ingredients_path);
  end

end
