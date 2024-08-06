class CreateAnnouncements < ActiveRecord::Migration[5.2]
  def change
    create_table :announcements do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.text :content

      t.timestamps
    end
  end
end
