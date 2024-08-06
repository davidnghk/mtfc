class AddSettingToMaster < ActiveRecord::Migration[5.2]
  def change
    add_column :masters, :setting1, :integer
  end
end
