class AddAssociationFlatUser < ActiveRecord::Migration
  def change
    add_reference :users, :flat, index: true
  end
end
