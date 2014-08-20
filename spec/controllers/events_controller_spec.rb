require 'rails_helper'

RSpec.describe EventsController, :type => :controller do

  context "index method" do
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

    it "loads all of the events" do
      event1 = Event.create start: DateTime.now, end: DateTime.now + 1.hour, title: "first", flat_id: @flat.id
      event2 = Event.create start: DateTime.now, end: DateTime.now + 1.hour, title: "first", flat_id: @flat.id
      expect(assigns(:events)).to match_array([event1, event2])
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
    end

    it "render the show flat template after creating a event" do
      event = Event.create start: DateTime.now, end: DateTime.now + 1.hour, title: "first", flat_id: @flat.id

      post :create, flat_id: @flat.id, event: {start: event.start, end: event.end, title: event.title}
      expect(response).to redirect_to(flat_path(@flat.id))
    end

    it "make a new location" do
      event = Event.create start: DateTime.now, end: DateTime.now + 1.hour, title: "first", flat_id: @flat.id

      expect{post :create, flat_id: @flat.id, event: {start: event.start, end: event.end, title: event.title}}.to change(Event,:count).by(1)
    end

    it "should not create new entry with wrong information" do
      event = Event.create start: DateTime.now, end: DateTime.now + 1.hour, flat_id: @flat.id
      expect{post :create, flat_id: @flat.id, event: {start: event.start, end: event.end}}.to_not change(Event,:count)
    end

    it "should not create new entry with wrong information" do
      event = Event.create start: DateTime.now, end: DateTime.now + 1.hour, flat_id: @flat.id
      post :create, flat_id: @flat.id, event: {start: event.start, end: event.end}
      expect(response).to render_template('new')
    end
  end


end
