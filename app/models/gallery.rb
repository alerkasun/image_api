class Gallery
  include Mongoid::Document
  belongs_to :user
  has_many :images

    # before_save :set_geometry

  # def set_geometry
  #   byebug
  #   geometry = self.image


  #   image = MiniMagick::Image.read(self.images.last)

  #   img = ::MiniMagick::Image::read(self.images.last) 
  #   width = img[:width] 
  #   height = img[:height] 
  #   # if (! geometry.nil?)
  #   #   self.best_width = geometry[0]
  #   #   self.best_height = geometry[1]
  #   # end
  # end
end



