class Day

	attr_accessor :number, :date

	def initialize( number, date )
		@number = number
		@date   = date
	end

	def classes
		classes = []
		classes << 'today' if self.today?
		classes << 'future' if self.future?
		classes.join(' ')
	end

	def today?
		@date == Date.today
	end

	def future?
		@date > Date.today
	end

end