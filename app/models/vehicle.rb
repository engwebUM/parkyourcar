class Vehicle < ActiveRecord::Base
  has_many :booking
  belongs_to :user

  validates :plate, presence: true, uniqueness: true
end
