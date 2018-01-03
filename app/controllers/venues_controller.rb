class VenuesController < ApplicationController

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


end
