class ChangeColumnOfUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :birth_date, :datetime
    add_column :users, :gender, :integer
    remove_column :users, :age, :integer
  end
end
