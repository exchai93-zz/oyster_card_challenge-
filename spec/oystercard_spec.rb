require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}

  describe '#balance' do
    it { is_expected.to respond_to :balance }

    it "initialized with balance of 0" do
      expect(card.balance).to eq 0
    end
  end

  describe "#top_up" do

    it "increases the balance by the amount topped up" do
      card.top_up(20)
      expect { card.top_up(20) }.to change { card.balance }.by(20)
    end

    it "raises an error if attempted top up exceeds £90 limit" do
      maximum_balance = described_class::MAXIMUM_BALANCE
      expect { card.top_up(maximum_balance+1) }.to raise_error "Cannot top up: maximum balance exceeded (£90)"
    end

    it "raises an error when limit of £90 is exceeded" do
      maximum_balance = described_class::MAXIMUM_BALANCE
      card.top_up(maximum_balance)
      expect { card.top_up(1) }.to raise_error "Cannot top up: maximum balance exceeded (£90)"
    end
  end

  describe "#deduct" do

    it "deducts fare from balance" do
      card.top_up(30)
      card.touch_out
      expect(card.balance).to eq 29
    end
  end

  describe "#in_journey?" do
    it 'is initally not in a journey' do
      expect(card.in_journey?).to be false
    end

    it 'is in journey' do
      card.top_up(described_class::MINIMUM_BALANCE)
      card.touch_in("High Barnet")
      expect(card.in_journey?).to be true
    end
  end

  describe "#touch_in" do
    it "can touch in" do
      card.top_up(described_class::MINIMUM_BALANCE)
      card.touch_in("High Barnet")
      expect(card).to be_in_journey
    end

    it "raises an error if there are insufficient funds" do
      expect{ card.touch_in("High Barnet")}.to raise_error "Cannot pass. Insufficient funds!"
    end
  end

  describe "#touch_out" do
    it "can touch out" do
      card.top_up(described_class::MINIMUM_BALANCE)
      card.touch_in("High Barnet")
      card.touch_out
      expect(card).not_to be_in_journey
    end

    it "deducts fare once journey is completed" do
      card.top_up(described_class::MINIMUM_BALANCE)
      card.touch_in("High Barnet")
      expect {card.touch_out}.to change{card.balance}.by(-described_class::MINIMUM_CHARGE)
    end
  end



end
