class Bill < ActiveRecord::Base
  belongs_to :flat

  validates :item, presence: true
  validates :price, presence: true
  validates :user_id, presence: true

scope :current_month, -> { where("created_at >= ? AND created_at <= ?",
  Date.today.at_beginning_of_month, Date.today.end_of_month) }

scope :month, -> (date) { where("created_at >= ? AND created_at <= ?",
  date.at_beginning_of_month, date.end_of_month) }


  def self.balance_data(date = Date.today)
    total = Bill.month(date).sum(:price)
    data ={:total => total}
    users_id = Bill.month(date).pluck('DISTINCT user_id')
    users_id.each do |id|
      data[id] = Bill.month(date).where(user_id: id).sum(:price)
    end
    return data

  end

end
