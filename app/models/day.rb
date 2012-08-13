class Day

	attr_accessor :number, :date, :checkins

	def initialize( number, date, checkins=nil )
		@number = number
		@date   = date
		@checkins = checkins || []
	end

	def classes
		classes = []
		classes << 'today active' if self.today?
		classes << 'future' if self.future?
		classes << 'checked-in' if self.has_checkins?
		classes.join(' ')
	end

	def today?
		@date == Date.today
	end

	def future?
		@date > Date.today
	end

	def has_checkins?
		@checkins.present?
	end

	def checkin
		checkins.first
	end

end