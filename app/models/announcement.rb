class Announcement < ApplicationRecord
  resourcify
  belongs_to :business_unit, :foreign_key => "business_unit_id", :optional => true
  validates_presence_of :content, :start_at, :end_at

	def self.current(hidden_ids = nil)
	  result = where("start_at <= :now and end_at >= :now", now: Time.zone.now)
	  result = result.where("id not in (?)", hidden_ids) if hidden_ids.present?
	  result
	end
end
