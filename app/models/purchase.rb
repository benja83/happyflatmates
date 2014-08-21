class Purchase < ActiveRecord::Base
  belongs_to :flat

  validates :name, presence: true
  validates :flat_id, presence: true

  scope :pending, -> { where(pending: true) }
end
