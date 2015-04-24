class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :space

  validates :comment, presence: true
  validates :evaluation, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
