class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :space, counter_cache: true

  validates_presence_of :comment, :evaluation, :user, :space
  validates_numericality_of :evaluation, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, only_integer: true
end
