class TagsController < ApplicationController
    def show
        @tag = Tag.find(params[:id])
        @pagy, @ingredients = pagy(params[:search].present? ? search_tag : @tag.ingredients)
    end

    private

    def search_tag
        @tag.ingredients.joins(:tags).distinct.where('ingredients.name LIKE ? OR tags.name LIKE ?',
                                  "%#{params[:search]}%", "%#{params[:search]}%")
    end
end