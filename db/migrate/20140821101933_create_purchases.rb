class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :name
      t.decimal :price, :precision => 6, :scale => 2
      t.integer :buyer
      t.boolean :pending, default: true
      t.timestamps
    end
  end
end
