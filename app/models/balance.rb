class Balance < ActiveRecord::Base


  def self.create_balances_users_per_flat(date = Date.today, flat_id)
    array_data = Bill.balance_data
    balances_users_per_flat = {}
    array_data.each_index do |i|
      if array_data[i][:flat_id] == flat_id
        array_data[i][:users_total].each do |key,value|
          user_balance = value -  array_data[i][:total_per_user]
          balances_users_per_flat[key] = user_balance
        end
      end
    end
    return balances_users_per_flat

  end

end