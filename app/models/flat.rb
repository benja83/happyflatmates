class Flat < ActiveRecord::Base
  has_many :users
  has_many :events
  has_many :purchases
  has_many :bills
  has_many :balances


  validates :name, presence: true
  validates :address, presence: true
end
