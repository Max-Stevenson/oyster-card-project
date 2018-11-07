class Oystercard
	attr_accessor :balance, :in_journey

	MAX_BALANCE = 90
	
	def initialize
		@balance = 0
		@in_journey = false
	end

	def top_up (amount)
		raise ("Maximum balance of £#{MAX_BALANCE} exceeded") if amount + balance > MAX_BALANCE
		@balance += amount
	end

	def deduct (amount)
		@balance -= amount
	end

	def in_journey?
		@in_journey
	end

	def touch_in 
		@in_journey = true
	end

	def touch_out
		@in_journey = false
	end

end