class Bill < ActiveRecord::Base
  belongs_to :flat

  validates :item, presence: true
  validates :price, presence: true



end
