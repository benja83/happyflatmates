class Purchase < ActiveRecord::Base
  belongs_to :flat

  validates :name, presence: true
  validates :flat_id, presence: true

  scope :pending, -> { where(pending: true) }

  def update_pending_status

  end
end
