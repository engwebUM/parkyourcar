class Attachment < ActiveRecord::Base
  mount_uploader :file_name, AvatarUploader
  belongs_to :space

  validates_presence_of :file_name, :space
end
