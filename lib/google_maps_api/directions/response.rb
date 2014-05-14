require "google_maps_api/directions/route"
require "json"

class GoogleMapsAPI::Directions::Response
  attr_reader :routes, :status

  def initialize(routes, status)
    @routes = routes
    @status = status
  end

  def self.from_json(json)
    parsed_json = parse_json(json)
    routes = build_routes(parsed_json)
    self.new(routes, parsed_json['status'])
  end

  private

  def self.parse_json(json)
    JSON.parse(json)
  end

  def self.build_routes(parsed_json)
    parsed_json['routes'].collect do |r|
      GoogleMapsAPI::Directions::Route.from_hash(r)
    end
  end
end
