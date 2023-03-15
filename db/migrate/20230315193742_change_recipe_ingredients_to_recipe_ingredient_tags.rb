class ChangeRecipeIngredientsToRecipeIngredientTags < ActiveRecord::Migration[7.0]
  def change
    rename_column(:recipe_ingredients, :ingredient_id, :tag_id)
    rename_table(:recipe_ingredients, :recipe_ingredient_tags)
  end
end
