class Bill < ActiveRecord::Base
  belongs_to :flat

  validates :item, presence: true
  validates :price, presence: true
  validates :user_id, presence: true

scope :current_month, -> { where("created_at >= ? AND created_at <= ?",
  Date.today.at_beginning_of_month, Date.today.end_of_month) }

end
