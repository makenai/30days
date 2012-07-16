class Goal < ActiveRecord::Base
  attr_accessible :name, :user_id, :slug
  validates_presence_of :name
  validates_associated :user
  before_save :sluggify
  
  belongs_to :user
  
  def sluggify
    self.slug = Goal.slug( self.name )
  end
  
  def self.slug( str )
    return str.downcase.gsub(/\s+/,'-').gsub(/[^a-z0-9-]/,'')
  end
  
end
