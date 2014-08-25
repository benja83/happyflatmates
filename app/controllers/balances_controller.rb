class BalancesController < ApplicationController

  def index
    flat = Flat.find(params[:flat_id])
    @users = User.where(:flat_id == params[:id])
    balance = flat.balances.last_month
    @relations = balance[0].generate_relations_payment

  end
end
