require 'pry'
require 'rest-client'
require 'json'


class SearchController < ApplicationController
  #
  # def search
  #   @keyword = params[:format]
  #   @event_results = event_search()
  #   render 'results'
  # end

  def results
    # @keyword = params[:format]
    @event_results = event_search
    @search_event_results = creates_event_instances(@event_results)
    @attraction_results = attraction_search()
    @search_attraction_results = creates_attraction_instances(@attraction_results)
    @venue_results = venue_search

    @search_venue_results = creates_venue_instances(@venue_results)


  end

  def show
  end


  private

  def event_search
    keyword_search = params[:format].split.join("+").to_s
    keyword_search_path = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=20&keyword=#{keyword_search}"
    JSON.parse(RestClient.get(keyword_search_path))
  end

  def creates_event_instances(json_results)
    if json_results != []
      json_results['_embedded']['events'].map do |e|
        ev = Event.create(name: e['name'], sale_date: e['sales']['public']['startDateTime'], start_date: e['dates']['start']['dateTime'])
        ven = Venue.find_or_create_by(name: e['_embedded']['venues'][0]['name'])
        ven.update(city: e['_embedded']['venues'][0]['city']['name'])
        ev.update(venue: ven)
        if e['_embedded']['attractions']
          e['_embedded']['attractions'].each do |attr|
            ev.attractions << Attraction.find_or_create_by(name: attr['name'])
          end
        end
        ev
      end
    end
  end

  def attraction_search
    attraction_keyword_search = params[:format].split.join('+').to_s
    attraction_keyword_search_path = "https://app.ticketmaster.com/discovery/v2/attractions.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=20&keyword=#{attraction_keyword_search}"
    JSON.parse(RestClient.get(attraction_keyword_search_path))
  end

  def creates_attraction_instances(attraction_json_results)
    if attraction_json_results != []
      attraction_json_results['_embedded']['attractions'].map do |attr|
        Attraction.find_or_create_by(name: attr['name'])
      end
    end
  end

  def venue_search
    venue_keyword_search = params[:format].split.join("+").to_s
    venue_keyword_search_path = "https://app.ticketmaster.com/discovery/v2/venues.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=20&keyword=#{venue_keyword_search}"
    JSON.parse(RestClient.get(venue_keyword_search_path))
  end

  def creates_venue_instances(venue_json_results)
    if venue_json_results != []
      venue_json_results['_embedded']['venues'].map do |v|
        ven = Venue.find_or_create_by(name: v['name'])
        ven.update(city: v['city']['name'])
        ven
      end
    end
  end










  # @venues = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/venues.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=20&keyword=#{@keyword.split.join('+')}"))
  # @attractions = JSON.parse(RestClient.get('https://app.ticketmaster.com/discovery/v2/attractions.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=20&keyword=#{@keyword.split.join('+')}'))

end
