class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :space

  validates :comment, presence: true
  validates :evaluation, presence: true
end
