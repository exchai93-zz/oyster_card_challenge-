require 'journeylog'


describe Journeylog do
  let(:journey) {double :journey}
  let(:station) {double :station}
  let(:journey_class) {double :journey_class, new: journey}
  subject(:journeylog) {described_class.new(journey_class: journey_class)}
  describe '#start_journey(station)' do
    context 'Having started a journey' do
      before do
        journeylog.start_journey(station)
      end

      it 'starts recording a journey' do
        expect(journeylog.journeys).to include journey
      end

    end
  end
end
