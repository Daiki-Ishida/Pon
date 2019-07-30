class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.string :title
      t.text :content
      t.string :image
      t.integer :user_id

      t.timestamps
    end
  end
end
