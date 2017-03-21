require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}

  describe '#balance' do
    it { is_expected.to respond_to :balance }

    it "initialized with balance of 0" do
      expect(card.balance).to eq 0
    end
  end


end
