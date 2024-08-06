class CreateDefects < ActiveRecord::Migration[5.2]
  def change
    create_table :defects do |t|
      t.references :assignment, foreign_key: true
      t.integer :defect_id
      t.integer :rating
      t.string :remarks

      t.timestamps
    end
  end
end
