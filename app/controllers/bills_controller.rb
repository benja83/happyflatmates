class BillsController < ApplicationController

  def index
    flat = Flat.find(params[:flat_id])
    @bills = flat.bills
  end

  def show
    flat = Flat.find(params[:flat_id])
    @bill = Bill.find(params[:id])
    render plain: "You try to cheat", status: 404 if @bill.flat_id != params[:flat_id].to_i
  rescue ActiveRecord::RecordNotFound
    render plain: 'Sorry, not found', status: 404
  end

  def new
    @flat = Flat.find(params[:flat_id])
    @bill = Bill.new
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
      render 'new'
    end
  end

  def edit
    @flat = Flat.find(params[:flat_id])
    @bill = Bill.find(params[:id])
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
        redirect_to action: 'show', id: @bill.id
        flash[:notice] = "Bill updated!"
    else
        @errors = @bill.errors.full_messages
        render 'edit'
    end
  end

  private

  def bill_params
    params.require(:bill).permit(:flat_id, :item, :price)
  end
end
