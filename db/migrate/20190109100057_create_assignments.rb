class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.integer :work_id
      t.references :location, foreign_key: true
      t.integer :incharge_user_id
      t.string :heading
      t.datetime :start_datetime
      t.integer :status
      t.datetime :due_datetime
      t.datetime :end_datetime

      t.timestamps
    end
  end
end
