class Oystercard
	attr_accessor :balance, :entry_station, :travel_history

	MAX_BALANCE = 90
	MIN_CHARGE = 1
	
	def initialize
		@balance = 0
		@entry_station = nil
		@exit_station = nil
		@travel_history = []
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
		@entry_station = station.name
	end

	def touch_out (station)
		deduct(MIN_CHARGE)
		@entry_station = nil
	end

	private def deduct (amount)
		@balance -= amount
	end

end