class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.timestamps
      t.string :type
      t.boolean :is_alcoholic
      t.date :vintage
      t.string :size
      t.float :abv
      t.string :purchase_url
      t.blob :image
      t.json :metadata
    end
  end
  
end


