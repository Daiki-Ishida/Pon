class AddTerritoryToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :territory, :integer
  end
end
