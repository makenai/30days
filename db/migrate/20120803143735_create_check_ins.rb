class CreateCheckIns < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.integer :commitment_id
      t.integer :day
      t.date :checkin_date
      t.text :note

      t.timestamps
    end
  end
end
