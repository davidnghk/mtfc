class Occupation < ApplicationRecord
  enum status: { In: 0, Out: 1, Cancelled: 2 }
#  belongs_to :location

  scope :In, ->{ where(" status = ?", 0) }
  scope :Out, ->{ where(" status = ?", 1) }

  after_create_commit :update_location

  private

  def update_location
  	location = Location.find(self.location_id)
  	location.Occupied!
  	location.save
  end

end
