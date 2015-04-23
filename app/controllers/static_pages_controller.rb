class StaticPagesController < ApplicationController
  before_filter :authenticate_user!, only: [:dashboard]
  def home
  end

  def help
  end

  def faq
  end

  def dashboard
    @pending_bookings_made = count_pending_bookings
    @user_spaces = count_user_spaces
  end

  private

  def count_pending_bookings
    current_user.bookings.where('state = ?', 'pending').count
  end

  def count_user_spaces
    current_user.spaces.count
  end
end
