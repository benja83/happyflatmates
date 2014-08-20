require 'rails_helper'

RSpec.describe Event, :type => :model do

  it "Don't create a event without start, end, title and flat id" do
    flat = Flat.new name: "marina", address:"carrer de la marina 200 Barcelona"
    event = Event.new flat_id: flat.id
    expect(event.valid?).to eq(false)
  end

  it "create a event if it has a name, an email" do
    flat = Flat.create name: "marina", address:"carrer de la marina 200 Barcelona"
    event = Event.new start: DateTime.now, end: DateTime.now + 1.hour, title: "first", flat_id: flat.id
    expect(event.valid?).to eq(true)
  end
end
