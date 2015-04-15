class Space < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :attachments, dependent: :destroy
  belongs_to :user
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def self.filter_by(date_from, date_until, available_weekend)
    filtered = Space.where(nil)
    filtered = filtered.where('date_from <= ?', date_from.to_datetime) if valid_date?(date_from)
    filtered = filtered.where('date_until >= ?', date_until.to_datetime) if valid_date?(date_until)
    filtered = filtered.where(available_weekend: true) if available_weekend == 'true'
    filtered
  end

  def self.sort_by(sort_param)
    sorted = Space.where(nil)
    if sort_param.to_i == 2
      sorted = sorted.reorder(:price_hour)
    elsif sort_param.to_i == 3
      sorted = sorted.select('COUNT(reviews.id) AS reviews_count').
               joins('LEFT JOIN reviews ON spaces.id = reviews.id').
               group(:id).reorder('reviews_count')
    end
    sorted
  end

  def self.datetime_conv(datetime)
    datetime_format = '%d/%m/%Y %I:%M %p'
    DateTime.strptime(datetime, datetime_format)
  end

  def self.valid_date?(date)
    date.to_datetime
    rescue ArgumentError, NoMethodError
      false
  end
end
