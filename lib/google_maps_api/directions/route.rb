class GoogleMapsAPI::Directions::Route
  attr_reader :bounds, :copyrights, :legs, 
              :overview_polyline, :summary, 
              :warnings, :waypoint_order

  def initialize(
    bounds, copyrights, legs, 
    overview_polyline, summary, 
    warnings, waypoint_order
  )
    @bounds = bounds
    @copyrights = copyrights
    @legs = legs
    @overview_polyline = overview_polyline
    @summary = summary
    @warnings = warnings
    @waypoint_order = waypoint_order
  end

  def self.from_hash(hash)
    bounds = build_bounds(hash)
    copyrights = hash["copyrights"]
    legs = build_legs(hash)
    overview_polyline = build_overview_polyline(hash)
    summary = hash["summary"]
    warnings = hash["warnings"]
    waypoint_order = hash["waypoint_order"]

    self.new(
      bounds, copyrights, legs, 
      overview_polyline, summary, 
      warnings, waypoint_order
    )
  end

  private

  def self.build_bounds(hash)
    GoogleMapsAPI::Directions::Bounds.from_hash(hash["bounds"])
  end

  def self.build_legs(hash)
    hash["legs"].collect do |l|
      GoogleMapsAPI::Directions::Leg.from_hash(l)
    end
  end

  def self.build_overview_polyline(hash)
    GoogleMapsAPI::Directions::EncodedPolyline.new(hash["overview_polyline"]["points"])
  end
end
