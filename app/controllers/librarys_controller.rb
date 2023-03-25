class LibrarysController < ApplicationController
  def new
  end

  def create
    @recipe = Recipe.find(params[:id])
    @user = User.find(params[:id])
    Library.create(recipe_id: @recipe.id, user_id: @user.id)
    redirect_to(recipes_path);
  end
end
