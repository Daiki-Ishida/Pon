class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :kanji_lastname
      t.string :kanji_firstname
      t.string :kana_lastname
      t.string :kana_firstname
      t.string :name
      t.string :age
      t.string :postal_code
      t.string :postal_address
      t.text :introduction
      t.text :image

      t.timestamps
    end
  end
end
