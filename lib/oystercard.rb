class Oystercard

  attr_reader :balance, :in_use, :entry_station

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE  = 1

  def initialize
    @balance = 0
    @in_use = false
    @entry_station
  end

  def top_up(amount)
    raise "Cannot top up: maximum balance exceeded (£#{MAXIMUM_BALANCE})" if balance + amount > MAXIMUM_BALANCE
    self.balance += amount
  end

  def in_journey?
    self.in_use
  end

  def touch_in(station)
    raise "Cannot pass. Insufficient funds!" if balance < MINIMUM_BALANCE
    self.in_use = true
    self.entry_station = station
  end

  def touch_out
    self.in_use = false
    deduct(MINIMUM_CHARGE)
  end

  private

  attr_writer :balance, :in_use, :entry_station

  def deduct(fare)
    self.balance -= fare
  end

end
