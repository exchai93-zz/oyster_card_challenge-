require_relative 'oystercard'

class Journeylog

  attr_reader :journeys

  def initialize(journey_class: Journey)
    @journey_class = journey_class
    @journeys = []
  end

  def start_journey(station)
    add(@journey_class.new(entry_station: station))
  end

  def add(journey)
    @journeys << journey
  end

end
