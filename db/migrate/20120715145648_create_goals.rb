class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :goals, :slug, :unique => true
  end
end
