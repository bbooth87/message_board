class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog
  version :thumb do
    process :resize_to_fit => [50, 50]
  end
  def default_url(*args)
  ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default_avatar.jpg"].compact.join('_'))
end
  version :small do
    process :resize_to_fit => [150, 150]
    # process :quality => 100
  end

  version :medium do
    process :resize_to_fit => [250, 250]
    # process :quality => 100
  end
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
    /image\//
  end
  def content_type_blacklist
  ['application/text', 'application/json']
  end

end
