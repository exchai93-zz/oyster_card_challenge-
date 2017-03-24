require_relative 'station'
require_relative 'journey'
class Oystercard
  # Anything relating to blance

  attr_reader :balance, :journeys, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @journeys = []
    @journey = Journey.new
  end

  def top_up(amount)
    raise "Cannot top up: maximum balance exceeded (£#{MAXIMUM_BALANCE})" if balance + amount > MAXIMUM_BALANCE
    self.balance += amount
  end

  def touch_in(station)
    raise "Cannot pass. Insufficient funds!" if balance < MINIMUM_BALANCE
      if journey.exit_station == nil && journey.entry_station != nil
        deduct(journey.penalty_fare)
        puts "You have been charged"
      end
    @journey = Journey.new(entry_station: station)
  end

  def touch_out(station)
    if journey.entry_station == nil || journey.exit_station != nil
      deduct(journey.penalty_fare)
      puts "PENALTY CHARGE!!!"
    else
    journey.end_journey(exit_station: station)
    deduct(journey.standard_fare)
    journeys << journey
  end
  end


  private

  attr_writer :balance, :journey

  def deduct(penalty_fare)
    self.balance -= penalty_fare
  end

end
