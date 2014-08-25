require 'rails_helper'

RSpec.describe Bill, :type => :model do
  it "Don't create a bill without item, price and flat id" do
    flat = Flat.new name: "marina", address:"carrer de la marina 200 Barcelona"
    bill = Bill.new flat_id: flat.id
    expect(bill.valid?).to eq(false)
  end

  it "create a bill if it has a item, price and flat id" do

    flat = Flat.create name: "marina", address: "carrer de la marina 200 Barcelona"
    user = User.create name:"Jane", email: "jane.buzzlightyear@gmail.com", flat_id: flat.id
    bill = Bill.new item: 'mercadona',price: '10', flat_id: flat.id, user_id: user.id
    expect(bill.valid?).to eq(true)
  end

  it "create a bill if it has a item, price and flat id" do

    item_option = ["Carrefour","Internet","Mercadona","Hardware store","Water suply","Electricity"]
    flat = Flat.create name: "marina", address: "carrer de la marina 200 Barcelona"
    user = User.create name:"Jane", email: "jane.buzzlightyear@gmail.com", flat_id: flat.id

    100.times do
      price = [*0..70].sample + rand.round(2)
      created_at = DateTime.now - [*0..6].sample.month - [*0..31].sample.day
      bill = Bill.new item: item_option.sample, price: price, flat_id: flat.id, created_at: created_at, user_id: user.id
      expect(bill.valid?).to eq(true)
    end
  end

  context 'scope month' do

    before(:each) do
      flat = Flat.create name: "marina", address: "carrer de la marina 200 Barcelona"
      user = User.create name:"Jane", email: "jane.buzzlightyear@gmail.com", flat_id: flat.id

      @bill1 = Bill.create item: 'mercadona', price: 12, flat_id: flat.id, created_at: Date.today.next_month, user_id: user.id
      @bill2 = Bill.create item: 'chineese store', price: 1, flat_id: flat.id, user_id: user.id
    end

    it "return bills month's date pass in params" do
      expect(Bill.month(Date.today).count).to eq(1)
    end

    it "return bills month's date pass in params" do
      expect(Bill.month(Date.today)).to match_array([@bill2])
    end

  end
end


