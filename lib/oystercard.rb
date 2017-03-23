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
      if journey.exit_station == nil
        deduct(journey.fare)
        puts "You have been charged"
      end
    @journey = Journey.new(station)
  end

  def touch_out(station)
    journey.end_journey(station)
    deduct(journey.fare)
    journeys << journey
  end


  private

  attr_writer :balance, :journey

  def deduct(fare)
    self.balance -= fare
  end

end
