class CreateLines < ActiveRecord::Migration[5.2]
  def change
    create_table :lines do |t|
      t.text :context
      t.integer :user_id 
      t.integer :conversation_id

      t.timestamps
    end
  end
end
