class AddItemToDefect < ActiveRecord::Migration[5.2]
  def change
    add_column :defects, :item, :string
    add_column :defects, :item_id, :string
  end
end
