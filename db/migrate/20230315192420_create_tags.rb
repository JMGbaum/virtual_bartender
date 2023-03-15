class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.timestamps
      t.string(:name, null: false)
      t.index(:name, unique: true)
    end
  end
end
