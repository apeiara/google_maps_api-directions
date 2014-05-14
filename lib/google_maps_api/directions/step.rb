require 'google_maps_api/directions/leg_and_step_common_builders'

class GoogleMapsAPI::Directions::Step
  extend GoogleMapsAPI::Directions::LegAndStepCommonBuilders

  attr_reader :distance, :duration, :end_location,
              :start_location, :html_instructions, 
              :polyline, :travel_mode

  def initialize(
    distance, duration, end_location,
    start_location, html_instructions, 
    polyline, travel_mode
  )
    @distance = distance
    @duration = duration
    @end_location = end_location
    @start_location = start_location
    @html_instructions = html_instructions
    @polyline = polyline
    @travel_mode = travel_mode
  end

  def self.from_hash(hash)
    distance = build_distance(hash)
    duration = build_duration(hash)
    end_location = build_coordinate(hash["end_location"])
    start_location = build_coordinate(hash["start_location"])
    html_instructions = hash["html_instructions"]
    polyline = build_polyline(hash)
    travel_mode = hash["travel_mode"]

    self.new(
      distance, duration, end_location,
      start_location, html_instructions, 
      polyline, travel_mode
    )
  end

  private

  def self.build_polyline(hash)
    GoogleMapsAPI::Directions::EncodedPolyline.new(hash["polyline"]["points"])
  end
end
