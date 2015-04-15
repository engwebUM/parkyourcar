class Space < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :attachments
  belongs_to :user
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
end
