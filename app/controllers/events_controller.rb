class EventsController < ApplicationController
  skip_before_action :authorize

  def index

    if params[:search]
      @events = Event.search(params[:search]).order("created_at DESC")
    else
      @events = Event.all.order('created_at DESC')
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:name, :sale_date, :start_date, attraction_ids: [], attractions_attributes: [:name])
  end
end
