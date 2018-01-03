require 'pry'
require 'rest-client'
require 'json'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

the_venues = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/venues.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq"))

the_venues["_embedded"]["venues"].each do |v|
  Venue.create(name: v["name"], city: v["city"]["name"])
end


attractions = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/attractions.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq"))


#this link has a link to events (upcomingEvents)
#classification

attractions["_embedded"]["attractions"].each do |attr|
  Attraction.create(name: attr["name"])
end


events = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=200"))


events["_embedded"]["events"].each do |event|
   ev = Event.create(
    name: event["name"],
    sale_date: event["sales"]["public"]["startDateTime"],
    start_date: event["dates"]["start"]["dateTime"],
    venue: ven = Venue.find_or_create_by(name: event["_embedded"]["venues"][0]["name"]))
    ven.update(city: event["_embedded"]["venues"][0]["city"]["name"] )


    if event["_embedded"]["attractions"]
      event["_embedded"]["attractions"].each do |attr|
      ev.attractions << Attraction.find_or_create_by(name: attr["name"])
      end
    end

end






events = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=200&page=2"))


events["_embedded"]["events"].each do |event|
   ev = Event.create(
    name: event["name"],
    sale_date: event["sales"]["public"]["startDateTime"],
    start_date: event["dates"]["start"]["dateTime"],
    venue: ven = Venue.find_or_create_by(name: event["_embedded"]["venues"][0]["name"]))
    ven.update(city: event["_embedded"]["venues"][0]["city"]["name"])


    if event["_embedded"]["attractions"]
      event["_embedded"]["attractions"].each do |attr|
      ev.attractions << Attraction.find_or_create_by(name: attr["name"])
      end
    end

end






events = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=200&page=3"))


events["_embedded"]["events"].each do |event|
   ev = Event.create(
    name: event["name"],
    sale_date: event["sales"]["public"]["startDateTime"],
    start_date: event["dates"]["start"]["dateTime"],
    venue: ven = Venue.find_or_create_by(name: event["_embedded"]["venues"][0]["name"]))
    ven.update(city: event["_embedded"]["venues"][0]["city"]["name"] )


    if event["_embedded"]["attractions"]
      event["_embedded"]["attractions"].each do |attr|
      ev.attractions << Attraction.find_or_create_by(name: attr["name"])
      end
    end

end






events = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=200&page=4"))


events["_embedded"]["events"].each do |event|
   ev = Event.create(
    name: event["name"],
    sale_date: event["sales"]["public"]["startDateTime"],
    start_date: event["dates"]["start"]["dateTime"],
    venue: ven = Venue.find_or_create_by(name: event["_embedded"]["venues"][0]["name"]))
    ven.update(city: event["_embedded"]["venues"][0]["city"]["name"] )


    if event["_embedded"]["attractions"]
      event["_embedded"]["attractions"].each do |attr|
      ev.attractions << Attraction.find_or_create_by(name: attr["name"])
      end
    end

end



 def search_bar

  @events = JSON.parse(RestClient("https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=20&keyword=#{params[:keyword]}"))
  @venues = JSON.parse(RestClient("https://app.ticketmaster.com/discovery/v2/venues.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=20&keyword=#{params[:keyword]}"))
  @attractions = JSON.parse(RestClient("https://app.ticketmaster.com/discovery/v2/attractions.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=20&keyword=#{params[:keyword]}"))

   if ["_embedded"]["events"]["name"]

   elsif["_embedded"]["events"]["name"]

   elsif["_embedded"]["events"]["name"]

   else
     "There are now search results returned"
   end

end

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











# <% Attraction.all.each do |att| %>
#   <% if current_page?(attraction_path(att)) %>
#     <%= link_to "All Attractions", attractions_path %>
#   <% end %>
# <% end %>
#
# <% Event.all.each do |att| %>
#   <% if current_page?(event_path(att)) %>
#     <%= link_to "All Events", events_path %>
#   <% end %>
# <% end %>
#
# <% Venue.all.each do |att| %>
#   <% if current_page?(venue_path(att)) %>
#     <%= link_to "All Venues", venues_path %>
#   <% end %>
# <% end %>
