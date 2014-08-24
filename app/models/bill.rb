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

    bills = Bill.month(date)
    flats_id = Flat.pluck('DISTINCT id').sort

    users = User.all
    balances_data = []

    flats_id.each do |flat_id|
      total = bills.where(flat_id: flat_id).sum(:price)
      users_id = users.where(flat_id: flat_id).pluck('DISTINCT id')
      data = {:flat_id => flat_id,
              :date => date,
              :total => total,
              :total_per_user => total/users_id.length
             }
      users_id.each do |user_id|
        data[user_id] = bills.where(user_id: user_id).sum(:price)
      end
      balances_data << data
    end

    return balances_data

  end

end
