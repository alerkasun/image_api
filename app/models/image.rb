class Image
  include Mongoid::Document

  field :orig_name, type: String
  field :file_name, type: String
  field :path, type: String
  field :url, type: String

  embedded_in :user
  embeds_many :resized_images

  IMAGE_SIZES = {
    :big => [1280, 1280],
    :mini => [300,900],
    :thumb => [100, 300]
  }
end
