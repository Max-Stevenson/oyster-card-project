class Journey
	attr_accessor :complete

	def initialize
		@complete = false
	end

	def complete?
		@complete
	end
end