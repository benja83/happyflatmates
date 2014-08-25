class Balance < ActiveRecord::Base
  serialize :users_balances
  belongs_to :flat

  scope :current_month, -> { where("date >= ? AND date <= ?",
    Date.today.at_beginning_of_month, Date.today.end_of_month) }

  def self.create_balances_users_per_flat(flat_id,date = Date.today)
    if !Balance.balance_current_month_exist?(flat_id)
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
      Balance.create :date => date,
                     :flat_id => flat_id,
                     :users_balances => balances_users_per_flat
      return balances_users_per_flat
    end
  end

  def self.balance_current_month_exist?(flat_id)
    Balance.where(flat_id: flat_id).current_month.present?
  end

  def generate_relations_payment
    users_balances = self.users_balances
    creditor={}
    debtor={}
    users_balances.each do |id,balance|
      if balance < 0
        debtor[id]=balance
      elsif balance != 0
        creditor[id]=balance
      end
    end
    creditor.sort_by {|key, value| value}
    debtor.sort_by {|key, value| value.abs}
    make_relation(creditor,debtor)
  end

  def make_relation(creditor,debtor)
    relation = []
    debtor.each_key do |i|
      creditor.each_key do |j|
        if (debtor[i] + creditor[j]) > 0
          creditor[j] += debtor[i]
          relation << {:debtor => i,
                       :creditor => j,
                       :amount => debtor[i].to_f.round(2).abs
                      }
          debtor.delete(i)
        elsif (debtor[i] + creditor[j]) < 0
          debtor[i] += creditor[j]
          relation << {:debtor => i,
                       :creditor => j,
                       :amount => creditor[j].to_f.round(2)
                      }
          creditor.delete(j)
        else
          relation << {:debtor => i,
                       :creditor => j,
                       :amount => creditor[j].to_f.round(2)
                      }
          creditor.delete(j)
          debtor.delete(i)
        end
      end
    end
    relation
  end


end