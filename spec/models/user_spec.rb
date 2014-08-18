require 'rails_helper'

RSpec.describe User, :type => :model do
  it "Don't create a user without name and email" do
    user = User.new
    expect(user.valid?).to eq(false)
  end

  it "create a user if it has a name and an email" do
    user = User.new name:"Jane", email: "jane.buzzlightyear@gmail.com"
    expect(user.valid?).to eq(true)
  end


  it "Email format is not correct" do
    user = User.new name: "Jane", email: "we_love_chocolate"
    expect(user.valid?).to eq(false)
  end

  it "doesn't create two user with the same email" do
    user1 = User.create name:"Jane", email: "jane.buzzlightyear@gmail.com"
    user2 = User.new name:"Peter", email: "jane.buzzlightyear@gmail.com"
    expect(user2.valid?).to eq(false)
  end
end
