class Goal < ActiveRecord::Base
  attr_accessible :name, :user_id, :slug
  validates_presence_of :name
  validates_associated :user
  before_save :sluggify
  
  def sluggify
    self.slug = self.name.downcase.gsub(/\s+/,'-').gsub(/[^a-z0-9-]/,'')
  end
  
end
