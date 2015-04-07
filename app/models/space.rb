class Space < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :attachments, dependent: :destroy
  belongs_to :user
  has_many :review, dependent: :destroy
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
