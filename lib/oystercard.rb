class Oystercard
	attr_accessor :balance, :entry_station

	MAX_BALANCE = 90
	MIN_CHARGE = 1
	
	def initialize
		@balance = 0
		@entry_station = nil
	end

	def top_up (amount)
		raise ("Maximum balance of £#{MAX_BALANCE} exceeded") if amount + balance > MAX_BALANCE
		@balance += amount
	end

	def in_journey?
		!!entry_station
	end

	def touch_in (station)
		raise ("You do not have enough funds to travel, please top up") if balance < MIN_CHARGE
		@in_journey = true
		@entry_station = station.name
	end

	def touch_out
		deduct(MIN_CHARGE)
		@entry_station = nil
	end

	private def deduct (amount)
		@balance -= amount
	end

end