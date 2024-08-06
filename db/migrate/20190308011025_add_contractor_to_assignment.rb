class AddContractorToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :contractor_id, :integer
  end
end
