class Vehicle < ActiveRecord::Base
  has_many :bookings
  belongs_to :user

  validates :plate, presence: true, uniqueness: true
end
