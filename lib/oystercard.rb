class Oystercard

  attr_reader :balance

  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Cannot top up: maximum balance exceeded (£#{MAXIMUM_BALANCE})" if balance + amount > MAXIMUM_BALANCE
    self.balance += amount
  end

  def deduct(fare)
    self.balance -= fare
  end

  private

  attr_writer :balance

end
