class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.timestamps
      t.string(:title, null: false)
      t.references(:author)
      t.integer(:servings)
      t.string(:glass)
      t.text(:description)
      t.text(:instructions)
      t.string(:source)
    end
  end
end
