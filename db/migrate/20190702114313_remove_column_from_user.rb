class RemoveColumnFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :birth_date, :datetime
  end
end
