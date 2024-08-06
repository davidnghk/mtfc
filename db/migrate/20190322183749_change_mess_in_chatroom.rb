class ChangeMessInChatroom < ActiveRecord::Migration[5.2]
  def change
  	change_column :chatrooms, :direct_message, :integer, default: 0  
  end
end
