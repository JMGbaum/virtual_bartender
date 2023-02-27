class CreateRecipeIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_ingredients do |t|
      t.timestamps
      t.references(:ingredient, null: false)
      t.references(:recipe, null: false)
      t.decimal(:amount, precision: 5, scale: 2, null: false)
      t.integer(:units, null: false, default: 0)
      t.string(:custom_unit)
    end
  end
end
