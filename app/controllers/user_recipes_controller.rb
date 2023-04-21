class UserRecipesController < ApplicationController
  def index
    @recipes = current_user.user_recipes
  end 

  def create
    UserRecipe.create(recipe_id: params[:id], user: current_user, liked: params[:liked])
    redirect_to(request.headers["Referer"])
  end

  def update
    @user_recipe = UserRecipe.find(params[:id])
    @user_recipe.update(user_recipe_params)

    redirect_to(request.headers["Referer"])
  end

  def destroy 
    UserRecipe.find(params[:id]).destroy
    redirect_to(request.headers["Referer"])
  end 

  private

  def user_recipe_params
    params.require(:user_recipe).permit(:liked)
  end
end
