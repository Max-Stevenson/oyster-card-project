require 'journey'

describe Journey do
	it 'knows if a journey is not complete' do
		expect(subject).not_to be_complete
	end
end