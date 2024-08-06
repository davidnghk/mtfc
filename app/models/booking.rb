class Booking < ApplicationRecord
  belongs_to :location 
  belongs_to :room,  optional: true

end
