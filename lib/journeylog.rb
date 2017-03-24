require_relative 'oystercard'
require 'forwardable'
class Journeylog
  extend Forwardable

  def_delegator :current_journey, :exit, :exit_journey

  attr_reader :journeys

  def initialize(journey_class: Journey)
    @journey_class = journey_class
    @journeys = []
  end

  def start_journey(station)
    fail "Already in a journey" if current_journey.entry_station
    add(journey_class.new(entry_station: station))
  end

  def journeys
    @journeys.dup
  end

  private

  attr_reader :journey_class

  def add(journey)
    @journeys << journey
  end

  def incomplete_journey
    journeys.reject(&:complete?).first
  end

  def current_journey
    incomplete_journey || journey_class.new
  end

end
