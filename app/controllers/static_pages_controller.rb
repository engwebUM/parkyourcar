class StaticPagesController < ApplicationController
  before_filter :authenticate_user!, only: [:dashboard]
  def home
  end

  def help
  end

  def faq
  end

  def dashboard
    @pending_bookings_made = count_bookings_made(BookingsController::PENDING_STATE)
    @received_bookings_awaiting_approval = count_bookings_received(BookingsController::SENT_STATE)
    @received_bookings_pending = count_bookings_received(BookingsController::PENDING_STATE)
    @user_spaces = count_user_spaces
  end

  private

  def count_bookings_made(state)
    current_user.bookings.where('state = ?', state).count
  end

  def count_bookings_received(state)
    current_user.spaces.joins(:bookings).where('state = ?', state).count
  end

  def count_user_spaces
    current_user.spaces.count
  end
end
