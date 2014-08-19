require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  context "index method" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads all of the locations the users" do
      user1 = User.create name:"Jane", email: "jane.buzzlightyear@gmail.com"
      user2 = User.create name:"kiko", email: "kiko@gmail.com"
      get :index
      expect(assigns(:users)).to match_array([user1, user2])
    end
  end

  context "show method" do

    before(:each) do
      @user = User.create name:"Jane", email: "jane.buzzlightyear@gmail.com"
    end

    it "renders the show template" do
      get :show, id: @user.id
      expect(response).to render_template("show")
    end

    it "responds successfully with an HTTP 200 status code" do
      get :show, id: @user.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads the user into @user" do
      get :show, id: @user.id
      expect(assigns(:user)).to eq(@user)
    end

    it "receives status 404 error - not found" do
      get :show, id: 100
      expect(response.status).to eq(404)
    end
  end

  context "add_flat" do

    before(:each) do
      @users = User.all
      @flat = Flat.create name: "marina", address:"carrer de la marina 200 Barcelona"
      get :add_flat, id: @flat.id
    end

    it "renders the add_flat_form template" do
      expect(response).to render_template("add_flat_form")
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads the users into @users" do
      expect(assigns(:users)).to eq(@users)
    end
  end

  context "update_flat_id" do

    before(:each) do
      @user = User.create name:"Jane", email: "jane.buzzlightyear@gmail.com"
      @users=[]
      @users.push(@user.id)
      @flat = Flat.create name: "marina", address:"carrer de la marina 200 Barcelona"
      put :update_flat_id, {:to_add => @users, :flat_id => @flat.id}
    end

    it "renders the update_flat_id template for specific user" do
      expect(response).to render_template('index')
    end

    it "should update information changed" do
      @user.reload
      expect(@user.flat_id == @flat.id).to eq(true)
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
    it "render the show template after creating a user" do
      @user = User.new name:"Jane", email: "jane.buzgsdggszlightyear@gmail.com"
      post :create, user: {:name => @user.name, :email => @user.email}
      expect(response).to redirect_to(User.last)
    end

    it "make a new user" do
      @user = User.new name:"Jane", email: "jane.buzgsdggszlightyear@gmail.com"
      expect{post :create, user: {:name => @user.name, :email => @user.email}}.to change(User,:count).by(1)
    end

    it "should not create new entry with wrong information" do
      user = User.new name:"Jane", email: "jane.buzzlightyear"
      expect{post :create, user: {:name => user.name, :email => user.email}}.to_not change(User,:count)
    end

    it "should not create new entry with wrong information" do
      @user = User.new name:"Jane", email: "jane.buzgsdggszlightyeargmail.com"
      post :create, user: {:name => @user.name, :email => @user.email}
      expect(response).to render_template('new')
    end

  end
end
