class AddPhotodateToPhoto < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :photo_datetime, :datetime
  end
end
