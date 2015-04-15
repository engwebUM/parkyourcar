class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :space

  validates :date_from, presence: true
  validates :date_until, presence: true
end
