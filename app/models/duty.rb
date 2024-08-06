class Duty < ApplicationRecord
  enum status: {Waiting: 0, Approved: 1, Declined: 2}

  belongs_to :user
  belongs_to :location
  belongs_to :work, :class_name => "Master", :foreign_key => "work_id"

  before_save :set_dates 

  def all_day_event?
    self.start_date == self.start_date.midnight && self.end_date == self.end_date.midnight ? true : false
  end

  private

  def set_dates
  	self.start_date = self.date_range[0..15].to_datetime 
  	self.end_date = self.date_range[18..34].to_datetime 
  end

end
