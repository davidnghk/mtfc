class Workflow < ApplicationRecord
  enum assignment: [:manual, :auto]

  validates :location_id, :presence => true
  validates :business_unit_id, :presence => true
  validates :work_id, :presence => true

  belongs_to :location
  belongs_to :business_unit, :class_name => "Chatroom", :foreign_key => "business_unit_id"
  belongs_to :work, :class_name => "Master", :foreign_key => "work_id"


  def self.i18n_assignments(hash = {})
    assignments.keys.each { |key| hash[I18n.t("workflow_assignments.#{key}")] = key }
    hash
  end

end
