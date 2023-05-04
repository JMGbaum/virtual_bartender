class RecipesController < ApplicationController
    before_action :set_recipe, only: %i[edit update destroy]
    before_action :authorize, only: %i[edit update destroy]

    def index
        @pagy, @recipes = pagy(params[:search].present? ? Recipe.where('title LIKE ? OR description LIKE ? OR instructions LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").select(:id, :title, :description)
            : Recipe.all.select(:id, :title, :description))
        
        @user_recipes = logged_in? ? current_user.user_recipes : []
    end

    def show
        @recipe = Recipe.find(params[:id])
    end

    def new
        @recipe = Recipe.new
    end

    def create
        @recipe = Recipe.new(author_id: current_user.id, **recipe_params)
        if @recipe.save
            flash[:success] = "Recipe created successfully"
            redirect_to recipe_ingredients_path(@recipe)
        else
            flash[:danger] = "Something went wrong"
            redirect_to new_recipe_path
        end
    end

    def edit
    end

    def update
        if @recipe.update(recipe_params)
            flash[:success] = "Recipe updated successfully"
            redirect_to recipe_ingredients_path(@recipe)
        else
            flash[:danger] = "Something went wrong"
            redirect_to edit_recipe_path(@recipe)
        end
    end

    def destroy
        if @recipe.destroy
            flash[:success] = "Recipe deleted successfully"
            redirect_to recipes_path
        else
            flash[:danger] = "Something went wrong"
            redirect_to edit_recipe_path(@recipe)
        end
    end

    private

    def authorize
        unless logged_in? && @recipe.author_id == current_user.id
            flash[:danger] = "You must be the author of the recipe to do this."
            redirect_to(recipe_path(@recipe))
        end
    end

    def set_recipe
        @recipe = Recipe.find(params[:id])
    end

    def recipe_params
        params.require(:recipe).permit(
            :title,
            :source,
            :category,
            :image,
            :servings,
            :glass,
            :description,
            :instructions
        )
    end
end
