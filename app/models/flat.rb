class Flat < ActiveRecord::Base
  has_many :users
  has_many :events

  validates :name, presence: true
  validates :address, presence: true
end
