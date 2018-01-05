class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :loggedin?, :guest_user, :create_guest, :guest?
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
    if !loggedin?
    flash[:msg] = "You do not have access to that!"
    redirect_to root_url
    end
  end

  def create_guest
    session[:guest_user_id] = save_guest.id
  end

  def save_guest
    user = User.create(:username => "guest", :password => "guest")
    user.save(:validate => false)
    user
  end

  def guest_user
    User.find(session[:guest_user_id]) if session[:guest_user_id]
  end

  def guest?
    !!guest_user
  end

end
