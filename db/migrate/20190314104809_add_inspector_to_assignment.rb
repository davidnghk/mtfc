class AddInspectorToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :inspector_id, :integer
    add_column :assignments, :witness_id, :integer
  end
end
