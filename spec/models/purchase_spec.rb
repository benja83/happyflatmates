require 'rails_helper'

RSpec.describe Purchase, :type => :model do
  it "Don't create a purchase without name" do
    purchase = Purchase.new
    expect(purchase.valid?).to eq(false)
  end

  it "create a purchase if it has a name, an email" do
    purchase = Purchase.new name: 'Oil'
    expect(purchase.valid?).to eq(true)
  end
end
