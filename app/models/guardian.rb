class Guardian < ApplicationRecord
  belongs_to :user 
  belongs_to :custodian, :class_name => "User", :foreign_key => "guardian_user_id", optional: true
end
  