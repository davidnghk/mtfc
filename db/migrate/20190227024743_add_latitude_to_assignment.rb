class AddLatitudeToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :latitude, :decimal, precision: 10, scale: 6 
  end
end
