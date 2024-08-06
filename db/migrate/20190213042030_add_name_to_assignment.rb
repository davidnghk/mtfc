class AddNameToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :name, :string
    add_column :assignments, :task, :integer
  end
end
