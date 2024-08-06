class ChatroomUser < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user
  has_many :assignments, through: :users

  validates_presence_of :user_id

  before_create :set_last_read

  def self.member(business_unit_id, user_id)
    ChatroomUser.where("chatroom_id = ? and user_id = ? ", business_unit_id, user_id).count > 0 
  end

  def set_last_read
    self.last_read_at = Time.zone.now
  end
end
