require_relative 'station'
class Oystercard

  attr_reader :balance, :current_station, :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE  = 1

  def initialize
    @balance = 0
    @current_station = nil
    @journeys = []
  end

  def top_up(amount)
    raise "Cannot top up: maximum balance exceeded (£#{MAXIMUM_BALANCE})" if balance + amount > MAXIMUM_BALANCE
    self.balance += amount
  end

  def in_journey?
    current_station == nil ? false : true
  end

  def touch_in(station)
    raise "Cannot pass. Insufficient funds!" if balance < MINIMUM_BALANCE
    self.current_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    journeys.push({entry_station: current_station, exit_station: station})
    self.current_station = nil
  end


  private

  attr_writer :balance, :current_station

  def deduct(fare)
    self.balance -= fare
  end

end
