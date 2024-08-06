class AddBimToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :bim_url, :string
  end
end
