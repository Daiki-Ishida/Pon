class AddDateToReport < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :date, :date
  end
end
