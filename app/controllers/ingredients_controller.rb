class IngredientsController < ApplicationController
  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def index
    @pagy, @ingredients = pagy(params[:search].present? ? search_ingredients : Ingredient.all)
  end

  def new
  end

  private

  def search_ingredients
    Ingredient.joins(:tags).distinct.where('ingredients.name LIKE ? OR tags.name LIKE ?',
                                  "%#{params[:search]}%", "%#{params[:search]}%")
  end
end
