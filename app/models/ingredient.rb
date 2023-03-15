class Ingredient < ApplicationRecord
    has_many :ingredient_tags, dependent: :destroy, inverse_of: :ingredient
    has_many :tags, through: :ingredient_tags, inverse_of: :ingredients
    has_many :recipes, through: :tags, inverse_of: :ingredients

    validates :name, presence: true
end
