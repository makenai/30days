class Icon < ActiveRecord::Base
  attr_accessible  :name, :license, :source, :url, :attribution, :tags
  validates :name, :uniqueness => true
end
