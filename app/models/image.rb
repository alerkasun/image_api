class Image
  include Mongoid::Document
  mount_uploader :file, ImageUploader
  belongs_to :galler
  field :file, type: String
end
