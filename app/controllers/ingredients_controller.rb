class IngredientsController < ApplicationController
  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def index
    @pagy, @ingredients = pagy(Ingredient.all)
  end

  def new
  end
end
