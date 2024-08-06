class Officer < ApplicationRecord
	belongs_to :defect, optional: true
end
