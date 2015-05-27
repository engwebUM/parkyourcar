class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :file

  version :thumb do
    process resize_to_fill: [150, 100]
  end

  version :show do
    process resize_to_fill: [640, 480]
  end

  def store_dir
    'uploads/attachments'
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    "#{secure_token(10)}.#{file.extension}" if original_filename.present?
  end

  protected

  def secure_token(length = 16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.hex(length / 2))
  end
end
