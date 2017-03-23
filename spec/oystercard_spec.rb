require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}
  let(:station) {double :station}
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  let(:journey) {double :journey, complete: false}
  let (:journey) { {entry_station: entry_station, exit_station: exit_station} }

  describe '#balance' do
    it { is_expected.to respond_to :balance }

    it "initialized with balance of 0" do
      expect(card.balance).to eq 0
    end
  end

  describe "#top_up" do

    it "increases the balance by the amount topped up" do
      card.top_up(Oystercard::MINIMUM_BALANCE)
      expect { card.top_up(Oystercard::MINIMUM_BALANCE) }.to change { card.balance }.by(Oystercard::MINIMUM_BALANCE)
    end

    it "raises an error if attempted top up exceeds £90 limit" do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      message = "Cannot top up: maximum balance exceeded (£90)"
      expect { card.top_up(maximum_balance + Oystercard::MINIMUM_BALANCE) }.to raise_error message
    end

    it "raises an error when limit of £90 is exceeded" do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      message = "Cannot top up: maximum balance exceeded (£90)"
      card.top_up(maximum_balance)
      expect { card.top_up(Oystercard::MINIMUM_BALANCE) }.to raise_error message
    end
  end

  describe "#deduct" do

    it "deducts fare from balance" do
      card.top_up(Oystercard::MINIMUM_BALANCE)
      card.touch_in(entry_station: station)
      expect{card.touch_out(exit_station: station)}.to change{card.balance}.by(-Oystercard::MINIMUM_BALANCE)
    end
  end

  describe "#touch_in" do

    it "raises an error if there are insufficient funds" do
      message = "Cannot pass. Insufficient funds!"
      expect{ card.touch_in(station) }.to raise_error message
    end

    it 'deducts a penalty charge if previous journey not complete' do
      card.top_up(Oystercard::MINIMUM_BALANCE + 6)
      expect{card.touch_in(entry_station: station)}.to change{card.balance}.by(-6)
    end

    context 'topped up and touched in' do
      before do
        card.top_up(Oystercard::MINIMUM_BALANCE)
        card.touch_in(entry_station: station)
      end

    end

  end

  describe "#touch_out" do
    context 'tops up and touches in' do
      before do
        card.top_up(Oystercard::MINIMUM_BALANCE)
        card.touch_in(entry_station: station)
      end

      it "deducts fare once journey is completed" do
        expect {card.touch_out(exit_station: station)}.to change{card.balance}.by(-Oystercard::MINIMUM_BALANCE)
      end
    end

    it { is_expected.to respond_to(:touch_out).with(1).argument }

    it 'stores one journey after touching out' do
      card.top_up(Oystercard::MINIMUM_BALANCE)
      card.touch_in(entry_station: station)
      card.touch_out(exit_station: station)
      expect(card.journeys).to include card.journey
    end
  end

  describe '#journeys' do
    it { is_expected.to respond_to(:journeys)}

    it 'should be empty' do
      expect(card.journeys).to be_empty
    end
  end




end
