require 'oystercard'

describe Oystercard do
	it 'has a balance of 0' do
		expect(subject.balance).to eq(0)
	end

	describe '#top_up' do
		it { is_expected.to respond_to(:top_up).with(1).argument}

		it 'can be topped up with an amount' do
			subject.top_up(10)

			expect(subject.balance).to eq(10)
		end

		it 'raises an error if maximum balance is exceeded' do
			maximum_balance = Oystercard::MAX_BALANCE
			subject.top_up(maximum_balance)
			expect{ subject.top_up(10) }.to raise_error ("Maximum balance of £#{maximum_balance} exceeded")
		end
	end
end