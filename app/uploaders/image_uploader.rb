# encoding: utf-8
class ImageUploader < CarrierWave::Uploader::Base

 include CarrierWave::MiniMagick

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  process :resize_to_fit => [600, 600]

  version :tiny_thumb do
    process :resize_to_fill => [50, 50]
  end

  version :thumb do
    process :resize_to_fill => [200, 200]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
