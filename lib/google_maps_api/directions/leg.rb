require 'google_maps_api/directions/leg_and_step_common_builders'

class GoogleMapsAPI::Directions::Leg
  extend GoogleMapsAPI::Directions::LegAndStepCommonBuilders

  attr_reader :distance, :duration, :end_address, :end_location,
              :start_address, :start_location, :steps, :via_waypoint

  def initialize(
    distance, duration, end_address, end_location,
    start_address, start_location, steps, via_waypoint
  )
    @distance = distance
    @duration = duration
    @end_address = end_address
    @end_location = end_location
    @start_address = start_address
    @start_location = start_location
    @steps = steps
    @via_waypoint = via_waypoint
  end

  def self.from_hash(hash)
    distance = build_distance(hash)
    duration = build_duration(hash)
    end_address = hash["end_address"]
    end_location = build_coordinate(hash["end_location"])
    start_address = hash["start_address"]
    start_location = build_coordinate(hash["start_location"])
    steps = build_steps(hash)
    via_waypoint = hash["via_waypoint"]

    self.new(
      distance, duration, end_address, end_location,
      start_address, start_location, steps, via_waypoint
    )
  end

  private

  def self.build_steps(hash)
    hash["steps"].collect do |s|
      GoogleMapsAPI::Directions::Step.from_hash(s)
    end
  end
end
