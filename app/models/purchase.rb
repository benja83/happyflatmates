class Purchase < ActiveRecord::Base
  belongs_to :flat

  validates :name, presence: true
end
