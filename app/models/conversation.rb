class Conversation < ApplicationRecord
  belongs_to :sender_user, foreign_key: :sender_id, class_name: "User"
  belongs_to :recipient_user, foreign_key: :recipient_id, class_name: "User"

  has_many :lines, dependent: :destroy
  validates_uniqueness_of :sender_user_id, :recipient_user_id

  scope :involving, -> (user) {
    where("conversations.sender_user_id = ? OR conversations.recipient_user_id = ?", 
    	user.id, user.id)
  }

  scope :between, -> (user_A, user_B) {
    where("(conversations.sender_user_id = ? OR conversations.recipient_user_id = ?) 
    		OR conversations.sender_user_id = ? OR conversations.recipient_user_id = ?", 
    		user_A, user_B, user_B, user_A)
  }
end
