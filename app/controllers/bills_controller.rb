class BillsController < ApplicationController

  def index
    flat = Flat.find(params[:flat_id])
    @bills = flat.bills.current_month.order('created_at DESC')
    @flat = Flat.find(params[:flat_id])
    @users = User.where(:flat_id == params[:id])
    @bill = Bill.new
  end

  def new
    @flat = Flat.find(params[:flat_id])
    @bill = Bill.new
    @users = User.where(:flat_id == params[:id])
  end

  def create
    @flat = Flat.find(params[:flat_id])
    @bill = @flat.bills.new bill_params
    @bill.save
    if @bill.save
      flash[:notice] = "Bill created!"
      redirect_to action: 'index', controller: 'bills', flat_id: @flat.id
    else
      @errors = @bill.errors.full_messages
      redirect_to action: 'index', controller: 'bills', flat_id: @flat.id
    end
  end

  def edit
    @flat = Flat.find(params[:flat_id])
    @bill = Bill.find(params[:id])
    @users = User.where(:flat_id == params[:id])
  end

  def destroy
    @flat = Flat.find(params[:flat_id])
    bill = @flat.bills.find(params[:id]).destroy
    redirect_to action: 'index'
  end

  def update
    @flat = Flat.find(params[:flat_id])
    @bill = @flat.bills.find(params[:id])
    if @bill.update_attributes(bill_params)
        redirect_to action: 'index'
        flash[:notice] = "Bill updated!"
    else
        @errors = @bill.errors.full_messages
        render 'edit'
    end
  end

  private

  def bill_params
    params.require(:bill).permit(:flat_id, :item, :price, :user_id)
  end
end
