class RecipesController < ApplicationController
    def index
        @pagy, @recipes = pagy(params[:search].present? ? Recipe.where('title LIKE ? OR description LIKE ? OR instructions LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").select(:id, :title, :description)
            : Recipe.all.select(:id, :title, :description))
        
        @user_recipes = logged_in? ? current_user.user_recipes : []
    end

    def show
        @recipe = Recipe.find(params[:id])
    end
end
