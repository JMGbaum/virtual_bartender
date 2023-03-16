class ChangeIngredientVintageToInteger < ActiveRecord::Migration[7.0]
  def up
    change_column(:ingredients, :vintage, :integer)
  end

  def down
    change_column(:ingredients, :vintage, :date)
  end
end
