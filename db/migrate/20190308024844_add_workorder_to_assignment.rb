class AddWorkorderToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :worker_order, :string
  end
end
