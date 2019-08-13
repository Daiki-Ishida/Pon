class ChangeColumnToContact < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :subject, :integer
    remove_column :contacts, :type, :integer
  end
end
