class Message < ApplicationRecord
  #after_create_commit :create_notification
  belongs_to :chatroom
  belongs_to :user

  validates :body, presence: true

  private 

  	def create_notification
	    Notification.create(recipient: self.user, user: self.user, content: "New Message")
  	end
end
