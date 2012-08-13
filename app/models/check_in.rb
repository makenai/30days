class CheckIn < ActiveRecord::Base
  attr_accessible :checkin_date, :commitment_id, :note
  belongs_to :commitment
  validates :commitment, :presence => true
  validates :note, :presence => true
  validates_uniqueness_of :checkin_date, :scope => :commitment_id

  def to_day
  	number = 1 + (self.checkin_date - self.commitment.start_date).to_i
  	Day.new( number, self.checkin_date, (self.destroyed? || self.new_record?) ? [] : [ self ] )
  end

end
