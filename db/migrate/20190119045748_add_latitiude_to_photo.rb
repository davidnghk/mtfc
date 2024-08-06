class AddLatitiudeToPhoto < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :latitude, :decimal, { precision: 10, scale: 6 }
    add_column :photos, :longitude, :decimal, { precision: 10, scale: 6 }
    add_column :photos, :altitude, :decimal, { precision: 10, scale: 6 }
    add_column :photos, :is_printable, :boolean, default: true
  end
end

