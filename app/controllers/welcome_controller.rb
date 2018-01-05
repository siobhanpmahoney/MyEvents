require 'pry'
require 'rest-client'
require 'json'

class WelcomeController < ApplicationController

   skip_before_action :authorize

  def home
    @events = Event.all
    @user = current_user
    byebug
    @nearby_and_upcoming_events = Event.all.select {|e| e.venue.city == "Brooklyn"}.sort_by {|ev| ev.start_date }
  end


end
