class AddNoToNotification < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :no, :integer
  end
end
