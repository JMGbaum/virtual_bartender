class RecipeIngredientsController < ApplicationController
    before_action :set_recipe
    before_action :set_recipe_ingredient, only: %i[edit update destroy]
    before_action :authorize

    def index
        @recipe_ingredients = Recipe.find(params[:recipe_id]).recipe_ingredients
    end

    def new
        @recipe_ingredient = RecipeIngredient.new
        @pagy, @results = pagy(params[:search].present? && params[:type].present? ? Object.const_get(params[:type]).where("name LIKE ?", "%#{params[:search]}%")
            .where.not(id: params[:type] == 'Tag' ? @recipe.ingredient_tags.ids : @recipe.ingredients.ids) : [])
    end

    def create
        @recipe_ingredient = RecipeIngredient.new(recipe_id: params[:recipe_id], mixable_type: params[:mixable_type], mixable_id: params[:mixable_id])
        if @recipe_ingredient.save
            flash[:success] = "Ingredient created successfully"
            redirect_to edit_recipe_ingredient_path(@recipe, @recipe_ingredient)
        else
            flash[:danger] = "Something went wrong"
            redirect_to(new_recipe_ingredient_path)
        end
    end

    def edit
    end

    def update
        if @recipe_ingredient.update(recipe_ingredient_params)
            flash[:success] = "Ingredient updated successfully"
            redirect_to recipe_ingredients_path(recipe_id: params[:recipe_id])
        else
            flash[:danger] = "Something went wrong"
            redirect_to(edit_recipe_ingredient_path(@recipe, @recipe_ingredient))
        end
    end

    def destroy
        if @recipe_ingredient.destroy
            flash[:success] = "Ingredient removed successfully"
            redirect_to(recipe_ingredients_path(@recipe))
        else
            flash[:danger] = "Something went wrong"
            redirect_to(edit_recipe_ingredient_path(@recipe, @recipe_ingredient))
        end
    end

    private

    def set_recipe
        @recipe = Recipe.find(params[:recipe_id])
    end

    def set_recipe_ingredient
        @recipe_ingredient = RecipeIngredient.find(params[:id])
    end

    def authorize
        unless logged_in? && Recipe.find(params[:recipe_id]).author_id == current_user.id
            flash[:danger] = "You must be the author of the recipe to do this."
            redirect_to(recipe_path(@recipe_ingredient.recipe))
        end
    end

    def recipe_ingredient_params
        params.require(:recipe_ingredient).permit(
            :amount,
            :units,
            :custom_unit,
            :note
        )
    end
end