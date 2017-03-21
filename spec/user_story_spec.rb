
describe "User Stories" do

  let(:card) {Oystercard.new}
  # In order to use public transport
  # As a customer
  # I want money on my card
  it "In order to use public transport, a card stores money" do
    expect{ card.balance }.not_to raise_error
  end

end
