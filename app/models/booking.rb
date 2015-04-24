class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :space

  validates :date_from, presence: true
  validates :date_until, presence: true

  validate :valid_datetimes
  validate :valid_interval

  private

  def valid_datetimes
    errors.add(:date_from, 'must be a valid datetime') unless date_from.to_datetime && date_from.to_datetime > DateTime.now.to_datetime
    errors.add(:date_until, 'must be a valid datetime') unless date_until.to_datetime
  end

  def valid_interval
    errors.add(:date_from, 'cannot be higher than date until') unless date_from.to_datetime < date_until.to_datetime
    errors.add(:date_from, 'must be between date from and date until') unless date_from.to_datetime > space.date_from.to_datetime
    errors.add(:date_until, 'must be between date from and date until') unless date_until.to_datetime < space.date_until.to_datetime
  end
end
