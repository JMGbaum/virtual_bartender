class AddLikedToUserRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column(:user_recipes, :liked, :boolean, null: false, default: 1)
  end
end
