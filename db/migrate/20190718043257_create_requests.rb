class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :owner_id
      t.integer :sitter_id
      t.integer :fee
      t.date :start_at
      t.date :end_at
      t.text :memo

      t.timestamps
    end
  end
end
