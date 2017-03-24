require 'journeylog'


describe Journeylog do
  let(:station) {double :station}
  let(:journey_class) {double :journey_class, new: journey}
  subject(:journeylog) {described_class.new(journey_class: journey_class)}

  describe '#start_journey(station)' do
    let(:journey) {double :journey, entry_station: nil, complete?: false}
    context 'Having started a journey' do
      before do
        journeylog.start_journey(station)
      end

      it 'starts recording a journey' do
        expect(journeylog.journeys).to include journey
      end
    end
  end
  describe 'with start journey' do
    let(:journey) {double :journey, entry_station: :station, complete?: false}
    it 'raises an error if already started a journey' do
      expect{journeylog.start_journey(station)}.to raise_error "Already in a journey"
    end
  end

end
