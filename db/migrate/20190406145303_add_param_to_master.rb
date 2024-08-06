class AddParamToMaster < ActiveRecord::Migration[5.2]
  def change
    add_column :masters, :param_1, :string
  end
end
