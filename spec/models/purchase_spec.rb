require 'rails_helper'

RSpec.describe Purchase, :type => :model do
  flat = Flat.create name: "marina", address:"carrer de la marina 200 Barcelona"

  it "Don't create a purchase without name" do
    purchase = Purchase.new
    expect(purchase.valid?).to eq(false)
  end

  it "create a purchase if it has a name" do
    purchase = Purchase.new name: 'Oil', flat_id: flat.id
    expect(purchase.valid?).to eq(true)
  end

  it "when it's created an item in purchase class, it's pending to buy" do
    purchase = Purchase.create name: 'Oil', flat_id: flat.id
    expect(purchase.pending).to eq(true)
  end



end
