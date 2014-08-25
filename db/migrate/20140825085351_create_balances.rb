class CreateBalances < ActiveRecord::Migration
  def change
    create_table :balances do |t|
      t.belongs_to :flat
      t.date :date
      t.text :users_balances
      t.timestamps
    end
  end
end
