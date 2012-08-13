class ExpandIcons < ActiveRecord::Migration
  def change
  	remove_column :icons, :filename
  	add_column :icons, :license, :string
  	add_column :icons, :source, :string
	add_column :icons, :tags, :string
	add_index :icons, :name, :unique => true
  end
end
