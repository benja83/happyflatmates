class Flat < ActiveRecord::Base
  has_many :users
  has_many :events
  has_many :purchases
  has_many :bills


  validates :name, presence: true
  validates :address, presence: true
end
