class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :space

  validates :date_from, presence: true
  validates :date_until, presence: true

  validate :valid_dates_format
  validate :valid_dates_interval
  validate :valid_date_from_space_interval
  validate :valid_date_until_space_interval
  validate :valid_accepted_bookings_interval

  def owner_email
    space.user.email
  end

  def owner_phone
    space.user.phone_number
  end

  private

  def valid_dates_format
    errors.add(:date_from, 'must be a valid datetime') unless date_from.to_datetime && date_from.to_datetime > DateTime.now.to_datetime
    errors.add(:date_until, 'must be a valid datetime') unless date_until.to_datetime
  end

  def valid_dates_interval
    errors.add(:date_from, 'cannot be higher than date until') unless date_from.to_datetime < date_until.to_datetime
  end

  def valid_date_from_space_interval
    errors.add(:date_from, "must be between #{space.date_from} and #{space.date_until}") unless date_from.to_datetime > space.date_from.to_datetime
  end

  def valid_date_until_space_interval
    errors.add(:date_until, "must be between #{space.date_from} and #{space.date_until}") unless date_until.to_datetime < space.date_until.to_datetime
  end

  def valid_accepted_bookings_interval
    errors.add(:dates, 'cannot be between accepted bookings interval') unless accepted_bookings_interval == 0
  end

  def accepted_bookings_interval
    space.bookings.where('date_until > ? AND date_from < ?', date_from, date_until).count
  end
end
