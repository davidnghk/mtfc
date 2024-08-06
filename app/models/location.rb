class Location < ApplicationRecord
  enum status: { Vacant: 0, Occupied: 1, Others: 2 }
  enum condition: { Clean: 0, Dirty: 1, Cleaning: 2 }

  has_many :children, :class_name => "Location", foreign_key: 'parent_id'
  belongs_to :parent, :class_name => "Location", foreign_key: 'parent_id', :optional => true
  has_many :workflows
  has_many :duties
  belongs_to :category, :class_name => "Master", foreign_key: 'category_id', :optional => true
#  belongs_to :room, :optional => true
#  has_many :bookings
#  has_many :occupations
   has_many :assignments
  
  scope :GuestRoom, -> { where(category_id: 8) }

  def self.i18n_statuses(hash = {})
    statuses.keys.each { |key| hash[I18n.t("statuses.#{key}")] = key }
    hash
  end

  def self.i18n_conditions(hash = {})
    conditions.keys.each { |key| hash[I18n.t("conditions.#{key}")] = key }
    hash
  end
  
  def self.create_assignment(location_id, work_id)
    Assignment.create(work_id: work_id, location_id: location_id)
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

  def short_code
    self.name.split.map(&:first).join
  end

  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      location = Location.new
      location.parent = Location.where(' code = ?',  row[0]).first
      location.name = row[1]
      location.chi_name = row[1]
      location.code = row[1].split.map(&:first).join
      location.save
      if row[3] == 'Car Park'
        location.category_id = 30
      else
        location.category_id = 31
      end
    end
  end

end
