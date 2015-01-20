# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :resize_to_limit => [720, 720]
  version :icon40 do
    process :resize_to_fill => [40, 40]
  end

  version :icon60 do
    process :resize_to_fill => [60, 60]
  end

  version :profile do
    process :resize_to_fit => [180, 180]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_dir
    "users/#{model.user_id}/"
  end

  def default_url
    "/images/fallback/" + [version_name, "default.jpg"].compact.join('_')
  end
end