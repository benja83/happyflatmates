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
      @bill1 = Bill.create item: 'mercadona',price: 10, flat_id: @flat1.id, created_at: Date.today.prev_month,user_id: @user1.id
      @bill2 = Bill.create item: 'mercadona',price: 20, flat_id: @flat1.id, user_id: @user2.id, created_at: Date.today.prev_month
    end

    it "It generate an hash with the differences between total_per_user with total of each user" do

      hash = Balance.create_balances_users_per_flat(@flat1.id)
      expect(hash[@user1.id]).to eq(-5)
      expect(hash[@user2.id]).to eq(5)
    end
  end

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

    it "It generates data in db with the date pass as argument" do

      hash = Balance.create_balances_users_per_flat(@flat1.id, Date.today.prev_month)
      balance = Balance.last
      expect(balance.date).to eq(Date.today.prev_month)
      expect{Balance.create_balances_users_per_flat(@flat1.id, Date.today.prev_month)}.to change(Balance, :count).by(1)
    end

    it "It not generate data in db with the date in the current mont pass as argument" do

      expect{Balance.create_balances_users_per_flat(@flat1.id, Date.today)}.to_not change(Balance, :count)
    end
  end

  context "generate_relations_payment" do

    before(:each) do

      @flat1 = Flat.create name: "marina", address: "carrer de la marina 200 Barcelona"
      @user1 = User.create name:"Jane", email: "jane.buzzlightyear@gmail.com", flat_id: @flat1.id
      @user2 = User.create name:"Jane", email: "greg@gmail.com", flat_id: @flat1.id

    end

    it "create an array of hashes containing each relation" do
      @bill1 = Bill.create item: 'mercadona',price: 10, flat_id: @flat1.id, user_id: @user1.id
      @bill2 = Bill.create item: 'mercadona',price: 10, flat_id: @flat1.id, user_id: @user2.id

      Balance.create_balances_users_per_flat(@flat1.id)
      relation = Balance.last
      expect(relation.generate_relations_payment).to eq([])
    end

    it "create an array of hashes containing each relation" do
      @bill1 = Bill.create item: 'mercadona',price: 0, flat_id: @flat1.id, user_id: @user1.id, created_at: Date.today.prev_month
      @bill2 = Bill.create item: 'mercadona',price: 10, flat_id: @flat1.id, user_id: @user2.id, created_at: Date.today.prev_month

      Balance.create_balances_users_per_flat(@flat1.id)
      balance = Balance.last
      relation = [{:debtor => @user1.id, :creditor => @user2.id, :amount => 5}]
      expect(balance.generate_relations_payment[0][:amount]).to eq(5)

      expect(balance.generate_relations_payment).to eq(relation)
    end

    it "create an array of hashes containing each relation for 3 user in a flat" do
      @bill1 = Bill.create item: 'mercadona',price: 0, flat_id: @flat1.id, user_id: @user1.id, created_at: Date.today.prev_month
      @bill2 = Bill.create item: 'mercadona',price: 10, flat_id: @flat1.id, user_id: @user2.id, created_at: Date.today.prev_month
      @user3 = User.create name:"Jane", email: "mike@gmail.com", flat_id: @flat1.id
      @bill3 = Bill.create item: 'mercadona',price: 20, flat_id: @flat1.id, user_id: @user3.id, created_at: Date.today.prev_month

      Balance.create_balances_users_per_flat(@flat1.id)
      balance = Balance.last
      relation = [{:debtor => @user1.id, :creditor => @user3.id, :amount => 10}]

      expect(balance.generate_relations_payment).to eq(relation)
    end
    it "create an array of hashes containing each relation for 3 user in a flat" do
      @bill1 = Bill.create item: 'mercadona',price: 5, flat_id: @flat1.id, user_id: @user1.id, created_at: Date.today.prev_month
      @bill2 = Bill.create item: 'mercadona',price: 15, flat_id: @flat1.id, user_id: @user2.id, created_at: Date.today.prev_month
      @user3 = User.create name:"Jane", email: "mike@gmail.com", flat_id: @flat1.id
      @bill3 = Bill.create item: 'mercadona',price: 20, flat_id: @flat1.id, user_id: @user3.id, created_at: Date.today.prev_month

      Balance.create_balances_users_per_flat(@flat1.id)
      balance = Balance.last
      relation = [{:debtor => @user1.id, :creditor => @user3.id, :amount => 6.67},{:debtor => @user1.id, :creditor => @user2.id, :amount => 1.67}]

      expect(balance.generate_relations_payment).to match_array(relation)
    end
  end

end
