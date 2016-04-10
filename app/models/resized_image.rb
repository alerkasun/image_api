class ResizedImage
  include Mongoid::Document

  field :file_name, type: String
  field :size, type: String
  field :path, type: String
  field :url, type: String

  embedded_in :image
end
