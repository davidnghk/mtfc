require 'letter_avatar/has_avatar'

class User < ApplicationRecord
  include LetterAvatar::HasAvatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, 
    :rememberable, :trackable, :confirmable, :validatable, :masqueradable

  # default_scope { order('username') }
  #enum role: [:Admin, :manager, :worker, :guest]

  scope :online, lambda{ where("updated_at > ?", 30.minutes.ago) }

  rolify :before_add => :before_add_method
  before_create :assign_default_role

  has_many :assignments, dependent: :destroy  
  has_many :worker_assignments,  :foreign_key => "worker_user_id", dependent: :destroy  
  has_many :incharge_assignments,  :foreign_key => "incharge_user_id", dependent: :destroy  
  has_many :inspector_assignments,  :foreign_key => "inspector_id", dependent: :destroy  
  has_many :witness_assignments,  :foreign_key => "witness_id", dependent: :destroy  

  has_many :guardians, dependent: :destroy  
  has_many :custodians,  :foreign_key => "guardian_user_id", dependent: :destroy  

  has_one_attached :avatar, dependent: :destroy  
  has_many :workflows, :class_name => "WorkFlow", foreign_key: 'incharge_user_id', dependent: :destroy  

  has_many :notifications, dependent: :destroy  
  has_many :recipients, :class_name => "Notification", foreign_key: 'recipient_id', dependent: :destroy  

  has_many :chatroom_users, dependent: :destroy  
  has_many :chatrooms, through: :chatroom_users
  has_many :messages, dependent: :destroy  
  has_many :duties, dependent: :destroy  
  has_many :business_staffs, dependent: :destroy  

  #ROLES = %w[admin manager worker client] 

  #def roles=(roles)
  #  self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  #end

  #def roles
  #  ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  #end

  #def role?(role)
  #  roles.include? role.to_s
  #end

  def team
    if self.chatrooms.business_units.count > 0
      self.chatrooms.business_units.first.id
    else
      0
    end
  end

  def teams
    if self.chatrooms.business_units.count > 0
      "#{self.chatrooms.business_units.ids}".gsub('[', '(').gsub(']', ')')
    else 
      "( 0 )"
    end
  end

  def name
    "#{username}"
  end

  def fullname
    "#{username}"
  end

  def admin?
    role == "admin"
  end

  def manager?
    role == "manager"
  end

  def worker?
    role == "worker"
  end

  def lead?
    role == "lead"
  end

  def guest?
    role == "guest"
  end

  def online?
    updated_at > 30.minutes.ago
  end

  def before_add_method(role)
    # do something before it gets added
  end

  def assign_default_role
    #self.add_role(:newuser) if self.roles.blank?
    #self.role.guest! if self.role.blank?
    self.role ||= 'guest'
  end

  def before_add_method(role)
    # do something before it gets added
  end

  def average_star
    records = self.assignments.reviewed.count
    if records > 0 
      return (self.assignments.reviewed.average/records).round(2)
    end  
  end

  def self.user_name(user_id)
    User.find(user_id).username
  end

end
 