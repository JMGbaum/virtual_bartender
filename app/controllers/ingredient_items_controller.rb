class IngredientItemsController < ApplicationController
  def index
    @ingredients = current_user.ingredients
  end 

  def create
    @ingredient = Ingredient.find(params[:id])
    @user = current_user
    IngredientItem.create(ingredient_id: @ingredient.id, user_id: @user.id)
    redirect_to(request.headers["Referer"]);
  end

  def destroy 
    IngredientItem.find(params[:id]).destroy
    redirect_to(request.headers["Referer"])
  end 

end
