class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.integer :contract_id
      t.float :rate

      t.timestamps
    end
  end
end
