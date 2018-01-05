class SessionsController < ApplicationController

  skip_before_action :authorize, only: [:new, :create]

  def new
    @user = User.new
  end


  def create
    @user = User.find_by(username: params[:username])

    if guest?
      @user = guest_user
      session[:userid] = @user.id
      session[:guest_user_id] = nil
      flash[:msg] = "Thanks for signing up"
      redirect_to edit_user_path(@user)
    elsif @user == nil
      flash[:msg] = "Username does not exist"
      redirect_to login_path
    else
      if @user.authenticate(params[:password])
        session[:userid] = @user.id
        redirect_to user_path(@user)
      else
        flash[:msg] = "Username and Password do not match"
        redirect_to login_path
      end
    end
  end


  def destroy
    session.delete(:userid)
    redirect_to root_url, notice: "Logged out!"
  end


end
