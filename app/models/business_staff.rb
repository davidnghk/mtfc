class BusinessStaff < ApplicationRecord
  belongs_to :user
  belongs_to :business_unit, :class_name => "Master", foreign_key: 'business_unit_id'
  belongs_to :post, :class_name => "Master", foreign_key: 'post_id'
end
