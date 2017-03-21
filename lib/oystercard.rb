class Oystercard

  attr_reader :balance

  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    new_balance = balance + amount
    raise "Cannot top up: maximum balance exceeded (£#{MAXIMUM_BALANCE})" if new_balance > MAXIMUM_BALANCE
    self.balance += amount
  end

  private

  attr_writer :balance

  # def balance_exceeded?
  #   balance + amount
  # end

end
