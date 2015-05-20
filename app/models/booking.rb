class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :space
  belongs_to :vehicle

  scope :by_datetime_until, -> { order(date_until: :asc) }
  validates :date_from, presence: true
  validates :date_until, presence: true

  validate :valid_dates_format
  validate :valid_dates_interval
  validate :valid_space_interval
  validate :valid_accepted_bookings_interval

  def owner
    space.user
  end

  def as_json(*)
    {
      id: id,
      title: 'Reserved',
      start:  date_from.rfc822,
      end: date_until.rfc822,
      allDay: true,
      user_name: user.username,
      color: 'red'
    }
  end

  private

  def valid_dates_format
    errors.add(:date_from, 'must be a valid datetime') unless date_from.to_datetime && date_from.to_datetime > DateTime.now.to_datetime
    errors.add(:date_until, 'must be a valid datetime') unless date_until.to_datetime
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
