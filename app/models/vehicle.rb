class Vehicle < ActiveRecord::Base
  belongs_to :booking
  belongs_to :user

  validates :plate, presence: true, uniqueness: true
end
