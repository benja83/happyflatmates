class Flat < ActiveRecord::Base
  has_many :users
  has_many :events
  has_many :purchases

  validates :name, presence: true
  validates :address, presence: true
end
