class PurchasesController < ApplicationController
  def index
    flat=Flat.find(params[:flat_id])
    @purchases = flat.purchases.pending
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

  private

    def purchase_params
      params.require(:purchase).permit(:flat_id, :name, :price, :buyer, :pending)
    end
end