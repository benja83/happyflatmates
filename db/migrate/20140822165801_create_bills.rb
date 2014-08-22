class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.decimal :item
      t.decimal :price, :precision => 6, :scale => 2
      t.integer :user_id
      t.timestamps
    end
  end
end
