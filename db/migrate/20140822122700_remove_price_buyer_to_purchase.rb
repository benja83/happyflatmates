class RemovePriceBuyerToPurchase < ActiveRecord::Migration
  def change
    remove_column :purchases, :price
    remove_column :purchases, :buyer
  end
end
