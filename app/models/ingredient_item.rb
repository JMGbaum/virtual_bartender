class IngredientItem < ApplicationRecord
    belongs_to :ingredient, inverse_of: :ingredient_items
    belongs_to :user, inverse_of: :ingredient_items
end
