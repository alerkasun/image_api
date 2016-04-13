class Gallery
  include Mongoid::Document
  mount_uploader :image, ImageUploader
  field :name, :type => String
  field :width, :type => String
  field :height, :type => String
  field :format, :type => String
  field :size, :type => String
  validates_presence_of :name


  def resize
      @image = MiniMagick::Image.open( dir_read )
      image.resize size
      image.write( dir_save )
  end
end
