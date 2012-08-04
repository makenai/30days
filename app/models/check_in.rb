class CheckIn < ActiveRecord::Base
  attr_accessible :checkin_date, :commitment_id, :day, :note
  belongs_to :commitment
end
