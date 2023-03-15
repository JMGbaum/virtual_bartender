class Recipe < ApplicationRecord
    belongs_to :author, class_name: 'User', optional: true
    
    has_many :recipe_ingredient_tags, dependent: :destroy, inverse_of: :recipe
    has_many :tags, through: :recipe_ingredient_tags, inverse_of: :recipes
    has_many :ingredients, through: :tags, inverse_of: :recipes

    has_one_attached :image

    validates :title, presence: true
end