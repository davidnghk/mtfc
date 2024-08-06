class Photo < ApplicationRecord

  belongs_to :photoable, polymorphic: true

  scope :General, -> { where(category: :General)}
  scope :Before, -> { where(category: :Before)}
  scope :After, -> { where(category: :After)}

  scope :Printable, -> { where(is_printable: true) }
  scope :NotPrintable, -> { where(is_printable: false) }

  enum category: [:General, :Before, :After]

  mount_uploader :image, ImageUploader 

  # after_create_commit :update_gps  
 
  before_create do
    puts image.path
#    if File.extname(image.path) != ".pdf" 
    if File.extname(image.path) == ".jpg" or File.extname(image.path) == ".jpeg"  
  		if EXIFR::JPEG.new(image.path).exif?   
        begin             # => true
  			   PhotoGeoloader.new(image.path).place_attributes self  
           self.photo_datetime = EXIFR::JPEG.new(image.path).date_time
        rescue Exception
          puts "Error in setting GPS data"
        end         
  		end
	  end
  end 

  private
   
  def update_gps
    if self.latitude? and self.photoable_type = "Assignment"
      assignment = Assignment.find(self.photoable_id)
      assignment.latitude = self.latitude
      assignment.longitude = self.longitude
      assignment.save
    end   
  end

end
