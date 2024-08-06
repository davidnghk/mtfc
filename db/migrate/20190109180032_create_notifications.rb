class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :receipient_id
      t.string :content
      t.datetime :read_at
      t.integer :user_id

      t.timestamps
    end
  end
end

