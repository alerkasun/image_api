# encoding: utf-8
class ImageUploader < CarrierWave::Uploader::Base
  permissions 0777
 include CarrierWave::MiniMagick

  def cache_dir
    "#{Rails.root}/uploads/temp/"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end






