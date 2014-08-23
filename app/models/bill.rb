class Bill < ActiveRecord::Base
  belongs_to :flat

  validates :item, presence: true
  validates :price, presence: true
  validates :user_id, presence: true



end
