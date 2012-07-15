class CreateCommitments < ActiveRecord::Migration
  def change
    create_table :commitments do |t|
      t.integer :user_id
      t.integer :goal_id
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
