class BalancesController < ApplicationController

  def index
    flat = Flat.find(params[:flat_id])
    @flat = Flat.find(params[:flat_id])
    @users = User.where(:flat_id == params[:id])
    @balance = Balance.last_month
  end
end
