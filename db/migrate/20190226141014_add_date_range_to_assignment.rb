class AddDateRangeToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :date_range, :string
  end
end
