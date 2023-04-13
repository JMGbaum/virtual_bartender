class Ingredient < ApplicationRecord
    has_many :ingredient_tags, dependent: :destroy, inverse_of: :ingredient
    has_many :tags, through: :ingredient_tags, inverse_of: :ingredients

    has_many :ingredient_items, dependent: :destroy, inverse_of: :ingredient
    has_many :users, through: :ingredient_items, inverse_of: :ingredients

    has_many :recipe_ingredients, as: :mixable, dependent: :destroy, inverse_of: :mixable
    has_many :recipes, through: :recipe_ingredients, inverse_of: :mixables

    has_one_attached :image

    validates :name, presence: true
end
