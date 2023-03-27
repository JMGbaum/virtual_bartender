class UserRecipesController < ApplicationController
  def index
    @recipes = current_user.recipes
  end 

  def create
    @recipe = Recipe.find(params[:id])
    @user = current_user
    UserRecipe.create(recipe: @recipe, user: @user)
    redirect_to(request.headers["Referer"])
  end

  def destroy 
    UserRecipe.find(params[:id]).destroy
    redirect_to(request.headers["Referer"])
  end 
end
