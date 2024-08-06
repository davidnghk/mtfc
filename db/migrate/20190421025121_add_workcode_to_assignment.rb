class AddWorkcodeToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :work_code, :string
    add_column :assignments, :location_code, :string
  end
end
