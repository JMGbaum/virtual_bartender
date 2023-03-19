class Recipe < ApplicationRecord
    belongs_to :author, class_name: 'User', optional: true

    has_many :recipe_ingredients, dependent: :destroy, inverse_of: :recipe
    has_many :mixables, through: :recipe_ingredients, inverse_of: :recipes

    has_one_attached :image

    validates :title, presence: true
end