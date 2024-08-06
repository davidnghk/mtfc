class AddAncestryToAssignments < ActiveRecord::Migration[5.2]
  def self.up
    add_column :assignments, :ancestry, :string
    add_index  :assignments, :ancestry
  end

  def self.down
    remove_index  :assignments, :ancestry
    remove_column :assignments, :ancestry
  end

end
