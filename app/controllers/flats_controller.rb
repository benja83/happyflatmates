class FlatsController < ApplicationController
  def index
    @flats = Flat.all
  end

  def show
    @flat = Flat.find(params[:id])
    @users = User.where(:flat_id == params[:id])
    @events  = Event.where(:flat_id == params[:id])
  end

  private

    def flat_params
      params.require(:flat).permit(:name, :address)
    end
end
