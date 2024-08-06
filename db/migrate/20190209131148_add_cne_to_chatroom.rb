class AddCneToChatroom < ActiveRecord::Migration[5.2]
  def change
    add_column :chatrooms, :chi_name, :string
    add_column :chatrooms, :incharge_user_id, :integer
  end
end
