class AddPhotoableToPhoto < ActiveRecord::Migration[5.2]
  def up
    change_table :photos do |t|
      t.references :photoable, polymorphic: true
    end
    add_index :photos, [:photoable_id, :photoable_type]
  end

  def down
    change_table :photos do |t|
      t.remove_references :photoable, polymorphic: true
    end
  end
end
