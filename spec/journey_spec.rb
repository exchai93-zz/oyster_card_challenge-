require 'journey'
describe Journey do
let(:station) {double :station}
subject {described_class.new(station)}

  describe '#entry_station' do
    it 'has an entry station' do
      expect(subject.entry_station).to eq station
    end
  end

  describe '#journey_started' do
    it 'is false when initialized' do
      expect(subject.complete).to be false
    end
  end

  describe '#end_journey' do
    it 'marks complete as true' do
      subject.end_journey
      expect(subject.complete).to be true
    end
  end
end
