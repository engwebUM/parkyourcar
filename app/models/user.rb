class User < ActiveRecord::Base
  has_many :spaces, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :vehicles, dependent: :destroy
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  PHONE_NUMBER_REGEX = /\d{9}/
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, length: { within: 5..25 }, uniqueness: true
  validates :email, presence: true, format: EMAIL_REGEX, uniqueness: true
  validates :phone_number, allow_blank: true, format: PHONE_NUMBER_REGEX, uniqueness: true
  validate :valid_age
  validates_integrity_of :avatar
  validates_processing_of :avatar

  def photo
    @avatar = avatar.url(:thumb) || 'user_avatar.png'
  end

  def phone
    @phone = phone_number || 'Not available'
  end

  def birthdate
    @phone = date_of_birth || 'Not available'
  end

  def valid_age
    return errors.add(:date_of_birth, 'You must be 18 years or older.') if date_of_birth.present? && date_of_birth > 18.year.ago
  end

  def ==(other)
    super || other.instance_of?(self.class) && id.present? && other.id == id
  end
end
