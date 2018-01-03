require 'pry'
require 'rest-client'
require 'json'

class SearchController < ApplicationController

  def search
    byebug
    @keyword = params[:keyword]
    @events = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=20&keyword=#{@keyword.split.join('+')}"))
    @venues = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/venues.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=20&keyword=#{@keyword.split.join('+')}"))
    @attractions = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/attractions.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=20&keyword=#{@keyword.split.join('+')}"))

    redirect_to search_path(@keyword)
  end

  def results
    @keyword = params[:keyword]
      end

end
