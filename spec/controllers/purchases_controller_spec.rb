require 'rails_helper'

RSpec.describe PurchasesController, :type => :controller do

  context "index method show the pending purchases" do
    before(:each) do
      @flat = Flat.create name: "marina", address:"carrer de la marina 200 Barcelona"
      get :index, flat_id: @flat.id
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads only the pending purchase" do
      purchase1 = Purchase.create name: 'oil', flat_id: @flat.id
      purchase2 = Purchase.create name: 'oil', pending: 'false', flat_id: @flat.id
      expect(assigns(:purchases)).to match_array([purchase1])
    end
  end

  context "new method" do

    before(:each) do
      @flat = Flat.create name: "marina", address:"carrer de la marina 200 Barcelona"
      get :new, flat_id: @flat.id
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
      @flat = Flat.create name: "marina", address:"carrer de la marina 200 Barcelona"
      @purchase = Purchase.create name: 'oil', flat_id: @flat.id
    end

    it "render the show flat template after creating a event" do
      post :create, flat_id: @flat.id, purchase: {name: @purchase.id,flat_id: @flat.id}
      expect(response).to redirect_to(flat_path(@flat.id))
    end

    it "make a new location" do
      expect{post :create, flat_id: @flat.id, purchase: {name: @purchase.id,flat_id: @flat.id}}.to change(Purchase,:count).by(1)
    end

    it "should not create new entry with wrong information" do
      expect{post :create, flat_id: @flat.id, purchase: {flat_id: @flat.id}}.to_not change(Purchase,:count)
    end

    it "should not create new entry with wrong information and render new template" do
      post :create, flat_id: @flat.id, purchase: {flat_id: @flat.id}
      expect(response).to render_template('new')
    end
  end

end
