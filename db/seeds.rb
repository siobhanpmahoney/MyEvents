require 'pry'
require 'rest-client'
require 'json'

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


      # img_1: event["sales"]["public"]["endDateTime"],


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






      ev = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=50"))

      seed_events(ev)

      ev1 = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=50&page=2"))

      seed_events(ev1)

      ev2 = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=50&page=3"))

      seed_events(ev2)

      events3 = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=50&page=4"))

      seed_events(events3)
      #
      #
      # # This file should contain all the record creation needed to seed the database with its default values.
      # # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
      # #
      # # Examples:
      # #
      # #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
      # #   Character.create(name: 'Luke', movie: movies.first)
      #
      #
      attractions = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/attractions.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=100"))


      # def seed_attractions(attractions)
      #   attractions["_embedded"]["attractions"].each do |attr|
      #     new_attr = Attraction.find_or_create_by(tm_attraction_id: attr["id"])
      #       new_attr.update(name: attr["name"])
      #
      #       if attr.keys.include?("externalLinks")
      #         if attr["externalLinks"].keys.include?("twitter")
      #           new_attr.update(twitter: attr["externalLinks"]["twitter"][0]["url"])
      #         end
      #         if attr["externalLinks"].keys.include?("facebook")
      #           new_attr.update(facebook: attr["externalLinks"]["facebook"][0]["url"])
      #         end
      #         if attr["externalLinks"].keys.include?("instagram")
      #           new_attr.update(instagram: attr["externalLinks"]["instagram"][0]["url"])
      #         end
      #       end
      #
      #
      #
      #       at_ev = JSON.parse(RestClient.get( "https://app.ticketmaster.com/discovery/v2/events.json?attractionId=#{attr[:tm_attraction_id]}&apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq"))["_embedded"]["attractions"]
      #       if at_ev != []
      #         at_ev.each do |event|
      #           ev = Event.find_or_create_by(tm_event_id: event["id"])
      #           ev.update(name: event["name"],
      #             sale_start_date: event["sales"]["public"]["startDateTime"],
      #             sale_end_date: event["sales"]["public"]["endDateTime"], start_date: event["dates"]["start"]["dateTime"])
      #             if event["priceRanges"] != nil
      #               if event["priceRanges"][0].keys.include?("min")
      #                 ev.update(price_min: event["priceRanges"][0]["min"])
      #               end
      #               if event["priceRanges"][0].keys.include?("max")
      #                 ev.update(price_max: event["priceRanges"][0]["max"])
      #               end
      #             end
      #
      #
      #           end
      #         end
      #       end
      #     end



venues = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/venues.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq"))

def seed_venues(venues)
  new_venues = venues["_embedded"]["venues"].each do |v|
    ven = Venue.find_or_create_by(tm_venue_id: v["id"])
    ven.update(
      address: v["address"]["line1"],
      city: v["city"]["name"],
      general_info: v["generalInfo"]["generalRule"],
      name: v["name"],
      parking_details: v["parkingDetail"],
      postal_code: v["postalCode"],
      state: v["state"]["name"])

     venue_events = JSON.parse(RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?venueId=#{v[:tm_venue_id]}&apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq"))["_embedded"]["events"]

     if venue_events != nil

       venue_events.each do |ve_ev|
         ev500 = Event.find_or_create_by(tm_event_id: ve_ev["id"])
         ev500.update(
           name: ve_ev["name"],
           sale_start_date: ve_ev["sales"]["public"]["startDateTime"],
           sale_end_date: ve_ev["sales"]["public"]["endDateTime"],
           start_date: ve_ev["dates"]["start"]["dateTime"], venue: Venue.find(v[:id]))

           if ev500["priceRanges"] != nil
             if ve_ev["priceRanges"][0].keys.include?("min")
               ev500.update(price_min: ve_ev["priceRanges"][0]["min"])
             end
             if ve_ev["priceRanges"][0].keys.include?("max")
               ev500.update(price_max: ve_ev["priceRanges"][0]["max"])
             end
           end


          if ve_ev["_embedded"]["attractions"]
            ve_ev["_embedded"]["attractions"].each do |attr|
              a = Attraction.find_or_create_by(tm_attraction_id: attr["id"])
              a.update(name: attr["name"], twitter: attr["externalLinks"]["twitter"][0]["url"], facebook: attr["externalLinks"]["facebook"][0]["url"], instagram: attr["externalLinks"]["instagram"][0]["url"])
              # , youtube: attr["externalLinks"]["youtube"][0]["url"])

              ev500.attractions << a


            end
          end
        end
      end
    end
  end



      #         #
      #         # def search_bar
      #         #
      #         #   @events = JSON.parse(RestClient("https://app.ticketmaster.com/discovery/v2/events.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=20&keyword=#{params[:keyword]}"))
      #         #   @venues = JSON.parse(RestClient("https://app.ticketmaster.com/discovery/v2/venues.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=20&keyword=#{params[:keyword]}"))
      #         #   @attractions = JSON.parse(RestClient("https://app.ticketmaster.com/discovery/v2/attractions.json?apikey=wCElOJlP8V5gpb6GGKmL3c9hKAva1dRq&size=20&keyword=#{params[:keyword]}"))
      #         #
      #         #   if ["_embedded"]["events"]["name"]
      #         #
      #         #   elsif["_embedded"]["events"]["name"]
      #         #
      #         #   elsif["_embedded"]["events"]["name"]
      #         #
      #         #   else
      #         #     "There are now search results returned"
      #         #   end
      #         #
      #         # end
      #
      #
      #         # if event["_embedded"]["attractions"]
      #         #   event["_embedded"]["attractions"].each do |attr|
      #         #   attraction: Attraction.find_or_create_by(name: event["_embedded"]["attractions"][0][""])
      #         #
      #         #
      #         # event_sales_date = events["_embedded"]["events"][0]["sales"]["public"]["startDateTime"]
      #         #
      #         # event_start = events["_embedded"]["events"][0]["dates"]["start"]["dateTime"]
      #         #
      #         # event_name = events["_embedded"]["events"][0]["name"]
      #         #
      #         # venue_name = events["_embedded"]["events"][0]["_embedded"]["venues"][0]["name"]
      #         #
      #         #
      #         #
      #         # binding.pry
      #         #
      #         # "hello"
      #
      #         # if u2_event["_embedded"]["attractions"]
      #         #   u2_event["_embedded"]["attractions"].each do |attr|
      #         #   u2_inst.attractions << Attraction.find_or_create_by(name: attr["name"])
      #         #   end
      #         # end
