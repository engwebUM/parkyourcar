class Space < ActiveRecord::Base
  belongs_to :user
  has_many :review, dependent: :destroy
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
