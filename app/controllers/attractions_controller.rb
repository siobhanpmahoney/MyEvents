class AttractionsController < ApplicationController

  def index
    if params[:search]
      @attractions = Attraction.search(params[:search]).order("created_at DESC")
    else
      @attractions = Attraction.all.order('created_at DESC')
    end
  end

  def show
    @attraction = Attraction.find(params[:id])
  end


  private

  def attraction_params
    params.require[:attraction].permit(:name, event_ids:[], events_attributes:[:name, :sale_date, :start_date])
  end
end
