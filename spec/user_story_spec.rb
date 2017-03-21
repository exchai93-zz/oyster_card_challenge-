
describe "User Stories" do

  let(:card) {Oystercard.new}
  # In order to use public transport
  # As a customer
  # I want money on my card
  it "In order to use public transport, a card stores money" do
    expect{ card.balance }.not_to raise_error
  end

  # In order to keep using public transport
  # As a customer
  # I want to add money to my card
  it "In order to keep using public transport, able to top up card" do
    expect { card.top_up(2) }.not_to raise_error
  end

end
