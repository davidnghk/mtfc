class AddUserToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :user_id, :integer 
  end
end
