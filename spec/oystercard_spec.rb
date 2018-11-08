require 'oystercard'
require 'station'

describe Oystercard do
	context 'testing card funds' do
		let(:max_balance) {max_balance = Oystercard::MAX_BALANCE}

		it 'new card has a balance of 0' do
			expect(subject.balance).to eq(0)
		end

		describe '#top_up' do
			it { is_expected.to respond_to(:top_up).with(1).argument }

			it 'can be topped up with an amount' do
				subject.top_up(max_balance)

				expect(subject.balance).to eq(max_balance)
			end
		end

		it 'raises an error if maximum balance is exceeded' do
			subject.top_up(max_balance)
			expect{ subject.top_up(max_balance) }.to raise_error("Maximum balance of £#{max_balance} exceeded")
		end
	end

	context 'testing journey methods' do
		let(:entry_station) { entry_station = double }
		let(:exit_station)	{exit_station = double}

		before (:each) do
			# When double created here it is not recognized within methods
			allow(entry_station).to receive(:name) {"Barbican"}
			allow(exit_station).to receive(:name) {"Paddington"}
		end

		describe '#touch_in' do
			it 'records the name of entry_station when touched in' do
				subject.top_up(10)
				subject.touch_in(entry_station)
				expect(subject.entry_station).to eq("Barbican")
			end
		end

		describe '#in_journey?' do
			it 'a newly created card should not be in journey' do
				card = Oystercard.new

				expect(card.in_journey?).to eq(false)
			end

			it 'returns true if user has touch_in' do
				subject.top_up(10)
				subject.touch_in(entry_station)

				expect(subject.in_journey?).to eq(true)
			end

			it 'returns false after a user has touch_in and touch_out' do
				subject.top_up(10)
				subject.touch_in(entry_station)
				subject.touch_out(exit_station)

				expect(subject.in_journey?).to eq(false)
			end
		end

		describe '#touch_out' do
			it 'entry_station should be reset to nil when touching out' do
				subject.top_up(10)
				subject.touch_in(entry_station)
				expect{ subject.touch_out(exit_station) }.to change{ subject.entry_station }.from("Barbican").to(nil)
			end
			it { is_expected.to respond_to(:touch_out).with(1).argument }

			it 'should store the name of the station when touching out' do
				subject.top_up(10)
				subject.touch_in(entry_station)
				subject.touch_out(exit_station)

				expect(subject.exit_station).to eq("Paddington")
			end
		end
	end

	describe 'min balance testing' do
		it 'error raised when user tries to touch in with less than min balance' do
			entry_station = double(:name => "Barbican")
			expect{ subject.touch_in(entry_station) }.to raise_error ("You do not have enough funds to travel, please top up")
		end
	end

	describe 'charging for a journey' do
		it 'a user should be charged at least the minimum amount for a journey' do
			entry_station = double(:name => "Barbican")
			exit_station = double(:name => "Paddington")
			subject.top_up(10)
			subject.touch_in(entry_station)
			expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::MIN_CHARGE)
		end
	end

	context 'card travel history' do
		let(:journey) { {entry_station: entry_station.name, exit_station: exit_station.name} }
		let(:entry_station) { entry_station = double(:name => "Barbican") }
		let(:exit_station) { exit_station = double(:name => "Paddington") }
		
		it { is_expected.to have_attributes(:travel_history => (Array)) }

		it 'travel_history should be empty by default' do
			expect(subject.travel_history).to be_empty
		end

		it 'should store journey in travel_history' do
			subject.top_up(10)
			subject.touch_in(entry_station)
			subject.touch_out(exit_station)

			expect(subject.travel_history).to include(journey)
		end
	end
end