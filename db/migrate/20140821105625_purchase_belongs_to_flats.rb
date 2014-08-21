class PurchaseBelongsToFlats < ActiveRecord::Migration
  def change
    add_reference :purchases, :flat, index: true
  end
end
