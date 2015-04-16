class BookingsController < ApplicationController
  before_filter :authenticate_user!, except: [:show]

  # GET /bookings
  def index
    @bookings = Hash.new
    @bookings[:sent] = bookings_by_state('sent')
    @bookings[:pending] = bookings_by_state('pending')
    @bookings[:accepted] = bookings_by_state('accepted')
    @bookings[:rejected] = bookings_by_state('rejected')
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
    @booking = Booking.find(params[:id])
  end

  def create
    @space = Space.find(params[:space_id])
    booking_fill
    if @booking.save
      flash[:success] = 'Booking was successfully created.'
      redirect_to @space
    else
      redirect_to @space
    end
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(params[:id])
      redirect_to @booking
    else
      render 'edit'
    end
  end

  private

  def bookings_by_state(state)
    current_user.bookings.where('state = ?', state)
  end

  def booking_params
    params.require(:booking).permit(:date_from, :date_until, :state)
  end

  def booking_fill
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.space = @space
    @booking.state = 'sent'
  end
end
