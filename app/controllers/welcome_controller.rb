require 'pry'
require 'rest-client'
require 'json'

class WelcomeController < ApplicationController

  skip_before_action :authorize

  def home
    # @events = Event.all
    # @the_user = current_user
    # @nearby_and_upcoming_events = Event.all.select {|e| e.venue.city == @the_user.city}.sort_by {|ev| ev.start_date }
  end
  


end
