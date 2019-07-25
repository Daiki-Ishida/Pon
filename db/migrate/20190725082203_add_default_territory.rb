class AddDefaultTerritory < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :territory, :integer, null: false, default: 15
  end

  def down
    change_column :users, :territory, :integer
  end
end
