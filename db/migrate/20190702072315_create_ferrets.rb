class CreateFerrets < ActiveRecord::Migration[5.2]
  def change
    create_table :ferrets do |t|
      t.string :name
      t.string :age
      t.string :character
      t.text :introduction
      t.text :image
      t.integer :user_id

      t.timestamps
    end
  end
end
