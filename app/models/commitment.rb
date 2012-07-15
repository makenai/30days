class Commitment < ActiveRecord::Base
  attr_accessible :end_date, :goal_id, :start_date, :user_id
  validates_presence_of :start_date, :end_date
  validates_associated :goal, :user
  
end