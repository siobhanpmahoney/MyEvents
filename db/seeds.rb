require 'pry'
require 'rest-client'
require 'json'

the_venues = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/venues.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq"))

the_venues["_embedded"]["venues"].each do |v|
  Venue.create(name: v["name"], city: v["city"]["name"])
end


attractions = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/attractions.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq"))

attractions["_embedded"]["attractions"].each do |attr|
  Attraction.create(name: attr["name"])
end


def seed_events(events)
  events["_embedded"]["events"].each do |event|
    ev = Event.find_or_create_by(tm_event_id: event["id"])

   ev.update(name: event["name"],
      sale_start_date: event["sales"]["public"]["startDateTime"],
      sale_end_date: event["sales"]["public"]["endDateTime"], start_date: event["dates"]["start"]["dateTime"])
      if event["priceRanges"] != nil
        if event["priceRanges"][0].keys.include?("min")
          ev.update(price_min: event["priceRanges"][0]["min"])
        end
        if event["priceRanges"][0].keys.include?("max")
          ev.update(price_max: event["priceRanges"][0]["max"])
        end
      end



      ven = Venue.find_or_create_by(tm_venue_id: event["_embedded"]["venues"][0]["id"])
        ven.update(
          address: event["_embedded"]["venues"][0]["address"]["line1"],
          city: event["_embedded"]["venues"][0]["city"]["name"])
          if event["_embedded"]["venues"][0]["generalInfo"] != nil
            ven.update(general_info: event["_embedded"]["venues"][0]["generalInfo"]["generalRule"])
          end

         if event["_embedded"]["venues"][0]["name"] != nil
            ven.update(name: event["_embedded"]["venues"][0]["name"])
          end

         if event["_embedded"]["venues"][0]["parkingDetail"] != nil
            ven.update(parking_details: event["_embedded"]["venues"][0]["parkingDetail"])
          end

         if event["_embedded"]["venues"][0]["postalCode"] != nil
            ven.update(postal_code: event["_embedded"]["venues"][0]["postalCode"])
          end

         if event["_embedded"]["venues"][0]["state"] != nil
            ven.update(state: event["_embedded"]["venues"][0]["state"]["stateCode"])
          end

         ven.events << ev




         if event["_embedded"].keys.include?("attractions")
          event["_embedded"]["attractions"].each do |attr|

           a = Attraction.find_or_create_by(tm_attraction_id: attr["id"])
            a.update(name: attr["name"])
            if attr.keys.include?("externalLinks")
              if attr["externalLinks"].keys.include?("twitter")
                a.update(twitter: attr["externalLinks"]["twitter"][0]["url"])
              end
              if attr["externalLinks"].keys.include?("facebook")
                a.update(facebook: attr["externalLinks"]["facebook"][0]["url"])
              end
              if attr["externalLinks"].keys.include?("instagram")
                a.update(instagram: attr["externalLinks"]["instagram"][0]["url"])
              end
              ev.attractions << a
            end
          end
        end



        if event.keys.include?("classifications")
        cat_search = event["classifications"][0]
        if cat_search.keys.include?("subGenre")
          sg = Category.find_or_create_by(subgenre_tm_id: cat_search["subGenre"]["id"])
          sg.update(subgenre_name: cat_search["subGenre"]["name"], genre_name: cat_search["genre"]["name"], genre_tm_id: cat_search["genre"]["id"], classification_name: cat_search["segment"]["name"], classification_tm_id: cat_search["segment"]["id"])
          sg.events << ev
          ev.categories << sg
        elsif cat_search.keys.include?("genre")
          g = Category.find_or_create_by(genre_tm_id: cat_search["genre"]["id"])
          g.update(genre_name: cat_search["genre"]["name"], classification_name: cat_search["segment"]["name"], classification_tm_id: cat_search["segment"]["id"])
          g.events << ev
        else
          c = Category.find_or_create_by(classification_tm_id: cat_search["segment"]["id"])
          c.update(classification_name: cat_search["segment"]["name"])
          c.events << ev
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
