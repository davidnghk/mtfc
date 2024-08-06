class FixWorkOrder < ActiveRecord::Migration[5.2]
  def self.up
    rename_column :assignments, :worker_order, :work_order 
  end

  def self.down
    rename_column :assignments, :work_order, :worker_order 
  end
end
