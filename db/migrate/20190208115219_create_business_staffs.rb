class CreateBusinessStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :business_staffs do |t|
      t.integer :business_unit_id
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  end
end
