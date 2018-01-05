require 'pry'
require 'rest-client'
require 'json'

class WelcomeController < ApplicationController

  skip_before_action :authorize

  def home
    
  end


end
