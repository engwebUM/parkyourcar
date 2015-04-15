class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :space

  validates :date_from, presence: true
  validates :date_until, presence: true

  validate :happened_at_is_valid_datetime
  validate :valid_interval

  def happened_at_is_valid_datetime
    errors.add(:date_from, 'must be a valid datetime') if date_from.to_datetime
    errors.add(:date_until, 'must be a valid datetime') if date_until.to_datetime
  end

  def valid_interval
    errors.add(:date_from, 'dates must be in valid interval') if date
    from.to_datetime > date_until.to_datetime
  end
end
