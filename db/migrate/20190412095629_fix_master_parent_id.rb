class FixMasterParentId < ActiveRecord::Migration[5.2]
  def change
  	change_column :masters, :parent_id, :integer
  end
end
