class CreateUserRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :user_recipes do |t|
      t.references :user
      t.references :recipe

      t.index([:user_id, :recipe_id], unique: true)

      t.timestamps
    end
  end
end
