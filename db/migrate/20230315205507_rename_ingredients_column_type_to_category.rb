class RenameIngredientsColumnTypeToCategory < ActiveRecord::Migration[7.0]
  def change
    rename_column(:ingredients, :type, :category)
  end
end
