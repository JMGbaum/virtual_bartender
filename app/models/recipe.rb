class Recipe < ApplicationRecord
    has_many :user_recipes, dependent: :destroy, inverse_of: :recipe
    has_many :users, through: :user_recipes, inverse_of: :recipes


    belongs_to :author, class_name: 'User', optional: true

    has_many :recipe_ingredients, dependent: :destroy, inverse_of: :recipe
    has_many :mixables, through: :recipe_ingredients, inverse_of: :recipes

    has_one_attached :image

    validates :title, presence: true
end