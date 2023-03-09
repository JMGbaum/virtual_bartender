class CreateIngredientItems < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredient_items do |t|
      t.integer :user_id
      t.integer :ingredient_id

      t.timestamps
    end
  end
end
