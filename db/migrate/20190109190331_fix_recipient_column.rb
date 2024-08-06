class FixRecipientColumn < ActiveRecord::Migration[5.2]
  def self.up
    rename_column :notifications, :receipient_id, :recipient_id
  end
end
