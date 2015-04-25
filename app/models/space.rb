class Space < ActiveRecord::Base
  require 'action_view'
  include ActionView::Helpers::NumberHelper
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :review, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :attachments
  scope :by_last_created, -> { order(created_at: :desc) }

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  NUMBER_REGEX = /\A\d+(?:\.\d{0,2})?\z/

  validates :title, presence: true
  validates :available_spaces, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :country, presence: true
  validates :city, presence: true
  validates :address, presence: true
  validates :post_code, presence: true
  validates :price_hour, presence: true, format: NUMBER_REGEX, numericality: { greater_than: 0 }
  validates :price_week, format: NUMBER_REGEX, allow_blank: true, numericality: { greater_than: 0 }
  validates :price_month, format: NUMBER_REGEX, allow_blank: true, numericality: { greater_than: 0 }
  validates :date_from, presence: true
  validates :date_until, presence: true

  def self.filter_by(date_from, date_until, time_from, time_until, available_weekend)
    filtered = Space.where(nil)
    filtered = filter_dates(filtered, date_from, date_until)
    filtered = filter_times(filtered, time_from, time_until)
    filtered = filter_weekend(filtered, available_weekend)
    filtered
  end

  def self.filter_dates(filtered, date_from, date_until)
    filtered = filtered.where('date_from <= ?', date_from) if valid_date? date_from
    filtered = filtered.where('date_until >= ?', date_until) if valid_date? date_until
    filtered
  end

  def self.filter_times(filtered, time_from, time_until)
    filtered = filtered.where('time_from <= ?', convert(time_from)) if valid_time? time_from
    filtered = filtered.where('time_until >= ?', convert(time_until)) if valid_time? time_until
    filtered
  end

  def self.filter_weekend(filtered, available_weekend)
    filtered = filtered.where(available_weekend: true) if available_weekend == 'true'
    filtered
  end

  def self.sort_by(sort_param)
    sorted = Space.where(nil)
    if sort_param == 'pri'
      sorted = sorted.reorder(:price_hour)
    elsif sort_param == 'rev'
      sorted = sorted.joins(:reviews).select('spaces.id, count(reviews.id) as number_of_reviews').group('spaces.id').order('number_of_reviews DESC')
    end
    sorted
  end

  def owner_avatar
    @owner_avatar = user.photo
  end

  def owner_rating
    @owner_rating = number_with_precision(user.spaces.joins(:reviews).average(:evaluation), precision: 2).to_f
  end

  def first_image
    if attachments.empty?
      'no_image.png'
    else
      attachments.first.file_name.url(:thumb)
    end
  end

  def weekend
    if available_weekend
      'including weekends'
    else
      'excluding weekends'
    end
  end

  def self.convert(time)
    time = Time.parse(time)
    Time.utc(2000, 1, 1, time.hour, time.min).localtime
  end

  def self.valid_date?(date)
    date.to_date unless date.nil?
  end

  def self.valid_time?(time)
    time.to_time unless time.nil?
  end
end
