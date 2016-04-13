class Image
  include Mongoid::Document
  mount_uploader :file, ImageUploader
  # embedded_in :gallery
  belongs_to :gallery

  field :file, type: String
end
