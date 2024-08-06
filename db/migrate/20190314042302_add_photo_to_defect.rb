class AddPhotoToDefect < ActiveRecord::Migration[5.2]
  def change
    add_column :defects, :before_photo, :string
    add_column :defects, :after_photo, :string
  end
end
