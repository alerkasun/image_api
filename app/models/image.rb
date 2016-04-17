class Image
  include Mongoid::Document
  mount_uploader :file, ImageUploader
  belongs_to :gallery
  field :file, type: String
  field :format, type: String
  field :width, type: String
  field :heigth, type: String
end
