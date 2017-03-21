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
  end

end
