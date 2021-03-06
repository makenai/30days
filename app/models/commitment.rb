class Commitment < ActiveRecord::Base

  attr_accessible :end_date, :goal_id, :start_date, :user_id
  validates_presence_of :start_date, :end_date
  validates :goal, :user, :presence => true
  
  belongs_to :user
  belongs_to :goal
  has_many :check_ins
  
  before_validation :set_dates
  
  def set_dates
    self.start_date = Date.today
    self.end_date = self.start_date + 30.days
  end
  
  def current_day
    1 + (Date.today - self.start_date).to_i
  end
  
  def days_left
    (self.end_date - Date.today).to_i
  end

  def length
    (self.end_date - self.start_date).to_i
  end
  
  def days
    days = []
    checkins = {}
    self.check_ins.each do |c|
      ( checkins[ c.checkin_date ] ||= [] ) << c
    end
    (self.start_date..Date.today).each_with_index do |date,i|
        days << Day.new( i + 1, date, checkins[ date ] )
    end
    return days.reverse
  end
  
end