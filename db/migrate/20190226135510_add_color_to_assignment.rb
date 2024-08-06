class AddColorToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :color, :string
  end
end
