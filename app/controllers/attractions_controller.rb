class AttractionsController < ApplicationController

  skip_before_action :authorize

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
    params.require[:attraction].permit(
      :name,
      :twitter,
      :facebook,
      :instagram,
      :youtube,
      event_ids:[],
       event_attributes:[
         :name,
         :sale_start_date,
         :sale_end_date,
         :price_min,
         :price_max,
         :image_1,
         :tm_url,
         :tm_event_id])
  end
end
