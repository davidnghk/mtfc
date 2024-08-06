class Defect < ApplicationRecord
  belongs_to :assignment
  belongs_to :issue, :class_name => "Master", foreign_key: 'issue_id'
  has_many :officers, dependent: :destroy
  has_many :photos, as: :photoable, dependent: :destroy  
  accepts_nested_attributes_for :officers, allow_destroy: true, reject_if: 
  	proc { |att| att['name'].blank? }


  enum rating: ["OK", "Malfunction"]

  mount_uploader :before_photo, ImageUploader
  mount_uploader :after_photo, ImageUploader
end
