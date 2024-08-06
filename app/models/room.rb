class Room < ApplicationRecord
  enum status: [ :Vacant, :Occupied, :Others ]
  enum condition: [:Clean, :Dirty]
  enum smoking: [:NonSmoking, :Smoking]

  validates :room_no, presence: true, length: {maximum: 12}
  validates :category_id, presence: true
  validates :status, presence: true
  validates :condition, presence: true
  validates :smoking, presence: true
  validates :bed_type_id, presence: true
  validates :accomodate, presence: true

  has_many :bookings
  has_many :locations
  belongs_to :category, :class_name => "Master", :foreign_key => "category_id", optional: true
  belongs_to :bed_type, :class_name => "Master", :foreign_key => "bed_type_id", optional: true

  def to_label
    room_no
  end

  def self.i18n_statuses(hash = {})
    statuses.keys.each { |key| hash[I18n.t("statuses.#{key}")] = key }
    hash
  end

  def self.i18n_conditions(hash = {})
    conditions.keys.each { |key| hash[I18n.t("conditions.#{key}")] = key }
    hash
  end

  def self.i18n_smokings(hash = {})
    smokings.keys.each { |key| hash[I18n.t("smokings.#{key}")] = key }
    hash
  end

end
  