require_relative 'station'
require_relative 'journey'
class Oystercard

  attr_reader :balance, :current_station, :journeys, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @current_station = nil
    @journeys = []
    @journey = Journey.new
  end

  def top_up(amount)
    raise "Cannot top up: maximum balance exceeded (£#{MAXIMUM_BALANCE})" if balance + amount > MAXIMUM_BALANCE
    self.balance += amount
  end

  def touch_in(station)
    raise "Cannot pass. Insufficient funds!" if balance < MINIMUM_BALANCE
      if journey.exit_station != nil
        deduct(journey.fare)
        puts "You have been charged"
      end
    @journey = Journey.new(station)
    self.current_station = station
  end

  def touch_out(station)
    journey.end_journey(station)
    deduct(journey.fare)
    journeys << journey
    self.current_station = nil
  end


  private

  attr_writer :balance, :current_station, :journey

  def deduct(fare)
    self.balance -= fare
  end

end
