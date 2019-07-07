class AddDefaultPic < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :image, :text, default: "no_image.jpg"
    change_column :ferrets, :image, :text, default: "no_image.jpg"
    change_column :posts, :image, :string, default: "no_image.jpg"
  end
end
