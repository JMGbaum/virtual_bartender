class CreateIngredientTags < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredient_tags do |t|
      t.timestamps
      t.references(:ingredient, null: false)
      t.references(:tag, null: false)
    end
  end
end
