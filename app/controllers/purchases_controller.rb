class PurchasesController < ApplicationController
  def index
    flat=Flat.find(params[:flat_id])
    @purchases = flat.purchases.pending?
  end

  def new
    @flat = Flat.find(params[:flat_id])
    @purchase = Purchase.new
  end

  def create
    @flat = Flat.find(params[:flat_id])
    @purchase = Purchase.new purchase_params
    @purchase.save
    if @purchase.save
      flash[:notice] = "Purchase created!"
      redirect_to flat_path(@flat.id)
    else
      @errors = @purchase.errors.full_messages
      render 'new'
    end
  end

  def update_status_purchases
    @flat = Flat.find(params[:flat_id])
    purchases = params[:bought]
    purchases.each do |id|
      Purchase.find(id).update_attribute(:pending, false)

    end
    redirect_to flat_path(@flat.id)
  end

  private

    def purchase_params
      params.require(:purchase).permit(:flat_id, :name, :pending)
    end
end