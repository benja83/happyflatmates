class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true, format: {with: /[0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/}, uniqueness: true
end
