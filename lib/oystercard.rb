class Oystercard
	attr_accessor(
	:balance, 
	:entry_station,
	:entry_station_zone,
	:travel_history, 
	:exit_station,
	:exit_station_zone,
	)

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
		@entry_station_zone = station.zone
		@exit_station = nil
	end

	def touch_out (station)
		deduct(MIN_CHARGE)
		@exit_station = station.name
		@exit_station_zone = station.zone
		store_journey
		@entry_station = nil
	end

	private def deduct (amount)
		@balance -= amount
	end

	private def store_journey
		travel_history << Hash[:entry_station, @entry_station,
		:entry_station_zone, @entry_station_zone,
		:exit_station, @exit_station,
		:exit_station_zone, @exit_station_zone]
	end
end