class ChangeColumnToUser < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :territory, :integer, default: 15
  end

  def down
    change_column :users, :territory, :integer
  end

  def change
    add_column :users, :password_digest, :string
  end
end
