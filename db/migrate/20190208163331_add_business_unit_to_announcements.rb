class AddBusinessUnitToAnnouncements < ActiveRecord::Migration[5.2]
  def change
    add_column :announcements, :business_unit_id, :integer
  end
end
