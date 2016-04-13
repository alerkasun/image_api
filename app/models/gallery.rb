class Gallery
  include Mongoid::Document
  field :name, :type => String
  mount_uploader :image, ImageUploader
  # references_many :items
  validates_presence_of :name
end
