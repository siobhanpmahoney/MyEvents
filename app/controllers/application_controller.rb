class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :loggedin?
  before_action :authorize

  def current_user
    if session[:userid]
      User.find(session[:userid])
    end
  end

  def loggedin?
    !!current_user
  end

  def authorize
    redirect_to root_url unless loggedin?
  end


end
