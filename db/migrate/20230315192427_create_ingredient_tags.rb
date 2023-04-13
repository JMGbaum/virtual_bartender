class CreateIngredientTags < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredient_tags do |t|
      t.timestamps
      t.references(:ingredient, null: false)
      t.references(:tag, null: false)
      t.index([:ingredient_id, :tag_id], unique: true)
    end
  end
end
