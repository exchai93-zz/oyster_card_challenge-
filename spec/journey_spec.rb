require 'journey'
describe Journey do
let(:station) {double :station}
subject {described_class.new(entry_station: station)}

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

  describe '#fare' do
    it 'charges a penalty charge' do
      subject.end_journey
      expect(subject.fare).to eq Journey::PENALTY_CHARGE
    end
  end

  context 'Given an exit station' do
    before do
      subject.end_journey(exit_station: station)
    end

    it 'charges a standard fare' do
      puts subject
      expect(subject.fare). to eq Journey::MIN_FARE
    end
  end
end
