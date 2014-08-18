require 'rails_helper'

RSpec.describe Flat, :type => :model do

  it "Don't create a flat without name and address" do
    flat = Flat.new
    expect(flat.valid?).to eq(false)
  end
  it "create a flat if it has a name and an address" do
    flat = Flat.new name: "marina", address:"carrer de la marina 200 Barcelona"
    expect(flat.valid?).to eq(true)
  end
end
