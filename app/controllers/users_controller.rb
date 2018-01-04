class UsersController < ApplicationController

  skip_before_action :authorize, only: []


  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      @user.save
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
