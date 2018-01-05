class SessionsController < ApplicationController

  skip_before_action :authorize, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:username])

    if @user.authenticate(params[:password])
      session[:userid] = @user.id
      redirect_to user_path(@user)
    else
      flash[:msg] = "Username and Password do not match"
      redirect_to login_path
    end
  end

  def destroy
    session.delete(:userid)
    redirect_to root_url
  end


end
