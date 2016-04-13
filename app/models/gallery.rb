class Gallery
  include Mongoid::Document
  # embedded_in :user
  # embeds_many :images
  belongs_to :user
  has_many :images
  # field :name, :type => String
  # field :width, :type => String
  # field :height, :type => String
  # field :format, :type => String
  # field :size, :type => String
  # field :image, :type => String
  # validates_presence_of :name
end
