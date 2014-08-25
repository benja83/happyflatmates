RSpec.describe Bill, :type => :model do

  context 'balance_data' do

    before(:each) do
      Flat.destroy_all
      User.destroy_all

      @flat1 = Flat.create name: "marina", address: "carrer de la marina 200 Barcelona"
      @flat2 = Flat.create name: "mob", address: "carrer de la marina 200 Barcelona"
      @user1 = User.create name:"Jane", email: "jane.buzzlightyear@gmail.com", flat_id: @flat1.id
      @user2 = User.create name:"Jane", email: "greg@gmail.com", flat_id: @flat1.id
      @bill1 = Bill.create item: 'mercadona',price: 10.5, flat_id: @flat1.id, user_id: @user1.id, created_at: Date.today.prev_month
      @bill2 = Bill.create item: 'mercadona',price: 15.3, flat_id: @flat1.id, user_id: @user2.id, created_at: Date.today.prev_month
    end

    it 'send the total of the amount of bills of one month for two flat' do
      balances = Bill.balance_data
      expect(balances[0][:total]).to eq(25.8)
      expect(balances[1][:total]).to eq(0)
    end

    it 'send the total of bills of one month paid by each user' do

    balances = Bill.balance_data
    user1 = User.first
    user2 = User.last
      expect(balances[0][:users_total][user1.id]).to eq(10.5)
      expect(balances[0][:users_total][user2.id]).to eq(15.3)
    end

    it 'send the total of bills of one month paid by each user' do

    balances = Bill.balance_data
    user1 = User.first
    user2 = User.last
      expect(balances[0][:users_total][user1.id]).to eq(10.5)
      expect(balances[0][:users_total][user2.id]).to eq(15.3)
    end

    it 'send the month of the data' do

    balances = Bill.balance_data
      expect(balances[0][:date]).to eq(Date.today.prev_month)
      expect(balances[1][:date]).to eq(Date.today.prev_month)
    end

    it "send the data for two flat with bills" do

    @user3 = User.create name:"Jane", email: "bob@gmail.com", flat_id: @flat2.id
    @user4 = User.create name:"Jane", email: "mike@gmail.com", flat_id: @flat2.id
    @bill3 = Bill.create item: 'mercadona',price: 30, flat_id: @flat2.id, user_id: @user3.id, created_at: Date.today.prev_month
    @bill4 = Bill.create item: 'mercadona',price: 10, flat_id: @flat2.id, user_id: @user4.id, created_at: Date.today.prev_month

    balances = Bill.balance_data
      expect(balances[1][:users_total][@user3.id]).to eq(30)
      expect(balances[1][:users_total][@user4.id]).to eq(10)
    end

  end


end