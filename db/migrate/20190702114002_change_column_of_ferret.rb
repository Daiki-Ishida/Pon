class ChangeColumnOfFerret < ActiveRecord::Migration[5.2]
  def change
    add_column :ferrets, :birth_date, :date
    add_column :ferrets, :gender, :integer
    remove_column :ferrets, :age, :integer
  end
end
