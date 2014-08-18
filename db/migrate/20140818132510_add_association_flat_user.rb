class AddAssociationFlatUser < ActiveRecord::Migration
  def change
    add_reference :users, :flats, index: true
  end
end
