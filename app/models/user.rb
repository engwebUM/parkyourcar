class User < ActiveRecord::Base
  has_many :spaces, dependent: :destroy
<<<<<<< HEAD
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
=======
  has_many :review, dependent: :destroy
>>>>>>> b9c2ec5b0de468a25069ce2a02384bff6126048d
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, length: { within: 5..25 }, uniqueness: true
  validates :email, presence: true, format: EMAIL_REGEX, uniqueness: true
end
