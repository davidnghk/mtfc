class Master < ApplicationRecord
  enum setting1: { simple: 0, standard: 1, inspection: 2 }

  has_many :defect, :class_name => "Defect", foreign_key: 'issue_id'
  has_many :children, :class_name => "Master", foreign_key: 'parent_id'
  belongs_to :parent, :class_name => "Master", foreign_key: 'parent_id', :optional => true
  has_many :workflows, :class_name => "WorkFlow", foreign_key: 'work_id'
  has_many :duties, :class_name => "Duty", foreign_key: 'work_id'
  has_many :locations, foreign_key: 'category_id'
  has_many :business_staffs, :class_name => "BusinessStaff", foreign_key: 'business_unit_id'
  has_many :announcements, :class_name => "Announcement", foreign_key: 'business_unit_id'
  has_many :assignments, foreign_key: 'work_id'
 
  scope :work, -> { where(parent_id: 1) }
  scope :RoomCategory, -> { where(parent_id: 9) }
  scope :LocationType, -> { where(parent_id: 29) }
  scope :BedType, -> { where(parent_id: 13) }
  scope :BusinessUnit, -> { where(parent_id: 18) }
  scope :Post, -> { where(parent_id: 22) }
  scope :people, -> { where(parent_id: 176) }
 
  def to_label
    if (I18n.locale == :zh) then 
        "#{chi_name}"
    else 
        "#{name}"
    end 
  end

  def full_name 
    if (I18n.locale == :zh) then 
        "#{code} #{chi_name}"
    else 
        "#{code} #{name}"
    end 
  end

  def display_name
    if (I18n.locale == :zh) then 
      "#{chi_name}"
    else 
      "#{name}"
    end 
  end

  def count_child
    Master.where(:parent_id => self.id).count
  end

  private

    def self.icons
      ['call', 'call_end', 'camera_alt',  'computer', 'network_check', 'power', 
        'switch_video', 'videocam', 'voice_call', 'wifi']
    end

    def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |master|
          csv << master.attributes.values_at(*column_names)
        end
      end
    end

    def self.import(file)
      CSV.foreach(file.path, headers: true) do |row|
        Master.create! row.to_hash  
      end
    end

end
