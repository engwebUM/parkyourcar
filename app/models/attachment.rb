class Attachment < ActiveRecord::Base
  mount_uploader :file_name, AvatarUploader
  belongs_to :space
end
