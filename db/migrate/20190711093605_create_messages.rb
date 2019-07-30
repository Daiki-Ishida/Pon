class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.integer :sender_id
      t.integer :room_id
      t.text :content

      t.timestamps
    end
  end
end
