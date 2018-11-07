class Oystercard
	attr_accessor :balance, :in_journey, :entry_station

	MAX_BALANCE = 90
	MIN_CHARGE = 1
	
	def initialize
		@balance = 0
		@in_journey = false
		@entry_station = nil
	end

	def top_up (amount)
		raise ("Maximum balance of £#{MAX_BALANCE} exceeded") if amount + balance > MAX_BALANCE
		@balance += amount
	end

	def in_journey?
		@in_journey
	end

	def touch_in (station)
		raise ("You do not have enough funds to travel, please top up") if balance < MIN_CHARGE
		@in_journey = true
		@entry_station = station.name
	end

	def touch_out
		@in_journey = false
		deduct(MIN_CHARGE)
	end

	private def deduct (amount)
		@balance -= amount
	end

end