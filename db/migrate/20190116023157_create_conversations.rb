class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.integer :send_user_id
      t.integer :recipient_user_id
      t.string :name

      t.timestamps
    end
  end
end
