class Oystercard
	attr_accessor :balance

	MAX_BALANCE = 90
	
	def initialize
		@balance = 0
	end

	def top_up (amount)
		raise ("Maximum balance of £#{MAX_BALANCE} exceeded") if amount + balance > MAX_BALANCE
		@balance += amount
	end

	def deduct (amount)
		@balance -= amount
	end
end