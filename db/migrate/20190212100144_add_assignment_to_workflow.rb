class AddAssignmentToWorkflow < ActiveRecord::Migration[5.2]
  def change
    add_column :workflows, :assignment, :integer, default: 0 
  end
end
