class EventsBelongsToFlats < ActiveRecord::Migration
  def change
    add_reference :events, :flat, index: true
  end
end
