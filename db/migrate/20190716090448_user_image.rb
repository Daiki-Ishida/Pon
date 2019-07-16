class UserImage < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :image, :text, default: "no_image.jpg"
    remove_column :ferrets, :image, :text, default: "no_image.jpg"
    remove_column :posts, :image, :string, default: "no_image.jpg"
  end
end
