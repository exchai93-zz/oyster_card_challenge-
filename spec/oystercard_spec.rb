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
    it { is_expected.to respond_to(:top_up).with(1).argument }

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
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it "deducts fare from balance" do
      card.top_up(30)
      card.deduct(20)
      expect(card.balance).to eq 10
    end
  end

end
