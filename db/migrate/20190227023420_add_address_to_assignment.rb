class AddAddressToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :address, :string
    add_column :assignments, :longitude, :decimal, precision: 10, scale: 6 
    add_column :assignments, :altitude, :decimal, precision: 10, scale: 6 
  end
end
