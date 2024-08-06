class AddStarToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :star, :integer
    add_column :assignments, :comment, :text
  end
end
