class FixDefectidColumn < ActiveRecord::Migration[5.2]
  def change
  	rename_column :defects, :defect_id, :issue_id
  end
end
