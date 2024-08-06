class AddAasmToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :aasm_state, :string
  end
end
