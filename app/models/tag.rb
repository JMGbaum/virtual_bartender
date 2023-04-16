class Tag < ApplicationRecord
    before_save :convert_to_lowercase

    has_many :ingredient_tags, dependent: :destroy, inverse_of: :tag
    has_many :ingredients, through: :ingredient_tags, inverse_of: :tags

    has_many :recipe_ingredients, as: :mixable, dependent: :destroy, inverse_of: :mixable
    has_many :recipes, through: :recipe_ingredients, inverse_of: :ingredient_tags

    validates :name, presence: true, uniqueness: true

    private

    def convert_to_lowercase
        name.downcase!
    end
end
