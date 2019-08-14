class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :email
      t.text :content
      t.text :reply
      t.integer :subject
      t.boolean :resolved, default: false

      t.timestamps
    end
  end
end
