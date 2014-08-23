require 'rails_helper'

RSpec.describe Bill, :type => :model do
  it "Don't create a bill without item, price and flat id" do
    flat = Flat.new name: "marina", address:"carrer de la marina 200 Barcelona"
    bill = Bill.new flat_id: flat.id
    expect(bill.valid?).to eq(false)
  end

  it "create a bill if it has a item, price and flat id" do
    flat = Flat.create name: "marina", address: "carrer de la marina 200 Barcelona"
    bill = Bill.new item: 'mercadona',price: '10', flat_id: flat.id
    expect(bill.valid?).to eq(true)
  end

  it "create a bill if it has a item, price and flat id" do

    item_option = ["Carrefour","Internet","Mercadona","Hardware store","Water suply","Electricity"]

    flat = Flat.create name: "marina", address: "carrer de la marina 200 Barcelona"

    100.times do
      price = ([*0..70].sample + [*0..100].sample / 100)
      bill = Bill.new item: item_option.sample, price: price, flat_id: flat.id
      expect(bill.valid?).to eq(true)
    end
  end



end
