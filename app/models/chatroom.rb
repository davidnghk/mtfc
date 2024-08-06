class Chatroom < ApplicationRecord
  has_many :chatroom_users, dependent: :destroy
  accepts_nested_attributes_for :chatroom_users, allow_destroy: true

  has_many :users, through: :chatroom_users
  belongs_to :incharge_user, :class_name => "User", :foreign_key => "incharge_user_id", optional: true
  has_many :messages, dependent: :destroy
  has_many :workflows
  has_many :assignments 
  has_many :announcements, :class_name => "Announcement", :foreign_key => "business_unit_id"

  validates_presence_of :name

  scope :public_channels, ->{ where(direct_message: 0) }
  scope :business_units, ->{ where(direct_message: 0) }
  scope :contractor, ->{ where(direct_message: 0) }
  scope :direct_messages, ->{ where(direct_message: 1) }

  def self.direct_message_for_users(users)
    user_ids = users.map(&:id).sort
    name = "DM:#{user_ids.join(":")}"

    if chatroom = direct_messages.where(name: name).first
      chatroom
    #else
      # create a new chatroom
    #  chatroom = new(name: name, direct_message: 1)
    #  chatroom.users = users
    #  chatroom.save
    #  chatroom
    end
  end

  def to_label
    if (I18n.locale == :zh) then 
      "#{chi_name}"
    else 
      "#{name}"
    end  
  end

  def display_name
    if (I18n.locale == :zh) then 
      "#{chi_name}"
    else 
      "#{name}"
    end 
  end
end
