class AddTasksToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :today_tasks, :integer, default: 0 
  end
end
