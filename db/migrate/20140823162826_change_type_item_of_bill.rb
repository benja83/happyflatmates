class ChangeTypeItemOfBill < ActiveRecord::Migration
  def change
    remove_column :bills, :item
    add_column :bills, :item, :string
  end
end
