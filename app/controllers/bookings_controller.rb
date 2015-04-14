class BookingsController < ApplicationController
  # GET /bookings
  def index
  end

  # GET /bookings/1
  def show
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
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.space = @space
    @booking.state = "pending"
    if @booking.save
      flash[:success] = 'Booking was successfully created.'
      redirect_to @space
    else
      render :new
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
    def booking_params
      params.require(:booking).permit(:date_from, :date_until, :state)
    end
end
