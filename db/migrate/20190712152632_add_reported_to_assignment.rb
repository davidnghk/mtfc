class AddReportedToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :reported, :boolean, :default => false
    add_column :assignments, :followup, :string
  end
end
