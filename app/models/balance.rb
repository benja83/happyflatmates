class Balance < ActiveRecord::Base


  def self.create_balances(date = Date.today)
    data = Bill.balance_data

  end

end