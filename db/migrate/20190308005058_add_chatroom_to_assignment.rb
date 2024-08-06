class AddChatroomToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :chatroom_id, :integer
  end
end
