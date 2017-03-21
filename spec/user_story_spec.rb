
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

  # In order to protect my money from theft or loss
  # As a customer
  # I want a maximum limit (of £90) on my card
  it "In order to protect money, enforce a maximum limit of £90 on card" do
    card.top_up(45)
    expect {card.top_up(46)}.to raise_error "Cannot top up: maximum balance exceeded (£90)"
  end

  # In order to pay for my journey
  # As a customer
  # I need my fare deducted from my card
  it "In order to pay for journeys, deduct fare from card" do
    card.top_up(20)
    expect { card.touch_out }.to change { card.balance }.by -1
  end

  # In order to get through the barriers.
  # As a customer
  # I need to touch in and out.
  it "In order to get through barriers, card is able to touch in and out" do
    card.top_up(1)
    card.touch_in
    expect(card.in_journey?).to be true
    card.touch_out
    expect(card.in_journey?).to be false
  end

  # In order to pay for my journey
  # As a customer
  # I need to have the minimum amount for a single journey
  it "In order to pay for journey, minimum amount for a single journey is needed" do
    expect{ card.touch_in }.to raise_error "Cannot pass. Insufficient funds!"
  end

  # In order to pay for my journey
  # As a customer
  # I need to pay for my journey when it's complete
  it "Pay for journey when complete" do
    card.top_up(1)
    card.touch_in
    expect {card.touch_out}.to change{card.balance}.by -1
  end
end
