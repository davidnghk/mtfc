class ChangeInchargeToWorkflows < ActiveRecord::Migration[5.2]
  def change
    rename_column :workflows, :incharge_user_id, :business_unit_id
  end
end
