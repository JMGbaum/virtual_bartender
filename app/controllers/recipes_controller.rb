class RecipesController < ApplicationController
    def index
        @recipes = params[:search].present? ? Recipe.where('title LIKE ? OR description LIKE ? OR instructions LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").select(:id, :title, :description)
            : Recipe.all.select(:id, :title, :description)
    end

    def show
        @recipe = Recipe.find(id: params[:id])
    end
end
