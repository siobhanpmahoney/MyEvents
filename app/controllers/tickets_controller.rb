class TicketsController < ApplicationController
  skip_before_action :authorize

  def new
    if flash[:id]
      @event = Event.find(flash[:id])
    else
      @event = Event.find(params[:id])
    end
  end

  def create
    if !!current_user.cc_number
      i = params[:ticket][:count].to_i
      @event = Event.find(params[:id])
      i.times do
        current_user.buy_ticket(@event)
      end
      redirect_to user_path(current_user)
    else
      flash[:msg] = "You need a valid a Credit Card to purchase tickets"
      @event = Event.find(params[:id])
      flash[:id] = @event.id
      redirect_to new_ticket_path
    end
  end


  def new_w_guest
    create_guest
    @event = Event.find(params[:id])
  end

  def create_w_guest
    i = params[:ticket][:count].to_i
    @event = Event.find(params[:id])
    @user = User.find(guest_user.id)

    @user.update(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      address: params[:address],
      address2: params[:address2],
      city: params[:city],
      state: params[:state],
      postal_code: params[:postal_code],
      cc_number: params[:cc_number],
      cc_expiration: params[:cc_expiration],
      cc_name: params[:cc_name],
      cc_security_code: params[:cc_security_code]
    )
    @user.save(:validate => false)

    i.times do
      @ticket = @user.buy_ticket(@event)
    end

    redirect_to ticket_path(@ticket)
  end


  def show
    @ticket = Ticket.find(params[:id])
    @tickets = Ticket.where(user: guest_user)
    @user = guest_user
  end


end
