class StaticPagesController < ApplicationController
  before_filter :authenticate_user!, only: [:dashboard]
  def home
  end

  def help
  end

  def faq
  end

  def dashboard
    @pending_bookings_made = count_pending_bookings_made
    @received_bookings_awaiting_approval = count_received_bookings_awaiting_approval
    @received_bookings_pending = count_received_bookings_pending
    @user_spaces = count_user_spaces
  end

  private

  def count_pending_bookings_made
    current_user.bookings.where('state = ?', BookingsController::PENDING_STATE).count
  end

  def count_received_bookings_awaiting_approval
    count_received_bookings(BookingsController::SENT_STATE)
  end

  def count_received_bookings_pending
    count_received_bookings(BookingsController::PENDING_STATE)
  end

  def count_received_bookings(state)
    current_user.spaces.joins(:bookings).where('state = ?', state).count
  end

  def count_user_spaces
    current_user.spaces.count
  end
end
