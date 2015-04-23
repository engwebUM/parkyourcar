class BookingsController < ApplicationController
  before_filter :authenticate_user!
  SENT_STATE = 'sent'
  PENDING_STATE = 'pending'
  ACCEPTED_STATE = 'accepted'
  REJECTED_STATE = 'rejected'

  # GET /bookings
  def index
    @bookings = {}
    @bookings[SENT_STATE] = bookings_by_state(SENT_STATE)
    @bookings[PENDING_STATE] = bookings_by_state(PENDING_STATE)
    @bookings[ACCEPTED_STATE] = bookings_by_state(ACCEPTED_STATE)
    @bookings[REJECTED_STATE] = bookings_by_state(REJECTED_STATE)
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

  def destroy
    @booking = current_user.bookings.find(params[:id])
    if @booking.present?
      @booking.destroy
      flash[:success] = 'Booking was successfully destroyed.'
    end
    redirect_to bookings_url
  end

  private

  def booking_params
    params.require(:booking).permit(:date_from, :date_until, :state)
  end

  def booking_fill
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.space = @space
    @booking.state = 'sent'
  end

  def bookings_by_state(state)
    param_state_page = state + '_page'
    current_user.bookings.where('state = ?', state).paginate(page: params[param_state_page], per_page: 2)
  end
end
