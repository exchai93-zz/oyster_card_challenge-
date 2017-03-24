class Journey
  # Remembering one instance of journey

  PENALTY_CHARGE = 6
  MIN_FARE = 1
  attr_reader :entry_station, :complete, :exit_station

  def initialize(entry_station: nil)
    @entry_station = entry_station
    @complete = false
  end

  def end_journey(exit_station: nil)
    @exit_station = exit_station
    self.complete = true
    # returns the object journey
    # card.exit - returns the journey
    self
  end

  def touch_in_penalty
    (!entry_station || !exit_station)
  end

  def touch_out_penalty
    (entry_station == nil || exit_station != nil)
  end

  def fare
    return PENALTY_CHARGE if touch_in_penalty || touch_out_penalty
  end

  def standard_fare
    MIN_FARE
  end

private
attr_writer :complete, :entry_station

end
