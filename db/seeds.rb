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
  # Venue.create(name: v["name"], city: v["city"]["name"])
end

#
attractions = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/attractions.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq"))


attractions["_embedded"]["attractions"].each do |attr|
  # Attraction.create(name: attr["name"])
end

#
events = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq"))





event_sales = events["_embedded"]["events"][0]["sales"]["public"]["startDateTime"]

event_start = events["_embedded"]["events"][0]["dates"]["start"]["dateTime"]

event_name = events["_embedded"]["events"][0]["name"]

venue_name = events["_embedded"]["events"][0]["_embedded"]["venues"][0]["name"]



binding.pry

"hello"
