class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :content
      t.integer :type
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
