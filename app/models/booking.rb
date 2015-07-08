class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :space
  belongs_to :vehicle
  scope :by_datetime_until, -> { order(date_until: :asc) }

  validates_presence_of :date_from, :date_until, :user, :space, :vehicle
  validate :valid_dates_format, :valid_date_from_after_now, :valid_dates_interval, :valid_space_interval, :valid_accepted_bookings_interval

  def owner
    space.user
  end

  def as_json(*)
    {
      id: id,
      title: 'Reserved',
      start:  date_from.rfc822,
      end: date_until.rfc822,
      allDay: false,
      user_name: user.username,
      color: 'red'
    }
  end

  private

  def valid_dates_format
    errors.add(:date_from, 'must be a valid datetime') unless date_from.to_datetime
    errors.add(:date_until, 'must be a valid datetime') unless date_until.to_datetime
  end

  def valid_date_from_after_now
    errors.add(:date_from, 'must be after than now') unless date_from.to_datetime > DateTime.now.to_datetime
  end

  def valid_dates_interval
    errors.add(:date_from, 'cannot be higher than date until') unless date_from.to_datetime < date_until.to_datetime
  end

  def valid_space_interval
    errors.add(:date_from, "must be between #{space.date_from.to_formatted_s(:short)} and #{space.date_until.to_formatted_s(:short)}") if invalid_space_interval
  end

  def invalid_space_interval
    ((date_from.to_datetime <= space.date_from.to_datetime) || (date_until.to_datetime >= space.date_until.to_datetime))
  end

  def valid_accepted_bookings_interval
    errors.add(:dates, 'cannot be between accepted bookings interval') unless accepted_bookings_interval == 0
  end

  def accepted_bookings_interval
    space.bookings.where('state = ? AND date_until > ? AND date_from < ?', BookingsController::ACCEPTED_STATE, date_from, date_until).count
  end
end
