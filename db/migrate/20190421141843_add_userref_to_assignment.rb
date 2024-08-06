class AddUserrefToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :user_ref, :string
    add_column :assignments, :remarks, :text
  end
end
