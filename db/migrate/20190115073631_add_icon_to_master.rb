class AddIconToMaster < ActiveRecord::Migration[5.2]
  def change
    add_column :masters, :icon, :string
  end
end
