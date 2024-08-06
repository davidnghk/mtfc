class AddNoToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :no, :integer
  end
end
