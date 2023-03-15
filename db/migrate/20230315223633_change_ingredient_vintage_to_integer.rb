class ChangeIngredientVintageToInteger < ActiveRecord::Migration[7.0]
  def change
    change_column(:ingredients, :vintage, :integer)
  end
end
