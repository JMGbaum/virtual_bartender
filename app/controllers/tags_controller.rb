class TagsController < ApplicationController
    def show
        @tag = Tag.find(params[:id])
        @pagy, @ingredients = pagy(@tag.ingredients)
    end
end