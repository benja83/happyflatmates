require 'rails_helper'

RSpec.describe BillsController, :type => :controller do

  before(:each) do
        @flat = Flat.create name: "marina", address:"carrer de la marina 200 Barcelona"
        @user = User.create name:"Jane", email: "jane.buzzlightyear@gmail.com", flat_id: @flat.id
  end

  context 'index method' do
    it "renders the bills index template" do
      get :index, flat_id: @flat.id
      expect(response).to render_template("index")
    end

    it "responds successfully with an HTTP 200 status code" do
      get :index, flat_id: @flat.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads all of the bills" do
      bill1 = Bill.create item: 'mercadona',price: '10', flat_id: @flat.id, user_id: @user.id
      bill2 = Bill.create item: 'water',price: '50', flat_id: @flat.id, user_id: @user.id
      get :index, flat_id: @flat.id
      expect(assigns(:bills)).to match_array([bill1, bill2])
    end
  end

  context "new method" do

    before(:each) do
      bill = Bill.create item: 'water',price: '50', flat_id: @flat.id, user_id: @user.id
      get :new, flat_id: @flat.id,id: bill.id
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  context "create method" do

    before(:each) do
      @bill = Bill.create item: 'water',price: '50', flat_id: @flat.id, user_id: @user.id
    end

    it "render the index bill template after creating a bill" do

      post :create, flat_id: @flat.id, bill: {item: @bill.item, price: @bill.price, flat_id: @flat.id, user_id: @user.id}
      expect(response).to redirect_to(flat_bills_path(flat_id: @flat.id))
    end

    it "make a new bill" do
      expect{post :create, flat_id: @flat.id, bill: {item: @bill.item, price: @bill.price, flat_id: @flat.id, user_id: @user.id}}.to change(Bill, :count).by(1)
    end

    it "should not create new entry with wrong information" do
      expect{post :create, flat_id: @flat.id, bill: {price: @bill.price, flat_id: @flat.id}}.to_not change(Bill,:count)
    end

    xit "should not create new entry with wrong information" do
      post :create, flat_id: @flat.id, bill: {price: @bill.price, flat_id: @flat.id}
      expect(response).to render_template('new')
    end
  end

end
