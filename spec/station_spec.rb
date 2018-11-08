require 'station'
require 'oystercard'

describe Station do
	
	subject { described_class.new("Edgeware Road", 1) }

	it 'has a station name' do
		expect(subject.name).to eq("Edgeware Road")
	end

	it 'knows what zone it is in' do
		expect(subject.zone).to eq(1)
	end
end