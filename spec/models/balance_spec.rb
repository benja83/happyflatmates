require 'rails_helper'

RSpec.describe Balance, :type => :model do

  context "create_balances_users_per_flat" do

    before(:each) do
      Flat.destroy_all
      User.destroy_all

      @flat1 = Flat.create name: "marina", address: "carrer de la marina 200 Barcelona"
      @flat2 = Flat.create name: "mob", address: "carrer de la marina 200 Barcelona"
      @user1 = User.create name:"Jane", email: "jane.buzzlightyear@gmail.com", flat_id: @flat1.id
      @user2 = User.create name:"Jane", email: "greg@gmail.com", flat_id: @flat1.id
      @bill1 = Bill.create item: 'mercadona',price: 10, flat_id: @flat1.id, user_id: @user1.id
      @bill2 = Bill.create item: 'mercadona',price: 20, flat_id: @flat1.id, user_id: @user2.id
    end

    it "It generate an hash with the differences between total_per_user with total of each user" do

      hash = Balance.create_balances_users_per_flat(nil,@flat1.id)
      expect(hash[@user1.id]).to eq(-5)
      expect(hash[@user2.id]).to eq(5)
    end
  end

end
