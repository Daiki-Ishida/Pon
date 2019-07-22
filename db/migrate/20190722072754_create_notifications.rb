class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :notified_user_id
      t.integer :action_user_id
      t.string :action
      t.integer :post_id
      t.integer :comment_id
      t.integer :message_id
      t.boolean :checked, default: false

      t.timestamps
    end
  end
end
