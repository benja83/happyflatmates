require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  context "show method" do
    it "renders the show template" do
      user = User.create name:"Jane", email: "jane.buzzlightyear@gmail.com"
      get :show, id: user.id
      expect(response).to render_template("show")
    end

    it "responds successfully with an HTTP 200 status code" do
      user = User.create name:"Jane", email: "jane.buzzlightyear@gmail.com"
      get :show, id: user.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads the user into @user" do
      user = User.create name:"Jane", email: "jane.buzzlightyear@gmail.com"
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end

    xit "receives status 404 error - not found" do
      user = User.create name:"Jane", email: "jane.buzzlightyear@gmail.com"
      get :show, id: 100
      expect(response.status).to eq(404)
    end
  end

  context "add_flat" do
    it "renders the add_flat_form template" do
      users = User.all
      flat = Flat.create name: "marina", address:"carrer de la marina 200 Barcelona"
      get :add_flat, id: flat.id
      expect(response).to render_template("add_flat_form")
    end

    it "responds successfully with an HTTP 200 status code" do
      users = User.all
      flat = Flat.create name: "marina", address:"carrer de la marina 200 Barcelona"
      get :add_flat, id: flat.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads the users into @users" do
      users = User.all
      flat = Flat.create name: "marina", address:"carrer de la marina 200 Barcelona"
      get :add_flat, id: flat.id
      expect(assigns(:users)).to eq(users)
    end
  end

  context "update_flat_id" do
    it "renders the update_flat_id template for specific user" do
      user = User.create name:"Jane", email: "jane.buzzlightyear@gmail.com"
      users=[]
      users.push(user.id)
      flat = Flat.create name: "marina", address:"carrer de la marina 200 Barcelona"
      put :update_flat_id, {:to_add => users, :flat_id => flat.id}
      expect(response).to render_template('index')
    end

    it "should update information changed" do
      user = User.create name:"Jane", email: "jane.buzzlightyear@gmail.com"
      users=[]
      users.push(user.id)
      flat = Flat.create name: "marina", address:"carrer de la marina 200 Barcelona"
      put :update_flat_id, {:to_add => users, :flat_id => flat.id}
      user.reload
      expect(user.flat_id == flat.id).to eq(true)
    end
  end

  context "new method" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end

    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  context "create method" do
    xit "render the show template after creating a user" do
      user = User.new
      post :create, user: attributes_for(:user)
      expect(response).to redirect_to(action: 'index')
    end

    xit "make a new user" do
      user = User.create name:"Jane", email: "jane.buzzlightyear@gmail.com"
      expect{post :create, user: attributes_for(:user)}.to change(User,:count).by(1)
    end

    xit "should not create new entry with wrong information" do
      user = User.new name:"Jane", email: "jane.buzzlightyear"
      expect{post :create, user: attributes_for(:user, email: 'jane.buzzlightyear')}.to_not change(User,:count)
    end

    xit "should not create new entry with wrong information" do
      user = build(:user)
      post :create, user: attributes_for(:user, name: 'Gaud!')
      expect(response).to render_template('new')
    end

  end
end
