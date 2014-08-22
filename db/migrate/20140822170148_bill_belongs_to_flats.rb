class BillBelongsToFlats < ActiveRecord::Migration
  def change
    add_reference :bills, :flat, index: true
  end
end
