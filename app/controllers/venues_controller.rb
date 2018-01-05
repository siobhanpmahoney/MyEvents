class VenuesController < ApplicationController

  skip_before_action :authorize

  def index
    if params[:search]
      @venues = Venue.search(params[:search]).order("created_at DESC")
    else
      @venues = Venue.all.order('created_at DESC')
    end
  end

  def show
    @venue = Venue.find(params[:id])
  end

  private

  def venue_params
     params.require(:venue).permit(
       :name,
       :address,
       :city,
       :state,
       :postal_code,
       :general_info,
       :parking_detais,
       :tm_venue_id,
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
