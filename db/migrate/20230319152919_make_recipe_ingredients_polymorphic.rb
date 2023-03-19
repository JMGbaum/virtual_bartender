class MakeRecipeIngredientsPolymorphic < ActiveRecord::Migration[7.0]
  def change
    remove_reference :recipe_ingredients , :ingredient, index: false
    add_reference :recipe_ingredients, :mixable, polymorphic: true, null: false
    change_column_null :recipe_ingredients, :amount, true
    change_column_null :recipe_ingredients, :units, true
    change_column_default :recipe_ingredients, :units, nil
  end
end
