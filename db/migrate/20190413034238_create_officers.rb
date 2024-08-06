class CreateOfficers < ActiveRecord::Migration[5.2]
  def change
    create_table :officers do |t|
      t.references :defect, foreign_key: true
      t.string :name
      t.string :passwd

      t.timestamps
    end
  end
end
