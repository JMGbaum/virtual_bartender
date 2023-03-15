class IngredientTag < ApplicationRecord
    belongs_to :ingredient, inverse_of: :ingredient_tags
    belongs_to :tag, inverse_of: :ingredient_tags
end
