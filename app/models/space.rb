class Space < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :attachments, dependent: :destroy
  belongs_to :user
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def self.filter_by(date_from, date_until)
    filtered = Space.where(nil)
    filtered = filtered.where('date_from <= ?', DateTime.parse(date_from)) if date_from.present?
    filtered = filtered.where('date_until >= ?', DateTime.parse(date_until)) if date_until.present?
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
end
