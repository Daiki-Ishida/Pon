class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.integer :contract_id
      t.text :content

      t.timestamps
    end
  end
end
