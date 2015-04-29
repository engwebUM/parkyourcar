class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :space
  scope :by_datetime_until, -> { order(date_until: :asc, time_until: :asc) }

  validates :date_from, presence: true
  validates :date_until, presence: true
  validates :time_from, presence: true
  validates :time_until, presence: true

  validate :valid_dates_format
  validate :valid_dates_interval
  validate :valid_date_from_space_interval
  validate :valid_date_until_space_interval

  validate :valid_time_format
  validate :valid_times_interval

  validate :valid_accepted_bookings_interval

  def owner_email
    space.user.email
  end

  def owner_phone
    space.user.phone_number
  end

  private

  def valid_dates_format
    errors.add(:date_from, 'must be a valid date') unless date_from.to_date
    errors.add(:date_until, 'must be a valid date') unless date_until.to_date
  end

  def valid_dates_interval
    errors.add(:date_from, 'cannot be higher than date until') if date_from.to_date < DateTime.now.to_date || date_from.to_date > date_until.to_date
  end

  def valid_date_from_space_interval
    errors.add(:date_from, "must be between #{space.date_from} and #{space.date_until}") if date_from.to_date < space.date_from.to_date
  end

  def valid_date_until_space_interval
    errors.add(:date_until, "must be between #{space.date_from} and #{space.date_until}") if date_until.to_date > space.date_until.to_date
  end

  def valid_time_format
    errors.add(:time_from, 'must be a valid time') unless time_from.to_time
    errors.add(:time_until, 'must be a valid time') unless time_until.to_time
  end

  def valid_times_interval
    if time_from.to_time == time_until.to_time
      booking_same_day
    elsif space.time_until < space.time_from
      space_times_in_different_days
    else
      space_times_in_same_day
    end
  end

  def space_times_in_different_days
    if time_from < time_until
      special_case
    else
      regular_case
    end
  end

  def space_times_in_same_day
    if time_from > time_until
      times_error
    else
      regular_case
    end
  end

  def regular_case
    times_error unless time_from.to_time >= space.time_from.to_time && time_until.to_time <= space.time_until.to_time
  end

  def special_case
    times_error unless time_from.to_time > space.time_from.to_time || time_until.to_time < space.time_until.to_time
  end

  def times_error
    errors.add(:time_from, "should be between #{space.time_from.to_formatted_s(:time)} and #{space.time_until.to_formatted_s(:time)}")
  end

  def booking_same_day
    errors.add(:time_from, 'and until are equals. Choose different days.') if date_from.to_date == date_until.to_date
  end

  def valid_accepted_bookings_interval
    errors.add(:dates, 'cannot be between accepted bookings interval') if accepted_bookings_interval > 0
  end

  def accepted_bookings_interval
    space.bookings.where('state = ? AND date_until >= ? AND date_from <= ? AND time_until >= ? AND time_from <= ?', BookingsController::ACCEPTED_STATE, date_from, date_until, time_from, time_until).count
  end
end
