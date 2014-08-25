class BalancesController < ApplicationController

  def index
    flat = Flat.find(params[:flat_id])
    @bills = flat.bills.current_month.order('created_at DESC')
    @flat = Flat.find(params[:flat_id])
    @users = User.where(:flat_id == params[:id])
    @balance = Balance.last_month
  end
end
