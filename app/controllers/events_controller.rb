class EventsController < ApplicationController
  def index
    flat=Flat.find(params[:flat_id])
    @events = flat.events
  end

  def new
    @flat = Flat.find(params[:flat_id])
    @event = Event.new
  end

  def create
    @flat = Flat.find(params[:flat_id])
    @event = Event.new event_params
    @event.save
    if @event.save
      flash[:notice] = "Event created!"
      redirect_to flat_path(@flat.id)
    else
      @errors = @event.errors.full_messages
      render 'new'
    end
  end

  private

    def event_params
      params.require(:event).permit(:flat_id, :start, :end, :title)
    end
end
