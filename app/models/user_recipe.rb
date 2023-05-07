class UserRecipe < ApplicationRecord
    belongs_to :user, inverse_of: :user_recipes
    belongs_to :recipe, inverse_of: :user_recipes
    validates :user_id, uniqueness: {scope: :recipe_id}
end
