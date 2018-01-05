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



def seed_events(events)

  events["_embedded"]["events"].each do |event|
     ev = Event.create(
      name: event["name"],
      sale_start_date: event["sales"]["public"]["startDateTime"],
      sale_end_date: event["sales"]["public"]["endDateTime"],
      price_min: rand(10..100),
      # price_max: event["priceRanges"][0]["max"],
      # img_1: event["sales"]["public"]["endDateTime"],
      start_date: event["dates"]["start"]["dateTime"],
      category: event["classifications"][0]["segment"]["name"],
      genre: event["classifications"][0]["genre"]["name"],
      subgenre: event["classifications"][0]["subGenre"]["name"],
      venue: ven = Venue.find_or_create_by(name: event["_embedded"]["venues"][0]["name"]))
      ven.update(city: event["_embedded"]["venues"][0]["city"]["name"] )


      if event["_embedded"]["attractions"]
        event["_embedded"]["attractions"].each do |attr|
        ev.attractions << Attraction.find_or_create_by(name: attr["name"])
        end
      end

    end
end


ev = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=200"))

seed_events(ev)

ev = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=200&page=2"))

seed_events(ev)

ev = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=200&page=3"))

seed_events(ev)

events = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=200&page=4"))

seed_events(ev)



50.times do
  fn = Faker::Name.first_name
  ln = Faker::Name.last_name

  User.create(
     username: Faker::Superhero.name,
     password: "hello",
     first_name: fn,
     last_name: ln,
     birth_date: Faker::Date.birthday(18, 65),
     email: Faker::Internet.email,
     address: Faker::Address.street_address,
     address2: Faker::Address.secondary_address,
     city: Faker::Address.city,
     state: Faker::Address.state,
     postal_code: Faker::Address.zip_code,
     cc_number: Faker::Number.number(16),
     cc_expiration: Faker::Date.forward(60),
     cc_name: fn + ln,
     cc_security_code: Faker::Number.number(3)
  )
end



User.all[0..4].each do |user|
  user.add_friend(User.last)
  user.add_friend(User.all[-2])
  user.add_friend(User.all[-3])
  user.add_friend(User.all[-4])
  user.add_friend(User.all[-5])
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
