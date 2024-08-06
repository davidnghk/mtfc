class AddBlockToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :block_hash, :string
    add_column :assignments, :nonce, :integer
  end
end
