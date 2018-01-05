class UsersController < ApplicationController

  skip_before_action :authorize, only: [:new, :create]


  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) ? User.new(user_params) : User.new_guest

    if @user.valid?
      @user.save
      session[:userid] = @user.id
      redirect_to user_path(@user)
    else
      flash[:error] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      flash[:error] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end


  private


  def user_params
    params.require(:user).permit(
     :username,
     :password,
     :first_name,
     :last_name,
     :birth_date,
     :email,
     :address,
     :address2,
     :city,
     :state,
     :postal_code
   )
  end

end
