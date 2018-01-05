class EventsController < ApplicationController


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
    params.require(:event).permit(:name, :sale_date, :start_date, attraction_ids: [], attractions_attributes: [:name, :twitter, :facebook, :instagram, :youtube, :tm_attraction_id], category_ids: [], category_attributes:[:subgenre_name, :subgenre_tm_id, :genre_name, :genre_tm_id, :classification_name, :classification_tm_id])
  end
end
