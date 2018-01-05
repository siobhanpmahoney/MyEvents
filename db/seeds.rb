require 'pry'
require 'rest-client'
require 'json'


def seed_events(events)
  events["_embedded"]["events"].each do |event|
    ev = Event.create(
      name: event["name"],
      sale_start_date: event["sales"]["public"]["startDateTime"],
      sale_end_date: event["sales"]["public"]["endDateTime"],
      price_min: event["priceRanges"][0]["min"],
      price_max: event["priceRanges"][0]["max"],
      # img_1: event["sales"]["public"]["endDateTime"],
      start_date: event["dates"]["start"]["dateTime"])

      ven = Venue.find_or_create_by(tm_venue_id: event["_embedded"]["venues"][0]["id"])
      ven.update(address: event["_embedded"]["venues"][0]["address"]["line1"],
      city: event["_embedded"]["venues"][0]["city"]["name"],
      general_info: event["_embedded"]["venues"][0]["generalInfo"]["generalRule"],
      name: event["_embedded"]["venues"][0]["name"],
      parking_details: event["_embedded"]["venues"][0]["parkingDetail"],
      postal_code: event["_embedded"]["venues"][0]["postalCode"],
      state: event["_embedded"]["venues"][0]["state"]["stateCode"])

      ev.update(venue: ven)

      if event["_embedded"]["attractions"]
        event["_embedded"]["attractions"].each do |attr|
          a = Attraction.find_or_create_by(tm_attraction_id: attr["id"])
          a.update(name: attr["name"], twitter: attr["externalLinks"]["twitter"][0]["url"], facebook: attr["externalLinks"]["facebook"][0]["url"], instagram: attr["externalLinks"]["instagram"][0]["url"])
            # , youtube: attr["externalLinks"]["youtube"][0]["url"])

          ev.attractions << a
      end
    end
  end
end



ev = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=200"))

seed_events(ev)

ev1 = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=200&page=2"))

seed_events(ev1)

ev2 = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=200&page=3"))

seed_events(ev2)

events3 = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=200&page=4"))

seed_events(ev3)


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


attractions = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/attractions.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=100"))


#this link has a link to events (upcomingEvents)
#classification

def seed_attractions
  attractions["_embedded"]["attractions"].each do |attr|
    Attraction.create(name: attr["name"],
      twitter: attr["externalLinks"]["twitter"][0]["url"],
      facebook: attr["externalLinks"]["facebook"][0]["url"],
      instagram: attr["externalLinks"]["instagram"][0]["url"],
      youtube: attr["externalLinks"]["youtube"][0]["url"],
      tm_attraction_id: attr["id"])

      at_ev = JSON.parse(RestClient.get( "https://app.ticketmaster.com/discovery/v2/events.json?attractionId=#{attr[:tm_attraction_id]}&apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq"))["_embedded"]["attractions"]
      if at_ev != []
        at_ev.each do |event|
          ev = Event.create(
            name: event["name"],
            sale_start_date: event["sales"]["public"]["startDateTime"],
            sale_end_date: event["sales"]["public"]["endDateTime"],
            price_min: event["priceRanges"][0]["min"],
            price_max: event["priceRanges"][0]["max"],
            # img_1: event["sales"]["public"]["endDateTime"],
            start_date: event["dates"]["start"]["dateTime"],
            venue: ven = Venue.find_or_create_by(name: event["_embedded"]["venues"][0]["name"]))
            ven.update(
              address: event["_embedded"]["venues"][0]["address"]["line1"],
              city: event["_embedded"]["venues"][0]["city"]["name"],
              general_info: event["_embedded"]["venues"][0]["generalInfo"]["generalRule"],
              name: event["_embedded"]["venues"][0]["name"],
              parking_details: event["_embedded"]["venues"][0]["parkingDetail"],
              postal_code: event["_embedded"]["venues"][0]["postalCode"],
              state: event["_embedded"]["venues"][0]["state"]["stateCode"],
              tm_venue_id: event["_embedded"]["venues"][0]["id"]
            )
          end
    end
  end
end

seed_attractions



# the_venues = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/venues.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq"))
#
# the_venues["_embedded"]["venues"].each do |v|
#   Venue.create(name: v["name"], city: v["city"]["name"])
# end












#
# def search_bar
#
#   @events = JSON.parse(RestClient("https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=20&keyword=#{params[:keyword]}"))
#   @venues = JSON.parse(RestClient("https://app.ticketmaster.com/discovery/v2/venues.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=20&keyword=#{params[:keyword]}"))
#   @attractions = JSON.parse(RestClient("https://app.ticketmaster.com/discovery/v2/attractions.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=20&keyword=#{params[:keyword]}"))
#
#   if ["_embedded"]["events"]["name"]
#
#   elsif["_embedded"]["events"]["name"]
#
#   elsif["_embedded"]["events"]["name"]
#
#   else
#     "There are now search results returned"
#   end
#
# end


# if event["_embedded"]["attractions"]
#   event["_embedded"]["attractions"].each do |attr|
#   attraction: Attraction.find_or_create_by(name: event["_embedded"]["attractions"][0][""])
#
#
# event_sales_date = events["_embedded"]["events"][0]["sales"]["public"]["startDateTime"]
#
# event_start = events["_embedded"]["events"][0]["dates"]["start"]["dateTime"]
#
# event_name = events["_embedded"]["events"][0]["name"]
#
# venue_name = events["_embedded"]["events"][0]["_embedded"]["venues"][0]["name"]
#
#
#
# binding.pry
#
# "hello"

# if u2_event["_embedded"]["attractions"]
#   u2_event["_embedded"]["attractions"].each do |attr|
#   u2_inst.attractions << Attraction.find_or_create_by(name: attr["name"])
#   end
# end
