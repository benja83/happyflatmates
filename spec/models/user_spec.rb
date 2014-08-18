require 'rails_helper'

# before(:each) do
#   @flat = Flat.create name: "marina", address:"carrer de la marina 200 Barcelona"
# end

RSpec.describe User, :type => :model do
  flat = Flat.create name: "marina", address:"carrer de la marina 200 Barcelona"

  it "Don't create a user without name, email and flat id" do

    user = User.new flat_id: flat.id
    expect(user.valid?).to eq(false)
  end

  it "create a user if it has a name, an email" do
    user = User.new name:"Jane", email: "jane.buzzlightyear@gmail.com"
    expect(user.valid?).to eq(true)
  end


  it "Email format is not correct" do
    user = User.new name: "Jane", email: "we_love_chocolate", flat_id: flat.id
    expect(user.valid?).to eq(false)
  end


  it "doesn't create two user with the same email" do
    user1 = User.create name:"Jane", email: "jane.buzzlightyear@gmail.com",flat_id: flat.id
    user2 = User.new name:"Peter", email: "jane.buzzlightyear@gmail.com",flat_id: flat.id
    expect(user2.valid?).to eq(false)
  end
end
