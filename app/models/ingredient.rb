class Ingredient < ApplicationRecord
    has_many :recipe_ingredients, dependent: :destroy, inverse_of: :ingredient
    has_many :recipes, through: :recipe_ingredients, inverse_of: :ingredients

    validates :name, presence: true, length: { maximum: 50 }
end
