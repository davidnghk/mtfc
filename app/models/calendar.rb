class Calendar < ApplicationRecord
  enum status: [:Available, :Not_Available]
  validates :day, presence: true
  belongs_to :locations
  belongs_to :masters
end

