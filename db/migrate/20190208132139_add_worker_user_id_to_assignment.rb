class AddWorkerUserIdToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :worker_user_id, :integer
  end
end
