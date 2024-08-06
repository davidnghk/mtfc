class CreateWorkflows < ActiveRecord::Migration[5.2]
  def change
    create_table :workflows do |t|
      t.integer :work_id
      t.references :location, foreign_key: true
      t.integer :incharge_user_id

      t.timestamps
    end
  end
end
